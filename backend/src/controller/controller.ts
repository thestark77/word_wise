import type { Request, Response } from 'express'
import { db } from '../db/db'
import { obtenerConsulta } from '../db/queries'
import { type Imysql2Error } from '../interfaces'
import { errores, mensajesUsuario } from '../utils/dictionaries'
import { enviarRespuesta } from './auxiliar.functions'

const listaProgramasAcademicos = async (
  req: Request,
  res: Response
): Promise<void> => {
  try {
    const consulta = obtenerConsulta({
      modulo: 1,
      numeroConsulta: 1
    })
    const [datos] = await db.query(consulta)

    enviarRespuesta({ res, estado: 200, mensaje: mensajesUsuario[1], datos })
  } catch (error) {
    enviarRespuesta({
      res,
      estado: 500,
      mensaje: errores[1],
      error: error as Imysql2Error
    })
  }
}

const listaAsignaturasProgramaAcademico = async (
  req: Request,
  res: Response
): Promise<void> => {
  const idProgramaAcademico = req.params.id_programa_academico
  const consulta = obtenerConsulta({
    modulo: 1,
    numeroConsulta: 2,
    parametros: [idProgramaAcademico]
  })
  try {
    const [datos] = await db.query(consulta)

    enviarRespuesta({ res, estado: 200, mensaje: mensajesUsuario[2], datos })
  } catch (error) {
    enviarRespuesta({
      res,
      estado: 500,
      mensaje: errores[2],
      error: error as Imysql2Error
    })
  }
}

export { listaAsignaturasProgramaAcademico, listaProgramasAcademicos }
