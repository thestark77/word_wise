/* eslint-disable @typescript-eslint/indent */
import type { OkPacket, RowDataPacket } from 'mysql2'
import { db } from '../db/db'
import type {
  IconsultarBD,
  Imysql2Error,
  IrespuestaBD,
  IrespuestaBDValidada,
  IvalidacionParametros
} from '../interfaces'
import { validarRespuestaBD } from './auxiliar.functions'

const consultarEnBD = async ({
  consulta,
  arregloParametros
}: IconsultarBD): Promise<IrespuestaBD> => {
  let respuesta: IrespuestaBD = { exito: false, datos: [] as RowDataPacket }
  const parametros = arregloParametros ?? []

  let datos: RowDataPacket | OkPacket

  try {
    datos = (
      (await db.query(consulta.consulta, parametros)) as RowDataPacket[]
    )[0]
    respuesta = {
      exito: true,
      descripcion: consulta.descripcion,
      datos,
      cantidadResultados: (datos as RowDataPacket[]).length
    }
  } catch (error) {
    respuesta = {
      exito: false,
      descripcion: consulta.descripcion,
      datos: [] as RowDataPacket,
      error: error as Imysql2Error
    }
  }

  return respuesta
}

const consultarEnBDYValidar = async (
  parametrosValidados: IvalidacionParametros
): Promise<IrespuestaBDValidada> => {
  const respuestaBD = await consultarEnBD({
    consulta: parametrosValidados.consulta,
    arregloParametros: parametrosValidados.arregloParametros
  })

  const respuestaBDValidada = validarRespuestaBD({
    respuestaBD,
    consultaDeLectura: parametrosValidados.consultaDeLectura
  })

  return respuestaBDValidada
}

export { consultarEnBDYValidar }
