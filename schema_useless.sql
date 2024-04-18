-- BORRADO --
DROP IF EXIST TABLE GERENTE;
DROP IF EXIST TABLE USUARIO;

-- Telefono VARCHAR2 -- 
-- porque no vamos a hacer operaciones aritmeticas 
-- sobre ellos, y queremos dejar que definan un prefijo 

CREATE TABLE USUARIO (
    id              UNSIGNED INTEGER, -- acepta integer?
    nombre          VARCHAR2(255) NOT NULL,
    apellidos       VARCHAR2(255) NOT NULL,
    telefono        VARCHAR2(255) NOT NULL,
    direccion       VARCHAR2(255),
    correo_e        VARCHAR2(255),
    usuario_oracle  VARCHAR2(255),
    
    CONSTRAINT usuario_pk PRIMARY KEY (id) USING INDEX TABLESPACE TS_INDICES -- hacerlo UUID?
);

CREATE SEQUENCE usuario_sq;

INSERT INTO USUARIO VALUES (usuario_sq.nextval, '',)

CREATE TABLE GERENTE (
    gerente.user    UNSIGNED INTEGER,
    despacho        VARCHAR2(255),
    horario         DATE,
    
    CONSTRAINT user_fk FOREIGN KEY (id) USING INDEX TABLESPACE TS_INDICES
);

-- AUTO INCREMENT?
-- 