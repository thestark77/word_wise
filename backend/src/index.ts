import cookieParser from 'cookie-parser'
import cors from 'cors'
import express, {
  type Application,
  type NextFunction,
  type Request,
  type Response
} from 'express'
import logger from 'morgan'
import path from 'path'

import { NODE_ENV, PORT } from './config/config'
import { enviarRespuesta } from './controller/auxiliar.functions'
import { Router } from './routes/index.router'

const app: Application = express()

// view engine setup

// Middleware
app.use(cors())
app.use(logger('dev'))
app.use(express.json())
app.use(express.urlencoded({ extended: false }))
app.use(cookieParser())
app.use(express.static(path.join(__dirname, 'public')))

// Routes
app.use('/api', Router)

// catch 404 and forward to error handler
app.use((req: Request, res: Response, next: NextFunction) => {
  enviarRespuesta({ res, estado: 404, mensaje: 'Error, ruta no encontrada' })
})

// error handler
app.use((err: any, req: Request, res: Response, next: NextFunction) => {
  // set locals, only providing error in development
  res.locals.message = err.message
  res.locals.error = req.app.get('env') === 'development' ? err : {}

  // render the error page
  res.status(err.status ?? 500)
})

app.listen(PORT)
console.log(`Server on port: ${PORT}`)
console.log(`Node env: ${NODE_ENV}`)

export default app
