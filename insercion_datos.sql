--Llenamos tabla dietas
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (1, 'Mediterránea', 'Alta en frutas, verduras, cereales integrales y aceite de oliva.', 'Equilibrada');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (2, 'Keto', 'Alta en grasas y muy baja en carbohidratos.', 'Baja en Carbohidratos');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (3, 'Vegetariana', 'Sin carne ni pescado, incluye productos lácteos y huevos.', 'Equilibrada');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (4, 'Vegana', 'Sin productos de origen animal, solo alimentos vegetales.', 'Equilibrada');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (5, 'Paleolítica', 'Basada en alimentos que se consumían en el período paleolítico.', 'Alta en Proteínas');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (6, 'DASH', 'Diseñada para reducir la hipertensión, alta en frutas, verduras y lácteos bajos en grasa.', 'Equilibrada');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (7, 'Baja en Carbohidratos', 'Reduce significativamente la ingesta de carbohidratos.', 'Baja en Carbohidratos');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (8, 'Alta en Proteínas', 'Aumenta la ingesta de proteínas para la construcción muscular.', 'Alta en Proteínas');


-------------------------------------------------Creamos 4 clientes con PL/SQL
set serveroutput on
DECLARE
    -- Declarar una variable de tipo TCLIENTE para pasar como parámetro
    v_cliente BASE.TCLIENTE;
    -- Declarar variables para recibir los datos de usuario y cliente
    v_usuario USUARIO%ROWTYPE;
    v_cliente_out CLIENTE%ROWTYPE;
BEGIN
    -- Asignar valores a la variable de tipo TCLIENTE
    v_cliente.NOMBRE := 'Juan';
    v_cliente.APELLIDOS := 'Perez';
    v_cliente.TELEFONO := '123456789';
    v_cliente.DIRECCION := 'Calle Falsa 123';
    v_cliente.CORREOE := 'juan.perez@example.com';
    v_cliente.OBJETIVOS := 'Perder peso';
    v_cliente.DIETA := 3;
    v_cliente.PREFERENCIAS := 'Vegetariano';
    v_cliente.CENTRO := 10;

    -- Llamar al procedimiento CREA_CLIENTE
    BASE.CREA_CLIENTE(
        P_DATOS    => v_cliente,
        P_USERPASS => 'password123',
        P_USUARIO  => v_usuario,
        P_CLIENTE  => v_cliente_out
    );

END;
/

set serveroutput on
DECLARE
    -- Declarar una variable de tipo TCLIENTE para pasar como parámetro
    v_cliente BASE.TCLIENTE;
    -- Declarar variables para recibir los datos de usuario y cliente
    v_usuario USUARIO%ROWTYPE;
    v_cliente_out CLIENTE%ROWTYPE;
BEGIN
    -- Asignar valores a la variable de tipo TCLIENTE
    v_cliente.NOMBRE := 'Maria';
    v_cliente.APELLIDOS := 'Lopez';
    v_cliente.TELEFONO := '987654321';
    v_cliente.DIRECCION := 'Avenida Principal 456';
    v_cliente.CORREOE := 'maria.lopez@example.com';
    v_cliente.OBJETIVOS := 'Ganar masa muscular';
    v_cliente.DIETA := 5;
    v_cliente.PREFERENCIAS := 'Paleolítica';
    v_cliente.CENTRO := 10;

    -- Llamar al procedimiento CREA_CLIENTE
    BASE.CREA_CLIENTE(
        P_DATOS    => v_cliente,
        P_USERPASS => 'password123',
        P_USUARIO  => v_usuario,
        P_CLIENTE  => v_cliente_out
    );

END;
/

set serveroutput on
DECLARE
    -- Declarar una variable de tipo TCLIENTE para pasar como parámetro
    v_cliente BASE.TCLIENTE;
    -- Declarar variables para recibir los datos de usuario y cliente
    v_usuario USUARIO%ROWTYPE;
    v_cliente_out CLIENTE%ROWTYPE;
BEGIN
    -- Asignar valores a la variable de tipo TCLIENTE
    v_cliente.NOMBRE := 'Pedro';
    v_cliente.APELLIDOS := 'Garcia';
    v_cliente.TELEFONO := '123456788';
    v_cliente.DIRECCION := 'Calle Falsa 123';
    v_cliente.CORREOE := 'pedro.garcia@example.com';
    v_cliente.OBJETIVOS := 'Perder peso';
    v_cliente.DIETA := 3;
    v_cliente.PREFERENCIAS := 'Vegetariano';
    v_cliente.CENTRO := 10;

    -- Llamar al procedimiento CREA_CLIENTE
    BASE.CREA_CLIENTE(
        P_DATOS    => v_cliente,
        P_USERPASS => 'password123',
        P_USUARIO  => v_usuario,
        P_CLIENTE  => v_cliente_out
    );
END;
/

set serveroutput on
DECLARE
    -- Declarar una variable de tipo TCLIENTE para pasar como parámetro
    v_cliente BASE.TCLIENTE;
    -- Declarar variables para recibir los datos de usuario y cliente
    v_usuario USUARIO%ROWTYPE;
    v_cliente_out CLIENTE%ROWTYPE;
BEGIN
    -- Asignar valores a la variable de tipo TCLIENTE
    v_cliente.NOMBRE := 'Manuel';
    v_cliente.APELLIDOS := 'Fernández';
    v_cliente.TELEFONO := '123456888';
    v_cliente.DIRECCION := 'Calle Falsa 123';
    v_cliente.CORREOE := 'manu.fdz@example.com';
    v_cliente.OBJETIVOS := 'Perder peso';
    v_cliente.DIETA := 4;
    v_cliente.PREFERENCIAS := 'Vegana';
    v_cliente.CENTRO := 10;

    -- Llamar al procedimiento CREA_CLIENTE
    BASE.CREA_CLIENTE(
        P_DATOS    => v_cliente,
        P_USERPASS => 'password123',
        P_USUARIO  => v_usuario,
        P_CLIENTE  => v_cliente_out
    );
END;
/

-------------------------------------------------Creamos 3 entrenadores con PL/SQL

set serveroutput on
DECLARE
    -- Declarar una variable de tipo TENTRENADOR para pasar como parámetro
    v_entrenador BASE.TENTRENADOR;
    -- Declarar variables para recibir los datos de usuario y entrenador
    v_usuario USUARIO%ROWTYPE;
    v_entrenador_out ENTRENADOR%ROWTYPE;
BEGIN
    -- Asignar valores a la variable de tipo TENTRENADOR
    v_entrenador.NOMBRE := 'Mariano';
    v_entrenador.APELLIDOS := 'Lopez';
    v_entrenador.TELEFONO := '997654321';
    v_entrenador.DIRECCION := 'Avenida Principal 456';
    v_entrenador.CORREOE := 'mariano.lpz@example.con';
    v_entrenador.DISPONIBILIDAD := 'Mañana';
    v_entrenador.CENTRO := 10;

    -- Llamar al procedimiento CREA_ENTRENADOR
    BASE.CREA_ENTRENADOR(
        P_DATOS    => v_entrenador,
        P_USERPASS => 'password123',
        P_USUARIO  => v_usuario,
        P_ENTRENADOR  => v_entrenador_out
    );

END;
/

set serveroutput on
DECLARE
    -- Declarar una variable de tipo TENTRENADOR para pasar como parámetro
    v_entrenador BASE.TENTRENADOR;
    -- Declarar variables para recibir los datos de usuario y entrenador
    v_usuario USUARIO%ROWTYPE;
    v_entrenador_out ENTRENADOR%ROWTYPE;
BEGIN
    -- Asignar valores a la variable de tipo TENTRENADOR
    v_entrenador.NOMBRE := 'Federico';
    v_entrenador.APELLIDOS := 'Pérez';
    v_entrenador.TELEFONO := '997654391';
    v_entrenador.DIRECCION := 'Avenida Principal 456';
    v_entrenador.CORREOE := 'fede.prz@example.con';
    v_entrenador.DISPONIBILIDAD := 'MAÑANA';
    v_entrenador.CENTRO := 10;

    -- Llamar al procedimiento CREA_ENTRENADOR
    BASE.CREA_ENTRENADOR(
        P_DATOS    => v_entrenador,
        P_USERPASS => 'password123',
        P_USUARIO  => v_usuario,
        P_ENTRENADOR  => v_entrenador_out
    );

END;
/

set serveroutput on
DECLARE
    -- Declarar una variable de tipo TENTRENADOR para pasar como parámetro
    v_entrenador BASE.TENTRENADOR;
    -- Declarar variables para recibir los datos de usuario y entrenador
    v_usuario USUARIO%ROWTYPE;
    v_entrenador_out ENTRENADOR%ROWTYPE;
BEGIN
    -- Asignar valores a la variable de tipo TENTRENADOR
    v_entrenador.NOMBRE := 'Alvaro';
    v_entrenador.APELLIDOS := 'Rodriguez';
    v_entrenador.TELEFONO := '997655321';
    v_entrenador.DIRECCION := 'Avenida Principal 456';
    v_entrenador.CORREOE := 'alvaro.rdrz@example.con';
    v_entrenador.DISPONIBILIDAD := 'TARDE';
    v_entrenador.CENTRO := 10;

    -- Llamar al procedimiento CREA_ENTRENADOR
    BASE.CREA_ENTRENADOR(
        P_DATOS    => v_entrenador,
        P_USERPASS => 'password123',
        P_USUARIO  => v_usuario,
        P_ENTRENADOR  => v_entrenador_out
    );

END;
/

-------------------------------------------------Creamos 2 gerentes con PL/SQL
set serveroutput on

DECLARE
    -- Declarar una variable de tipo TGERENTE para pasar como parámetro
    v_gerente BASE.TGERENTE;
    -- Declarar variables para recibir los datos de usuario y gerente
    v_usuario USUARIO%ROWTYPE;
    v_gerente_out GERENTE%ROWTYPE;
BEGIN
    -- Asignar valores a la variable de tipo TGERENTE
    v_gerente.NOMBRE := 'Migule';
    v_gerente.APELLIDOS := 'Gomez';
    v_gerente.TELEFONO := '659997321';
    v_gerente.DIRECCION := 'Plaza Mayor 789';
    v_gerente.CORREOE := 'miguel.gomez@gmail.com';
    v_gerente.DESPACHO := 'Despacho 1';
    v_gerente.HORARIO := 'Lunes a Viernes de 9 a 5';
    v_gerente.CENTRO := 10;

    -- Llamar al procedimiento CREA_GERENTE
    BASE.CREA_GERENTE(
        P_DATOS    => v_gerente,
        P_USERPASS => 'password123',
        P_USUARIO  => v_usuario,
        P_GERENTE  => v_gerente_out
    );

END;
/

set serveroutput on

DECLARE
    -- Declarar una variable de tipo TGERENTE para pasar como parámetro
    v_gerente BASE.TGERENTE;
    -- Declarar variables para recibir los datos de usuario y gerente
    v_usuario USUARIO%ROWTYPE;
    v_gerente_out GERENTE%ROWTYPE;
BEGIN
    -- Asignar valores a la variable de tipo TGERENTE
    v_gerente.NOMBRE := 'Fabiola';
    v_gerente.APELLIDOS := 'Gallego';
    v_gerente.TELEFONO := '666987321';
    v_gerente.DIRECCION := 'Plaza Mayor 789';
    v_gerente.CORREOE := 'pedro.gomez@gmail.com';
    v_gerente.DESPACHO := 'Despacho 2';
    v_gerente.HORARIO := 'Lunes a Viernes de 9 a 5';
    v_gerente.CENTRO := 20;

    -- Llamar al procedimiento CREA_GERENTE
    BASE.CREA_GERENTE(
        P_DATOS    => v_gerente,
        P_USERPASS => 'password123',
        P_USUARIO  => v_usuario,
        P_GERENTE  => v_gerente_out
    );

END;
/

--Llenamos tabla elementocalen
INSERT INTO ELEMENTOCALEN (fechayhora, entrenador_id) VALUES (TO_DATE('2024-06-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 35);
INSERT INTO ELEMENTOCALEN (fechayhora, entrenador_id) VALUES (TO_DATE('2024-07-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 36);

--Llenamos tabla citas
INSERT INTO CITA (fechayhora, id, modalidad, cliente_id, estado_cita) VALUES (TO_DATE('2024-06-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 35, 'Presencial', 42, 'P');
INSERT INTO CITA (fechayhora, id, modalidad, cliente_id, estado_cita) VALUES (TO_DATE('2024-07-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 36, 'Presencial', 43, 'P');

--Llenamos tabla rutina
INSERT INTO RUTINA (id, nombre, descripcion) VALUES (1, 'pepe', 'rutina de pepe');
INSERT INTO RUTINA (id, nombre, descripcion) VALUES (2, 'juan', 'rutina de juan');
INSERT INTO RUTINA (id, nombre, descripcion) VALUES (3, 'luis', 'rutina de luis');

--Llenamos tabla entrena
INSERT INTO ENTRENA (especialidad, entrenador_id, cliente_id) VALUES ('ENTRENAMIENTO', 35, 42);
INSERT INTO ENTRENA (especialidad, entrenador_id, cliente_id) VALUES ('ENTRENAMIENTO', 36, 43);

--Llenamos tabla plan
INSERT INTO PLAN (inicio, fin, rutina_id, entrena_entrenador_id, entrena_cliente_id) 
VALUES (TO_DATE('2024-06-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), null, 1, 35, 42);
INSERT INTO PLAN (inicio, fin, rutina_id, entrena_entrenador_id, entrena_cliente_id)
VALUES (TO_DATE('2024-06-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), null, 1, 36, 43);

--Llenamos tabla sesion
INSERT INTO SESION (inicio, fin, presencial, descripcion, video, datos_salud, plan_inicio, plan_rutina_id, plan_entrena_entrenador_id, plan_entrena_cliente_id)
VALUES (TO_DATE('2024-06-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-19 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Sí', 'Calentamiento', 'https://www.youtube.com/watch?v=123456', 'Saludable',TO_DATE('2024-06-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS') , 1, 35, 42);
INSERT INTO SESION (inicio, fin, presencial, descripcion, video, datos_salud, plan_inicio, plan_rutina_id, plan_entrena_entrenador_id, plan_entrena_cliente_id)
VALUES (TO_DATE('2024-06-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-30 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'No', 'Calentamiento', 'https://www.youtube.com/watch?v=123456', 'Saludable',TO_DATE('2024-06-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS') , 1, 36, 43);

