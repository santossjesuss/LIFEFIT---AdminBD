-- Prueba cliente
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
    v_cliente.DIETA := 1;
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

-- Prueba entrenador
set serveroutput on
DECLARE
    -- Declarar una variable de tipo TENTRENADOR para pasar como parámetro
    v_entrenador BASE.TENTRENADOR;
    -- Declarar variables para recibir los datos de usuario y entrenador
    v_usuario USUARIO%ROWTYPE;
    v_entrenador_out ENTRENADOR%ROWTYPE;
BEGIN
    -- Asignar valores a la variable de tipo TENTRENADOR
    v_entrenador.NOMBRE := 'Maria';
    v_entrenador.APELLIDOS := 'Lopez';
    v_entrenador.TELEFONO := '987654321';
    v_entrenador.DIRECCION := 'Avenida Principal 456';
    v_entrenador.CORREOE := 'maria.lopez@gmial.con';
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

-- Prueba gerente
set serveroutput on

DECLARE
    -- Declarar una variable de tipo TGERENTE para pasar como parámetro
    v_gerente BASE.TGERENTE;
    -- Declarar variables para recibir los datos de usuario y gerente
    v_usuario USUARIO%ROWTYPE;
    v_gerente_out GERENTE%ROWTYPE;
BEGIN
    -- Asignar valores a la variable de tipo TGERENTE
    v_gerente.NOMBRE := 'Pedro';
    v_gerente.APELLIDOS := 'Gomez';
    v_gerente.TELEFONO := '654987321';
    v_gerente.DIRECCION := 'Plaza Mayor 789';
    v_gerente.CORREOE := 'pedro.gomez@gmail.com';
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
