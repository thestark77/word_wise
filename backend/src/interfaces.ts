import { type Request, type Response } from 'express'

export interface controller {
  getUsers?: (req: Request, res: Response) => void
}

export interface Irespuesta {
  exito?: boolean
  estado?: number
  mensaje?: any
  datos?: any
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
  res: Response
  estado: number
  mensaje: string
  datos?: any
  error?: Imysql2Error
}

export interface IinsertarNombreTablaEnConsultaParametros {
  modulo: number
  numeroConsulta: number
  parametros?: number[] | string[]
}

export type Iconsultas = Record<number, Record<number, string>>
