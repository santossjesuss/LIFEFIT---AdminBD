DECLARE
    tslifefit_exist NUMBER(1,0);
    user_exist NUMBER(1,0);
    tsindexes_exist NUMBER(1,0);
BEGIN 
    SELECT COUNT(*) INTO tslifefit_exist FROM DBA_TABLESPACES WHERE TABLESPACE_NAME = 'TS_LIFEFIT';
    -- IF (tslifefit_exist > 0) THEN
    --     EXECUTE IMMEDIATE 'DROP TABLESPACE TS_LIFEFIT INCLUDING CONTENTS AND DATAFILES';
    -- END IF;
    IF (tslifefit_exist = 0) THEN
        EXECUTE IMMEDIATE 'CREATE TABLESPACE TS_LIFEFIT DATAFILE ''ts_lifefit.dbf'' SIZE 1G AUTOEXTEND ON';
    END IF;

    SELECT COUNT(*) INTO user_exist FROM ALL_USERS WHERE USERNAME = 'LIFEFIT';
    -- IF (user_exist > 0) THEN
    --     EXECUTE IMMEDIATE 'DROP USER LIFEFIT';
    -- END IF;
    IF (user_exist = 0) THEN
    -- Hemos dado ___ MB/GB... de quota por tal y tal
        EXECUTE IMMEDIATE 'CREATE USER LIFEFIT IDENTIFIED BY LIFEFIT123
            DEFAULT TABLESPACE TS_LIFEFIT
            QUOTA 1G ON TS_LIFEFIT';
    END IF;
    -- También para crear secuencias, procedimientos, vistas, vistas materializadas, 
    -- privilegios para crear trabajos de , necesarios para las vistas materializadas 
    EXECUTE IMMEDIATE 'GRANT CREATE TABLE, CREATE VIEW, CREATE MATERIALIZED VIEW, CREATE SEQUENCE,
        CREATE PROCEDURE, CREATE SESSION, CREATE JOB TO LIFEFIT';

    SELECT COUNT(*) INTO tsindexes_exist FROM DBA_TABLESPACES WHERE TABLESPACE_NAME = 'TS_INDICES';
    -- IF (tsindexes_exist > 0) THEN 
    --     EXECUTE IMMEDIATE 'DROP TABLESPACE TS_INDICES INCLUDING CONTENTS AND DAFATILES';
    -- END IF;
    IF (tsindexes_exist = 0) THEN 
        EXECUTE IMMEDIATE 'CREATE TABLESPACE TS_INDICES DATAFILE ''ts_indices.dbf'' SIZE 50M AUTOEXTEND ON';
    END IF;

    -- Asigna ___ de quota a LIFEFIT por tal y tal
    EXECUTE IMMEDIATE 'ALTER USER LIFEFIT QUOTA 50M ON TS_INDICES';
END;
/