CREATE TABLE auditoria_citas (
    id_audit INTEGER PRIMARY KEY,
    fecha_hora TIMESTAMP,
    accion VARCHAR2(20),
    id_entrenador INTEGER,
    fechayhoraCita DATE,
    id_usuario INTEGER
);

CREATE SEQUENCE seq_audit
START WITH 1
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trigger_auditoria_citas
BEFORE INSERT OR DELETE OR UPDATE ON cita
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO auditoria_citas (id_audit, fecha_hora, accion, id_entrenador, fechayhoraCita, id_usuario)
        VALUES (seq_audit.nextval, SYSDATE, 'INSERT', :new.id, :new.fechayhora, :new.cliente_id);
    ELSIF DELETING THEN
        INSERT INTO auditoria_citas (id_audit, fecha_hora, accion, id_entrenador, fechayhoraCita, id_usuario)
        VALUES (seq_audit.nextval, SYSDATE, 'DELETE', :old.id, :old.fechayhora, :old.cliente_id);
    ELSIF UPDATING THEN
        INSERT INTO auditoria_citas (id_audit, fecha_hora, accion, id_entrenador, fechayhoraCita, id_usuario)
        VALUES (seq_audit.nextval, SYSDATE, 'UPDATE', :old.id, :old.fechayhora, :old.cliente_id);
    END IF;
END;
/


