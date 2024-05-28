------------------------------------------------------------Parte 2
--------------------DESDE SYSTEM-------------------
-- Creamos roles:
CREATE ROLE administrador;

-- Cuando un privilegio administrativo se otorga a un rol, y luego el rol se otorga a un usuario, 
-- el usuario no puede ejercer ese privilegio administrativo. Esto es una medida de seguridad para 
-- prevenir que usuarios adquieran accidentalmente privilegios poderosos.
GRANT CREATE USER TO LIFEFIT;
GRANT DROP USER TO LIFEFIT;

-- Asignamos rol a LIFEEFIT:
GRANT administrador TO LIFEFIT;

--------------------DESDE LIFEFIT-------------------
-- Creamos roles
CREATE ROLE gerente;
CREATE ROLE entrenador_deporte;
CREATE ROLE entrenador_nutricion;
CREATE ROLE cliente;

-- Asingamos permisos a los roles
GRANT CREATE SESSION, CONNECT TO gerente;
GRANT CREATE SESSION, CONNECT TO entrenador_deporte;
GRANT CREATE SESSION, CONNECT TO entrenador_nutricion;
GRANT CREATE SESSION, CONNECT TO cliente;

-- Responsabilidad Gerente
GRANT SELECT, INSERT, UPDATE, DELETE ON centro TO gerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON entrenador TO gerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON usuario TO gerente; 
GRANT SELECT, INSERT, UPDATE, DELETE ON cliente TO gerente;

-- Gestión dieta (tipo) y asignación a cliente
GRANT SELECT, UPDATE(tipo) ON dieta TO entrenador_deporte;

CREATE OR REPLACE VIEW VCLIENTES_ENTRENADOR AS SELECT * FROM cliente WHERE id = (SELECT cliente_id FROM entrena WHERE entrenador_id = (SELECT id FROM usuario WHERE usuariooracle = USER));
GRANT SELECT, UPDATE(dieta_id) ON VCLIENTES_ENTRENADOR TO entrenador_deporte;

-- Gestión dieta
GRANT SELECT, INSERT, UPDATE, DELETE ON dieta TO entrenador_nutricion;


-- 1. RF1. Gestión de los Ejercicios

GRANT SELECT, INSERT, UPDATE, DELETE ON ejercicio TO entrenador_deporte;
ALTER TABLE ejercicio ADD PUBLICO CHAR(1) DEFAULT 'S';
CREATE OR REPLACE VIEW VEJERCICIO AS SELECT * FROM ejercicio WHERE PUBLICO = 'S';

-- 2. RF3. Gestión de la rutina
GRANT SELECT, INSERT, UPDATE, DELETE ON rutina TO entrenador_deporte;
GRANT SELECT, INSERT, UPDATE, DELETE ON conforman TO entrenador_deporte;

-- 3. RF2. Asignación de clientes a entrenadores
GRANT SELECT, INSERT, UPDATE, DELETE ON entrena TO gerente;

-- 4. RF4. Asignación de plan y sesiones de entrenamiento
-- - Los entrenadores podrán asignar planes, rutinas y sesiones de ejercicios a los clientes
CREATE OR REPLACE VIEW VPLAN_ENTRENADOR AS SELECT * FROM plan WHERE entrena_entrenador_id = (SELECT id FROM usuario WHERE usuariooracle = USER);
GRANT SELECT, INSERT, UPDATE, DELETE ON VPLAN_ENTRENADOR TO entrenador_deporte;

ALTER TABLE sesion ADD estado_entrenamiento VARCHAR2(20 CHAR);

CREATE OR REPLACE VIEW VSESION_ENTRENADOR AS SELECT * FROM sesion WHERE plan_entrena_entrenador_id = (SELECT id FROM USUARIO WHERE usuariooracle = USER);
GRANT SELECT, INSERT, UPDATE(inicio, fin, presencial, descripcion, plan_inicio, plan_rutina_id, plan_entrena_entrenador_id, plan_entrena_cliente_id) ON VSESION_ENTRENADOR TO entrenador_deporte;