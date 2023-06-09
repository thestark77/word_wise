/* eslint-disable @typescript-eslint/indent */
import type { OkPacket, RowDataPacket } from 'mysql2'
import { db } from '../db/db'
import type { IconsultarDB, Imysql2Error, IrespuestaDB } from '../interfaces'

const consultarEnDB = async ({
  consulta,
  arregloParametros,
  consultaDeLectura = true
}: IconsultarDB): Promise<IrespuestaDB> => {
  let respuesta: IrespuestaDB = { exito: false, datos: [] as RowDataPacket }
  const parametros = arregloParametros ?? []

  let datos: RowDataPacket | OkPacket

  try {
    if (consultaDeLectura) {
      datos = (
        (await db.query(consulta.consulta, parametros)) as RowDataPacket[]
      )[0]
    } else {
      datos = ((await db.query(consulta.consulta, parametros)) as OkPacket[])[0]
    }
    respuesta = {
      exito: true,
      descripcion: consulta.descripcion,
      datos,
      cantidadResultados: (datos as RowDataPacket[]).length
    }
  } catch (error) {
    respuesta = {
      exito: false,
      datos: [] as RowDataPacket,
      error: error as Imysql2Error
    }
  }

  return respuesta
}

export { consultarEnDB }
