CREATE DATABASE IF NOT EXISTS institucion_educativa;

USE institucion_educativa;

CREATE TABLE `institucion_educativa` (
  `id_institucion_educativa` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_institucion_educativa` varchar(100) NOT NULL,
  `fecha_fundacion` date NOT NULL,
  `fk_id_rector` int NOT NULL
);

CREATE TABLE `departamento` (
  `id_departamento` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_departamento` varchar(100) NOT NULL,
  `fk_id_institucion_educativa` int NOT NULL,
  `fk_id_jefe_departamento` int NOT NULL
);

CREATE TABLE `facultad` (
  `id_facultad` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_facultad` varchar(100) NOT NULL,
  `ubicacion` varchar(100),
  `fk_id_institucion_educativa` int NOT NULL,
  `fk_id_director_facultad` int NOT NULL
);

CREATE TABLE `rol` (
  `id_rol` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_rol` varchar(50) NOT NULL
);

CREATE TABLE `permiso` (
  `id_permiso` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_permiso` varchar(50) NOT NULL,
  `descripcion` varchar(100)
);

CREATE TABLE `sexo` (
  `id_sexo` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_sexo` varchar(50) NOT NULL
);

CREATE TABLE `estado_academico` (
  `id_estado_academico` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_estado_academico` varchar(50) NOT NULL
);

CREATE TABLE `direccion` (
  `id_direccion` int PRIMARY KEY AUTO_INCREMENT,
  `direccion` varchar(100) NOT NULL,
  `barrio` varchar(100) NOT NULL,
  `ciudad` varchar(100) NOT NULL,
  `departamento` varchar(100) NOT NULL
);

CREATE TABLE `usuario` (
  `id_usuario` int PRIMARY KEY,
  `sexo` int NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `correo_electronico` varchar(100) UNIQUE NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `id_direccion` int NOT NULL,
  `contrasena_salt` varchar(100) NOT NULL,
  `contrasena_hash` varchar(100) NOT NULL
);

CREATE TABLE `detalle_estudiante` (
  `id_estudiante` int PRIMARY KEY,
  `id_estado_academico` int NOT NULL
);

CREATE TABLE `detalle_docente` (
  `id_docente` int,
  `fk_id_departamento` int,
  `url_hoja_de_vida` varchar(100),
  `salario` int NOT NULL,
  `id_tipo_contrato` int NOT NULL,
  PRIMARY KEY (`id_docente`, `fk_id_departamento`)
);

CREATE TABLE `tipo_contrato` (
  `id_contrato` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_contrato` varchar(100) NOT NULL
);

CREATE TABLE `detalle_administrativo` (
  `id_administrativo` int PRIMARY KEY
);

CREATE TABLE `cargo_administrativo` (
  `id_cargo_administrativo` int PRIMARY KEY,
  `nombre_cargo_administrativo` varchar(100) NOT NULL,
  `descripcion_cargo_administrativo` varchar(100)
);

CREATE TABLE `periodo_academico` (
  `anio_periodo_academico` int,
  `id_periodo_academico` int,
  `fk_id_institucion_educativa` int NOT NULL,
  `fecha_matricula` date NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_final` date NOT NULL,
  PRIMARY KEY (`anio_periodo_academico`, `id_periodo_academico`)
);

CREATE TABLE `periodo_tiempo` (
  `id_periodo_tiempo` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(50)
);

CREATE TABLE `programa_academico` (
  `id_programa_academico` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_facultad` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `total_creditos` int NOT NULL,
  `id_director` int NOT NULL
);

CREATE TABLE `asignatura` (
  `id_asignatura` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_departamento` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `num_creditos` int NOT NULL,
  `max_estudiantes` int NOT NULL
);

CREATE TABLE `dia_semana` (
  `id_dia_semana` int PRIMARY KEY,
  `nombre_dia_semana` varchar(20) NOT NULL
);

CREATE TABLE `clase` (
  `id_clase` int PRIMARY KEY,
  `hora_inicio` int NOT NULL,
  `horas_duracion` int NOT NULL
);

CREATE TABLE `clase_dia` (
  `id_clase_dia` int PRIMARY KEY,
  `id_dia_semana` int NOT NULL,
  `id_clase` int NOT NULL
);

CREATE TABLE `oferta_academica` (
  `fk_id_programa_academico` int,
  `fk_anio_periodo_academico` int,
  `fk_id_periodo_academico` int,
  PRIMARY KEY (`fk_id_programa_academico`, `fk_anio_periodo_academico`, `fk_id_periodo_academico`)
);

CREATE TABLE `matricula_academica` (
  `fk_id_programa_academico` int,
  `fk_anio_periodo_academico` int,
  `fk_id_periodo_academico` int,
  `fk_id_estudiante` int,
  PRIMARY KEY (`fk_id_programa_academico`, `fk_anio_periodo_academico`, `fk_id_periodo_academico`, `fk_id_estudiante`)
);

CREATE TABLE `curso` (
  `fk_id_programa_academico` int,
  `fk_id_asignatura` int,
  `fk_anio_periodo_academico` int,
  `fk_id_periodo_academico` int,
  `fk_id_grupo` int UNIQUE NOT NULL AUTO_INCREMENT,
  `id_docente_asignado` int NOT NULL,
  `edificio` int NOT NULL,
  `salon_clase` int NOT NULL,
  PRIMARY KEY (`fk_id_programa_academico`, `fk_id_asignatura`, `fk_anio_periodo_academico`, `fk_id_periodo_academico`)
);

CREATE TABLE `horario_semanal_grupo` (
  `fk_id_programa_academico` int,
  `fk_id_asignatura` int,
  `fk_anio_periodo_academico` int,
  `fk_id_periodo_academico` int,
  `fk_id_grupo` int,
  `fk_clase_dia` int,
  PRIMARY KEY (`fk_id_programa_academico`, `fk_id_asignatura`, `fk_anio_periodo_academico`, `fk_id_periodo_academico`, `fk_id_grupo`, `fk_clase_dia`)
);

CREATE TABLE `historial_academico` (
  `fk_id_programa_academico` int,
  `fk_id_asignatura` int,
  `fk_anio_periodo_academico` int,
  `fk_id_periodo_academico` int,
  `fk_id_grupo` int,
  `fk_id_estudiante` int,
  `nota_estudiante_curso` float,
  PRIMARY KEY (`fk_id_programa_academico`, `fk_id_asignatura`, `fk_anio_periodo_academico`, `fk_id_periodo_academico`, `fk_id_grupo`, `fk_id_estudiante`)
);

CREATE TABLE `rol_permiso` (
  `fk_id_rol` int,
  `fk_id_permiso` int,
  PRIMARY KEY (`fk_id_rol`, `fk_id_permiso`)
);

CREATE TABLE `asignacion_roles` (
  `fk_id_usuario` int,
  `fk_id_rol` int,
  PRIMARY KEY (`fk_id_usuario`, `fk_id_rol`)
);

CREATE TABLE `docente_asignatura` (
  `fk_id_docente` int,
  `fk_id_asignatura` int,
  PRIMARY KEY (`fk_id_docente`, `fk_id_asignatura`)
);

CREATE TABLE `pensum_programa_academico` (
  `fk_id_programa_academico` int,
  `fk_id_asignatura` int,
  PRIMARY KEY (`fk_id_programa_academico`, `fk_id_asignatura`)
);

CREATE TABLE `detalle_administrativo_cargo_administrativo` (
  `fk_id_administrativo` int,
  `fk_id_cargo_administrativo` int,
  PRIMARY KEY (`fk_id_administrativo`, `fk_id_cargo_administrativo`)
);

ALTER TABLE `institucion_educativa` ADD FOREIGN KEY (`fk_id_rector`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `departamento` ADD FOREIGN KEY (`fk_id_institucion_educativa`) REFERENCES `institucion_educativa` (`id_institucion_educativa`);

ALTER TABLE `departamento` ADD FOREIGN KEY (`fk_id_jefe_departamento`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `facultad` ADD FOREIGN KEY (`fk_id_institucion_educativa`) REFERENCES `institucion_educativa` (`id_institucion_educativa`);

ALTER TABLE `facultad` ADD FOREIGN KEY (`fk_id_director_facultad`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `usuario` ADD FOREIGN KEY (`sexo`) REFERENCES `sexo` (`id_sexo`);

ALTER TABLE `usuario` ADD FOREIGN KEY (`id_direccion`) REFERENCES `direccion` (`id_direccion`);

ALTER TABLE `detalle_estudiante` ADD FOREIGN KEY (`id_estudiante`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `detalle_estudiante` ADD FOREIGN KEY (`id_estado_academico`) REFERENCES `estado_academico` (`id_estado_academico`);

ALTER TABLE `detalle_docente` ADD FOREIGN KEY (`id_docente`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `detalle_docente` ADD FOREIGN KEY (`fk_id_departamento`) REFERENCES `departamento` (`id_departamento`);

ALTER TABLE `detalle_docente` ADD FOREIGN KEY (`id_tipo_contrato`) REFERENCES `tipo_contrato` (`id_contrato`);

ALTER TABLE `detalle_administrativo` ADD FOREIGN KEY (`id_administrativo`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `periodo_academico` ADD FOREIGN KEY (`id_periodo_academico`) REFERENCES `periodo_tiempo` (`id_periodo_tiempo`);

ALTER TABLE `periodo_academico` ADD FOREIGN KEY (`fk_id_institucion_educativa`) REFERENCES `institucion_educativa` (`id_institucion_educativa`);

ALTER TABLE `programa_academico` ADD FOREIGN KEY (`fk_id_facultad`) REFERENCES `facultad` (`id_facultad`);

ALTER TABLE `programa_academico` ADD FOREIGN KEY (`id_director`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `asignatura` ADD FOREIGN KEY (`fk_id_departamento`) REFERENCES `departamento` (`id_departamento`);

ALTER TABLE `clase_dia` ADD FOREIGN KEY (`id_dia_semana`) REFERENCES `dia_semana` (`id_dia_semana`);

ALTER TABLE `clase_dia` ADD FOREIGN KEY (`id_clase`) REFERENCES `dia_semana` (`id_dia_semana`);

ALTER TABLE `oferta_academica` ADD FOREIGN KEY (`fk_id_programa_academico`) REFERENCES `programa_academico` (`id_programa_academico`);

ALTER TABLE `oferta_academica` ADD FOREIGN KEY (`fk_anio_periodo_academico`) REFERENCES `periodo_academico` (`anio_periodo_academico`);

ALTER TABLE `oferta_academica` ADD FOREIGN KEY (`fk_id_periodo_academico`) REFERENCES `periodo_academico` (`id_periodo_academico`);

ALTER TABLE `matricula_academica` ADD FOREIGN KEY (`fk_id_programa_academico`) REFERENCES `oferta_academica` (`fk_id_programa_academico`);

ALTER TABLE `matricula_academica` ADD FOREIGN KEY (`fk_anio_periodo_academico`) REFERENCES `oferta_academica` (`fk_anio_periodo_academico`);

ALTER TABLE `matricula_academica` ADD FOREIGN KEY (`fk_id_periodo_academico`) REFERENCES `oferta_academica` (`fk_id_periodo_academico`);

ALTER TABLE `matricula_academica` ADD FOREIGN KEY (`fk_id_estudiante`) REFERENCES `detalle_estudiante` (`id_estudiante`);

ALTER TABLE `curso` ADD FOREIGN KEY (`fk_id_programa_academico`) REFERENCES `oferta_academica` (`fk_id_programa_academico`);

ALTER TABLE `curso` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `curso` ADD FOREIGN KEY (`fk_anio_periodo_academico`) REFERENCES `oferta_academica` (`fk_anio_periodo_academico`);

ALTER TABLE `curso` ADD FOREIGN KEY (`fk_id_periodo_academico`) REFERENCES `oferta_academica` (`fk_id_periodo_academico`);

ALTER TABLE `curso` ADD FOREIGN KEY (`id_docente_asignado`) REFERENCES `detalle_docente` (`id_docente`);

ALTER TABLE `horario_semanal_grupo` ADD FOREIGN KEY (`fk_id_programa_academico`) REFERENCES `curso` (`fk_id_programa_academico`);

ALTER TABLE `horario_semanal_grupo` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `curso` (`fk_id_asignatura`);

ALTER TABLE `horario_semanal_grupo` ADD FOREIGN KEY (`fk_anio_periodo_academico`) REFERENCES `curso` (`fk_anio_periodo_academico`);

ALTER TABLE `horario_semanal_grupo` ADD FOREIGN KEY (`fk_id_periodo_academico`) REFERENCES `curso` (`fk_id_periodo_academico`);

ALTER TABLE `horario_semanal_grupo` ADD FOREIGN KEY (`fk_id_grupo`) REFERENCES `curso` (`fk_id_grupo`);

ALTER TABLE `horario_semanal_grupo` ADD FOREIGN KEY (`fk_clase_dia`) REFERENCES `clase_dia` (`id_clase_dia`);

ALTER TABLE `historial_academico` ADD FOREIGN KEY (`fk_id_programa_academico`) REFERENCES `curso` (`fk_id_programa_academico`);

ALTER TABLE `historial_academico` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `curso` (`fk_id_asignatura`);

ALTER TABLE `historial_academico` ADD FOREIGN KEY (`fk_anio_periodo_academico`) REFERENCES `curso` (`fk_anio_periodo_academico`);

ALTER TABLE `historial_academico` ADD FOREIGN KEY (`fk_id_periodo_academico`) REFERENCES `curso` (`fk_id_periodo_academico`);

ALTER TABLE `historial_academico` ADD FOREIGN KEY (`fk_id_grupo`) REFERENCES `curso` (`fk_id_grupo`);

ALTER TABLE `historial_academico` ADD FOREIGN KEY (`fk_id_estudiante`) REFERENCES `detalle_estudiante` (`id_estudiante`);

ALTER TABLE `rol_permiso` ADD FOREIGN KEY (`fk_id_rol`) REFERENCES `rol` (`id_rol`);

ALTER TABLE `rol_permiso` ADD FOREIGN KEY (`fk_id_permiso`) REFERENCES `permiso` (`id_permiso`);

ALTER TABLE `asignacion_roles` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `asignacion_roles` ADD FOREIGN KEY (`fk_id_rol`) REFERENCES `rol` (`id_rol`);

ALTER TABLE `docente_asignatura` ADD FOREIGN KEY (`fk_id_docente`) REFERENCES `detalle_docente` (`id_docente`);

ALTER TABLE `docente_asignatura` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `pensum_programa_academico` ADD FOREIGN KEY (`fk_id_programa_academico`) REFERENCES `programa_academico` (`id_programa_academico`);

ALTER TABLE `pensum_programa_academico` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `detalle_administrativo_cargo_administrativo` ADD FOREIGN KEY (`fk_id_administrativo`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `detalle_administrativo_cargo_administrativo` ADD FOREIGN KEY (`fk_id_cargo_administrativo`) REFERENCES `cargo_administrativo` (`id_cargo_administrativo`);

ALTER TABLE `clase` ADD CONSTRAINT uq_clase UNIQUE(`hora_inicio`, `horas_duracion`);

ALTER TABLE `clase_dia` ADD CONSTRAINT uq_clase_dia UNIQUE(`id_dia_semana`, `id_clase`);
