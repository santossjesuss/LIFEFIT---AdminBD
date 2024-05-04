------------------------------------------------------PARTE 3
ALTER TABLE sesion ADD estado_entrenamiento VARCHAR2(20 CHAR);

-- 1. RF5. Control del cliente de sus sesiones de entrenamiento
CREATE VIEW VSesiones_Actuales_Cliente AS
SELECT s.*
FROM sesion s
JOIN cliente c ON s.plan_entrena_cliente_id = c.id
JOIN usuario u ON c.usuario_id = u.id
WHERE u.usuariooracle = USER;

GRANT SELECT ON VSesiones_Actuales_Cliente TO cliente;

-- - Gestión de estado personal del cliente (responsabilidad del cliente)
GRANT UPDATE (video, estado_entrenamiento) ON VSesiones_Actuales_Cliente TO cliente;

-- - Actualización del perfil:
GRANT UPDATE (datos_salud) ON VSesiones_Actuales_Cliente TO cliente;

CREATE VIEW VCliente AS
SELECT c.*
FROM cliente c
JOIN usuario u ON c.usuario_id = u.id
WHERE u.usuariooracle = USER;

GRANT UPDATE (objetivos, preferencias) ON VCliente TO cliente;

-- 2. RF6 Seguimiento de entrenamientos (entrenador)
-- - Entrenador personal puede ver los vídeos de entrenamiento que le han enviado los
--   clientes (los que tiene asignados).
-- - Gestión del estado del cliente (visualización de datos históricos):
-- - Trabajo realizado,
-- - datos físicos
-- - comprobación de objetivos

