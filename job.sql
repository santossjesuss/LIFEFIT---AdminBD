--Crear un job de Oracle que cree los eventos de calendario de todos los entrenadores para el
--mes siguiente el día 20 de cada mes a las 01:00 de la madrugada.

BEGIN
    DBMS_SCHEDULER.create_job (
        job_name        => 'JOB_EVENTOS_CALENDARIO',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN ICALC.CREA_ELEMENTOS; END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=MONTHLY; BYMONTHDAY=20; BYHOUR=1; BYMINUTE=0; BYSECOND=0',
        enabled         => TRUE
    );
END;
/
