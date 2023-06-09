import express from 'express'
// import express, { type Request, type Response } from 'express'
// import { saveUser } from '../controller/auxiliar.functions';
import { manejadorDeConsultas } from '../controller/query.handler'
const Router = express.Router()

Router.route('/lectura').get(manejadorDeConsultas)

Router.route('/escritura').post(manejadorDeConsultas)

export { Router }
