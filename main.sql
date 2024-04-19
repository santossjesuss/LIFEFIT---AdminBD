-- 1 - CREACION DEL USUARIO Y TABLESPACE
-- Desde SYSTEM --
@create_user

-- 2 - CREACION DEL ESQUEMA
-- Desde LIFEFIT --
@schema_deletion
@schema_gen

-- 3 - IMPORTACION DE DATOS
@data_import

-- 4 - TABLAS EXTERNAS
@external_tables

-- 5 - INDICES
@indices 

-- 6 - MATERIALIZED VIEW
@materialized_view