------------------------------------------------------PARTE 3
ALTER TABLE sesion ADD estado_entrenamiento VARCHAR2(20 CHAR);

-- 1. RF5. Control del cliente de sus sesiones de entrenamiento
CREATE VIEW VSesiones_Actuales_Cliente AS
SELECT *
FROM sesion 
WHERE plan_entrena_cliente_id  = (SELECT id FROM usuario WHERE usuariooracle = USER) AND fin IS NULL;

GRANT SELECT ON VSesiones_Actuales_Cliente TO cliente;

-- - Gestión de estado personal del cliente (responsabilidad del cliente)
GRANT UPDATE (video, estado_entrenamiento) ON VSesiones_Actuales_Cliente TO cliente;

-- - Actualización del perfil:
GRANT UPDATE (datos_salud) ON VSesiones_Actuales_Cliente TO cliente;

CREATE VIEW VCliente AS
SELECT c.*
FROM cliente c
JOIN usuario u ON c.id = u.id
WHERE u.usuariooracle = USER;

GRANT UPDATE (objetivos, preferencias) ON VCliente TO cliente;

-- 2. RF6 Seguimiento de entrenamientos (entrenador)
CREATE VIEW VSesiones_Entrenador AS
SELECT *
FROM sesion 
WHERE plan_entrena_entrenador_id = (SELECT id FROM usuario WHERE usuariooracle = USER);

GRANT SELECT ON VSesiones_Entrenador TO entrenador;

-- 3. RF7 Gestión de citas:
ALTER TABLE cita ADD estado_cita CHAR(1) DEFAULT 'P';

CREATE VIEW VCitas_Cliente AS
SELECT fechayhora, id, modalidad
FROM cita
WHERE cliente_id = (SELECT id FROM usuario WHERE usuariooracle = USER);

GRANT SELECT, INSERT, DELETE ON VCitas_Cliente TO cliente;

CREATE VIEW VCitas_Entrenador_Pendientes AS
SELECT *
FROM cita
WHERE id = (SELECT id FROM usuario WHERE usuariooracle = USER) AND estado_cita = 'P';

GRANT SELECT, DELETE, UPDATE(fechayhora, estado_cita) ON VCitas_Entrenador_Pendientes TO entrenador;

CREATE VIEW VCitas_Entrenador_Confirmadas AS
SELECT *
FROM cita
WHERE id = (SELECT id FROM usuario WHERE usuariooracle = USER) AND estado_cita = 'C';

GRANT SELECT ON VCitas_Entrenador_Confirmadas TO entrenador;
