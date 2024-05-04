-- Creamos roles:
CREATE ROLE administrador;
CREATE ROLE gerente;
CREATE ROLE entrenador_deporte;
CREATE ROLE entrenador_nutricion;
CREATE ROLE cliente;

-- 1. RF1. Gestión de los Ejercicios.

GRANT SELECT, INSERT, UPDATE, DELETE ON ejercicio TO entrenador_deporte;
ALTER TABLE ejercicio ADD PUBLICO CHAR(1) DEFAULT 'S';
CREATE VIEW VEJERCICIO AS SELECT * FROM ejercicio WHERE PUBLICO = 'S';
INSERT INTO ejercicio (id, nombre, descripcion, video) SELECT ROWNUM, nombre, descripcion, video FROM ejercicios_ext;


-- 2. RF3. Gestión de la rutina.
GRANT SELECT, INSERT, UPDATE, DELETE ON rutina TO entrenador_deporte;
GRANT SELECT, INSERT, UPDATE, DELETE ON conforman TO entrenador_deporte;

-- 3. RF2. Asignación de clientes a entrenadores.
GRANT SELECT, INSERT, UPDATE, DELETE ON entrena TO gerente;

-- 4. RF4. Asignación de plan y sesiones de entrenamiento.
-- - Los entrenadores podrán asignar planes, rutinas y sesiones de ejercicios a los clientes.
GRANT SELECT, INSERT, UPDATE, DELETE ON plan TO entrenador_deporte;
GRANT SELECT, INSERT, UPDATE, DELETE ON sesion TO entrenador_deporte;


