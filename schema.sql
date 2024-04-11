-- Telefono VARCHAR2 -- 
-- porque no vamos a hacer operaciones aritmeticas 
-- sobre ellos, y queremos dejar que definan un prefijo 

CREATE TABLE USUARIO (
    id              UNSIGNED INTEGER, -- acepta integer?
    nombre          VARCHAR2(255),
    apellidos       VARCHAR2(255),
    telefono        VARCHAR2(255),
    direccion       VARCHAR2(255),
    correo_e        VARCHAR2(255),
    usuario_oracle  VARCHAR2(255),
    CONSTRAINT usuario_pk PRIMARY KEY (id)  -- hacerlo UUID?
);