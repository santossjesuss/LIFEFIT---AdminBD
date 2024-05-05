------------------------------------------------------PARTE 1

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
-- LIFEFIT y SYSTEM (ver dentro del archivo)--
@external_tables

-- 5 - INDICES
-- Desde LIFEFIT --
@indices 

-- 6 - VISTA MATERIALIZADA
-- Desde LIFEFIT --
@vista_materializada

-- 7  SINÓNIMOS
-- Desde LIFEFIT --
@sinonimos

-- 8 EJERCICIO
-- Desde LIFEFIT --
@ejercicio

------------------------------------------------PARTE 2 y 3

-- Creación de roles y asignación de permisos:
-- LIFEFIT y SYSTEM (ver dentro del archivo)--
@roles1
-- Desde LIFEFIT --
@roles2