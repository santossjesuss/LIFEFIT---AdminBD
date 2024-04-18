CREATE TABLESPACE TS_LIFEFIT1 DATAFILE 'ts_lifefit.dbf' SIZE 10m AUTOEXTEND ON;

SELECT file_name FROM dba_data_files WHERE tablespace_name = 'TS_LIFEFIT1';

CREATE USER LIFEFIT IDENTIFIED BY LIFEFIT123
    DEFAULT TABLESPACE TS_LIFEFIT1
    QUOTA 10M ON TS_LIFEFIT;
    

GRANT CREATE TABLE,CREATE SESSION ,CREATE VIEW, CREATE MATERIALIZED VIEW, CREATE SEQUENCE, CREATE PROCEDURE TO LIFEFIT;

CREATE TABLESPACE TS_INDICES DATAFILE 'ts_indices.dbf' SIZE 50M AUTOEXTEND ON;

select * from DBA_TABLESPACES;

-- Consulta para verificar el tablespace predeterminado del usuario LIFEFIT
SELECT default_tablespace
FROM dba_users
WHERE username = 'LIFEFIT';

SELECT index_name, table_name
FROM dba_indexes
WHERE tablespace_name = 'TS_INDICES';

drop user LIFEFIT cascade;
