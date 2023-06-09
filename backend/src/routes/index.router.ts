import express from 'express'
// import express, { type Request, type Response } from 'express'
// import { saveUser } from '../controller/auxiliar.functions';
import {
  listaAsignaturasProgramaAcademico,
  listaProgramasAcademicos
} from '../controller/controller'
const Router = express.Router()

Router.route('/programas_academicos/').get(listaProgramasAcademicos)

Router.route('/asignaturas_programa_academico/:id_programa_academico').get(
  listaAsignaturasProgramaAcademico
)

Router.route('/almacenes/:nombreAlmacen').post().put()

export { Router }
