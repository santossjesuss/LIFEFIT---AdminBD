-- Crear la vista materializada
CREATE MATERIALIZED VIEW VM_EJERCICIOS
REFRESH FORCE
NEXT TRUNC(SYSDATE) + 1
AS
SELECT *
FROM ejercicios_ext;

-- Crear el job para refrescar la vista materializada diariamente a las 00:00 horas
BEGIN
    DBMS_SCHEDULER.create_job (
        job_name          => 'REFRESH_VM_EJERCICIOS',
        job_type          => 'PLSQL_BLOCK',
        job_action        => 'BEGIN DBMS_MVIEW.REFRESH(''VM_EJERCICIOS''); END;',
        start_date        => TRUNC(SYSDATE) + 1,
        repeat_interval   => 'FREQ=DAILY; BYHOUR=0',
        enabled           => TRUE
    );
END;
/