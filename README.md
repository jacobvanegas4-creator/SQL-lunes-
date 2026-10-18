# Momento 2: Construccion y Manipulacion de Base de Datos

## Descripcion
Este repositorio contiene la implementacion y manipulacion de la base de datos `sistema_reservas` desarrollada en Microsoft SQL Server.

## Estructura del Proyecto
- **`script_momento2.sql`**: Script unico que contiene:
  1. **DDL**: Creacion de la base de datos y 4 tablas (`usuario`, `tipo_espacio`, `espacio`, `reserva`) con llaves primarias, foraneas y restricciones (`CHECK`, `DEFAULT`, `UNIQUE`). Uso de `ALTER TABLE`.
  2. **DML (Poblacion)**: Insercion de 20 registros por tabla y comandos `UPDATE`.
  3. **DML (Consultas de Negocio)**: 5 consultas analiticas con `INNER JOIN`, `LEFT JOIN`, `GROUP BY`, `HAVING`, funciones de agregacion (`SUM`, `AVG`, `COUNT`) y manipulacion de fechas (`DATEDIFF`).