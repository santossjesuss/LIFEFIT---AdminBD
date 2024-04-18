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
@external_tables

-- 5 - INDICES
@indices 