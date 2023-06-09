import type { Request, Response } from 'express'
import { obtenerConsulta } from '../db/queries'
import { metodos } from '../interfaces'
import { enviarRespuesta, validarRespuestaBD } from './auxiliar.functions'
import { consultarEnDB } from './controller'

const manejadorDeConsultas = async (
  req: Request,
  res: Response
): Promise<void> => {
  const { numeroConsulta, parametro1, parametro2, parametro3 } = req.query
  const metodo = req.method
  const consultaDeLectura = metodo !== metodos.post

  const nConsulta = Number(numeroConsulta ?? 0)
  const consulta = obtenerConsulta({ numeroConsulta: nConsulta })

  let arregloParametros = [
    Number(parametro1),
    Number(parametro2),
    Number(parametro3)
  ]
  arregloParametros = arregloParametros.filter(
    (parametro) => parametro !== undefined && parametro !== null
  )

  const respuestaDB = await consultarEnDB({
    consulta,
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
