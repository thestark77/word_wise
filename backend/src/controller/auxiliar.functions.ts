// import { pool } from '../db/db'
import { type OkPacket } from 'mysql2'
import type {
  IParametrosenviarRespuesta,
  IrespuestaBackend,
  IrespuestaValidada,
  IvalidarRespuestaBD
} from '../interfaces'
import { errores, mensajesUsuario } from '../utils/dictionaries'

const validarRespuestaBD = ({
  respuestaDB,
  consultaDeLectura,
  nConsulta
}: IvalidarRespuestaBD): IrespuestaValidada => {
  let descripcion = ''
  let mensaje = ''

  if (respuestaDB.exito) {
    const registrosAfectados = (respuestaDB.datos as OkPacket).affectedRows
    respuestaDB.registrosAfectados = registrosAfectados
    descripcion = mensajesUsuario[nConsulta]
    mensaje = mensajesUsuario[0]
    if (consultaDeLectura) {
      if (
        respuestaDB.cantidadResultados !== undefined &&
        respuestaDB.cantidadResultados <= 0
      ) {
        mensaje = mensajesUsuario[2]
      }
    } else {
      if (registrosAfectados <= 0) {
        mensaje = mensajesUsuario[1]
      }
    }
  } else {
    mensaje = errores[0]
  }

  const respuestaValidada: IrespuestaValidada = {
    descripcion,
    respuestaRevisadaDB: respuestaDB,
    mensaje
  }

  return respuestaValidada
}

const enviarRespuesta = ({
  res,
  descripcion,
  mensaje,
  respuestaDB,
  fallo
}: IParametrosenviarRespuesta): void => {
  let respuestaBackend: IrespuestaBackend = {
    exito: false,
    estado: 404
  }

  if (fallo === undefined && respuestaDB !== undefined) {
    if (respuestaDB.exito) {
      respuestaBackend = {
        exito: true,
        estado: 200,
        respuestaDB,
        descripcion,
        mensaje
      }
    } else {
      respuestaBackend = {
        exito: false,
        estado: 500,
        descripcion,
        error: respuestaDB.error,
        mensaje
      }
    }
  } else {
    respuestaBackend = {
      exito: false,
      estado: 404,
      descripcion,
      mensaje
    }
  }

  res.status(respuestaBackend.estado).json(respuestaBackend)
}

export { enviarRespuesta, validarRespuestaBD }
