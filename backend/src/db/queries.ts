import type {
  Iconsultas,
  IinsertarNombreTablaEnConsultaParametros
} from '../interfaces'

export const obtenerConsulta = ({
  modulo,
  numeroConsulta,
  parametros
}: IinsertarNombreTablaEnConsultaParametros): string => {
  let consulta = consultas[modulo][numeroConsulta]

  if (parametros != null) {
    parametros.forEach((parametro, indice) => {
      consulta = consulta.replace(`[${indice + 1}]`, parametro.toString())
    })
  }

  return consulta
}

const consultas: Iconsultas = {
  1: {
    // 1. Módulo de inicio
    1: 'SELECT * FROM programa_academico;',
    2: `SELECT asignatura.*
        FROM pensum_programa_academico ppa
        INNER JOIN programa_academico ON ppa.fk_id_programa_academico = programa_academico.id_programa_academico
        INNER JOIN asignatura ON ppa.fk_id_asignatura = asignatura.id_asignatura
        WHERE ppa.fk_id_programa_academico = [1]`
  },
  2: {
    // 2. Módulo de Login
    1: ''
  },
  3: {
    // 3. Módulo estudiante
    1: '',
    2: '',
    3: ''
  }
}
