-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE centro (
    id          UNSIGNED INTEGER NOT NULL,
    nombre      VARCHAR2(20 CHAR) NOT NULL,
    direccion   VARCHAR2(50 CHAR),
    cod_postal  VARCHAR2(7 CHAR),

    CONSTRAINT centro_pk PRIMARY KEY (id) USING INDEX TABLESPACE TS_INDICES
);
-- ALTER TABLE centro ADD CONSTRAINT centro_pk PRIMARY KEY ( id );

CREATE TABLE cita (
    fecha_y_hora    DATETIME NOT NULL,
    entrenador_id   UNSIGNED INTEGER NOT NULL,
    cliente_id      UNSIGNED INTEGER NOT NULL
    modalidad       VARCHAR2(20 CHAR),

    CONSTRAINT cita_pk PRIMARY KEY (fecha_y_hora, entrenador_id) USING INDEX TABLESPACE TS_INDICES,
    CONSTRAINT cita_uk UNIQUE KEY  (cliente_id) USING INDEX TABLESPACE TS_INDICES
);
-- ALTER TABLE cita ADD CONSTRAINT cita_pk PRIMARY KEY ( fechayhora, id );
-- ALTER TABLE cita ADD CONSTRAINT cita_pkv1 UNIQUE ( cliente_id );

CREATE TABLE cliente (
    id           UNSIGNED INTEGER NOT NULL,
    dieta_id     UNSIGNED INTEGER,
    centro_id    UNSIGNED INTEGER NOT NULL,
    objetivo     VARCHAR2(20 CHAR) NOT NULL,
    preferencias VARCHAR2(50 CHAR),

    CONSTRAINT cliente_pk PRIMARY KEY (id) USING INDEX TABLESPACE TS_INDICES
);
-- ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id );

CREATE TABLE conforman (
    rutina_id    UNSIGNED INTEGER NOT NULL,
    ejercicio_id UNSIGNED INTEGER NOT NULL,
    series       UNSIGNED NUMBER(4, 0),
    repeticiones UNSIGNED NUMBER(4, 0),     -- SE DECLARA COMO NUMBER PORQUE ADEMÁS VAMOS A HACER ESTADÍSTICAS CON ESTOS DATOS, COMPARARLOS, ETC.
    duracion     UNSIGNED NUMBER(5, 0),     -- EN EL APP HACER OPERACIONES DE CONVERSIÓN DE TIEMPO -- TIENES 5 CIFRAS DECIMALES PARA GUARDAR EL TIEMPO, ES DECIR 99.999 SEGUNDOS O 27.78 HORAS QUE PUEDE DURAR UN ENTRENAMIENTO, EN UN PRINCIPIO LA IDEA ERA PODER ALMACENAR ENRENAMIETNOS DE 5H, SIN EMBARGO, PARA LAMACENAR ESA CANTIDAD NECESITAMOS 5 DIGITOS Y POR TANTO LA COTA SUBE A ESA MAYOR CANTIDAD DE HORAS

    CONSTRAINT conforman_pk PRIMARY KEY (rutina_id, ejercicio_id)
);
-- ALTER TABLE conforman ADD CONSTRAINT conforman_pk PRIMARY KEY ( rutina_id, ejercicio_id );

CREATE TABLE dieta (
    id          UNSIGNED INTEGER NOT NULL,
    nombre      VARCHAR2(20 CHAR) NOT NULL,
    descripcion VARCHAR2(50 CHAR),
    tipo        VARCHAR2(10 CHAR),

    CONSTRAINT dieta_pk PRIMARY KEY (id) USING INDEX TABLESPACE TS_INDICES,
    CONSTRAINT dieta_nombre_uk UNIQUE KEY USING INDEX TABLESPACE TS_INDICES 
);
-- ALTER TABLE dieta ADD CONSTRAINT dieta_pk PRIMARY KEY ( id );
-- ALTER TABLE dieta ADD CONSTRAINT dieta_nombre_un UNIQUE ( nombre );

CREATE TABLE ejercicio (
    id          UNSIGNED INTEGER NOT NULL,
    nombre      VARCHAR2(20 CHAR) NOT NULL,
    descripcion VARCHAR2(255),
    video       BLOB,
    imagen_url  VARCHAR2(511), 

    CONSTRAINT ejercicio_pk PRIMARY KEY (id) USING INDEX TABLESPACE TS_INDICES
);
-- ALTER TABLE ejercicio ADD CONSTRAINT ejercicio_pk PRIMARY KEY ( id );

CREATE TABLE elem_calend (
    fecha_y_hora    DATETIME NOT NULL,
    entrenador_id   UNSIGNED INTEGER NOT NULL,

    CONSTRAINT elem_calend_pk PRIMARY KEY (fecha_y_hora, entrenador_id)
);
-- ALTER TABLE elementocalendario ADD CONSTRAINT elementocalendario_pk PRIMARY KEY ( fechayhora, entrenador_id );

CREATE TABLE entrena (
    cliente_id    UNSIGNED INTEGER NOT NULL,
    entrenador_id UNSIGNED INTEGER NOT NULL,
    especialidad  VARCHAR2(20 CHAR),

    CONSTRAINT entrena_pk PRIMARY KEY (cliente_id, entrenador_id)
);
-- ALTER TABLE entrena ADD CONSTRAINT entrena_pk PRIMARY KEY ( cliente_id, entrenador_id );

CREATE TABLE entrenador (
    id             UNSIGNED INTEGER NOT NULL,
    centro_id      UNSIGNED INTEGER NOT NULL,
    disponibilidad VARCHAR2(20 CHAR),

    CONSTRAINT entrenador_pk PRIMARY KEY (id) USING INDEX TABLESPACE TS_INDICES -- defino el tablespace, aun cogiendolo de user??
);
-- ALTER TABLE entrenador ADD CONSTRAINT entrenador_pk PRIMARY KEY ( id );

CREATE TABLE gerente (
    id        UNSIGNED INTEGER NOT NULL,
    centro_id UNSIGNED INTEGER NOT NULL,
    despacho  VARCHAR2(12 CHAR),
    horario   VARCHAR2(20 CHAR),

    CONSTRAINT gerente_pk PRIMARY KEY (id) USING INDEX TABLESPACE TS_INDICES, -- tengo que declarar el tablespace si la pk es una fk?
    CONSTRAINT gerente_idx UNIQUE KEY (centro_id) ASC USING INDEX TABLESPACE TS_INDICES -- ASC WORKS?
);
-- CREATE UNIQUE INDEX gerente__idx ON
--     gerente ( centro_id ASC );

-- ALTER TABLE gerente ADD CONSTRAINT gerente_pk PRIMARY KEY ( id );

CREATE TABLE plan (
    inicio          DATETIME NOT NULL,
    fin             VARCHAR2(20 CHAR),
    rutina_id       UNSIGNED INTEGER NOT NULL,
    entrena_cli_id  UNSIGNED INTEGER NOT NULL,
    entrena_entr_id UNSIGNED INTEGER NOT NULL,

    CONSTRAINT plan_pk PRIMARY KEY (inicio, entrena_cli_id, entrena_entr_id, rutina_id) USING INDEX TABLESPACE TS_INDICES
);
-- ALTER TABLE plan ADD CONSTRAINT plan_pk PRIMARY KEY ( inicio, rutina_id );

CREATE TABLE rutina (
    id          UNSIGNED INTEGER NOT NULL,
    nombre      VARCHAR2(20 CHAR) NOT NULL,
    descripcion VARCHAR2(255),

    CONSTRAINT rutina_pk PRIMARY KEY (id) USING INDEX TABLESPACE TS_INDICES
);
-- ALTER TABLE rutina ADD CONSTRAINT rutina_pk PRIMARY KEY ( id );

CREATE TABLE sesion (
    inicio         DATETIME NOT NULL,
    fin            DATETIME,
    presencial     UNSIGNED NUMBER(1,0),
    descripcion    VARCHAR2(50 CHAR),
    video          BLOB,
    datos_salud    VARCHAR2(100 CHAR),
    plan_inicio    VARCHAR2(20 CHAR) NOT NULL,
    plan_rutina_id UNSIGNED INTEGER NOT NULL,

    CONSTRAINT sesion_pk PRIMARY KEY (plan_inicio, plan_rutina_id) USING INDEX TABLESPACE TS_INDICES,
    CONSTRAINT sesion_presenc_ck CHECK (presencial IN (0,1))
);
-- ALTER TABLE sesion ADD CONSTRAINT sesion_pk PRIMARY KEY ( plan_inicio, plan_rutina_id );

CREATE TABLE usuario (
    id              UNSIGNED INTEGER NOT NULL,
    nombre          VARCHAR2(10 CHAR) NOT NULL,
    apellidos       VARCHAR2(25 CHAR) NOT NULL,
    telefono        VARCHAR2(12 CHAR) NOT NULL,
    direccion       VARCHAR2(32 CHAR),
    correo_e        VARCHAR2(25 CHAR),
    usuario_oracle  VARCHAR2(10 CHAR),

    CONSTRAINT usuario_pk PRIMARY KEY (id) USING INDEX TABLESPACE TS_INDICES
);

ALTER TABLE cita ADD CONSTRAINT cita_cliente_fk FOREIGN KEY ( cliente_id ) REFERENCES cliente ( id );
ALTER TABLE cita ADD CONSTRAINT cita_elemcalend_fk FOREIGN KEY ( fecha_y_hora, entrenador_id ) REFERENCES elem_calend ( fecha_y_hora, entrenador_id );

ALTER TABLE cliente ADD CONSTRAINT cliente_centro_fk FOREIGN KEY ( centro_id ) REFERENCES centro ( id );
ALTER TABLE cliente ADD CONSTRAINT cliente_dieta_fk FOREIGN KEY ( dieta_id ) REFERENCES dieta ( id );
ALTER TABLE cliente ADD CONSTRAINT cliente_usuario_fk FOREIGN KEY ( id ) REFERENCES usuario ( id );

ALTER TABLE conforman ADD CONSTRAINT conforman_ejercicio_fk FOREIGN KEY ( ejercicio_id ) REFERENCES ejercicio ( id );
ALTER TABLE conforman ADD CONSTRAINT conforman_rutina_fk FOREIGN KEY ( rutina_id ) REFERENCES rutina ( id );

ALTER TABLE elem_calend ADD CONSTRAINT elemcalend_entrenador_fk FOREIGN KEY ( entrenador_id ) REFERENCES entrenador ( id );

ALTER TABLE entrena ADD CONSTRAINT entrena_cliente_fk FOREIGN KEY ( cliente_id ) REFERENCES cliente ( id );
ALTER TABLE entrena ADD CONSTRAINT entrena_entrenador_fk FOREIGN KEY ( entrenador_id ) REFERENCES entrenador ( id );

ALTER TABLE entrenador ADD CONSTRAINT entrenador_centro_fk FOREIGN KEY ( centro_id ) REFERENCES centro ( id );
ALTER TABLE entrenador ADD CONSTRAINT entrenador_usuario_fk FOREIGN KEY ( id ) REFERENCES usuario ( id );

ALTER TABLE gerente ADD CONSTRAINT gerente_centro_fk FOREIGN KEY ( centro_id ) REFERENCES centro ( id );
ALTER TABLE gerente ADD CONSTRAINT gerente_usuario_fk FOREIGN KEY ( id ) REFERENCES usuario ( id );

ALTER TABLE plan ADD CONSTRAINT plan_entrena_fk FOREIGN KEY ( entrena_cli_id, entrena_entr_id ) REFERENCES entrena ( cliente_id, entrenador_id );
ALTER TABLE plan ADD CONSTRAINT plan_rutina_fk FOREIGN KEY ( rutina_id ) REFERENCES rutina ( id );

ALTER TABLE sesion ADD CONSTRAINT sesion_plan_fk FOREIGN KEY ( plan_inicio, plan_rutina_id ) REFERENCES plan ( inicio, rutina_id );