--Consulta para ver la columna cifrada
SELECT table_name, column_name, encryption_alg 
FROM user_encrypted_columns 
WHERE table_name = 'USUARIO';

--VPD
--Creamos la función que se encargará de filtrar los datos segun el usuario que se conecte

CREATE OR REPLACE FUNCTION vpd_tablaGerente (schema IN VARCHAR2, tabla IN VARCHAR2)
RETURN VARCHAR2
IS
  v_condicion VARCHAR2(4000);
BEGIN
    v_condicion := 'id = (SELECT id FROM usuario WHERE usuariooracle = USER)';
    RETURN v_condicion;
END vpd_tablaGerente;
/

--Creamos la politica de seguridad
BEGIN
  DBMS_RLS.ADD_POLICY(
    object_schema => 'LIFEFIT',
    object_name => 'GERENTE',
    policy_name => 'POLITICA_GERENTE',
    function_schema => 'LIFEFIT',
    policy_function => 'vpd_tablaGerente',
    statement_types => 'SELECT',
    update_check => TRUE,
    enable => TRUE
  );
END;
/



