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
        v_usuariooracle VARCHAR2(30); -- Variable para el nombre de usuario Oracle
    BEGIN

        SAVEPOINT EXCEPCION_CREACION; -- Crear un punto de guardado para rollback

        -- Obtener el próximo valor de la secuencia para el ID del usuario y cliente
        SELECT usuario_seq.NEXTVAL INTO v_usuario_id FROM dual;
        v_cliente_id := v_usuario_id; -- El ID del cliente es igual al ID del usuario

        -- Crear el nombre de usuario Oracle
        v_usuariooracle := 'LIFEFIT_' || v_usuario_id;

        -- Crear el usuario
        BEGIN
            EXECUTE IMMEDIATE 'CREATE USER ' || P_DATOS.NOMBRE || ' IDENTIFIED BY ' || P_USERPASS || ' DEFAULT TABLESPACE TS_LIFEFIT QUOTA UNLIMITED ON TS_LIFEFIT';
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK TO SAVEPOINT EXCEPCION_CREACION; -- Rollback si hay errores

                -- Si falla la creación del usuario, manejar el error
                DBMS_OUTPUT.PUT_LINE('Error al crear el cliente');
                RAISE EXCEPCION_CREACION;
        END;

        -- Insertar usuario
        INSERT INTO usuario (id, nombre, apellidos, telefono, direccion, correoe, usuariooracle)
        VALUES (v_usuario_id, P_DATOS.NOMBRE, P_DATOS.APELLIDOS, P_DATOS.TELEFONO, P_DATOS.DIRECCION, P_DATOS.CORREOE, v_usuariooracle);
        
        -- Insertar cliente
        INSERT INTO cliente (id, objetivo, preferencias, dieta_id, centro_id)
        VALUES (v_cliente_id, P_DATOS.OBJETIVOS, P_DATOS.PREFERENCIAS, P_DATOS.DIETA, P_DATOS.CENTRO);

        -- Commit de la transacción autónoma para confirmar cambios
        COMMIT;

        -- Recuperar los datos de usuario y cliente
        SELECT * INTO P_USUARIO FROM usuario WHERE id = v_usuario_id;
        SELECT * INTO P_CLIENTE FROM cliente WHERE id = v_cliente_id;

    EXCEPTION
        WHEN OTHERS THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK TO SAVEPOINT EXCEPCION_CREACION;
            
            -- Eliminar el usuario creado si la excepción ocurre después de la creación
            EXECUTE IMMEDIATE 'DROP USER ' || P_DATOS.NOMBRE || ' CASCADE';
            DBMS_OUTPUT.PUT_LINE('Error al crear el cliente');
            RAISE EXCEPCION_CREACION;
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

    PROCEDURE ELIMINA_USER(P_ID USUARIO.ID%TYPE) IS
        BEGIN
        -- Actualizar el atributo UsuarioOracle a NULL en la tabla USUARIO
        UPDATE usuario
        SET usuariooracle = NULL
        WHERE id = P_ID;
        
        -- Commit para confirmar los cambios
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Manejar cualquier excepción que pueda ocurrir durante el proceso de eliminación
            ROLLBACK to savepoint EXCEPCION_ELIMINACION; -- Rollback en caso de error
            RAISE;
    END ELIMINA_USER;
    
    PROCEDURE ELIMINA_CLIENTE(P_ID USUARIO.ID%TYPE) IS
    BEGIN
        DELETE FROM usuario WHERE id = P_ID;
        DELETE FROM cliente WHERE id = P_ID;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK to savepoint EXCEPCION_ELIMINACION;
            RAISE;
    END ELIMINA_CLIENTE;
    
    PROCEDURE ELIMINA_GERENTE(P_ID USUARIO.ID%TYPE) IS
    BEGIN
        DELETE FROM usuario WHERE id = P_ID;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK to savepoint EXCEPCION_ELIMINACION;
            RAISE;
    END ELIMINA_GERENTE;
    
    PROCEDURE ELIMINA_ENTRENADOR(P_ID USUARIO.ID%TYPE) IS
    BEGIN

        DELETE FROM plan WHERE entrena_entrenador_id = P_ID;
        DELETE FROM entrenador WHERE id = P_ID;
        DELETE FROM usuario WHERE id = P_ID;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK to savepoint EXCEPCION_ELIMINACION;
            RAISE;
    END ELIMINA_ENTRENADOR;

END BASE;
