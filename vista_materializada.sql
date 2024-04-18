-- Crear la vista materializada
CREATE MATERIALIZED VIEW VM_EJERCICIOS
REFRESH FORCE ON DEMAND
AS
SELECT * 
FROM ejercicios
ORDER BY fecha_carga DESC
FETCH FIRST 1 ROWS ONLY;  -- Esto te dará solo la última carga de ejercicios