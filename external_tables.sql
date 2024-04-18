-- Para crear la tabla basicamente
IF (VISTA USUARIO != 'LIFEFIT')
    DISCONNECT;
    CONNECT LIFEFIT/LIFEFIT123;
END IF
/

CREATE OR REPLACE DIRECTORY directorio_ext AS C:\app\alumnos\admin\orcl\dpdump;

GRANT READ, WRITE ON DIRECTORY directorio_ext TO LIFEFIT;

CREATE TABLE ejercicios_ext ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY directorio_ext
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        skip 1
        CHARACTERSET UTF8
        FIELDS TERMINATED BY ';'
        OPTIONALLY ENCLOSED BY '"'
        MISSING FIELD VALUES ARE NULL
        (nombre, descripcion, video)
    )
    LOCATION ('Ejercicios.csv')     -- a lo mejor da fallos esto
);

-- Desde el usuario LIFEFIT probar a ejecutar sentencias SQL para leer, modificar, insertar... 
-- Investigar que ocurre con cada una de ellas.
-- SELECT * FROM ejercicios_ext

-- Probamos con SELECT, INSERT, UPDATE... y lo que ocurre es que podemos acceder
-- a la tabla de la misma forma que si fuese una table interna de Oracle 