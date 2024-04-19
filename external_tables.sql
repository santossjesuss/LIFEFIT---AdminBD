------------------------------------ Esta parte desde el usuario SYSTEM, resto desde LIFEFIT ---------------------------------
CREATE OR REPLACE DIRECTORY directorio_ext AS 'C:\app\alumnos\admin\orcl\dpdump';

GRANT READ, WRITE ON DIRECTORY directorio_ext TO LIFEFIT;
------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE ejercicios_ext
(
    nombre VARCHAR2(50),
    descripcion VARCHAR2(3000),
    video VARCHAR2(100)
)
ORGANIZATION EXTERNAL
(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY directorio_ext
    ACCESS PARAMETERS
    (
        RECORDS DELIMITED BY NEWLINE
        SKIP 1
        CHARACTERSET UTF8
        FIELDS TERMINATED BY ';'
        OPTIONALLY ENCLOSED BY '"'
        MISSING FIELD VALUES ARE NULL
        (
            nombre,
            descripcion,
            video
        )
    )
    LOCATION ('Ejercicios.csv')
);

-- Desde el usuario LIFEFIT probar a ejecutar sentencias SQL para leer, modificar, insertar... 
-- Investigar que ocurre con cada una de ellas.
-- SELECT * FROM ejercicios_ext

-- Probamos con SELECT, INSERT, UPDATE...

-- Las tablas externas en Oracle, creadas mediante el uso de ORGANIZATION EXTERNAL,
-- son solo vistas lógicas de datos almacenados externamente y no permiten operaciones
-- de modificación directas como insertar, actualizar o borrar datos.