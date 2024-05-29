CREATE OR REPLACE VIEW full_datos_entrenador AS
SELECT 
    e.id AS entrenador_id,
    e.disponibilidad,
    e.centro_id,
    t.especialidad
FROM 
    entrenador e
JOIN 
    entrena t ON e.id = t.entrenador_id;