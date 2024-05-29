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
            EXECUTE IMMEDIATE 'CREATE USER ' || v_usuariooracle || ' IDENTIFIED BY ' || P_USERPASS || ' DEFAULT TABLESPACE TS_LIFEFIT QUOTA UNLIMITED ON TS_LIFEFIT PROFILE cliente';
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_CREACION;
        END;

        -- Asignar el rol de cliente al usuario
        EXECUTE IMMEDIATE 'GRANT cliente TO ' || v_usuariooracle;

        BEGIN
            -- Insertar usuario
            INSERT INTO usuario (id, nombre, apellidos, telefono, direccion, correoe, usuariooracle)
            VALUES (v_usuario_id, P_DATOS.NOMBRE, P_DATOS.APELLIDOS, P_DATOS.TELEFONO, P_DATOS.DIRECCION, P_DATOS.CORREOE, v_usuariooracle);
            
            -- Insertar cliente
            INSERT INTO cliente (id, objetivo, preferencias, dieta_id, centro_id)
            VALUES (v_cliente_id, P_DATOS.OBJETIVOS, P_DATOS.PREFERENCIAS, P_DATOS.DIETA, P_DATOS.CENTRO);
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_MODIFICACION;
                SYS.DBMS_OUTPUT.PUT_LINE(SQLERRM);
        END;

        -- Recuperar los datos de usuario y cliente
        BEGIN
            SELECT * INTO P_USUARIO FROM usuario WHERE id = v_usuario_id;
            SELECT * INTO P_CLIENTE FROM cliente WHERE id = v_cliente_id;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_LECTURA;
        END;

        -- Commit de la transacción autónoma para confirmar cambios
        COMMIT;

    EXCEPTION
        WHEN EXCEPCION_CREACION THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_CREACION');


        WHEN EXCEPCION_MODIFICACION THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;
            
            -- Eliminar el usuario creado si la excepción ocurre después de la creación
            EXECUTE IMMEDIATE 'DROP USER ' || v_usuariooracle || ' CASCADE';
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_MODIFICACION: Error al modificar tablas');

        WHEN EXCEPCION_LECTURA THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;

            -- Eliminar el usuario creado si la excepción ocurre después de la creación
            EXECUTE IMMEDIATE 'DROP USER ' || v_usuariooracle || ' CASCADE';
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_LECTURA: Error al leer');

        WHEN OTHERS THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('OTHERS: Error inesperado');

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
            EXECUTE IMMEDIATE 'CREATE USER ' || v_usuariooracle || ' IDENTIFIED BY ' || P_USERPASS || ' DEFAULT TABLESPACE TS_LIFEFIT QUOTA UNLIMITED ON TS_LIFEFIT PROFILE entrenador';
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_CREACION;
        END;

        -- Asignar el rol de entrenador al usuario
        EXECUTE IMMEDIATE 'GRANT entrenador_nutricion TO ' || v_usuariooracle;
        EXECUTE IMMEDIATE 'GRANT entrenador_deporte TO ' || v_usuariooracle;

        BEGIN
            -- Insertar usuario
            INSERT INTO usuario (id, nombre, apellidos, telefono, direccion, correoe, usuariooracle)
            VALUES (v_usuario_id, P_DATOS.NOMBRE, P_DATOS.APELLIDOS, P_DATOS.TELEFONO, P_DATOS.DIRECCION, P_DATOS.CORREOE, v_usuariooracle);

            -- Insertar entrenador
            INSERT INTO entrenador (id, disponibilidad, centro_id)
            VALUES (v_entrenador_id, P_DATOS.DISPONIBILIDAD, P_DATOS.CENTRO);

        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_MODIFICACION;
        END;

        BEGIN
            -- Recuperar los datos de usuario y entrenador
            SELECT * INTO P_USUARIO FROM usuario WHERE id = v_usuario_id;
            SELECT * INTO P_ENTRENADOR FROM entrenador WHERE id = v_entrenador_id;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_LECTURA;
        END;

        -- Commit de la transacción autónoma para confirmar cambios
        COMMIT;


    EXCEPTION
        WHEN EXCEPCION_CREACION THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_CREACION');


        WHEN EXCEPCION_MODIFICACION THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;
            
            -- Eliminar el usuario creado si la excepción ocurre después de la creación
            EXECUTE IMMEDIATE 'DROP USER ' || v_usuariooracle || ' CASCADE';
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_MODIFICACION: Error al modificar tablas');

        WHEN EXCEPCION_LECTURA THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;

            -- Eliminar el usuario creado si la excepción ocurre después de la creación
            EXECUTE IMMEDIATE 'DROP USER ' || v_usuariooracle || ' CASCADE';
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_LECTURA: Error al leer');

        WHEN OTHERS THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('OTHERS: Error inesperado');

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
            EXECUTE IMMEDIATE 'CREATE USER ' || v_usuariooracle || ' IDENTIFIED BY ' || P_USERPASS || ' DEFAULT TABLESPACE TS_LIFEFIT QUOTA UNLIMITED ON TS_LIFEFIT PROFILE gerente';
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_CREACION;
        END;

        -- Asignar el rol de gerente al usuario
        EXECUTE IMMEDIATE 'GRANT gerente TO ' || v_usuariooracle;

        BEGIN
            -- Insertar usuario
            INSERT INTO usuario (id, nombre, apellidos, telefono, direccion, correoe, usuariooracle)
            VALUES (v_usuario_id, P_DATOS.NOMBRE, P_DATOS.APELLIDOS, P_DATOS.TELEFONO, P_DATOS.DIRECCION, P_DATOS.CORREOE, v_usuariooracle);

            -- Insertar gerente
            INSERT INTO gerente (id, despacho, horario, centro_id)
            VALUES (v_gerente_id, P_DATOS.DESPACHO, P_DATOS.HORARIO, P_DATOS.CENTRO);
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_MODIFICACION;
        END;

        BEGIN
            -- Recuperar los datos de usuario y gerente
            SELECT * INTO P_USUARIO FROM usuario WHERE id = v_usuario_id;
            SELECT * INTO P_GERENTE FROM gerente WHERE id = v_gerente_id;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_LECTURA;
        END;

        -- Commit de la transacción autónoma para confirmar cambios
        COMMIT;


    EXCEPTION
        WHEN EXCEPCION_CREACION THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_CREACION');


        WHEN EXCEPCION_MODIFICACION THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;
            
            -- Eliminar el usuario creado si la excepción ocurre después de la creación
            EXECUTE IMMEDIATE 'DROP USER ' || v_usuariooracle || ' CASCADE';
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_MODIFICACION: Error al modificar tablas');

        WHEN EXCEPCION_LECTURA THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;

            -- Eliminar el usuario creado si la excepción ocurre después de la creación
            EXECUTE IMMEDIATE 'DROP USER ' || v_usuariooracle || ' CASCADE';
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_LECTURA: Error al leer');

        WHEN OTHERS THEN
            -- Si se produce una excepción, realizar rollback
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('OTHERS: Error inesperado');

    END CREA_GERENTE;

    --Implementación del procedimiento de eliminación de usuario
    PROCEDURE ELIMINA_USER(P_ID USUARIO.ID%TYPE) IS
        v_usuariooracle USUARIO.USUARIOORACLE%TYPE;
    BEGIN
        BEGIN
            -- Obtener el nombre de usuario Oracle
            SELECT usuariooracle INTO v_usuariooracle FROM usuario WHERE id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_LECTURA;
        END;

        -- Eliminar el usuario
        BEGIN
            EXECUTE IMMEDIATE 'DROP USER ' || v_usuariooracle || ' CASCADE';
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;

        BEGIN
            -- Poner a null el usuariooracle en la tabla usuario
            UPDATE usuario SET usuariooracle = NULL WHERE id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_MODIFICACION;
        END;

        COMMIT;

    EXCEPTION
        WHEN EXCEPCION_ELIMINACION THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_ELIMINACION: Error al eliminar el usuario');

        WHEN EXCEPCION_MODIFICACION THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_MODIFICACION: Error al modificar tabla usuario');

        WHEN EXCEPCION_LECTURA THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_LECTURA: Error al leer tabla usuario');

    END ELIMINA_USER;

    -- Implementación del procedimiento de elimina cliente
    PROCEDURE ELIMINA_CLIENTE(P_ID USUARIO.ID%TYPE) IS
        v_usuariooracle USUARIO.USUARIOORACLE%TYPE;
    BEGIN
        BEGIN
            -- Obtener el nombre de usuario Oracle
            SELECT usuariooracle INTO v_usuariooracle FROM usuario WHERE id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_LECTURA;
        END;

        -- Eliminar el usuario
        BEGIN
            EXECUTE IMMEDIATE 'DROP USER ' || v_usuariooracle || ' CASCADE';
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;

        BEGIN
            -- Poner a null el usuariooracle en la tabla usuario
            UPDATE usuario SET usuariooracle = NULL WHERE id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_MODIFICACION;
        END;

        BEGIN
            -- Eliminar las citas
            DELETE FROM cita WHERE cliente_id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;

        BEGIN
            -- Eliminar el sesion
            DELETE FROM sesion WHERE plan_entrena_cliente_id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;

        BEGIN
            -- Eliminar el plan 
            DELETE FROM plan WHERE entrena_cliente_id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;

        BEGIN
            -- Eliminar el entrena
            DELETE FROM entrena WHERE cliente_id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;

        BEGIN
            -- Eliminar el cliente
            DELETE FROM cliente WHERE id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;

        COMMIT;

    EXCEPTION
        WHEN EXCEPCION_ELIMINACION THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_ELIMINACION: Error al eliminar el usuario');

        WHEN EXCEPCION_MODIFICACION THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_MODIFICACION: Error al modificar tabla usuario');

        WHEN EXCEPCION_LECTURA THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_LECTURA: Error al leer tabla usuario');

    END ELIMINA_CLIENTE;


    -- Implementación del procedimiento de elimina gerente
    PROCEDURE ELIMINA_GERENTE(P_ID USUARIO.ID%TYPE) IS
        v_usuariooracle USUARIO.USUARIOORACLE%TYPE;
    BEGIN
        BEGIN
            -- Obtener el nombre de usuario Oracle
            SELECT usuariooracle INTO v_usuariooracle FROM usuario WHERE id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_LECTURA;
        END;

        -- Eliminar el usuario
        BEGIN
            EXECUTE IMMEDIATE 'DROP USER ' || v_usuariooracle || ' CASCADE';
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;

        BEGIN
            -- Poner a null el usuariooracle en la tabla usuario
            UPDATE usuario SET usuariooracle = NULL WHERE id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_MODIFICACION;
        END;

        BEGIN
            -- Eliminar el gerente
            DELETE FROM gerente WHERE id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;

        COMMIT;

    EXCEPTION
        WHEN EXCEPCION_ELIMINACION THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_ELIMINACION: Error al eliminar el usuario');

        WHEN EXCEPCION_MODIFICACION THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_MODIFICACION: Error al modificar tabla usuario');

        WHEN EXCEPCION_LECTURA THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_LECTURA: Error al leer tabla usuario');

    END ELIMINA_GERENTE;


    -- Implementación del procedimiento de elimina entrenador
    PROCEDURE ELIMINA_ENTRENADOR(P_ID USUARIO.ID%TYPE) IS
        v_usuariooracle USUARIO.USUARIOORACLE%TYPE;
    BEGIN
        BEGIN
            -- Obtener el nombre de usuario Oracle
            SELECT usuariooracle INTO v_usuariooracle FROM usuario WHERE id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_LECTURA;
        END;


        BEGIN
            -- Poner a null el usuariooracle en la tabla usuario
            UPDATE usuario SET usuariooracle = NULL WHERE id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_MODIFICACION;
        END;

        BEGIN
            -- Eliminar las citas
            DELETE FROM cita WHERE id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;
        
        BEGIN
            -- Eliminar los elementos calendario
            DELETE FROM elementocalen WHERE entrenador_id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;


        BEGIN
            -- Eliminar las sesion
            DELETE FROM sesion WHERE plan_entrena_entrenador_id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;

        BEGIN
            -- Eliminar los planes
            DELETE FROM plan WHERE entrena_entrenador_id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;

        BEGIN
            -- Eliminar los entrena
            DELETE FROM entrena WHERE entrenador_id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;

        BEGIN
            -- Eliminar el entrenador
            DELETE FROM entrenador WHERE id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;

        -- Eliminar el usuario
        BEGIN
            EXECUTE IMMEDIATE 'DROP USER ' || v_usuariooracle || ' CASCADE';
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;
        
        COMMIT;

    EXCEPTION
        WHEN EXCEPCION_ELIMINACION THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_ELIMINACION: Error al eliminar el usuario');

        WHEN EXCEPCION_MODIFICACION THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_MODIFICACION: Error al modificar tabla usuario');

        WHEN EXCEPCION_LECTURA THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_LECTURA: Error al leer tabla usuario');

    END ELIMINA_ENTRENADOR;

    
    --Eliminar centro usando elimina_gerente, elimina_cliente y elimina_entrenador, estos dos ultimos con un bucle donde
    --se recorren todos los clientes y entrenadores con centro_id = P_ID, hasta que ya no haya mas
    PROCEDURE ELIMINA_CENTRO(P_ID CENTRO.ID%TYPE) IS
        --Creamos array de clientes y entrenadores
        TYPE nested_table_of_integers IS TABLE OF INTEGER;
        v_clientes_ids nested_table_of_integers := nested_table_of_integers();
        v_entrenadores_ids nested_table_of_integers := nested_table_of_integers();

        --Cursor para recorrer los clientes
        CURSOR c_clientes IS
            SELECT id FROM cliente WHERE centro_id = P_ID;

        --Cursor para recorrer los entrenadores
        CURSOR c_entrenadores IS
            SELECT id FROM entrenador WHERE centro_id = P_ID;
        
        v_gerente_id USUARIO.ID%TYPE;
    BEGIN
        -- Añadir ids de clientes al array
        FOR c IN c_clientes LOOP
            v_clientes_ids.EXTEND;
            SYS.DBMS_OUTPUT.PUT_LINE('Añadiendo Cliente ID: ' || c.id);
            v_clientes_ids(v_clientes_ids.LAST) := c.id;
        END LOOP;

        -- Añadir ids de entrenadores al array
        FOR c IN c_entrenadores LOOP
            v_entrenadores_ids.EXTEND;
            SYS.DBMS_OUTPUT.PUT_LINE('Añadiendo Entrenador ID: ' || c.id);
            v_entrenadores_ids(v_entrenadores_ids.LAST) := c.id;
        END LOOP;

        -- Eliminar los clientes
        FOR i IN 1..v_clientes_ids.COUNT LOOP
            BEGIN
                SYS.DBMS_OUTPUT.PUT_LINE('Eliminando Cliente ID: ' || v_clientes_ids(i));
                BASE.ELIMINA_CLIENTE(v_clientes_ids(i));
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE EXCEPCION_ELIMINACION;
            END;
        END LOOP;

        -- Eliminar los entrenadores
        FOR i IN 1..v_entrenadores_ids.COUNT LOOP
            BEGIN
                SYS.DBMS_OUTPUT.PUT_LINE('Eliminando Entrenador ID: ' || v_entrenadores_ids(i));
                BASE.ELIMINA_ENTRENADOR(v_entrenadores_ids(i));
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE EXCEPCION_ELIMINACION;
            END;
        END LOOP;
        
        -- Obtener el ID del usuario del gerente del centro
        BEGIN
            SELECT id INTO v_gerente_id FROM centro WHERE id = P_ID;
            SYS.DBMS_OUTPUT.PUT_LINE('Gerente ID: ' || v_gerente_id);
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_LECTURA;
        END;

        -- Eliminar el gerente
        BEGIN
            BASE.ELIMINA_GERENTE(v_gerente_id);
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;

        -- Eliminar el centro
        BEGIN
            DELETE FROM centro WHERE id = P_ID;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPCION_ELIMINACION;
        END;

        COMMIT; 

    EXCEPTION
        WHEN EXCEPCION_ELIMINACION THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_ELIMINACION: Error al eliminar el usuario');

        WHEN EXCEPCION_MODIFICACION THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_MODIFICACION: Error al modificar tabla usuario');

        WHEN EXCEPCION_LECTURA THEN
            DBMS_OUTPUT.PUT_LINE('EXCEPCION_LECTURA: Error al leer tabla usuario');

    END ELIMINA_CENTRO;

END BASE;
/
