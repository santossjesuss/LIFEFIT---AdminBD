-- Crear la vista materializada que se refresco cada dia a las 00:00
CREATE MATERIALIZED VIEW VM_EJERCICIOS
REFRESH FORCE
NEXT TRUNC(SYSDATE) + 1
AS
SELECT *
FROM ejercicios_ext;
