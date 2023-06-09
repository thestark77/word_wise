/* eslint-disable @typescript-eslint/indent */
import type { Response } from 'express'
import type { OkPacket, RowDataPacket } from 'mysql2'

export interface MiError extends Error {
  status?: number
}

export interface IrespuestaBackend {
  exito: boolean
  estado: number
  mensaje?: string
  descripcion?: string
  respuestaDB?: IrespuestaDB
  error?: any
}
export interface Imysql2Error {
  message: string
  code: string
  errno: number
  sql: string
  sqlState: string
  sqlMessage: string
}

export interface IParametrosenviarRespuesta {
  fallo?: boolean
  res: Response
  mensaje?: string
  descripcion?: string
  respuestaDB?: IrespuestaDB
}

export interface IobtenerRuta {
  numeroConsulta: number | string
  arregloParametros: number[] | string[]
}
export interface IparametroNumeroConsulta {
  numeroConsulta: number | string
}
export interface IconsultaRespuesta {
  consulta: string
  descripcion: string
}
export interface IconsultarDB {
  consulta: IconsultaRespuesta
  consultaDeLectura: boolean
  arregloParametros?: number[] | string[]
}

export interface IrespuestaDB {
  exito: boolean
  descripcion?: string
  registrosAfectados?: number
  cantidadResultados?: number
  datos: RowDataPacket | OkPacket
  error?: Imysql2Error
}
export interface IvalidarRespuestaBD {
  respuestaDB: IrespuestaDB
  consultaDeLectura: boolean
  nConsulta: number
}
export interface IrespuestaValidada {
  respuestaRevisadaDB: IrespuestaDB
  descripcion: string
  mensaje: string
}
export type Iconsultas = Record<
  number,
  {
    metodo: string
    descripcion: string
    consulta: string
    parametros: string[]
  }
>
export type Iconsultas2 = Record<number, Record<number, string>>
interface Imetodos {
  get: string
  post: string
  put: string
  delete: string
}

// Constantes
export const metodos: Imetodos = {
  get: 'GET',
  post: 'POST',
  put: 'PUT',
  delete: 'DELETE'
}
