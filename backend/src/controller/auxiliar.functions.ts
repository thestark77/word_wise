// import { pool } from '../db/db'
import type { IParametrosenviarRespuesta, Irespuesta } from '../interfaces'

const enviarRespuesta = ({
  res,
  estado,
  mensaje,
  datos,
  error
}: IParametrosenviarRespuesta): void => {
  let respuesta: Irespuesta = {}

  if (estado === 200) {
    respuesta = {
      exito: true,
      datos,
      estado,
      mensaje
    }
  } else if (estado === 404 || estado === 500) {
    respuesta = {
      exito: false,
      estado,
      mensaje,
      error
    }
  }

  res.status(estado).json(respuesta)
}

export { enviarRespuesta }
