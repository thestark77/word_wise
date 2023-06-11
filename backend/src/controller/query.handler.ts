import type { Request, Response } from 'express'
import { metodos, type IconsultaRespuesta } from '../interfaces'
import {
  enviarRespuesta,
  validarParametrosConsulta,
  validarRespuestaBD
} from './auxiliar.functions'
import { consultarEnDB } from './controller'

const manejadorDeConsultas = async (
  req: Request,
  res: Response
): Promise<void> => {
  const { numeroConsulta, parametro1, parametro2, parametro3 } = req.query
  const metodo = req.method
  const consultaDeLectura = metodo !== metodos.post

  const {
    nConsulta,
    parametrosCorrectos,
    consulta,
    mensaje: mensajeValidacion,
    arregloParametros
  } = validarParametrosConsulta({
    numeroConsulta: numeroConsulta as string,
    parametro1: parametro1 as string,
    parametro2: parametro2 as string,
    parametro3: parametro3 as string
  })

  if (!parametrosCorrectos) {
    enviarRespuesta({
      res,
      mensaje: mensajeValidacion
    })
    return
  }

  const respuestaDB = await consultarEnDB({
    consulta: consulta as IconsultaRespuesta,
    arregloParametros,
    consultaDeLectura
  })

  const { respuestaRevisadaDB, descripcion, mensaje } = validarRespuestaBD({
    respuestaDB,
    consultaDeLectura,
    nConsulta
  })

  enviarRespuesta({
    res,
    descripcion,
    respuestaDB: respuestaRevisadaDB,
    mensaje
  })
}

export { manejadorDeConsultas }
