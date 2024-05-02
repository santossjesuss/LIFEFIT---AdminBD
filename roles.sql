-- Creamos roles:
CREATE ROLE Administrador;
CREATE ROLE Gerente;
CREATE ROLE Entrenador_deporte;
CREATE ROLE Entrenador_nutricion;
CREATE ROLE Cliente;

-- Asignación de permisos:
GRANT ALL PRIVILEGES ON TS_LIFEFIT TO Administrador;

GRANT ALL PRIVILEGES ON TS_LIFEFIT.centro TO gerente;
GRANT ALL PRIVILEGES ON TS_LIFEFIT.entrenador TO gerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON TS_LIFEFIT.cliente TO gerente;

GRANT ALL PRIVILEGES ON TS_LIFEFIT.ejercicio TO Entrenador_deporte;
GRANT ALL PRIVILEGES ON TS_LIFEFIT.rutina TO Entrenador_deporte;
GRANT ALL PRIVILEGES ON TS_LIFEFIT.conforman TO Entrenador_deporte;
GRANT ALL PRIVILEGES ON TS_LIFEFIT.sesion TO Entrenador_deporte;
GRANT ALL PRIVILEGES ON TS_LIFEFIT.plan TO Entrenador_deporte;



-- Asignación de role a usuario:
GRANT Administrador TO LIFEFIT;