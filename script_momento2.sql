-- =============================================================================
-- SEGUNDA ENTREGA: SEMANA 12 - CONSTRUCCION Y MANIPULACION DE BASE DE DATOS
-- Motor: Microsoft SQL Server (SSMS)
-- Proyecto Integrador: Sistema de Gestion de Reservas de Espacios
-- =============================================================================

-- =============================================================================
-- PARTE 1: SCRIPT DE ESTRUCTURA (DDL)
-- =============================================================================

CREATE DATABASE sistema_reservas;
GO

USE sistema_reservas;
GO

-- TABLA: usuario
CREATE TABLE usuario (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20) DEFAULT 'Sin telefono',
    fecha_registro DATETIME DEFAULT GETDATE() NOT NULL,
    estado VARCHAR(20) DEFAULT 'ACTIVO' NOT NULL CHECK (estado IN ('ACTIVO', 'INACTIVO'))
);

-- TABLA: tipo_espacio
CREATE TABLE tipo_espacio (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    descripcion VARCHAR(MAX)
);

-- TABLA: espacio
CREATE TABLE espacio (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL CHECK (capacidad > 0),
    precio_hora NUMERIC(10,2) NOT NULL CHECK (precio_hora > 0),
    tipo_espacio_id INT NOT NULL REFERENCES tipo_espacio(id) ON DELETE CASCADE,
    disponible BIT DEFAULT 1 NOT NULL
);

-- TABLA: reserva
CREATE TABLE reserva (
    id INT IDENTITY(1,1) PRIMARY KEY,
    usuario_id INT NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
    espacio_id INT NOT NULL REFERENCES espacio(id) ON DELETE NO ACTION,
    fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME NOT NULL,
    total_pagar NUMERIC(10,2) NOT NULL CHECK (total_pagar >= 0),
    estado_reserva VARCHAR(20) DEFAULT 'CONFIRMADA' NOT NULL CHECK (estado_reserva IN ('CONFIRMADA', 'CANCELADA', 'COMPLETADA')),
    CONSTRAINT chk_fechas CHECK (fecha_fin > fecha_inicio)
);

-- Requisito Obligatorio: Uso de ALTER TABLE
ALTER TABLE reserva ADD observaciones VARCHAR(MAX) DEFAULT 'Sin observaciones';
GO

-- =============================================================================
-- PARTE 2: SCRIPT DE POBLACION (DML - INSERT / UPDATE)
-- =============================================================================

-- Poblacion de tabla tipo_espacio (20 registros)
INSERT INTO tipo_espacio (nombre, descripcion) VALUES
('Sala de Juntas', 'Espacios ejecutivos para reuniones corporativas y presentaciones.'),
('Cancha Sintetica', 'Canchas de futbol con cesped artificial y luz nocturna.'),
('Auditorio', 'Salones amplios equipados con sistemas audiovisuales avanzadas.'),
('Oficina Privada', 'Espacios cerrados ideales para trabajo individual o equipos pequenos.'),
('Escenario Abierto', 'Tarimas y espacios al aire libre para eventos culturales o musicales.'),
('Salon de Eventos', 'Espacios amplios para recepciones, bodas y fiestas corporativas.'),
('Laboratorio de Computo', 'Salas equipadas con computadoras de alto rendimiento e internet rapido.'),
('Cancha de Baloncesto', 'Canchas techadas con piso de madera profesional.'),
('Estudio de Fotografia', 'Set fotografico equipado con luces, fondos e iluminacion.'),
('Sala de Ensayos', 'Salon insonorizado para practica musical o de danza.'),
('Piscina Olimpica', 'Carriles de natacion para entrenamiento o competencias.'),
('Cancha de Tenis', 'Canchas de arcilla y dura para partidos individuales o dobles.'),
('Espacio Coworking', 'Mesas compartidas en ambiente colaborativo de trabajo.'),
('Sala de Podcast', 'Cabina de grabacion insonorizada con microfonos profesionales.'),
('Salon de Danza', 'Salon con espejos de pared completa y piso flotante.'),
('Taller de Arte', 'Espacio equipado con caballetes y lavamanos para pintura.'),
('Terraza Lounge', 'Espacio al aire libre en azotea con vista panoramica.'),
('Sala VIP', 'Salon de descanso exclusivo con servicio de catering.'),
('Aula de Capacitacion', 'Aulas tipo escuela con tableros interactivos y proyectores.'),
('Cancha de Padel', 'Canchas de cristal con superficie sintetica estandar.');

-- Poblacion de tabla usuario (20 registros)
INSERT INTO usuario (nombre, email, telefono, estado) VALUES
('Carlos Mendoza', 'carlos.mendoza@email.com', '3001234567', 'ACTIVO'),
('Laura Gomez', 'laura.gomez@email.com', '3109876543', 'ACTIVO'),
('Andres Ramirez', 'andres.ramirez@email.com', '3155551234', 'ACTIVO'),
('Sofia Torres', 'sofia.torres@email.com', '3204448899', 'ACTIVO'),
('Mateo Fernandez', 'mateo.fernandez@email.com', '3017773322', 'ACTIVO'),
('Valentina Rios', 'valentina.rios@email.com', '3128889900', 'ACTIVO'),
('Camilo Vargas', 'camilo.vargas@email.com', '3183332211', 'ACTIVO'),
('Mariana Castro', 'mariana.castro@email.com', '3196665544', 'ACTIVO'),
('Daniel Ortiz', 'daniel.ortiz@email.com', '3021112233', 'ACTIVO'),
('Gabriela Morales', 'gabriela.morales@email.com', '3114445566', 'ACTIVO'),
('Alejandro Silva', 'alejandro.silva@email.com', '3059998877', 'ACTIVO'),
('Natalia Rojas', 'natalia.rojas@email.com', '3162223344', 'ACTIVO'),
('Felipe Suarez', 'felipe.suarez@email.com', '3178887766', 'ACTIVO'),
('Isabella Cruz', 'isabella.cruz@email.com', '3045556677', 'ACTIVO'),
('Diego Guerrero', 'diego.guerrero@email.com', '3131114455', 'ACTIVO'),
('Paula Delgado', 'paula.delgado@email.com', '3146667788', 'ACTIVO'),
('Esteban Paredes', 'esteban.paredes@email.com', '3008881122', 'ACTIVO'),
('Lucia Navarro', 'lucia.navarro@email.com', '3213334455', 'ACTIVO'),
('Santiago Gil', 'santiago.gil@email.com', '3027778899', 'ACTIVO'),
('Elena Benitez', 'elena.benitez@email.com', '3102221100', 'ACTIVO');

-- Poblacion de tabla espacio (20 registros)
INSERT INTO espacio (nombre, capacidad, precio_hora, tipo_espacio_id, disponible) VALUES
('Sala Ejecutiva Alpha', 12, 45000.00, 1, 1),
('Cancha Futbol 5 Norte', 10, 80000.00, 2, 1),
('Auditorio Principal', 200, 250000.00, 3, 1),
('Oficina Individual 101', 2, 20000.00, 4, 1),
('Tarima Central Parque', 500, 350000.00, 5, 1),
('Salon Gran Gala', 150, 180000.00, 6, 1),
('Lab Computo B', 30, 90000.00, 7, 1),
('Cancha Baloncesto Cubierta', 20, 70000.00, 8, 1),
('Studio Foto Pro', 6, 60000.00, 9, 1),
('Sala Musica Insonorizada', 5, 40000.00, 10, 1),
('Carril Natacion 1', 4, 30000.00, 11, 1),
('Cancha Tenis Arcilla 1', 4, 50000.00, 12, 1),
('Mesa Coworking Flex 5', 1, 12000.00, 13, 1),
('Cabina Podcast Master', 3, 35000.00, 14, 1),
('Salon Espejos Danza', 25, 55000.00, 15, 1),
('Taller Pintura Luz Natural', 15, 38000.00, 16, 1),
('Rooftop Sky Bar', 80, 220000.00, 17, 1),
('Lounge Lounge VIP', 15, 120000.00, 18, 1),
('Aula Proyector 204', 40, 65000.00, 19, 1),
('Cancha Padel Cristal 2', 4, 60000.00, 20, 1);

-- Poblacion de tabla reserva (20 registros)
INSERT INTO reserva (usuario_id, espacio_id, fecha_inicio, fecha_fin, total_pagar, estado_reserva, observaciones) VALUES
(1, 1, '2026-03-01 08:00:00', '2026-03-01 10:00:00', 90000.00, 'COMPLETADA', 'Reunion directiva'),
(2, 2, '2026-03-01 18:00:00', '2026-03-01 20:00:00', 160000.00, 'COMPLETADA', 'Partido semanal'),
(3, 3, '2026-03-02 09:00:00', '2026-03-02 13:00:00', 1000000.00, 'COMPLETADA', 'Conferencia de tecnologia'),
(4, 4, '2026-03-03 14:00:00', '2026-03-03 18:00:00', 80000.00, 'COMPLETADA', 'Trabajo remoto'),
(5, 5, '2026-03-05 10:00:00', '2026-03-05 16:00:00', 2100000.00, 'CONFIRMADA', 'Evento cultural regional'),
(6, 6, '2026-03-06 19:00:00', '2026-03-07 01:00:00', 1080000.00, 'CONFIRMADA', 'Fiesta de graduacion'),
(7, 7, '2026-03-08 08:00:00', '2026-03-08 12:00:00', 360000.00, 'COMPLETADA', 'Taller de programacion'),
(8, 8, '2026-03-09 16:00:00', '2026-03-09 18:00:00', 140000.00, 'COMPLETADA', 'Torneo relampago'),
(9, 9, '2026-03-10 10:00:00', '2026-03-10 13:00:00', 180000.00, 'COMPLETADA', 'Sesion fotografica catalogo'),
(10, 10, '2026-03-11 15:00:00', '2026-03-11 17:00:00', 80000.00, 'CANCELADA', 'Ensayo banda local'),
(11, 11, '2026-03-12 06:00:00', '2026-03-12 08:00:00', 60000.00, 'COMPLETADA', 'Entrenamiento matutino'),
(12, 12, '2026-03-13 17:00:00', '2026-03-13 19:00:00', 100000.00, 'COMPLETADA', 'Partido amistoso'),
(13, 13, '2026-03-14 09:00:00', '2026-03-14 17:00:00', 96000.00, 'COMPLETADA', 'Jornada Freelance'),
(14, 14, '2026-03-15 11:00:00', '2026-03-15 13:00:00', 70000.00, 'CONFIRMADA', 'Grabacion Episodio 10'),
(15, 15, '2026-03-16 14:00:00', '2026-03-16 17:00:00', 165000.00, 'CONFIRMADA', 'Clase de ballet'),
(1, 2, '2026-03-17 19:00:00', '2026-03-17 21:00:00', 160000.00, 'CONFIRMADA', 'Partido de revancha'),
(2, 1, '2026-03-18 10:00:00', '2026-03-18 12:00:00', 90000.00, 'CONFIRMADA', 'Reunion de socios'),
(3, 20, '2026-03-19 18:00:00', '2026-03-19 20:00:00', 120000.00, 'CONFIRMADA', 'Torneo de padel'),
(4, 19, '2026-03-20 08:00:00', '2026-03-20 12:00:00', 260000.00, 'CONFIRMADA', 'Capacitacion personal'),
(5, 17, '2026-03-21 20:00:00', '2026-03-22 01:00:00', 1100000.00, 'CONFIRMADA', 'Aniversario corporativo');

-- Requisito Obligatorio: Uso de UPDATE
UPDATE usuario SET telefono = '3009990000' WHERE id = 1;
UPDATE reserva SET observaciones = 'Cliente solicito proyector adicional' WHERE id = 1;
GO

-- =============================================================================
-- PARTE 3: CONSULTAS DE NEGOCIO (DML - SELECT)
-- =============================================================================

/*
  CONSULTA 1: Total acumulado de ingresos y numero de reservas por tipo de espacio.
  Proposito: Identificar las categorias de espacios mas rentables para la empresa.
  Requisitos: JOIN, GROUP BY, Funcion de agregado (SUM, COUNT).
*/
SELECT 
    te.nombre AS tipo_espacio,
    COUNT(r.id) AS total_reservas,
    SUM(r.total_pagar) AS ingresos_totales
FROM tipo_espacio te
INNER JOIN espacio e ON te.id = e.tipo_espacio_id
INNER JOIN reserva r ON e.id = r.espacio_id
WHERE r.estado_reserva != 'CANCELADA'
GROUP BY te.nombre
ORDER BY ingresos_totales DESC;

/*
  CONSULTA 2: Usuarios que han realizado mas de 1 reserva con un consumo promedio superior a $100.000.
  Proposito: Segmentar a los clientes VIP o recurrentes para programas de fidelizacion.
  Requisitos: JOIN, GROUP BY, HAVING, Funciones de agregado (COUNT, AVG).
*/
SELECT 
    u.id AS usuario_id,
    u.nombre AS nombre_usuario,
    u.email,
    COUNT(r.id) AS cantidad_reservas,
    AVG(r.total_pagar) AS promedio_gasto_por_reserva
FROM usuario u
INNER JOIN reserva r ON u.id = r.usuario_id
GROUP BY u.id, u.nombre, u.email
HAVING COUNT(r.id) > 1 AND AVG(r.total_pagar) > 100000
ORDER BY promedio_gasto_por_reserva DESC;

/*
  CONSULTA 3: Listado general de espacios y su estado de uso (incluye espacios sin reservas registradas).
  Proposito: Evaluar que espacios no han sido reservados nunca para ajustar precios o promociones.
  Requisitos: LEFT JOIN, GROUP BY, COUNT, ISNULL.
*/
SELECT 
    e.nombre AS nombre_espacio,
    te.nombre AS categoria,
    e.precio_hora,
    COUNT(r.id) AS total_veces_reservado,
    ISNULL(SUM(r.total_pagar), 0) AS total_generado
FROM espacio e
INNER JOIN tipo_espacio te ON e.tipo_espacio_id = te.id
LEFT JOIN reserva r ON e.id = r.espacio_id
GROUP BY e.id, e.nombre, te.nombre, e.precio_hora
ORDER BY total_veces_reservado ASC;

/*
  CONSULTA 4: Reservas realizadas en la primera quincena del mes especificando duracion en horas.
  Proposito: Analizar la ocupacion por horas y montos pagados dentro de un rango de fechas.
  Requisitos: WHERE con fechas, manipulacion de fechas (DATEDIFF), INNER JOIN.
*/
SELECT 
    r.id AS reserva_id,
    u.nombre AS cliente,
    e.nombre AS espacio,
    r.fecha_inicio,
    r.fecha_fin,
    DATEDIFF(HOUR, r.fecha_inicio, r.fecha_fin) AS horas_reservadas,
    r.total_pagar
FROM reserva r
INNER JOIN usuario u ON r.usuario_id = u.id
INNER JOIN espacio e ON r.espacio_id = e.id
WHERE r.fecha_inicio >= '2026-03-01 00:00:00' 
  AND r.fecha_inicio <= '2026-03-15 23:59:59'
ORDER BY r.fecha_inicio ASC;

/*
  CONSULTA 5: Tipos de espacios cuya tarifa promedio por hora supera los $50.000.
  Proposito: Analizar los precios promedio de las categorias con mayor valor de mercado.
  Requisitos: INNER JOIN, GROUP BY, HAVING, AVG.
*/
SELECT 
    te.nombre AS tipo_espacio,
    COUNT(e.id) AS cantidad_espacios_registrados,
    AVG(e.precio_hora) AS precio_promedio_hora
FROM tipo_espacio te
INNER JOIN espacio e ON te.id = e.tipo_espacio_id
GROUP BY te.id, te.nombre
HAVING AVG(e.precio_hora) > 50000
ORDER BY precio_promedio_hora DESC;
GO