------------------------------------------------------------Parte 2
-- Creamos roles:
CREATE ROLE administrador;
CREATE ROLE gerente;
CREATE ROLE entrenador_deporte;
CREATE ROLE entrenador_nutricion;
CREATE ROLE cliente;

-- Asignamos permisos a los roles:
GRANT DBA ON TS_LIFEFIT TO administrador;
GRANT administrador TO LIFEFIT;

-- Responsabilidad Gerente
GRANT SELECT, INSERT, UPDATE, DELETE ON centro TO gerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON entrenador TO gerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON usuario TO gerente; 
GRANT SELECT, INSERT, UPDATE, DELETE ON cliente TO gerente;

-- Gestión dieta (tipo) y asignación a cliente
GRANT SELECT, UPDATE(tipo) ON DIETA TO entrenador_deporte;

CREATE VIEW VCLIENTE AS SELECT * FROM cliente WHERE id = (SELECT id FROM usuario WHERE usuariooracle = USER);
GRANT SELECT, UPDATE(dieta_id) ON VCLIENTE TO entrenador_deporte;

-- Gestión dieta
GRANT SELECT, INSERT, UPDATE, DELETE ON dieta TO entrenador_nutricion;


-- 1. RF1. Gestión de los Ejercicios

GRANT SELECT, INSERT, UPDATE, DELETE ON ejercicio TO entrenador_deporte;
ALTER TABLE ejercicio ADD PUBLICO CHAR(1) DEFAULT 'S';
CREATE VIEW VEJERCICIO AS SELECT * FROM ejercicio WHERE PUBLICO = 'S';
INSERT INTO ejercicio (id, nombre, descripcion, video) SELECT ROWNUM, nombre, descripcion, video FROM ejercicios_ext;


-- 2. RF3. Gestión de la rutina
GRANT SELECT, INSERT, UPDATE, DELETE ON rutina TO entrenador_deporte;
GRANT SELECT, INSERT, UPDATE, DELETE ON conforman TO entrenador_deporte;

-- 3. RF2. Asignación de clientes a entrenadores
GRANT SELECT, INSERT, UPDATE, DELETE ON entrena TO gerente;

-- 4. RF4. Asignación de plan y sesiones de entrenamiento
-- - Los entrenadores podrán asignar planes, rutinas y sesiones de ejercicios a los clientes
CREATE VIEW VPLAN AS SELECT * FROM plan WHERE entrena_entrenador_id = (SELECT id FROM usuario WHERE usuariooracle = USER);
GRANT SELECT, INSERT, UPDATE, DELETE ON VPLAN TO entrenador_deporte;

CREATE VIEW VSESION AS SELECT inicio, fin, presencial, descripcion, plan_inicio, plan_rutina_id, plan_entrena_entrenador_id, plan_entrena_cliente_id 
                       FROM sesion WHERE plan_entrena_entrenador_id = (SELECT id FROM USUARIO WHERE usuariooracle = USER);
GRANT SELECT, INSERT, UPDATE, DELETE ON VSESION TO entrenador_deporte;