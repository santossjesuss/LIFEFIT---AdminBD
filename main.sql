-- 1 - CREACION DEL USUARIO Y TABLESPACE
-- Desde SYSTEM --
@handleDeletion
@create_user

-- 2 - CREACION DEL ESQUEMA
-- Desde LIFEFIT --
@schema_gen

-- 3 - IMPORTACION DE DATOS
-- Desde el interfaz de usuario de Oracle SQL Developer --

-- 4 - TABLAS EXTERNAS
-- Desde LIFEFIT --
@external_tables

-- 5 - INDICES
-- Desde LIFEFIT --
@indices 

-- 6 - VISTA MATERIALIZADA
-- Desde LIFEFIT --
@vista_materializada

-- 7  SINÓNIMOS
-- Desde SYSTEM --
@sinonimos

-- 8 EJERCICIO
-- Desde LIFEFIT --
@ejercicio