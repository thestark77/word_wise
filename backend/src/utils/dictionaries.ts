export const errores: Record<number, string> = {
  0: 'Error al acceder a la base de datos',
  1: 'Error, ruta no encontrada',
  2: 'El número de la consulta ingresado es inválido',
  3: 'No ha introducido todos los parámetros necesarios para ejecutar la consulta deseada'
}

export const mensajesUsuario: Record<number, string> = {
  0: 'Consulta exitosa',
  1: 'Consulta exitosa pero no se alteró ningún registro',
  2: 'Consulta exitosa pero no se encontro ningún resultado en la base de datos'
}
