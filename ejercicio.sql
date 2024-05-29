-- Crear la secuencia SEQ_EJERCICIOS
CREATE SEQUENCE SEQ_EJERCICIOS;

-- Crea un trigger que modifique el ID de EJERCICIO si no se le suministra en el insert
CREATE OR REPLACE TRIGGER "tr_EJERCICIOS"
BEFORE INSERT ON EJERCICIO
FOR EACH ROW
BEGIN
    IF :new.ID IS NULL THEN
        :new.ID := SEQ_EJERCICIOS.NEXTVAL;
    END IF;
END tr_EJERCICIOS;
/

-- Obtener los datos de la tabla EJERCICIO de la tabla externa
INSERT INTO ejercicio (nombre, descripcion, video)
SELECT nombre, descripcion, video
FROM S_EJERCICIOS;