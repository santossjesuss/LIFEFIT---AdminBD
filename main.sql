-- 1 - CREACION DEL USUARIO Y TABLESPACE
-- Desde SYSTEM --
@handleDeletion
@create_user

-- 2 - CREACION DEL ESQUEMA
-- Desde LIFEFIT --
@schema_gen

-- 3 - IMPORTACION DE DATOS
@data_import

-- 4 - TABLAS EXTERNAS
@external_tables

-- 5 - INDICES
@indices 

-- 6 - VISTA MATERIALIZADA
@materialized_view

-- 7 - SINONIMOS
@synonims

-- 8 - EJERCICIO
