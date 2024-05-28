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
        v_countcorreo INTEGER; -- Variable para comprobar el correo electrónico
        v_counttelefono INTEGER; -- Variable para comprobar el teléfono
    BEGIN

        -- Mirar si el correo ya existe, si existe, lanzar excepción
        SELECT COUNT(*) INTO v_countcorreo FROM USUARIO WHERE correoe = P_DATOS.CORREOE;
        IF v_countcorreo > 0 THEN
            RAISE EXCEPCION_CREACION;
        END IF;

        -- Mirar si el correo ya existe, si existe, lanzar excepción
        SELECT COUNT(*) INTO v_counttelefono FROM USUARIO WHERE telefono = P_DATOS.TELEFONO;
        IF v_counttelefono > 0 THEN
            RAISE EXCEPCION_CREACION;
        END IF;

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
                ROLLBACK; -- Rollback si hay errores

                -- Si falla la creación del usuario, manejar el error
                DBMS_OUTPUT.PUT_LINE('Error al crear el cliente');
        END;

        -- Asignar el rol de cliente al usuario
        EXECUTE IMMEDIATE 'GRANT cliente TO ' || v_usuariooracle;

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
        WHEN EXCEPCION_CREACION THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_CREACION: correoe o telefono ya existen');
        
        WHEN OTHERS THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;
            
            -- Eliminar el usuario creado si la excepción ocurre después de la creación
            EXECUTE IMMEDIATE 'DROP USER ' || v_usuariooracle || ' CASCADE';
            DBMS_OUTPUT.PUT_LINE('OTHERS: Error al crear el cliente');

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
        v_countcorreo INTEGER; -- Variable para comprobar el correo electrónico
        v_counttelefono INTEGER; -- Variable para comprobar el teléfono

    BEGIN

        -- Mirar si el correo ya existe, si existe, lanzar excepción
        SELECT COUNT(*) INTO v_countcorreo FROM USUARIO WHERE correoe = P_DATOS.CORREOE;
        IF v_countcorreo > 0 THEN
            RAISE EXCEPCION_CREACION;
        END IF;

        -- Mirar si el correo ya existe, si existe, lanzar excepción
        SELECT COUNT(*) INTO v_counttelefono FROM USUARIO WHERE telefono = P_DATOS.TELEFONO;
        IF v_counttelefono > 0 THEN
            RAISE EXCEPCION_CREACION;
        END IF;

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
                ROLLBACK; -- Rollback si hay errores

                -- Si falla la creación del usuario, manejar el error
                DBMS_OUTPUT.PUT_LINE('Error al crear el entrenador');
        END;

        -- Asignar el rol de entrenador al usuario
        EXECUTE IMMEDIATE 'GRANT entrenador_nutricion TO ' || v_usuariooracle;
        EXECUTE IMMEDIATE 'GRANT entrenador_deporte TO ' || v_usuariooracle;

        -- Insertar usuario
        INSERT INTO usuario (id, nombre, apellidos, telefono, direccion, correoe, usuariooracle)
        VALUES (v_usuario_id, P_DATOS.NOMBRE, P_DATOS.APELLIDOS, P_DATOS.TELEFONO, P_DATOS.DIRECCION, P_DATOS.CORREOE, v_usuariooracle);

        -- Insertar entrenador
        INSERT INTO entrenador (id, disponibilidad, centro_id)
        VALUES (v_entrenador_id, P_DATOS.DISPONIBILIDAD, P_DATOS.CENTRO);
        DBMS_OUTPUT.PUT_LINE('Gerente insertado correctamente');


        -- Commit de la transacción autónoma para confirmar cambios
        COMMIT;

        -- Recuperar los datos de usuario y entrenador
        SELECT * INTO P_USUARIO FROM usuario WHERE id = v_usuario_id;
        SELECT * INTO P_ENTRENADOR FROM entrenador WHERE id = v_entrenador_id;

    EXCEPTION
        WHEN EXCEPCION_CREACION THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_CREACION: Correoe o telefono ya existen');
        
        WHEN OTHERS THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;
            
            -- Eliminar el usuario creado si la excepción ocurre después de la creación
            EXECUTE IMMEDIATE 'DROP USER ' || v_usuariooracle || ' CASCADE';
            DBMS_OUTPUT.PUT_LINE('OTHERS: Error al crear el entrenador');

    END CREA_ENTRENADOR;


    --Implementación del procedimiento CREAR_GERENTE
    PROCEDURE CREA_GERENTE(
        P_DATOS IN TGERENTE,
        P_USERPASS IN VARCHAR2,
        P_USUARIO OUT USUARIO%ROWTYPE,
        P_GERENTE OUT GERENTE%ROWTYPE
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        v_usuario_id USUARIO.ID%TYPE;
        v_gerente_id GERENTE.ID%TYPE;
        v_usuariooracle USUARIO.USUARIOORACLE%TYPE; -- Variable para el nombre de usuario Oracle
        v_countcorreo INTEGER; -- Variable para comprobar el correo electrónico
        v_counttelefono INTEGER; -- Variable para comprobar el teléfono

    BEGIN

        -- Mirar si el correo ya existe, si existe, lanzar excepción
        SELECT COUNT(*) INTO v_countcorreo FROM USUARIO WHERE correoe = P_DATOS.CORREOE;
        IF v_countcorreo > 0 THEN
            RAISE EXCEPCION_CREACION;
        END IF;

        -- Mirar si el correo ya existe, si existe, lanzar excepción
        SELECT COUNT(*) INTO v_counttelefono FROM USUARIO WHERE telefono = P_DATOS.TELEFONO;
        IF v_counttelefono > 0 THEN
            RAISE EXCEPCION_CREACION;
        END IF;

        -- Obtener el próximo valor de la secuencia para el ID del usuario y gerente
        SELECT usuario_seq.NEXTVAL INTO v_usuario_id FROM dual;
        v_gerente_id := v_usuario_id; -- El ID del gerente es igual al ID del usuario

        -- Crear el nombre de usuario Oracle
        v_usuariooracle := 'LIFEFIT_' || v_usuario_id;

        -- Crear el usuario
        BEGIN
            EXECUTE IMMEDIATE 'CREATE USER ' || v_usuariooracle || ' IDENTIFIED BY ' || P_USERPASS || ' DEFAULT TABLESPACE TS_LIFEFIT QUOTA UNLIMITED ON TS_LIFEFIT';
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK; -- Rollback si hay errores

                -- Si falla la creación del usuario, manejar el error
                DBMS_OUTPUT.PUT_LINE('Error al crear el gerente');
        END;

        -- Asignar el rol de gerente al usuario
        EXECUTE IMMEDIATE 'GRANT gerente TO ' || v_usuariooracle;

        -- Insertar usuario
        INSERT INTO usuario (id, nombre, apellidos, telefono, direccion, correoe, usuariooracle)
        VALUES (v_usuario_id, P_DATOS.NOMBRE, P_DATOS.APELLIDOS, P_DATOS.TELEFONO, P_DATOS.DIRECCION, P_DATOS.CORREOE, v_usuariooracle);

        -- Insertar gerente
        INSERT INTO gerente (id, despacho, horario, centro_id)
        VALUES (v_gerente_id, P_DATOS.DESPACHO, P_DATOS.HORARIO, P_DATOS.CENTRO);

        -- Commit de la transacción autónoma para confirmar cambios
        COMMIT;

        -- Recuperar los datos de usuario y gerente
        SELECT * INTO P_USUARIO FROM usuario WHERE id = v_usuario_id;
        SELECT * INTO P_GERENTE FROM gerente WHERE id = v_gerente_id;

    EXCEPTION
        WHEN EXCEPCION_CREACION THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_CREACION: Correoe o telefono ya existen');
        
        WHEN OTHERS THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;
            
            -- Eliminar el usuario creado si la excepción ocurre después de la creación
            EXECUTE IMMEDIATE 'DROP USER ' || v_usuariooracle || ' CASCADE';
            DBMS_OUTPUT.PUT_LINE('OTHERS: Error al crear el gerente');

    END CREA_GERENTE;

    --Implementación del procedimiento de eliminación de usuario
    

END BASE;
/
