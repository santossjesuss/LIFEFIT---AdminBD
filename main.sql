-- 1 - CREACION DEL USUARIO Y TABLESPACE
-- Desde SYSTEM --
@create_user

-- 2 - CREACION DEL ESQUEMA
-- Desde LIFEFIT --
@handleDeletion
@schema_gen

-- 3 - IMPORTACION DE DATOS
@data_import

-- 4 - TABLAS EXTERNAS
-- Desde SYSTEM --
@external_tables

-- 5 - INDICES
-- Desde LIFEFIT --
@indices 

-- 6 - VISTA MATERIALIZADA
@vista_materializada