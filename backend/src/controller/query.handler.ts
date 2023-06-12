import type { Request, Response } from 'express'
import { type RowDataPacket } from 'mysql2'
import type {
  Ibody,
  IconsultaDBconValidacionTotal,
  IconsultarBDPOST,
  IconsultasEspeciales,
  IparametrosYConsultaValidados
} from '../interfaces'
import { errores, mensajesUsuario } from '../utils/dictionaries'
import {
  encriptarContrasena,
  enviarRespuesta,
  procesarContrasena,
  validarParametrosConsulta
} from './auxiliar.functions'
import { consultarEnBDYValidar } from './controller'

const consultaDBconValidacionTotal = async ({
  res,
  nConsulta,
  nuevoArregloParametros
}: IconsultaDBconValidacionTotal): Promise<IparametrosYConsultaValidados> => {
  let parametrosCorrectos = false
  let descripcion: string | undefined
  let resultadosConsulta: RowDataPacket[] | undefined

  const parametrosValidados = validarParametrosConsulta({
    res,
    numeroConsulta: nConsulta,
    consultasEspeciales,
    parametros: nuevoArregloParametros
  })

  if (parametrosValidados.parametrosCorrectos) {
    parametrosCorrectos = true

    const respuestaBDValidada = await consultarEnBDYValidar(parametrosValidados)

    descripcion = respuestaBDValidada.descripcion
    resultadosConsulta = respuestaBDValidada.respuestaRevisadaBD
      .datos as RowDataPacket[]
  }

  const parametrosYConsultaValidados: IparametrosYConsultaValidados = {
    parametrosCorrectos,
    resultadosConsulta,
    descripcion
  }

  return parametrosYConsultaValidados
}

const validarContrasenaUsuario = async ({
  res,
  body,
  nConsulta
}: IconsultarBDPOST): Promise<void> => {
  const { idUsuario, contrasenaIngresada } = body

  const { parametrosCorrectos, resultadosConsulta, descripcion } =
    await consultaDBconValidacionTotal({
      res,
      nuevoArregloParametros: [idUsuario, contrasenaIngresada],
      nConsulta
    })

  if (!parametrosCorrectos) {
    return
  }

  const { comparacionContrasena, mensaje } = await procesarContrasena({
    resultadosConsulta: resultadosConsulta as RowDataPacket[],
    contrasenaIngresada: contrasenaIngresada as string
  })

  enviarRespuesta({
    res,
    datosConsultaEspecial: comparacionContrasena,
    descripcion,
    mensaje
  })
}

const cambiarContrasenaUsuario = async ({
  res,
  body,
  nConsulta
}: IconsultarBDPOST): Promise<void> => {
  const { idUsuario, nuevaContrasena } = body
  const contrasena = (nuevaContrasena as string).toString()
  let mensaje: string | undefined
  let descripcion: string | undefined
  let fallo: boolean | undefined

  const { encriptacionExitosa, contrasenaHash, error } =
    await encriptarContrasena(contrasena)

  if (encriptacionExitosa) {
    const { parametrosCorrectos, descripcion: descripcionConsulta } =
      await consultaDBconValidacionTotal({
        res,
        nuevoArregloParametros: [contrasenaHash, idUsuario],
        nConsulta
      })

    if (!parametrosCorrectos) {
      return
    }
    fallo = false
    mensaje = mensajesUsuario[3]
    descripcion = descripcionConsulta
  } else {
    mensaje = error
    fallo = true
  }

  enviarRespuesta({
    res,
    descripcion,
    mensaje,
    fallo
  })
}

const consultasEspeciales: IconsultasEspeciales = {
  23: validarContrasenaUsuario,
  13: cambiarContrasenaUsuario
}

const manejadorDeConsultas = async (
  req: Request,
  res: Response
): Promise<void> => {
  const { numeroConsulta, parametro1, parametro2, parametro3 } = req.query

  const parametrosValidados = validarParametrosConsulta({
    res,
    numeroConsulta: numeroConsulta as string,
    consultasEspeciales,
    parametros: [
      parametro1 as string,
      parametro2 as string,
      parametro3 as string
    ]
  })

  if (!parametrosValidados.parametrosCorrectos) {
    return
  }

  if (parametrosValidados.consultaDeLectura) {
    const respuestaBDValidada = await consultarEnBDYValidar(parametrosValidados)

    enviarRespuesta({
      res,
      descripcion: respuestaBDValidada.descripcion,
      respuestaBD: respuestaBDValidada.respuestaRevisadaBD,
      mensaje: respuestaBDValidada.mensaje
    })
  } else {
    const nConsulta = parametrosValidados.nConsulta
    if (
      consultasEspeciales[nConsulta] !== undefined &&
      consultasEspeciales[nConsulta] !== null
    ) {
      await consultasEspeciales[nConsulta]({
        res,
        body: req.body as Ibody,
        nConsulta
      })
    } else {
      enviarRespuesta({
        fallo: true,
        res,
        mensaje: errores[6]
      })
    }
  }
}

export { manejadorDeConsultas }
