create or replace PACKAGE BODY BASE AS

    -- Implementación del procedimiento CREA_CLIENTE
    PROCEDURE CREA_CLIENTE(
        P_DATOS    IN  TCLIENTE,
        P_USERPASS IN  VARCHAR2,
        P_USUARIO  OUT USUARIO%ROWTYPE,
        P_CLIENTE  OUT CLIENTE%ROWTYPE
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION; -- Directiva para transacción autónoma
        v_usuario_id USUARIO.ID%TYPE;
        v_cliente_id CLIENTE.ID%TYPE;
    BEGIN
        -- Insertar usuario
        INSERT INTO usuario (nombre, apellidos, telefono, direccion, correoe)
        VALUES (P_DATOS.NOMBRE, P_DATOS.APELLIDOS, P_DATOS.TELEFONO, P_DATOS.DIRECCION, P_DATOS.CORREOE)
        RETURNING id INTO v_usuario_id;

        -- Insertar cliente
        INSERT INTO cliente (id, objetivo, preferencias, dieta_id, centro_id)
        VALUES (v_usuario_id, P_DATOS.OBJETIVOS, P_DATOS.PREFERENCIAS, P_DATOS.DIETA, P_DATOS.CENTRO)
        RETURNING id INTO v_cliente_id;

        -- Commit de la transacción autónoma para confirmar cambios
        COMMIT;

        -- Recuperar los datos de usuario y cliente
        SELECT * INTO P_USUARIO FROM usuario WHERE id = v_usuario_id;
        SELECT * INTO P_CLIENTE FROM cliente WHERE id = v_cliente_id;

        -- Crear sinónimos, vistas y otros objetos relacionados
        --Por hacer

    EXCEPTION
        WHEN OTHERS THEN
            -- Rollback a savepoint si hay errores
            ROLLBACK TO SAVEPOINT EXCEPCION_CREACION;
            -- Lanzar excepción o manejar el error según sea necesario
            RAISE;
    END CREA_CLIENTE;
    
    --Implementación del procedimiento CREAR_ENTRENADOR
    
    PROCEDURE CREA_ENTRENADOR(
        P_DATOS IN TENTRENADOR,
        P_USERPASS IN VARCHAR2,
        P_USUARIO OUT USUARIO%ROWTYPE,
        P_ENTRENADOR OUT ENTRENADOR%ROWTYPE
    ) is
        PRAGMA AUTONOMOUS_TRANSACTION; -- Directiva para transacción autónoma
        v_usuario_id USUARIO.ID%TYPE;
        v_entrenador_id ENTRENADOR.ID%TYPE;
    BEGIN
        INSERT INTO usuario(nombre, apellidos, telefono, direccion, correoe)
        VALUES(P_DATOS.NOMBRE, P_DATOS.APELLIDOS, P_DATOS.TELEFONO, P_DATOS.DIRECCION, P_DATOS.CORREOE)
        RETURNING id INTO v_usuario_id;
        
        --Insertar entrenador
        INSERT INTO entrenador (id, disponibilidad, centro_id)
        VALUES (v_usuario_id, P_DATOS.DISPONIBILIDAD, P_DATOS.CENTRO)
        RETURNING id INTO v_entrenador_id;
        
        -- Commit de la transacción autónoma
        COMMIT;

        -- Recuperar los datos de usuario y entrenador
        SELECT * INTO P_USUARIO FROM usuario WHERE id = v_usuario_id;
        SELECT * INTO P_ENTRENADOR FROM entrenador WHERE id = v_entrenador_id;
        
        -- Crear sinónimos, vistas y otros objetos relacionados
        --Por hacer
        
        EXCEPTION
        WHEN OTHERS THEN
            -- Rollback a savepoint si hay errores
            ROLLBACK TO SAVEPOINT EXCEPCION_CREACION;
            -- Lanzar excepción o manejar el error según sea necesario
            RAISE;     
    END CREA_ENTRENADOR;
    
    --Implementación del procedimiento CREAR_GERENTE
    
    PROCEDURE CREA_GERENTE(
        P_DATOS IN TGERENTE,
        P_USERPASS IN VARCHAR2,
        P_USUARIO OUT USUARIO%ROWTYPE,
        P_GERENTE OUT GERENTE%ROWTYPE
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION; -- Directiva para transacción autónoma
        v_usuario_id USUARIO.ID%TYPE;
        v_gerente_id GERENTE.ID%TYPE;
    BEGIN
        -- Insertar usuario 
        INSERT INTO usuario (nombre, apellidos, telefono, direccion, correoe)
        VALUES (P_DATOS.NOMBRE, P_DATOS.APELLIDOS, P_DATOS.TELEFONO, P_DATOS.DIRECCION, P_DATOS.CORREOE)
        RETURNING id INTO v_usuario_id;

        -- Insertar gerente
        INSERT INTO gerente (id, despacho, horario, centro_id)
        VALUES (v_usuario_id, P_DATOS.DESPACHO, P_DATOS.HORARIO, P_DATOS.CENTRO)
        RETURNING id INTO v_gerente_id;

        -- Commit de la transacción autónoma
        COMMIT;

        -- Recuperar los datos de usuario y gerente
        SELECT * INTO P_USUARIO FROM usuario WHERE id = v_usuario_id;
        SELECT * INTO P_GERENTE FROM gerente WHERE id = v_gerente_id;

        -- Crear sinónimos, vistas y otros objetos relacionados
        --Por hacer

    EXCEPTION
        WHEN OTHERS THEN
            -- Rollback a savepoint si hay errores
            ROLLBACK TO SAVEPOINT EXCEPCION_CREACION;
            -- Lanzar excepción o manejar el error según sea necesario
            RAISE;
    END CREA_GERENTE;

END BASE;
