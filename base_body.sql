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
        v_usuariooracle USUARIO.USUARIOORACLE%TYPE; -- Variable para el nombre de usuario Oracle
    BEGIN

        SAVEPOINT EXCEPCION_CREACION; -- Crear un punto de guardado para rollback

        -- Obtener el próximo valor de la secuencia para el ID del usuario y cliente
        SELECT usuario_seq.NEXTVAL INTO v_usuario_id FROM dual;
        v_cliente_id := v_usuario_id; -- El ID del cliente es igual al ID del usuario

        -- Crear el nombre de usuario Oracle
        v_usuariooracle := 'LIFEFIT_' || v_usuario_id;

        -- Crear el usuario
        BEGIN
            EXECUTE IMMEDIATE 'CREATE USER ' || v_usuariooracle || ' IDENTIFIED BY ' || P_USERPASS || ' DEFAULT TABLESPACE TS_LIFEFIT QUOTA UNLIMITED ON TS_LIFEFIT';
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK TO SAVEPOINT EXCEPCION_CREACION; -- Rollback si hay errores

                -- Si falla la creación del usuario, manejar el error
                DBMS_OUTPUT.PUT_LINE('Error al crear el cliente');
                RAISE EXCEPCION_CREACION;
        END;

        -- Asignar el rol de cliente al usuario
        GRANT cliente TO v_usuariooracle;

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
            DBMS_OUTPUT.PUT_LINE('Error al eliminar el cliente creado');
            RAISE EXCEPCION_ELIMINACION;
    END CREA_CLIENTE;
    

    --Implementación del procedimiento CREAR_ENTRENADOR
    PROCEDURE CREA_ENTRENADOR(
        P_DATOS IN TENTRENADOR,
        P_USERPASS IN VARCHAR2,
        P_USUARIO OUT USUARIO%ROWTYPE,
        P_ENTRENADOR OUT ENTRENADOR%ROWTYPE
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION; -- Directiva para transacción autónoma
        v_usuario_id USUARIO.ID%TYPE;
        v_entrenador_id ENTRENADOR.ID%TYPE;
        v_usuariooracle USUARIO.USUARIOORACLE%TYPE; -- Variable para el nombre de usuario Oracle
    BEGIN
    
            SAVEPOINT EXCEPCION_CREACION; -- Crear un punto de guardado para rollback
    
            -- Obtener el próximo valor de la secuencia para el ID del usuario y entrenador
            SELECT usuario_seq.NEXTVAL INTO v_usuario_id FROM dual;
            v_entrenador_id := v_usuario_id; -- El ID del entrenador es igual al ID del usuario
    
            -- Crear el nombre de usuario Oracle
            v_usuariooracle := 'LIFEFIT_' || v_usuario_id;
    
            -- Crear el usuario
            BEGIN
                EXECUTE IMMEDIATE 'CREATE USER ' || v_usuariooracle || ' IDENTIFIED BY ' || P_USERPASS || ' DEFAULT TABLESPACE TS_LIFEFIT QUOTA UNLIMITED ON TS_LIFEFIT';
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK TO SAVEPOINT EXCEPCION_CREACION; -- Rollback si hay errores
    
                    -- Si falla la creación del usuario, manejar el error
                    DBMS_OUTPUT.PUT_LINE('Error al crear el entrenador');
                    RAISE EXCEPCION_CREACION;
            END;

            -- Asignar el rol de entrenador al usuario
            GRANT entrenador_deporte TO v_usuariooracle;
            GRANT entrenador_nutricion TO v_usuariooracle;
    
            -- Insertar usuario
            INSERT INTO usuario (id, nombre, apellidos, telefono, direccion, correoe, usuariooracle)
            VALUES (v_usuario_id, P_DATOS.NOMBRE, P_DATOS.APELLIDOS, P_DATOS.TELEFONO, P_DATOS.DIRECCION, P_DATOS.CORREOE, v_usuariooracle);
            
            -- Insertar entrenador
            INSERT INTO entrenador (id, disponibilidad, centro_id)
            VALUES (v_entrenador_id, P_DATOS.DISPONIBILIDAD, P_DATOS.CENTRO);
    
            -- Commit de la transacción autónoma para confirmar cambios
            COMMIT;
    
            -- Recuperar los datos de usuario y entrenador
            SELECT * INTO P_USUARIO FROM usuario WHERE id = v_usuario_id;
            SELECT * INTO P_ENTRENADOR FROM entrenador WHERE id = v_entrenador_id;

    EXCEPTION
        WHEN OTHERS THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK TO SAVEPOINT EXCEPCION_CREACION;
            
            -- Eliminar el usuario creado si la excepción ocurre después de la creación
            EXECUTE IMMEDIATE 'DROP USER ' || P_DATOS.NOMBRE || ' CASCADE';
            DBMS_OUTPUT.PUT_LINE('Error al eliminar el entrenador creado');
            RAISE EXCEPCION_ELIMINACION;
    END CREA_ENTRENADOR;
    

    --Implementación del procedimiento CREAR_GERENTE
    PROCEDURE CREA_GERENTE(
        P_DATOS IN TGERENTE,
        P_USERPASS IN VARCHAR2,
        P_USUARIO OUT USUARIO%ROWTYPE,
        P_GERENTE OUT GERENTE%ROWTYPE
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION
        v_usuario_id USUARIO.ID%TYPE;
        v_gerente_id GERENTE.ID%TYPE;
        v_usuariooracle USUARIO.USUARIOORACLE%TYPE;
    BEGIN
        SAVEPOINT EXCEPCION_CREACION;
        
        SELECT usuario_seq.NEXTVAL INTO v_usuario_id FROM dual;
        v_gerente_id := v_usuario_id;
        
        v_usuariooracle := 'LIFEFIT_' || v_usuario_id;
        
        BEGIN
            EXECUTE IMMEDIATE 'CREATE USER ' || v_usuariooracle || ' IDENTIFIED BY ' || P_USERPASS || ' DEFAULT TABLESPACE TS_LIFEFIT QUOTA UNLIMITED ON TS_LIFEFIT';
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK TO SAVEPOINT EXCEPCION_CREACION;
                DBMS_OUTPUT.PUT_LINE('Error al crear el gerente');
                RAISE EXCEPCION_CREACION;
        END;
        
        GRANT gerente TO v_usuariooracle;
        
        INSERT INTO usuario (id, nombre, apellidos, telefono, direccion, correoe, usuariooracle)
        VALUES (v_usuario_id, P_DATOS.NOMBRE, P_DATOS.APELLIDOS, P_DATOS.TELEFONO, P_DATOS.DIRECCION, P_DATOS.CORREOE, v_usuariooracle);
        
        INSERT INTO gerente (id, despacho, horario, centro_id)
        VALUES (v_gerente_id, P_DATOS.DESPACHO, P_DATOS.HORARIO, P_DATOS.CENTRO);
        
        COMMIT;
        
        SELECT * INTO P_USUARIO FROM usuario WHERE id = v_usuario_id;
        SELECT * INTO P_GERENTE FROM gerente WHERE id = v_gerente_id;

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK TO SAVEPOINT EXCEPCION_CREACION;
            EXECUTE IMMEDIATE 'DROP USER ' || P_DATOS.NOMBRE || ' CASCADE';
            DBMS_OUTPUT.PUT_LINE('Error al eliminar el gerente creado');
            RAISE EXCEPCION_ELIMINACION;
    END CREA_GERENTE;

    --Implementación del procedimiento de eliminación de usuario
    PROCEDURE ELIMINA_USER(P_ID USUARIO.ID%TYPE) IS
        BEGIN
        SAVEPOINT EXCEPCION_ELIMINACION; -- Crear un punto de guardado para rollback
        -- Actualizar el atributo UsuarioOracle a NULL en la tabla USUARIO
        UPDATE usuario
        SET usuariooracle = NULL
        WHERE id = P_ID;

        -- Eliminar el usuario de Oracle
        BEGIN
            EXECUTE IMMEDIATE 'DROP USER LIFEFIT_' || P_ID || ' CASCADE';
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK TO SAVEPOINT EXCEPCION_ELIMINACION; -- Rollback en caso de error
                RAISE EXCEPTION_ELIMINACION; -- Relanzar la excepción
        
        -- Commit para confirmar los cambios
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Manejar cualquier excepción que pueda ocurrir durante el proceso de eliminación
            ROLLBACK TO SAVEPOINT EXCEPCION_ELIMINACION; -- Rollback en caso de error
            RAISE EXCEPTION_ELIMINIACION ; -- Relanzar la excepción
    END ELIMINA_USER;

    --Implementación del procedimiento de eliminación de cliente
    PROCEDURE ELIMINA_CLIENTE(P_ID USUARIO.ID%TYPE) IS
        BEGIN
        SAVEPOINT EXCEPCION_ELIMINACION; -- Crear un punto de guardado para rollback
        -- Actualizar el atributo UsuarioOracle a NULL en la tabla USUARIO
        UPDATE usuario
        SET usuariooracle = NULL
        WHERE id = P_ID;

        -- Eliminar el usuario de Oracle
        BEGIN
            EXECUTE IMMEDIATE 'DROP USER LIFEFIT_' || P_ID || ' CASCADE';
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK TO SAVEPOINT EXCEPCION_ELIMINACION; -- Rollback en caso de error
                RAISE EXCEPTION_ELIMINACION; -- Relanzar la excepción
        
        -- Eliminamos el contenido del cliente de la BD
        DELETE FROM cliente
        WHERE id = P_ID;

        DELETE FROM cita
        WHERE cliente_id = P_ID;

        DELETE FROM entrena
        WHERE cliente_id = P_ID;

        DELETE FROM plan
        WHERE entrena_cliente_id = P_ID;

        DELETE FROM sesion
        WHERE plan_entrena_cliente_id = P_ID;
    
        -- Commit para confirmar los cambios
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Manejar cualquier excepción que pueda ocurrir durante el proceso de eliminación
            ROLLBACK TO SAVEPOINT EXCEPCION_ELIMINACION; -- Rollback en caso de error
            RAISE EXCEPTION_ELIMINIACION ; -- Relanzar la excepción
    END ELIMINA_CLIENTE;

    --Implementación del procedimiento de eliminación de gerente
    PROCEDURE ELIMINA_GERENTE(P_ID USUARIO.ID%TYPE) IS
        BEGIN
        SAVEPOINT EXCEPCION_ELIMINACION; -- Crear un punto de guardado para rollback
        -- Actualizar el atributo UsuarioOracle a NULL en la tabla USUARIO
        UPDATE usuario
        SET usuariooracle = NULL
        WHERE id = P_ID;

        -- Eliminar el usuario de Oracle
        BEGIN
            EXECUTE IMMEDIATE 'DROP USER LIFEFIT_' || P_ID || ' CASCADE';
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK TO SAVEPOINT EXCEPCION_ELIMINACION; -- Rollback en caso de error
                RAISE EXCEPTION_ELIMINACION; -- Relanzar la excepción
        
        -- Eliminamos el contenido del gerente de la BD
        DELETE FROM gerente
        WHERE id = P_ID;

        -- Commit para confirmar los cambios
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Manejar cualquier excepción que pueda ocurrir durante el proceso de eliminación
            ROLLBACK TO SAVEPOINT EXCEPCION_ELIMINACION; -- Rollback en caso de error
            RAISE EXCEPTION_ELIMINIACION ; -- Relanzar la excepción
    END ELIMINA_GERENTE;

    --Implementación del procedimiento de eliminación de entrenador
    PROCEDURE ELIMINA_ENTRENADOR(P_ID USUARIO.ID%TYPE) IS
        BEGIN
        SAVEPOINT EXCEPCION_ELIMINACION; -- Crear un punto de guardado para rollback
        -- Actualizar el atributo UsuarioOracle a NULL en la tabla USUARIO
        UPDATE usuario
        SET usuariooracle = NULL
        WHERE id = P_ID;

        -- Eliminar el usuario de Oracle
        BEGIN
            EXECUTE IMMEDIATE 'DROP USER LIFEFIT_' || P_ID || ' CASCADE';
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK TO SAVEPOINT EXCEPCION_ELIMINACION; -- Rollback en caso de error
                RAISE EXCEPTION_ELIMINACION; -- Relanzar la excepción
        
        -- Eliminamos el contenido del entrenador de la BD
        DELETE FROM entrenador
        WHERE id = P_ID;

        DELETE FROM elementocalen
        WHERE entrenador_id = P_ID;

        DELETE FROM entrena
        WHERE entrenador_id = P_ID;

        DELETE FROM plan
        WHERE entrena_entrenador_id = P_ID;

        DELETE FROM sesion
        WHERE plan_entrena_entrenador_id = P_ID;
    
        -- Commit para confirmar los cambios
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Manejar cualquier excepción que pueda ocurrir durante el proceso de eliminación
            ROLLBACK TO SAVEPOINT EXCEPCION_ELIMINACION; -- Rollback en caso de error
            RAISE EXCEPTION_ELIMINIACION ; -- Relanzar la excepción
    END ELIMINA_ENTRENADOR;

END BASE;
