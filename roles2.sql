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
-- - Cliente puede pedir / anular / cambiar cita con su entrenador (solo una petición activa a la
-- vez).
-- - Entrenador puede ver la lista de citas (confirmadas, pendientes).
-- - Entrenador puede cambiar estado de cita (confirmar, anular, cambiar fecha u hora.
