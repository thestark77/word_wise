DCREATE DATABASE IF NOT EXISTS institucion_educativa;

USE institucion_educativa;

CREATE TABLE `institucion_educativa` (
  `id_institucion_educativa` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_institucion_educativa` varchar(100) NOT NULL,
  `fecha_fundacion` date NOT NULL,
  `fk_id_rector` int NOT NULL,
  `anio_vigente` int NOT NULL,
  `periodo_academico_vigente` int NOT NULL
);

CREATE TABLE `facultad` (
  `id_facultad` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_facultad` varchar(100) NOT NULL,
  `ubicacion` varchar(100),
  `fk_id_institucion_educativa` int NOT NULL,
  `fk_id_director_facultad` int NOT NULL
);

CREATE TABLE `departamento` (
  `id_departamento` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_departamento` varchar(100) NOT NULL,
  `fk_id_facultad` int NOT NULL,
  `fk_id_institucion_educativa` int NOT NULL,
  `fk_id_jefe_departamento` int NOT NULL
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
  `id_direccion` int PRIMARY KEY,
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
  `url_foto` varchar(100),
  `contrasena_salt` varchar(100) NOT NULL,
  `contrasena_hash` varchar(100) NOT NULL
);

CREATE TABLE `detalle_estudiante` (
  `id_estudiante` int PRIMARY KEY,
  `fk_id_estado_academico` int NOT NULL
);

CREATE TABLE `detalle_docente` (
  `id_docente` int PRIMARY KEY,
  `fk_id_departamento` int NOT NULL,
  `url_hoja_de_vida` varchar(100),
  `salario` int NOT NULL,
  `fk_id_tipo_contrato` int NOT NULL
);

CREATE TABLE `tipo_contrato` (
  `id_tipo_contrato` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_contrato` varchar(100) NOT NULL
);

CREATE TABLE `detalle_administrativo` (
  `id_administrativo` int PRIMARY KEY
);

CREATE TABLE `cargo_administrativo` (
  `id_cargo_administrativo` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_cargo_administrativo` varchar(100) NOT NULL,
  `descripcion_cargo_administrativo` varchar(100)
);

CREATE TABLE `periodo_academico` (
  `id_periodo_academico` int PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(50)
);

CREATE TABLE `anio_periodo_academico` (
  `id_anio_periodo_academico` int PRIMARY KEY AUTO_INCREMENT,
  `anio` int,
  `fk_id_periodo_academico` int NOT NULL,
  `fk_id_institucion_educativa` int NOT NULL,
  `fecha_matricula` date NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_final` date NOT NULL
);

CREATE TABLE `programa_academico` (
  `id_programa_academico` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_facultad` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `total_creditos` int NOT NULL,
  `fk_id_director` int NOT NULL
);

CREATE TABLE `asignatura` (
  `id_asignatura` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_departamento` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `num_creditos` int,
  `max_estudiantes` int NOT NULL,
  `curso_extension` boolean,
  `descripcion` varchar(255),
  `intensidad_horaria` int,
  `costo` int
);

CREATE TABLE `dia_semana` (
  `id_dia_semana` int PRIMARY KEY AUTO_INCREMENT,
  `nombre_dia_semana` varchar(20) NOT NULL
);

CREATE TABLE `clase` (
  `id_clase` int PRIMARY KEY,
  `hora_inicio` int NOT NULL,
  `hora_final` int NOT NULL
);

CREATE TABLE `clase_dia` (
  `id_clase_dia` int PRIMARY KEY,
  `fk_id_dia_semana` int NOT NULL,
  `fk_id_clase` int NOT NULL
);

CREATE TABLE `ubicacion_clase` (
  `id_ubicacion_clase` int PRIMARY KEY AUTO_INCREMENT,
  `id_edificio` int,
  `id_salon` int,
  `nombre` varchar(100),
  `descripcion` varchar(150)
);

CREATE TABLE `oferta_academica` (
  `id_oferta_academica` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_anio_periodo_academico` int NOT NULL,
  `fk_id_programa_academico` int NOT NULL
);

CREATE TABLE `matricula_academica` (
  `id_matricula_academica` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_oferta_academica` int NOT NULL,
  `fk_id_estudiante` int NOT NULL
);

CREATE TABLE `curso` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_oferta_academica` int NOT NULL,
  `fk_id_asignatura` int NOT NULL
);

CREATE TABLE `grupo` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_curso` int NOT NULL,
  `numero_grupo` int NOT NULL,
  `fk_id_docente_asignado` int NOT NULL
);

CREATE TABLE `horario_clase` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_grupo` int NOT NULL,
  `fk_id_clase_dia` int NOT NULL,
  `fk_id_ubicacion_clase` int NOT NULL
);

CREATE TABLE `historial_academico` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_grupo` int NOT NULL,
  `fk_id_estudiante` int NOT NULL,
  `nota_estudiante_curso` float
);

CREATE TABLE `nota_estudiante_asignatura_matriculada` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_matricula_academica` int NOT NULL,
  `fk_id_asignatura` int NOT NULL,
  `nota_final_estudiante_asignatura` int
);

CREATE TABLE `creditos_aprobados_estudiante_programa_academico` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_estudiante` int,
  `fk_id_programa_academico` int NOT NULL,
  `total_creditos_aprobados` int
);

CREATE TABLE `prerequisitos_asignatura` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_asignatura` int NOT NULL,
  `fk_id_asignatura_prerequisito` int NOT NULL
);

CREATE TABLE `rol_permiso` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_rol` int NOT NULL,
  `fk_id_permiso` int NOT NULL
);

CREATE TABLE `asignacion_roles` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_usuario` int NOT NULL,
  `fk_id_rol` int NOT NULL
);

CREATE TABLE `docente_asignatura` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_docente` int NOT NULL,
  `fk_id_asignatura` int NOT NULL
);

CREATE TABLE `pensum_programa_academico` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_programa_academico` int NOT NULL,
  `fk_id_asignatura` int NOT NULL
);

CREATE TABLE `detalle_administrativo_cargo_administrativo` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_administrativo` int NOT NULL,
  `fk_id_cargo_administrativo` int NOT NULL
);



CREATE UNIQUE INDEX `anio_periodo_academico_index_0` ON `anio_periodo_academico` (`anio`, `fk_id_periodo_academico`);

CREATE UNIQUE INDEX `clase_index_1` ON `clase` (`hora_inicio`, `hora_final`);

CREATE UNIQUE INDEX `clase_dia_index_2` ON `clase_dia` (`fk_id_dia_semana`, `fk_id_clase`);

CREATE UNIQUE INDEX `oferta_academica_index_3` ON `oferta_academica` (`fk_id_anio_periodo_academico`, `fk_id_programa_academico`);

CREATE UNIQUE INDEX `matricula_academica_index_4` ON `matricula_academica` (`fk_id_oferta_academica`, `fk_id_estudiante`);

CREATE UNIQUE INDEX `curso_index_5` ON `curso` (`fk_id_oferta_academica`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `grupo_index_6` ON `grupo` (`fk_id_curso`, `numero_grupo`);

CREATE UNIQUE INDEX `horario_clase_index_7` ON `horario_clase` (`fk_id_grupo`, `fk_id_clase_dia`);

CREATE UNIQUE INDEX `horario_clase_index_8` ON `horario_clase` (`fk_id_clase_dia`, `fk_id_ubicacion_clase`);

CREATE UNIQUE INDEX `historial_academico_index_9` ON `historial_academico` (`fk_id_grupo`, `fk_id_estudiante`);

CREATE UNIQUE INDEX `nota_estudiante_asignatura_matriculada_index_10` ON `nota_estudiante_asignatura_matriculada` (`fk_id_matricula_academica`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `creditos_aprobados_estudiante_programa_academico_index_11` ON `creditos_aprobados_estudiante_programa_academico` (`fk_id_estudiante`, `fk_id_programa_academico`);

CREATE UNIQUE INDEX `prerequisitos_asignatura_index_12` ON `prerequisitos_asignatura` (`fk_id_asignatura`, `fk_id_asignatura_prerequisito`);

CREATE UNIQUE INDEX `rol_permiso_index_13` ON `rol_permiso` (`fk_id_rol`, `fk_id_permiso`);

CREATE UNIQUE INDEX `asignacion_roles_index_14` ON `asignacion_roles` (`fk_id_usuario`, `fk_id_rol`);

CREATE UNIQUE INDEX `docente_asignatura_index_15` ON `docente_asignatura` (`fk_id_docente`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `pensum_programa_academico_index_16` ON `pensum_programa_academico` (`fk_id_programa_academico`, `fk_id_asignatura`);

CREATE UNIQUE INDEX `detalle_administrativo_cargo_administrativo_index_17` ON `detalle_administrativo_cargo_administrativo` (`fk_id_administrativo`, `fk_id_cargo_administrativo`);



ALTER TABLE `institucion_educativa` ADD FOREIGN KEY (`fk_id_rector`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `facultad` ADD FOREIGN KEY (`fk_id_institucion_educativa`) REFERENCES `institucion_educativa` (`id_institucion_educativa`);

ALTER TABLE `facultad` ADD FOREIGN KEY (`fk_id_director_facultad`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `departamento` ADD FOREIGN KEY (`fk_id_facultad`) REFERENCES `facultad` (`id_facultad`);

ALTER TABLE `departamento` ADD FOREIGN KEY (`fk_id_institucion_educativa`) REFERENCES `institucion_educativa` (`id_institucion_educativa`);

ALTER TABLE `departamento` ADD FOREIGN KEY (`fk_id_jefe_departamento`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `direccion` ADD FOREIGN KEY (`id_direccion`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `usuario` ADD FOREIGN KEY (`sexo`) REFERENCES `sexo` (`id_sexo`);

ALTER TABLE `detalle_estudiante` ADD FOREIGN KEY (`id_estudiante`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `detalle_estudiante` ADD FOREIGN KEY (`fk_id_estado_academico`) REFERENCES `estado_academico` (`id_estado_academico`);

ALTER TABLE `detalle_docente` ADD FOREIGN KEY (`id_docente`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `detalle_docente` ADD FOREIGN KEY (`fk_id_departamento`) REFERENCES `departamento` (`id_departamento`);

ALTER TABLE `detalle_docente` ADD FOREIGN KEY (`fk_id_tipo_contrato`) REFERENCES `tipo_contrato` (`id_tipo_contrato`);

ALTER TABLE `detalle_administrativo` ADD FOREIGN KEY (`id_administrativo`) REFERENCES `usuario` (`id_usuario`);

ALTER TABLE `anio_periodo_academico` ADD FOREIGN KEY (`fk_id_periodo_academico`) REFERENCES `periodo_academico` (`id_periodo_academico`);

ALTER TABLE `anio_periodo_academico` ADD FOREIGN KEY (`fk_id_institucion_educativa`) REFERENCES `institucion_educativa` (`id_institucion_educativa`);

ALTER TABLE `programa_academico` ADD FOREIGN KEY (`fk_id_facultad`) REFERENCES `facultad` (`id_facultad`);

ALTER TABLE `programa_academico` ADD FOREIGN KEY (`fk_id_director`) REFERENCES `detalle_administrativo` (`id_administrativo`);

ALTER TABLE `asignatura` ADD FOREIGN KEY (`fk_id_departamento`) REFERENCES `departamento` (`id_departamento`);

ALTER TABLE `clase_dia` ADD FOREIGN KEY (`fk_id_dia_semana`) REFERENCES `dia_semana` (`id_dia_semana`);

ALTER TABLE `clase_dia` ADD FOREIGN KEY (`fk_id_clase`) REFERENCES `clase` (`id_clase`);

ALTER TABLE `oferta_academica` ADD FOREIGN KEY (`fk_id_anio_periodo_academico`) REFERENCES `anio_periodo_academico` (`id_anio_periodo_academico`);

ALTER TABLE `oferta_academica` ADD FOREIGN KEY (`fk_id_programa_academico`) REFERENCES `programa_academico` (`id_programa_academico`);

ALTER TABLE `matricula_academica` ADD FOREIGN KEY (`fk_id_oferta_academica`) REFERENCES `oferta_academica` (`id_oferta_academica`);

ALTER TABLE `matricula_academica` ADD FOREIGN KEY (`fk_id_estudiante`) REFERENCES `detalle_estudiante` (`id_estudiante`);

ALTER TABLE `curso` ADD FOREIGN KEY (`fk_id_oferta_academica`) REFERENCES `oferta_academica` (`id_oferta_academica`);

ALTER TABLE `curso` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `grupo` ADD FOREIGN KEY (`fk_id_curso`) REFERENCES `curso` (`id`);

ALTER TABLE `grupo` ADD FOREIGN KEY (`fk_id_docente_asignado`) REFERENCES `detalle_docente` (`id_docente`);

ALTER TABLE `horario_clase` ADD FOREIGN KEY (`fk_id_grupo`) REFERENCES `grupo` (`id`);

ALTER TABLE `horario_clase` ADD FOREIGN KEY (`fk_id_clase_dia`) REFERENCES `clase_dia` (`id_clase_dia`);

ALTER TABLE `horario_clase` ADD FOREIGN KEY (`fk_id_ubicacion_clase`) REFERENCES `ubicacion_clase` (`id_ubicacion_clase`);

ALTER TABLE `historial_academico` ADD FOREIGN KEY (`fk_id_grupo`) REFERENCES `grupo` (`id`);

ALTER TABLE `historial_academico` ADD FOREIGN KEY (`fk_id_estudiante`) REFERENCES `detalle_estudiante` (`id_estudiante`);

ALTER TABLE `nota_estudiante_asignatura_matriculada` ADD FOREIGN KEY (`fk_id_matricula_academica`) REFERENCES `matricula_academica` (`id_matricula_academica`);

ALTER TABLE `nota_estudiante_asignatura_matriculada` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `creditos_aprobados_estudiante_programa_academico` ADD FOREIGN KEY (`fk_id_estudiante`) REFERENCES `detalle_estudiante` (`id_estudiante`);

ALTER TABLE `creditos_aprobados_estudiante_programa_academico` ADD FOREIGN KEY (`fk_id_programa_academico`) REFERENCES `programa_academico` (`id_programa_academico`);

ALTER TABLE `prerequisitos_asignatura` ADD FOREIGN KEY (`fk_id_asignatura`) REFERENCES `asignatura` (`id_asignatura`);

ALTER TABLE `prerequisitos_asignatura` ADD FOREIGN KEY (`fk_id_asignatura_prerequisito`) REFERENCES `asignatura` (`id_asignatura`);

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


--
--
-- Volcado de datos para la tabla `sexo`
--

INSERT INTO `sexo` (`id_sexo`, `nombre_sexo`) VALUES
(1, 'Masculino'),
(2, 'Femenino');


--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `sexo`, `nombres`, `apellidos`, `correo_electronico`, `telefono`, `contrasena_salt`, `contrasena_hash`, `url_foto`) VALUES
(1, 1, 'Luis Fernando ', 'Gaviria Trujillo', 'gaviria@correo.com', '123', '123', '123', NULL),
(2, 1, 'Alexander', 'Molina Cabrera', 'decanoingenierias@utp.edu.co', '123', '123', '123', NULL),
(3, 1, 'Juan Pablo', 'Trujillo Lemus', 'jtrujillo@utp.edu.co', '123', '123', '123', NULL),
(4, 1, 'Enrique Demesio', 'Arias Castaño', 'decanaturabellasartes@utp.edu.co', '123', '123', '123', NULL),
(5, 2, 'Cecilia Luca', 'Escobar Vekeman', 'decaeducacion@utp.edu.co', '123', '123', '123', NULL),
(6, 1, 'Wilson', 'Arenas Valencia', 'warenas@utp.edu.co', '123', '123', '123', NULL),
(111, 1, 'Edsger ', 'Dijkstra', 'eDijkstra@utp.edu.co', '111', '111', 'dmfkifj', NULL),
(222, 1, 'Eduardo', 'Sáenz de Cabezón', 'derivando@utp.edu.co', '222', '222', 'dmfkifj', NULL),
(333, 1, 'Jose Luis', 'Crespo Cepeda', 'quantumfracture@utp.edu.co', '333', '333', 'dmfkifj', NULL),
(444, 1, 'Javier', 'Santaolalla', 'dateunvoltio@utp.edu.co', '444', '444', 'dmfkifj', NULL),
(777, 1, 'Ludwig', 'Von Bertalanffy', 'ludwig@utp.edu.co', '777', '777', 'dmfkifj', NULL),
(6688, 1, 'Richard', 'Dorf', 'dorf@utp.edu.co', '6688', '6688', 'dmfkifj', NULL),
(999, 1, 'Alan', 'Turing', 'turing@utp.edu.co', '999', '999', 'dmfkifj', NULL),
(1010, 1, 'Bill', 'Gates', 'bgates@utp.edu.co', '1010', '1010', 'dmfkifj', NULL),
(1111, 1, 'Thomas', 'Bayes', 'tbayes@utp.edu.co', '1111', '1111', 'dmfkifj', NULL),
(1212, 1, 'Grady', 'Booch', 'gbooch@utp.edu.co', '1212', '1212', 'dmfkifj', NULL),
(1314, 1, 'Thomas', 'Floyd', 'floyd@utp.edu.co', '1314', '1314', 'dmfkifj', NULL),
(123, 2, 'Lady ', 'Gaga', 'bbymonster@utp.edu.co', '911', '123', '123', NULL),
(124, 1, 'Christopher', 'Bang', 'bangchan@utp.edu.co', '124', '124', '124', NULL),
(125, 2, 'Perry', 'Edwards', 'perry@utp.edu.co', '125', '125', '125', NULL),
(126, 1, 'Sam', 'Smith', 'sams@utp.edu.co', '126', '126', '126', NULL),
(127, 2, 'Ariana', 'Grande', 'ariana@utp.edu.co', '127', '127', '127', NULL),
(456, 1, 'Harry', 'Styles', 'hstyles@utp.edu.co', '456', '456', '456', NULL),
(457, 1, 'Luke', 'Hemmings', 'luke@utp.edu.co', '457', '457', '457', NULL),
(458, 2, 'Billie', 'Eilish', 'b.eilish@utp.edu.co', '458', '458', '458', NULL),
(459, 1, 'Rami', 'Malek', 'rami@utp.edu.co', '459', '459', '459', NULL),
(789, 1, 'Elon ', 'Musk', 'tesla@utp.edu.co', '789', '789', '789', NULL),
(790, 2, 'Dua', 'Lipa', 'dualipa@utp.edu.co', '790', '790', '790', NULL),
(791, 1, 'Will', 'Smith', 'wsmith@utp.edu.co', '791', '791', '791', NULL),
(792, 2, 'Selena', 'Gomez', 'selena@utp.edu.co', '792', '792', '792', NULL),
(12345, 2, 'Maria Camila', 'Ramirez', 'm.ramirez8@utp.edu.co', '3333335', '12345', '12345', NULL);
COMMIT;


--
-- Volcado de datos para la tabla `direccion`
--

INSERT INTO `direccion` (`id_direccion`, `direccion`, `barrio`, `ciudad`, `departamento`) VALUES
(111, 'Carrera 1 Calle 1-1', 'Un barrio', 'Róterdam', 'Países Bajos'),
(222, 'Carrera 2 Calle 2-2', 'Un barrio', 'Logroño', 'España'),
(333, 'Carrera 3 Calle 3-3', 'Un barrio', 'Madrid', 'España'),
(444, 'Carrera 4 Calle 4-4', 'Un barrio', 'Burgos', 'España'),
(6688, 'Carrera 6 Calle 6-8', 'Un barrio', 'California', 'Estados Unidos'),
(777, 'Carrera 7 Calle 7-7', 'Un barrio', 'Viena', 'Austria'),
(999, 'Carrera 9 Calle 9-9', 'Un barrio', 'Londres', 'Reino Unido'),
(1010, 'Carrera 10 Calle 10-10', 'Un barrio', 'Washington', 'Estados Unidos'),
(1111, 'Carrera 11 Calle 11-11', 'Un barrio', 'Londres', 'Reino Unido'),
(1212, 'Carrera 12 Calle 12-12', 'Un barrio', 'California', 'Estados Unidos'),
(1314, 'Carrera 13 Calle 13-14', 'Un barrio', 'California', 'Estados Unidos'),
(123, 'Carrera 1 Calle 2-3', 'Un barrio ', 'Nueva York', 'Estados Unidos'),
(124, 'Carrera 1 Calle 2-4', 'Un barrio ', 'Seúl', 'Corea del Sur'),
(125, 'Carrera 1 Calle 2-5', 'Un barrio ', 'South Shields', 'Reino Unido'),
(126, 'Carrera 1 Calle 2-6', 'Un barrio ', 'Londres', 'Reino Unido'),
(127, 'Carrera 1 Calle 2-7', 'Un barrio ', 'Florida', 'Estados Unidos'),
(456, 'Carrera 4 Calle 5-6', 'Un barrio ', 'Redditch', 'Reino Unido'),
(457, 'Carrera 4 Calle 5-7', 'Un barrio ', 'Sídney', 'Australia'),
(458, 'Carrera 4 Calle 5-8', 'Un barrio ', 'California', 'Estados Unidos'),
(459, 'Carrera 4 Calle 5-9', 'Un barrio ', 'California', 'Estados Unidos'),
(789, 'Carrera 7 Calle 8-9', 'Un barrio ', 'Pretoria', 'Sudáfrica'),
(790, 'Carrera 7 Calle 9-0', 'Un barrio ', 'Londres', 'Reino Unido'),
(791, 'Carrera 7 Calle 9-1', 'Un barrio ', 'Pensilvania', 'Estados Unidos'),
(792, 'Carrera 7 Calle 9-2', 'Un barrio ', 'Texas', 'Estados Unidos'),
(12345, 'UTP', 'Un barrio', 'Pereira', 'Risaralda');


--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`id_permiso`, `nombre_permiso`, `descripcion`) VALUES
(1, 'Permiso Administrativo 1', 'Administrativo con la capacidad de ver y editar infomación laboral'),
(2, 'Permiso Administrativo 2', 'Administrativo con la capacidad de ver, crear y editar asignaturas'),
(3, 'Permiso Docente', 'Usuario con capacidades limitadas en ciertos modulos'),
(4, 'Permiso Estudiante', 'Usuario con capacidades limitadas en ciertos modulos');

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id_rol`, `nombre_rol`) VALUES
(1, 'Administrativo'),
(2, 'Docente'),
(3, 'Estudiante');

--
-- Volcado de datos para la tabla `rol_permiso`
--

INSERT INTO `rol_permiso` (`id`, `fk_id_rol`, `fk_id_permiso`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 3),
(4, 3, 4);


--
-- Volcado de datos para la tabla `asignacion_roles`
--

INSERT INTO `asignacion_roles` (`fk_id_usuario`, `fk_id_rol`) VALUES
(111, 2),
(222, 2),
(333, 2),
(444, 2),
(777, 2),
(6688, 2),
(999, 2),
(1010, 2),
(1111, 2),
(1212, 2),
(1314, 2),
(123, 3),
(124, 3),
(125, 3),
(126, 3),
(127, 3),
(456, 3),
(457, 3),
(458, 3),
(459, 3),
(789, 3),
(790, 3),
(791, 3),
(792, 3),
(12345, 1);

--
--
-- Volcado de datos para la tabla `tipo_contrato`
--

INSERT INTO `tipo_contrato` (`id_tipo_contrato`, `nombre_contrato`) VALUES
(1, 'Planta'),
(2, 'Transitorio'),
(3, 'Catedrático');


-- Volcado de datos para la tabla `estado_academico`
--

INSERT INTO `estado_academico` (`id_estado_academico`, `nombre_estado_academico`) VALUES
(1, 'Activo'),
(2, 'Inactivo');

--
-- Volcado de datos para la tabla `detalle_estudiante`
--

INSERT INTO `detalle_estudiante` (`id_estudiante`, `fk_id_estado_academico`) VALUES
(123, 1),
(456, 1),
(789, 1),
(124, 1),
(125, 1),
(126, 1),
(127, 2),
(457, 1),
(458, 1),
(459, 1),
(790, 1),
(791, 2),
(792, 1);


--
-- Volcado de datos para la tabla `detalle_administrativo`
--

INSERT INTO `detalle_administrativo` (`id_administrativo`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(12345);


--
-- Volcado de datos para la tabla `cargo_administrativo`
--

INSERT INTO `cargo_administrativo` (`id_cargo_administrativo`, `nombre_cargo_administrativo`, `descripcion_cargo_administrativo`) VALUES
(1, 'Rector', 'Persona encargada tomar decisiones sobre la institución educativa'),
(2, 'Director de facultad', 'Persona encargada tomar decisiones sobre determinada facultad'),
(3, 'Director de departamento', 'Persona encargada tomar decisiones sobre determinado departamento'),
(4, 'Director de programa academico', 'Persona encargada tomar decisiones sobre determinada programa academico'),
(5, 'Administrativo Registro y control', 'Persona que se encarga de la administración de asignaturas, cursos, estudiantes y docentes');


--
-- Volcado de datos para la tabla `detalle_administrativo_cargo_administrativo`
--
INSERT INTO `detalle_administrativo_cargo_administrativo` (`fk_id_administrativo`, `fk_id_cargo_administrativo`) VALUES
(1, 1),
(2, 2),
(3, 2),
(4, 2),
(5, 2);


--
-- Volcado de datos para la tabla `institucion_educativa`
--

INSERT INTO `institucion_educativa` (`id_institucion_educativa`, `nombre_institucion_educativa`, `fecha_fundacion`, `fk_id_rector`, `anio_vigente`, `periodo_academico_vigente`) VALUES
(1, 'Word Wise Institute', '2008-08-08', 1, 2023, 1);


--
-- Volcado de datos para la tabla `periodo_academico`
--

INSERT INTO `periodo_academico` (`id_periodo_academico`, `nombre`, `descripcion`) VALUES
(1, 'Primer Semestre', 'Se refiere a los primeros 6 meses, que corresponde'),
(2, 'Segundo semestre', 'Se refiere a los últimos 6 meses, que corresponden'),
(3, 'Intersemestral 1', 'Corresponde al espacio entre el semestre 1 y 2'),
(4, 'Intersemestral 2', 'Corresponde al espacio entre el semestre 2 y 1 del');


--
-- Volcado de datos para la tabla `anio_periodo_academico`
--

INSERT INTO `anio_periodo_academico` (`id_anio_periodo_academico`, `anio`, `fk_id_periodo_academico`, `fk_id_institucion_educativa`, `fecha_matricula`, `fecha_inicio`, `fecha_final`) VALUES
(1, 2023, 1, 1, '2023-01-04', '2023-02-06', '2023-06-27'),
(2, 2023, 2, 1, '2023-07-19', '2023-06-01', '2023-12-08');


--
-- Volcado de datos para la tabla `facultad`
--

INSERT INTO `facultad` (`id_facultad`, `nombre_facultad`, `ubicacion`, `fk_id_institucion_educativa`, `fk_id_director_facultad`) VALUES
(1, 'Facultad de Ingenierías', 'Edificio 3, entrada principal', 1, 2),
(2, 'Facultad de Ciencias Básicas', 'Edificio 1A, 4 piso entrada principal', 1, 3),
(3, 'Facultad de Bellas Artes y Humanidades', 'Edificio 12A, 5 piso, Entrada F', 1, 4),
(4, 'Facultad de Ciencias de la educación', 'Edificio 7A, 1 piso, Entrada ', 1, 5),
(5, 'Facultad de Ciencias Empresariales', 'Edificio 5, 1 piso, Entrada A', 1, 6);


--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`id_departamento`, `nombre_departamento`, `fk_id_facultad`, `fk_id_institucion_educativa`, `fk_id_jefe_departamento`) VALUES
(1, 'Departamento de Ingenierías', 1, 1, 1),
(2, 'Departamento de ciencias básicas', 2, 1, 2),
(3, 'Departamento de bellas artes y humanidades', 3, 1, 3),
(4, 'Departamento de ciencias de la educacion', 4, 1, 5),
(5, 'Departamento de ciencias empresariales', 5, 1, 6);


--
-- Volcado de datos para la tabla `asignatura`
--

INSERT INTO `asignatura` (`id_asignatura`, `fk_id_departamento`, `nombre`, `num_creditos`, `max_estudiantes`, `descripcion`, `intensidad_horaria`, `costo`, `curso_extension`) VALUES
(1, 1, 'Programación III', 3, 60, NULL, NULL, NULL, 0),
(2, 2, 'Matematicas IV', 3, 120, NULL, NULL, NULL, 0),
(3, 2, 'Fisica III', 4, 120, NULL, NULL, NULL, 0),
(4, 2, 'Laboratorio de fisica III', 2, 60, NULL, NULL, NULL, 0),
(5, 1, 'Fundamentos de electrónica', 3, 60, NULL, NULL, NULL, 0),
(6, 1, 'Fundamentos de electrónica 2', 3, 60, NULL, NULL, NULL, 0),
(7, 1, 'Teoria de sistemas', 2, 60, NULL, NULL, NULL, 0),
(8, 1, 'Laboratorio de electronica', 2, 60, NULL, NULL, NULL, NULL),
(9, 1, 'Gramaticas y lenguajes formales', 4, 100, NULL, NULL, NULL, NULL),
(10, 1, 'Administracion de empresas', 3, 120, NULL, NULL, NULL, NULL),
(11, 1, 'Estadistica', 2, 60, NULL, NULL, NULL, NULL),
(12, 1, 'Programación IV', 3, 60, NULL, NULL, NULL, NULL),
(13, 1, 'Electrónica digital', 3, 60, NULL, NULL, NULL, NULL),
(14, 1, 'Laboratorio de electronica digital', 2, 60, NULL, NULL, NULL, NULL),
(15, 2, 'Metodos numericos', 3, 120, NULL, NULL, NULL, NULL),
(16, 1, 'Electrónica general', 3, 60, NULL, NULL, NULL, NULL),
(17, 1, 'Laboratorio de electronica general', 2, 60, NULL, NULL, NULL, NULL),
(18, 1, 'Estadistica Ing. Física', 3, 60, NULL, NULL, NULL, NULL),
(19, 1, 'Electrónica lineal', 3, 60, NULL, NULL, NULL, NULL),
(20, 1, 'Mecanica de fluidos', 3, 60, NULL, NULL, NULL, NULL),
(21, 1, 'Programación II Ing.fisica', 3, 120, NULL, NULL, NULL, NULL),
(22, 1, 'Termodinámica', 3, 60, NULL, NULL, NULL, NULL),
(23, 1, 'Metodos matemáticos para la física', 3, 60, NULL, NULL, NULL, NULL),
(24, 1, 'Laboratorio de electronica lineal', 2, 60, NULL, NULL, NULL, NULL),
(25, 2, 'Metodos numericos y programación', 3, 120, NULL, NULL, NULL, NULL),
(26, 1, 'Electromagnetismo I', 3, 60, NULL, NULL, NULL, NULL),
(27, 1, 'Fundamentos de mecánica', 3, 60, NULL, NULL, NULL, NULL),
(28, 1, 'Electiva Socio Humanística III', 3, 60, NULL, NULL, NULL, NULL),
(29, 1, 'Estadística y probabilidad', 3, 60, NULL, NULL, NULL, NULL),
(30, 1, 'Circuitos eléctricos I', 4, 60, NULL, NULL, NULL, NULL),
(31, 1, 'Generación de energía eléctrica', 3, 120, NULL, NULL, NULL, NULL),
(32, 1, 'Electromagnetismo II', 3, 60, NULL, NULL, NULL, NULL),
(33, 1, 'Manufactura I', 2, 120, NULL, NULL, NULL, NULL),
(34, 1, 'Materiales de Ingeniería I', 2, 60, NULL, NULL, NULL, NULL),
(35, 1, 'Dinámica', 3, 60, NULL, NULL, NULL, NULL),
(36, 5, 'Estadística general', 3, 60, NULL, NULL, NULL, NULL),
(37, 2, 'Ecuaciones diferenciales', 3, 60, NULL, NULL, NULL, NULL),
(38, 1, 'Resistencia de materiales I', 3, 60, NULL, NULL, NULL, NULL),
(39, 1, 'Termonodinámica I', 3, 60, NULL, NULL, NULL, NULL),
(40, 1, 'Manufactura II', 2, 120, NULL, NULL, NULL, NULL),
(41, 1, 'Teoría de maquinas y mecanismos', 4, 60, NULL, NULL, NULL, NULL),
(42, 1, 'Dibujo de maquinas', 3, 60, NULL, NULL, NULL, NULL),
(43, 1, 'Materiales de ingeniería II', 2, 60, NULL, NULL, NULL, NULL),
(44, 3, 'Dibujo IV', 3, 60, NULL, NULL, NULL, NULL),
(45, 3, 'Técnicas de impresión', 2, 60, NULL, NULL, NULL, NULL),
(46, 3, 'Técnología de la imagen II', 2, 60, NULL, NULL, NULL, NULL),
(47, 3, 'Arte Latinoamericano', 3, 60, NULL, NULL, NULL, NULL),
(48, 3, 'Arte de la tierra', 3, 60, NULL, NULL, NULL, NULL),
(49, 3, 'Practica pedagogica II', 3, 60, NULL, NULL, NULL, NULL),
(50, 3, 'Psicología del desarrollo', 2, 60, NULL, NULL, NULL, NULL),
(51, 3, 'Dibujo y expresión', 3, 60, NULL, NULL, NULL, NULL),
(52, 3, 'Taller tridimensional', 3, 60, NULL, NULL, NULL, NULL),
(53, 3, 'Metodología de la investigación I', 2, 60, NULL, NULL, NULL, NULL),
(54, 3, 'Administración educacional', 3, 60, NULL, NULL, NULL, NULL),
(55, 3, 'Taller bidimensional I', 3, 60, NULL, NULL, NULL, NULL),
(56, 3, 'Práctica pedagogica III', 3, 60, NULL, NULL, NULL, NULL),
(57, 3, 'Medios de comunicación', 2, 60, NULL, NULL, NULL, NULL),
(58, 3, 'Didáctica de la filosofía II', 4, 60, NULL, NULL, NULL, NULL),
(59, 3, 'Psicología II', 4, 60, NULL, NULL, NULL, NULL),
(60, 3, 'Estética moderna II', 3, 60, NULL, NULL, NULL, NULL),
(61, 3, 'Empirismo', 3, 60, NULL, NULL, NULL, NULL),
(62, 3, 'Filosofía Antigua', 4, 60, NULL, NULL, NULL, NULL),
(63, 3, 'Seminario de investigación en el Aula', 5, 60, NULL, NULL, NULL, NULL),
(64, 3, 'Filosofía de la educación', 4, 60, NULL, NULL, NULL, NULL),
(65, 3, 'Filosofía moderna', 4, 60, NULL, NULL, NULL, NULL),
(66, 3, 'Estética y filosofía del arte', 4, 60, NULL, NULL, NULL, NULL),
(67, 3, 'Psicoliguística', 3, 60, NULL, NULL, NULL, NULL),
(68, 3, 'Pronunciación inglesa II', 3, 60, NULL, NULL, NULL, NULL),
(69, 3, 'Inglés Intermedio Alto', 6, 60, NULL, NULL, NULL, NULL),
(70, 3, 'Discurso académico I', 3, 60, NULL, NULL, NULL, NULL),
(71, 3, 'Gramática aavanzada', 4, 60, NULL, NULL, NULL, NULL),
(72, 3, 'Sociolinguística', 3, 60, NULL, NULL, NULL, NULL),
(73, 3, 'Adquisión del lenguaje', 3, 60, NULL, NULL, NULL, NULL),
(74, 3, 'Cultura Anglófona I', 3, 60, NULL, NULL, NULL, NULL),
(75, 3, 'Discurso académico II', 3, 60, NULL, NULL, NULL, NULL),
(76, 3, 'Fundamentos dela investigación y practica pedagogica II', 2, 60, NULL, NULL, NULL, NULL),
(77, 3, 'Piano complementario II', 1, 60, NULL, NULL, NULL, NULL),
(78, 3, 'Historia de la música universal II', 2, 60, NULL, NULL, NULL, NULL),
(79, 3, 'Lenguaje musical IV', 2, 60, NULL, NULL, NULL, NULL),
(80, 3, 'Enfoques pedagogicos', 2, 60, NULL, NULL, NULL, NULL),
(81, 3, 'Práctica coral IV', 2, 60, NULL, NULL, NULL, NULL),
(82, 3, 'Didáctica general', 3, 60, NULL, NULL, NULL, NULL),
(83, 3, 'Electiva instrumento', 1, 60, NULL, NULL, NULL, NULL),
(84, 3, 'Guitarra funcional IV', 1, 60, NULL, NULL, NULL, NULL),
(85, 3, 'TIC para la pedagogía musical III', 2, 60, NULL, NULL, NULL, NULL),
(86, 3, 'Administración Educacional', 2, 60, NULL, NULL, NULL, NULL),
(87, 3, 'Apoyos didácticos, tecnológicos y educativos', 2, 60, NULL, NULL, NULL, NULL),
(88, 3, 'Politicas educativas', 2, 60, NULL, NULL, NULL, NULL),
(89, 3, 'Fundamentos dela investigación y practica pedagogica III', 2, 60, NULL, NULL, NULL, NULL),
(90, 3, 'Piano complementario III', 1, 60, NULL, NULL, NULL, NULL),
(91, 3, 'Historia de la música universal III', 2, 60, NULL, NULL, NULL, NULL),
(92, 3, 'Práctica coral V', 2, 60, NULL, NULL, NULL, NULL),
(93, 3, 'Lenguaje musical V', 2, 60, NULL, NULL, NULL, NULL),
(94, 3, 'Guitarra funcional V', 1, 60, NULL, NULL, NULL, NULL),
(95, 4, 'Seminario de políticas públicas y gestión educativa', 3, 60, NULL, NULL, NULL, NULL),
(96, 4, 'Historia de america latina', 3, 60, NULL, NULL, NULL, NULL),
(97, 4, 'Democracia y constitución política', 3, 60, NULL, NULL, NULL, NULL),
(98, 4, 'Didáctica deas ciencias sociales', 3, 60, NULL, NULL, NULL, NULL),
(99, 4, 'Entidades territoriales y legislación colombiana', 3, 60, NULL, NULL, NULL, NULL),
(100, 4, 'Investigación educativa I', 3, 60, NULL, NULL, NULL, NULL),
(101, 4, 'Seminario familia comunidad y escuela', 3, 60, NULL, NULL, NULL, NULL),
(102, 4, 'Competencias comunicativas II y TICs', 3, 60, NULL, NULL, NULL, NULL),
(103, 4, 'Procesos historicos de construcción de nación en Colombia', 3, 60, NULL, NULL, NULL, NULL),
(104, 4, 'Teoría política', 3, 60, NULL, NULL, NULL, NULL),
(105, 4, 'Seminario de territorios y territorialidades', 3, 60, NULL, NULL, NULL, NULL),
(106, 3, 'Evaluación educativa', 3, 60, NULL, NULL, NULL, NULL),
(107, 4, 'Didáctica del lenguaje', 4, 60, NULL, NULL, NULL, NULL),
(108, 4, 'Construcción y didáctica de las ciencias naturales', 4, 60, NULL, NULL, NULL, NULL),
(109, 4, 'Usos pedagógicos', 2, 60, NULL, NULL, NULL, NULL),
(110, 4, 'Práctica pedagógica I', 8, 60, NULL, NULL, NULL, NULL),
(111, 4, 'Investigación cuantitativa', 2, 60, NULL, NULL, NULL, NULL),
(112, 4, 'Construcción y didática de las ciencias sociales', 4, 60, NULL, NULL, NULL, NULL),
(113, 4, 'Didáctica de las ciencias naturales', 4, 60, NULL, NULL, NULL, NULL),
(114, 4, 'Usos pedagogicos de las TIC II', 2, 60, NULL, NULL, NULL, NULL),
(115, 4, 'Práctica pedagógica II', 8, 60, NULL, NULL, NULL, NULL),
(116, 4, 'Electiva II EBP ', 1, 60, NULL, NULL, NULL, NULL),
(117, 4, 'Administración educativa', 2, 60, NULL, NULL, NULL, NULL),
(118, 4, 'Fonética y fonología del español', 3, 60, NULL, NULL, NULL, NULL),
(119, 4, 'Literatura Amerindia', 3, 60, NULL, NULL, NULL, NULL),
(120, 4, 'Las TIC en el contexto educativo', 4, 60, NULL, NULL, NULL, NULL),
(121, 4, 'Electiva II CL', 2, 60, NULL, NULL, NULL, NULL),
(122, 4, 'Morfología', 3, 60, NULL, NULL, NULL, NULL),
(123, 4, 'Literatura medieval', 3, 60, NULL, NULL, NULL, NULL),
(124, 4, 'Práctica pedagógica: Experiencias significativas', 5, 60, NULL, NULL, NULL, NULL),
(125, 4, 'Literatura Latino Americana I ', 3, 60, NULL, NULL, NULL, NULL),
(126, 4, 'Laboratorio Sonoro', 1, 60, NULL, NULL, NULL, NULL),
(127, 4, 'Radio', 3, 60, NULL, NULL, NULL, NULL),
(128, 4, 'Informática educativa II', 3, 60, NULL, NULL, NULL, NULL),
(129, 4, 'Teorías de la imagen', 3, 60, NULL, NULL, NULL, NULL),
(130, 4, 'Teorías del aprendizaje', 3, 60, NULL, NULL, NULL, NULL),
(131, 4, 'Práctica observacional', 5, 60, NULL, NULL, NULL, NULL),
(132, 4, 'Laboratorio Audiovisual I', 1, 60, NULL, NULL, NULL, NULL),
(133, 4, 'Cine', 3, 60, NULL, NULL, NULL, NULL),
(134, 4, 'Informática educativa III', 3, 60, NULL, NULL, NULL, NULL),
(135, 4, 'Didáctica general', 3, 60, NULL, NULL, NULL, NULL),
(136, 4, 'Administración educativa', 2, 60, NULL, NULL, NULL, NULL),
(137, 4, 'Electiva TC', 2, 60, NULL, NULL, NULL, NULL),
(138, 2, 'Calculo multivariado', 4, 60, NULL, NULL, NULL, NULL),
(139, 5, 'Economía', 3, 60, NULL, NULL, NULL, NULL),
(140, 2, 'Fisica II', 4, 60, NULL, NULL, NULL, NULL),
(141, 2, 'Laboratorio de fisica II', 2, 60, NULL, NULL, NULL, NULL),
(142, 5, 'Sicología organizacional', 2, 60, NULL, NULL, NULL, NULL),
(143, 5, 'Estadítica I', 3, 60, NULL, NULL, NULL, NULL),
(144, 5, 'Contabilidad de empresas', 3, 60, NULL, NULL, NULL, NULL),
(145, 5, 'Administración personal', 3, 60, NULL, NULL, NULL, NULL),
(146, 5, 'Estadística II', 3, 60, NULL, NULL, NULL, NULL),
(147, 5, 'Estática', 3, 60, NULL, NULL, NULL, NULL),
(148, 5, 'Electivas de formación Socio-Humanística II', 4, 60, NULL, NULL, NULL, NULL),
(149, 2, 'Ecuaciones diferenciales', 3, 60, NULL, NULL, NULL, NULL),
(150, 1, 'Curso rápido de JavaScript', NULL, 120, 'Curso para aprender las bases de JavaScript, se requiere conocimientos básicos de programación', 40, 500000, 1);


--
-- Volcado de datos para la tabla `prerequisitos_asignatura`
--

INSERT INTO `prerequisitos_asignatura` (`id`, `fk_id_asignatura`, `fk_id_asignatura_prerequisito`) VALUES
(1, 6, 140),
(2, 13, 6),
(3, 14, 8),
(4, 12, 1),
(5, 3, 140),
(6, 4, 141);


--
-- Volcado de datos para la tabla `detalle_docente`
--

INSERT INTO `detalle_docente` (`id_docente`, `fk_id_departamento`, `url_hoja_de_vida`, `salario`, `fk_id_tipo_contrato`) VALUES
(111, 1, 'dijkstra.com', 7000000, 1),
(222, 1, 'derivando.com', 7000000, 1),
(333, 1, 'quantumfracture.com', 3000000, 3),
(444, 1, 'dateunvoltio.com', 5000000, 2),
(6688, 1, 'dorf.com', 7000000, 1),
(777, 1, 'Bertalanffy.com', 5000000, 2),
(999, 1, 'turing.com', 7000000, 1),
(1010, 1, 'billgates.com', 3000000, 3),
(1111, 1, 'bayes.com', 3000000, 3),
(1212, 1, 'booch.com', 5000000, 2),
(1314, 1, 'floyd.com', 7000000, 1);


--
-- Volcado de datos para la tabla `programa_academico`
--


INSERT INTO `programa_academico` (`id_programa_academico`, `fk_id_facultad`, `nombre`, `total_creditos`, `fk_id_director`) VALUES
(1, 1, 'Ingeniería de Sistemas y Computación', 183, 1),
(2, 1, 'Ingeniería Eléctrica', 174, 2),
(3, 1, 'Ingeniería Física', 175, 3),
(4, 1, 'Ingeniería Mecánica', 174, 2),
(5, 3, 'Licenciatura en artes visuales', 167, 1),
(6, 3, 'Licenciatura en filosofía', 164, 3),
(7, 3, 'Licenciatura en Bilingüismo con Énfasis en Inglés', 152, 5),
(8, 3, 'Licenciatura en Música', 185, 2),
(9, 4, 'Licenciatura en Ciencias Sociales', 146, 1),
(10, 4, 'Licenciatura en Educación Básica Primaria', 2, 6),
(11, 4, 'Licenciatura en Literatura y Lengua Castellana', 159, 4),
(12, 4, 'Licenciatura en Tecnología', 163, 1),
(13, 5, 'Ingeniería Industrial', 176, 12345);


--
-- Volcado de datos para la tabla `pensum_programa_academico`
--


INSERT INTO `pensum_programa_academico` (`id`, `fk_id_programa_academico`, `fk_id_asignatura`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 1, 10),
(11, 1, 11),
(12, 1, 12),
(13, 1, 13),
(14, 1, 14),
(15, 1, 140),
(16, 1, 141),
(17, 2, 25),
(18, 2, 26),
(19, 2, 27),
(20, 2, 28),
(21, 2, 29),
(22, 2, 30),
(23, 2, 31),
(24, 2, 32),
(25, 2, 33),
(26, 2, 34),
(27, 2, 35),
(28, 2, 36),
(29, 2, 2),
(30, 2, 3),
(31, 2, 4),
(32, 2, 140),
(33, 2, 141),
(34, 3, 15),
(35, 3, 16),
(36, 3, 17),
(37, 3, 18),
(38, 3, 19),
(39, 3, 20),
(40, 3, 21),
(41, 3, 22),
(42, 3, 23),
(43, 3, 24),
(44, 3, 2),
(45, 3, 3),
(46, 3, 4),
(47, 3, 140),
(48, 3, 141),
(49, 4, 37),
(50, 4, 38),
(51, 4, 39),
(52, 4, 40),
(53, 4, 41),
(54, 4, 42),
(55, 4, 43),
(56, 4, 2),
(57, 4, 3),
(58, 4, 4),
(59, 4, 140),
(60, 4, 141),
(61, 5, 44),
(62, 5, 45),
(63, 5, 46),
(64, 5, 47),
(65, 5, 48),
(66, 5, 49),
(67, 5, 50),
(68, 5, 51),
(69, 5, 52),
(70, 5, 53),
(71, 5, 54),
(72, 5, 55),
(73, 5, 56),
(74, 5, 57),
(75, 6, 58),
(76, 6, 59),
(77, 6, 60),
(78, 6, 61),
(79, 6, 62),
(80, 6, 63),
(81, 6, 64),
(82, 6, 65),
(83, 6, 66),
(84, 7, 67),
(85, 7, 68),
(86, 7, 69),
(87, 7, 70),
(88, 7, 71),
(89, 7, 72),
(90, 7, 73),
(91, 7, 74),
(92, 7, 75),
(93, 7, 76),
(94, 8, 77),
(95, 8, 78),
(96, 8, 79),
(97, 8, 80),
(98, 8, 81),
(99, 8, 82),
(100, 8, 83),
(101, 8, 84),
(102, 8, 85),
(103, 8, 86),
(104, 8, 87),
(105, 8, 88),
(106, 8, 89),
(107, 8, 90),
(108, 8, 91),
(109, 8, 92),
(110, 8, 93),
(111, 8, 94),
(112, 9, 95),
(113, 9, 96),
(114, 9, 97),
(115, 9, 98),
(116, 9, 99),
(117, 9, 100),
(118, 9, 101),
(119, 9, 102),
(120, 9, 103),
(121, 9, 104),
(122, 9, 105),
(123, 9, 106),
(124, 10, 107),
(125, 10, 108),
(126, 10, 109),
(127, 10, 110),
(128, 10, 111),
(129, 10, 112),
(130, 10, 113),
(131, 10, 114),
(132, 10, 115),
(133, 10, 116),
(134, 11, 117),
(135, 11, 118),
(136, 11, 119),
(137, 11, 120),
(138, 11, 121),
(139, 11, 122),
(140, 11, 123),
(141, 11, 124),
(142, 11, 125),
(143, 12, 126),
(144, 12, 127),
(145, 12, 128),
(146, 12, 129),
(147, 12, 130),
(148, 12, 131),
(149, 12, 132),
(150, 12, 133),
(151, 12, 134),
(152, 12, 135),
(153, 12, 136),
(154, 12, 137),
(155, 13, 138),
(156, 13, 139),
(157, 13, 140),
(158, 13, 141),
(159, 13, 142),
(160, 13, 143),
(161, 13, 144),
(162, 13, 145),
(163, 13, 146),
(164, 13, 147),
(165, 13, 148),
(166, 13, 2),
(167, 13, 3),
(168, 13, 4);

--
-- Volcado de datos para la tabla `docente_asignatura`
--

INSERT INTO `docente_asignatura` (`id`, `fk_id_docente`, `fk_id_asignatura`) VALUES
(1, 111, 1),
(2, 222, 2),
(3, 333, 3),
(4, 444, 4),
(5, 6688, 6),
(6, 6688, 8),
(7, 777, 7),
(8, 999, 9),
(9, 1010, 10),
(10, 1111, 11),
(11, 1212, 12),
(12, 1314, 13),
(13, 1314, 14);


--
-- Volcado de datos para la tabla `oferta_academica`
--

INSERT INTO `oferta_academica` (`id_oferta_academica`, `fk_id_anio_periodo_academico`, `fk_id_programa_academico`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 1, 2),
(4, 2, 2),
(5, 1, 3),
(6, 2, 3),
(7, 1, 4),
(8, 2, 4),
(9, 1, 5),
(10, 1, 6),
(11, 1, 7),
(12, 2, 7),
(13, 1, 8),
(14, 1, 9),
(15, 2, 9),
(16, 1, 10),
(17, 2, 10),
(18, 1, 11),
(19, 2, 11),
(20, 1, 12),
(21, 2, 12),
(22, 1, 13),
(23, 2, 13);

--
-- Volcado de datos para la tabla `matricula_academica`
--

INSERT INTO `matricula_academica` (`id_matricula_academica`, `fk_id_oferta_academica`, `fk_id_estudiante`) VALUES
(1, 1, 123),
(2, 1, 124),
(3, 1, 125),
(4, 1, 126),
(5, 1, 127),
(6, 1, 456),
(7, 1, 457),
(8, 1, 458),
(9, 1, 459),
(10, 1, 789),
(11, 1, 790),
(12, 1, 791),
(13, 1, 792);

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`id`, `fk_id_oferta_academica`, `fk_id_asignatura`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(15, 1, 150),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 1, 10),
(11, 1, 11),
(12, 1, 12),
(13, 1, 13),
(14, 1, 14);


--
-- Volcado de datos para la tabla `clase`
--
INSERT INTO `clase` (`id_clase`, `hora_inicio`, `hora_final`) VALUES
(709, 7, 9),
(911, 9, 11),
(1113, 11, 13),
(1416, 14, 16),
(1618, 16, 18),
(1820, 18, 20),
(2022, 20, 22);


--
-- Volcado de datos para la tabla `grupo`
--

INSERT INTO `grupo` (`id`, `fk_id_curso`, `numero_grupo`, `fk_id_docente_asignado`) VALUES
(1, 1, 1, 111),
(2, 1, 2, 1212),
(3, 2, 1, 222),
(4, 2, 2, 222),
(5, 3, 1, 333),
(6, 4, 1, 444),
(7, 7, 1, 777),
(8, 6, 1, 6688),
(9, 8, 1, 6688),
(10, 9, 1, 999),
(11, 9, 2, 999),
(12, 10, 1, 1010),
(13, 11, 1, 1111),
(14, 12, 1, 1212),
(15, 12, 2, 111),
(16, 13, 1, 1314),
(17, 14, 1, 1314),
(18, 15, 1, 111);


--
-- Volcado de datos para la tabla `dia_semana`
--

INSERT INTO `dia_semana` (`id_dia_semana`, `nombre_dia_semana`) VALUES
(1, 'Lunes'),
(2, 'Martes'),
(3, 'Miercoles'),
(4, 'Jueves'),
(5, 'Viernes'),
(6, 'Sábado'),
(7, 'Domingo');

--


INSERT INTO `clase_dia` (`id_clase_dia`, `fk_id_dia_semana`, `fk_id_clase`) VALUES
(107, 1, 709),
(207, 2, 709),
(307, 3, 709),
(407, 4, 709),
(507, 5, 709),
(607, 6, 709),
(109, 1, 911),
(209, 2, 911),
(309, 3, 911),
(409, 4, 911),
(509, 5, 911),
(609, 6, 911),
(111, 1, 1113),
(211, 2, 1113),
(311, 3, 1113),
(411, 4, 1113),
(511, 5, 1113),
(611, 6, 1113),
(114, 1, 1416),
(214, 2, 1416),
(314, 3, 1416),
(414, 4, 1416),
(514, 5, 1416),
(614, 6, 1416),
(116, 1, 1618),
(216, 2, 1618),
(316, 3, 1618),
(416, 4, 1618),
(516, 5, 1618),
(616, 6, 1618),
(118, 1, 1820),
(218, 2, 1820),
(318, 3, 1820),
(418, 4, 1820),
(518, 5, 1820),
(120, 1, 2022),
(220, 2, 2022),
(320, 3, 2022),
(420, 4, 2022),
(520, 5, 2022);



INSERT INTO `ubicacion_clase` (`id_edificio`, `id_salon`, `nombre`, `descripcion`) VALUES
(1, 123, 'crie', ''),
(2, 234, 'hell', ''),
(3, 345, 'industrial', ''),
(4, 456, 'piscina', ''),
(5, 567, 'la concha de tu madre', '');

--
-- Volcado de datos para la tabla `horario_clase`
--

INSERT INTO `horario_clase` (`id`, `fk_id_grupo`, `fk_id_clase_dia`, `fk_id_ubicacion_clase`) VALUES
(1, 1, 207, 1),
(2, 1, 407, 2),
(3, 2, 209, 3),
(4, 2, 409, 4),
(5, 3, 311, 5),
(6, 3, 411, 1),
(7, 4, 318, 3),
(8, 4, 418, 3),
(9, 5, 109, 4),
(10, 5, 309, 5),
(11, 5, 509, 1),
(12, 6, 314, 2),
(13, 7, 107, 3),
(14, 7, 507, 4),
(15, 8, 207, 5),
(16, 8, 407, 1),
(17, 9, 316, 2),
(18, 10, 111, 3),
(19, 10, 311, 4),
(20, 10, 511, 5),
(21, 11, 118, 1),
(22, 11, 318, 2),
(23, 11, 518, 3),
(24, 12, 211, 4),
(25, 12, 411, 5),
(26, 13, 114, 1),
(27, 13, 414, 2),
(28, 14, 207, 3),
(29, 14, 507, 2),
(30, 15, 207, 2),
(31, 15, 507, 1),
(32, 16, 307, 2),
(33, 16, 407, 3),
(34, 17, 309, 4),
(35, 18, 609, 5);

--
-- Volcado de datos para la tabla `historial_academico`
--

INSERT INTO `historial_academico` (`id`, `fk_id_grupo`, `fk_id_estudiante`, `nota_estudiante_curso`) VALUES
(1, 2, 456, NULL),
(2, 3, 456, NULL),
(3, 5, 456, NULL),
(4, 6, 456, NULL),
(5, 8, 456, NULL),
(6, 7, 456, NULL),
(7, 9, 456, NULL),
(8, 2, 457, NULL),
(9, 3, 457, NULL),
(10, 5, 457, NULL),
(11, 6, 457, NULL),
(12, 8, 457, NULL),
(13, 7, 457, NULL),
(14, 9, 457, NULL),
(15, 2, 459, NULL),
(16, 3, 459, NULL),
(17, 5, 459, NULL),
(18, 6, 459, NULL),
(19, 8, 459, NULL),
(20, 7, 459, NULL),
(21, 9, 459, NULL),
(22, 2, 790, NULL),
(23, 3, 790, NULL),
(24, 5, 790, NULL),
(25, 6, 790, NULL),
(26, 8, 790, NULL),
(27, 7, 790, NULL),
(28, 9, 790, NULL),
(29, 1, 123, NULL),
(30, 1, 126, NULL),
(31, 10, 123, NULL),
(32, 12, 123, NULL),
(33, 13, 123, NULL),
(34, 16, 123, NULL),
(35, 17, 123, NULL),
(36, 10, 124, NULL),
(37, 12, 124, NULL),
(38, 13, 124, NULL),
(39, 14, 124, NULL),
(40, 16, 124, NULL),
(41, 17, 124, NULL);

-- 
-- Volcado de datos para la tabla `nota_estudiante_asignatura_matriculada`
--

INSERT INTO `nota_estudiante_asignatura_matriculada` (`id`, `fk_id_matricula_academica`, `fk_id_asignatura`, `nota_final_estudiante_asignatura`) VALUES
(1, 1, 1, NULL),
(2, 1, 10, NULL),
(3, 1, 12, NULL),
(4, 1, 13, NULL),
(5, 1, 16, NULL),
(6, 1, 17, NULL),
(7, 2, 10, NULL),
(8, 2, 12, NULL),
(9, 2, 13, NULL),
(10, 2, 14, NULL),
(11, 2, 16, NULL),
(12, 2, 17, NULL),
(13, 4, 1, NULL),
(14, 6, 1, NULL),
(15, 6, 2, NULL),
(16, 6, 3, NULL),
(17, 6, 4, NULL),
(18, 6, 6, NULL),
(19, 6, 7, NULL),
(20, 6, 8, NULL),
(21, 7, 1, NULL),
(22, 7, 2, NULL),
(23, 7, 3, NULL),
(24, 7, 4, NULL),
(25, 7, 6, NULL),
(26, 7, 7, NULL),
(27, 7, 8, NULL),
(28, 9, 1, NULL),
(29, 9, 2, NULL),
(30, 9, 3, NULL),
(31, 9, 4, NULL),
(32, 9, 6, NULL),
(33, 9, 7, NULL),
(34, 9, 8, NULL),
(35, 10, 1, NULL),
(36, 10, 2, NULL),
(37, 10, 3, NULL),
(38, 10, 4, NULL),
(39, 10, 6, NULL),
(40, 10, 7, NULL),
(41, 10, 8, NULL);

-- 
-- Volcado de datos para la tabla `creditos_aprobados_estudiante_programa_academico`
--

INSERT INTO `creditos_aprobados_estudiante_programa_academico` (`id`, `fk_id_estudiante`, `fk_id_programa_academico`, `total_creditos_aprobados`) VALUES
(1, 123, 1, 75),
(2, 124, 1, 75),
(3, 125, 1, 75),
(4, 126, 1, 75),
(5, 127, 1, 84),
(6, 456, 1, 56),
(7, 457, 1, 56),
(8, 458, 1, 75),
(9, 459, 1, 56),
(10, 789, 1, 86),
(11, 790, 1, 56),
(12, 791, 1, 84),
(13, 792, 1, 75);
