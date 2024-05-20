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

--Llenamos tabla dietas
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (1, 'Mediterránea', 'Alta en frutas, verduras, cereales integrales y aceite de oliva.', 'Equilibrada');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (2, 'Keto', 'Alta en grasas y muy baja en carbohidratos.', 'Baja en Carbohidratos');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (3, 'Vegetariana', 'Sin carne ni pescado, incluye productos lácteos y huevos.', 'Equilibrada');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (4, 'Vegana', 'Sin productos de origen animal, solo alimentos vegetales.', 'Equilibrada');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (5, 'Paleolítica', 'Basada en alimentos que se consumían en el período paleolítico.', 'Alta en Proteínas');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (6, 'DASH', 'Diseñada para reducir la hipertensión, alta en frutas, verduras y lácteos bajos en grasa.', 'Equilibrada');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (7, 'Baja en Carbohidratos', 'Reduce significativamente la ingesta de carbohidratos.', 'Baja en Carbohidratos');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (8, 'Alta en Proteínas', 'Aumenta la ingesta de proteínas para la construcción muscular.', 'Alta en Proteínas');
