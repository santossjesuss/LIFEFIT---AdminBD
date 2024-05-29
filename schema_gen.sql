-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2024-04-18 19:48:08 CEST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE centro (
    id        INTEGER NOT NULL,
    nombre    VARCHAR2(30 CHAR) NOT NULL,
    direccion VARCHAR2(50 CHAR),
    cpostal   VARCHAR2(7 CHAR)
);

ALTER TABLE centro ADD CONSTRAINT centro_pk PRIMARY KEY ( id ) USING INDEX TABLESPACE TS_INDICES;

CREATE TABLE cita (
    fechayhora DATE NOT NULL,
    id         INTEGER NOT NULL,
    modalidad  VARCHAR2(20 CHAR),
    cliente_id INTEGER NOT NULL
);

ALTER TABLE cita ADD CONSTRAINT cita_pk PRIMARY KEY ( fechayhora,
                                                      id, cliente_id ) USING INDEX TABLESPACE TS_INDICES;

CREATE TABLE cliente (
    id           INTEGER NOT NULL,
    objetivo     VARCHAR2(20 CHAR) NOT NULL,
    preferencias VARCHAR2(250 CHAR),
    dieta_id     INTEGER,
    centro_id    INTEGER NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id ) USING INDEX TABLESPACE TS_INDICES;

CREATE TABLE conforman (
    series       INTEGER,
    repeticiones LONG,
    duracion     VARCHAR2(20 CHAR),
    rutina_id    INTEGER NOT NULL,
    ejercicio_id INTEGER NOT NULL
);

ALTER TABLE conforman ADD CONSTRAINT conforman_pk PRIMARY KEY ( rutina_id,
                                                                ejercicio_id ) USING INDEX TABLESPACE TS_INDICES;

CREATE TABLE dieta (
    id          INTEGER NOT NULL,
    nombre      VARCHAR2(50 CHAR) NOT NULL,
    descripcion VARCHAR2(250 CHAR),
    tipo        VARCHAR2(50 CHAR)
);

ALTER TABLE dieta ADD CONSTRAINT dieta_pk PRIMARY KEY ( id ) USING INDEX TABLESPACE TS_INDICES;

ALTER TABLE dieta ADD CONSTRAINT dieta_nombre_un UNIQUE ( nombre ) USING INDEX TABLESPACE TS_INDICES;

CREATE TABLE ejercicio (
    id          INTEGER NOT NULL,
    nombre      VARCHAR2(50 CHAR) NOT NULL,
    descripcion VARCHAR2(3000 CHAR),
    video       VARCHAR2(100 CHAR),
    imagen      VARCHAR2(100 CHAR)
);

ALTER TABLE ejercicio ADD CONSTRAINT ejercicio_pk PRIMARY KEY ( id ) USING INDEX TABLESPACE TS_INDICES;

CREATE TABLE elementocalen (
    fechayhora    DATE NOT NULL,
    entrenador_id INTEGER NOT NULL
);

ALTER TABLE elementocalen ADD CONSTRAINT elementocalendario_pk PRIMARY KEY ( fechayhora,
                                                                             entrenador_id ) USING INDEX TABLESPACE TS_INDICES;

CREATE TABLE entrena (
    especialidad  VARCHAR2(20 CHAR),
    entrenador_id INTEGER NOT NULL,
    cliente_id    INTEGER NOT NULL,
    
    CONSTRAINT especialidad_ck CHECK (especialidad IN ('NUTRICION', 'ENTRENAMIENTO', 'FITNESS'))
);

ALTER TABLE entrena ADD CONSTRAINT entrena_pk PRIMARY KEY ( entrenador_id,
                                                            cliente_id ) USING INDEX TABLESPACE TS_INDICES;

CREATE TABLE entrenador (
    id             INTEGER NOT NULL,
    disponibilidad VARCHAR2(20 CHAR),
    centro_id      INTEGER NOT NULL
);

ALTER TABLE entrenador ADD CONSTRAINT entrenador_pk PRIMARY KEY ( id ) USING INDEX TABLESPACE TS_INDICES;

CREATE TABLE gerente (
    id        INTEGER NOT NULL,
    despacho  VARCHAR2(50 CHAR),
    horario   VARCHAR2(50 CHAR),
    centro_id INTEGER NOT NULL
);

CREATE UNIQUE INDEX gerente__idx ON
    gerente (
        centro_id
    ASC );

ALTER TABLE gerente ADD CONSTRAINT gerente_pk PRIMARY KEY ( id ) USING INDEX TABLESPACE TS_INDICES;

CREATE TABLE plan (
    inicio                DATE NOT NULL,
    fin                   DATE,
    rutina_id             INTEGER NOT NULL,
    entrena_entrenador_id INTEGER NOT NULL,
    entrena_cliente_id    INTEGER NOT NULL,

    CONSTRAINT fechas_validas_ck CHECK (fin > inicio)
);

ALTER TABLE plan
    ADD CONSTRAINT plan_pk PRIMARY KEY ( inicio,
                                         rutina_id,
                                         entrena_entrenador_id,
                                         entrena_cliente_id ) USING INDEX TABLESPACE TS_INDICES;

CREATE TABLE rutina (
    id          INTEGER NOT NULL,
    nombre      VARCHAR2(50 CHAR) NOT NULL,
    descripcion VARCHAR2(250 CHAR)
);

ALTER TABLE rutina ADD CONSTRAINT rutina_pk PRIMARY KEY ( id ) USING INDEX TABLESPACE TS_INDICES;

CREATE TABLE sesion (
    inicio                     DATE NOT NULL,
    fin                        DATE,
    presencial                 VARCHAR2(20 CHAR),
    descripcion                VARCHAR2(250 CHAR),
    video                      VARCHAR2(100 CHAR) ENCRYPT,
    datos_salud                VARCHAR2(100 CHAR) ENCRYPT,
    plan_inicio                DATE NOT NULL,
    plan_rutina_id             INTEGER NOT NULL,
    plan_entrena_entrenador_id INTEGER NOT NULL,
    plan_entrena_cliente_id    INTEGER NOT NULL,

    CONSTRAINT sesion_presenc_ck CHECK (presencial IN ('Sí', 'No'))
);

ALTER TABLE sesion
    ADD CONSTRAINT sesion_pk PRIMARY KEY ( plan_inicio,
                                           plan_rutina_id,
                                           plan_entrena_entrenador_id,
                                           plan_entrena_cliente_id ) USING INDEX TABLESPACE TS_INDICES;

CREATE TABLE usuario (
    id            INTEGER NOT NULL,
    nombre        VARCHAR2(50 CHAR) NOT NULL,
    apellidos     VARCHAR2(50 CHAR) NOT NULL,
    telefono      VARCHAR2(20 CHAR) NOT NULL UNIQUE,
    direccion     VARCHAR2(50 CHAR) ENCRYPT,
    correoe       VARCHAR2(60 CHAR) UNIQUE,
    usuariooracle VARCHAR2(30 CHAR)
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id ) USING INDEX TABLESPACE TS_INDICES;

ALTER TABLE cita
    ADD CONSTRAINT cita_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( id );

ALTER TABLE cita
    ADD CONSTRAINT cita_elementocalendario_fk FOREIGN KEY ( fechayhora,
                                                            id )
        REFERENCES elementocalen ( fechayhora,
                                   entrenador_id );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_centro_fk FOREIGN KEY ( centro_id )
        REFERENCES centro ( id );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_dieta_fk FOREIGN KEY ( dieta_id )
        REFERENCES dieta ( id );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_usuario_fk FOREIGN KEY ( id )
        REFERENCES usuario ( id );

ALTER TABLE conforman
    ADD CONSTRAINT conforman_ejercicio_fk FOREIGN KEY ( ejercicio_id )
        REFERENCES ejercicio ( id );

ALTER TABLE conforman
    ADD CONSTRAINT conforman_rutina_fk FOREIGN KEY ( rutina_id )
        REFERENCES rutina ( id );

ALTER TABLE elementocalen
    ADD CONSTRAINT elementocalend_entrenador_fk FOREIGN KEY ( entrenador_id )
        REFERENCES entrenador ( id );

ALTER TABLE entrena
    ADD CONSTRAINT entrena_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( id );

ALTER TABLE entrena
    ADD CONSTRAINT entrena_entrenador_fk FOREIGN KEY ( entrenador_id )
        REFERENCES entrenador ( id );

ALTER TABLE entrenador
    ADD CONSTRAINT entrenador_centro_fk FOREIGN KEY ( centro_id )
        REFERENCES centro ( id );

ALTER TABLE entrenador
    ADD CONSTRAINT entrenador_usuario_fk FOREIGN KEY ( id )
        REFERENCES usuario ( id );

ALTER TABLE gerente
    ADD CONSTRAINT gerente_centro_fk FOREIGN KEY ( centro_id )
        REFERENCES centro ( id );

ALTER TABLE gerente
    ADD CONSTRAINT gerente_usuario_fk FOREIGN KEY ( id )
        REFERENCES usuario ( id );

ALTER TABLE plan
    ADD CONSTRAINT plan_entrena_fk FOREIGN KEY ( entrena_entrenador_id,
                                                 entrena_cliente_id )
        REFERENCES entrena ( entrenador_id,
                             cliente_id );

ALTER TABLE plan
    ADD CONSTRAINT plan_rutina_fk FOREIGN KEY ( rutina_id )
        REFERENCES rutina ( id );

ALTER TABLE sesion
    ADD CONSTRAINT sesion_plan_fk FOREIGN KEY ( plan_inicio,
                                                plan_rutina_id,
                                                plan_entrena_entrenador_id,
                                                plan_entrena_cliente_id )
        REFERENCES plan ( inicio,
                          rutina_id,
                          entrena_entrenador_id,
                          entrena_cliente_id );


--Tablas temporales
CREATE GLOBAL TEMPORARY TABLE tempClientes (
    id      INTEGER
);    

CREATE GLOBAL TEMPORARY TABLE tempEntrenadores (
    id      INTEGER
);