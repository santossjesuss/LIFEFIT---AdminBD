------------------------------------------------------PARTE 3

-- 1. RF5. Control del cliente de sus sesiones de entrenamiento
CREATE OR REPLACE VIEW VSESIONES_ACTUALES_CLIENTE AS
SELECT *
FROM sesion 
WHERE plan_entrena_cliente_id  = (SELECT id FROM usuario WHERE usuariooracle = USER) AND fin IS NULL;

GRANT SELECT ON VSESIONES_ACTUALES_CLIENTE TO cliente;

-- - Gestión de estado personal del cliente (responsabilidad del cliente)
GRANT UPDATE (video, datos_salud, estado_entrenamiento) ON VSESIONES_ACTUALES_CLIENTE TO cliente;

CREATE OR REPLACE VIEW VCLIENTE AS
SELECT c.*
FROM cliente c
JOIN usuario u ON c.id = u.id
WHERE u.usuariooracle = USER;

GRANT SELECT, UPDATE (objetivo, preferencias) ON VCLIENTE TO cliente;

-- 2. RF6 Seguimiento de entrenamientos (entrenador)
-- Hecho en el RF4

-- 3. RF7 Gestión de citas:
ALTER TABLE cita ADD estado_cita CHAR(1) DEFAULT 'P';

CREATE OR REPLACE VIEW VCITAS_CLIENTE AS
SELECT fechayhora, id, modalidad, estado_cita
FROM cita
WHERE cliente_id = (SELECT id FROM usuario WHERE usuariooracle = USER);

GRANT SELECT, INSERT, DELETE ON VCITAS_CLIENTE TO cliente;

CREATE OR REPLACE VIEW VCITAS_ENTRENADOR_PENDIENTES AS
SELECT *
FROM cita
WHERE id = (SELECT id FROM usuario WHERE usuariooracle = USER) AND estado_cita = 'P';

GRANT SELECT, DELETE, UPDATE(fechayhora, estado_cita) ON VCITAS_ENTRENADOR_PENDIENTES TO entrenador_deporte;
GRANT SELECT, DELETE, UPDATE(fechayhora, estado_cita) ON VCITAS_ENTRENADOR_PENDIENTES TO entrenador_nutricion;

CREATE OR REPLACE VIEW VCITAS_ENTRENADOR_CONFIRMADAS AS
SELECT *
FROM cita
WHERE id = (SELECT id FROM usuario WHERE usuariooracle = USER) AND estado_cita = 'C';

GRANT SELECT ON VCITAS_ENTRENADOR_CONFIRMADAS TO entrenador_deporte;
GRANT SELECT ON VCITAS_ENTRENADOR_CONFIRMADAS TO entrenador_nutricion;

