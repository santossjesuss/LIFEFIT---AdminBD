CREATE TABLESPACE TS_LIFEFIT DATAFILE 'ts_lifefit.dbf' SIZE 10M AUTOEXTEND ON;

-- Hemos dado  MB/GB... de quota por tal y tal
CREATE USER LIFEFIT IDENTIFIED BY LIFEFIT123
    DEFAULT TABLESPACE TS_LIFEFIT
    QUOTA 10M ON TS_LIFEFIT;

--También para crear secuencias, procedimientos, vistas y vistas materializadas
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE MATERIALIZED VIEW, CREATE SEQUENCE, CREATE PROCEDURE TO LIFEFIT;
-- Privilegios para crear trabajos de , necesarios para las vistas materializadas 
GRANT CREATE JOB TO LIFEFIT;
GRANT MANAGE SCHEDULER TO LIFEFIT;
-- Privilegios para crear triggers , necesarios para las secuencias
GRANT CREATE TRIGGER TO LIFEFIT;


CREATE TABLESPACE TS_INDICES DATAFILE 'ts_indices.dbf' SIZE 50M AUTOEXTEND ON;

-- Asigna ___ de quota a LIFEFIT por tal y tal
ALTER USER LIFEFIT QUOTA 50M ON TS_INDICES;

