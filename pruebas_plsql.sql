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
    v_cliente.DIETA := 1; -- Suponiendo que este ID de dieta existe
    v_cliente.PREFERENCIAS := 'Vegetariano';
    v_cliente.CENTRO := 1; -- Suponiendo que este ID de centro existe

    -- Llamar al procedimiento CREA_CLIENTE
    BASE.CREA_CLIENTE(
        P_DATOS    => v_cliente,
        P_USERPASS => 'password123',
        P_USUARIO  => v_usuario,
        P_CLIENTE  => v_cliente_out
    );

END;
/