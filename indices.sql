-- Entendemos que los atributo por los que más vamos a buscar usuarios son: correo electrónico, teléfono y, nombre y apellidos.
-- Creamos indices para estas columnas de Usuario:
CREATE UNIQUE INDEX idx_usuario_correo ON usuario(correoe) TABLESPACE TS_INDICES;
CREATE UNIQUE INDEX idx_usuario_telefono ON usuario(telefono) TABLESPACE TS_INDICES;
-- creo que es case insensitive
CREATE INDEX idx_usuario_nombre_apellidos ON usuario(UPPER(nombre), UPPER(apellidos)) TABLESPACE TS_INDICES;
-- Creamos indice de tipo BITMAP en centro_id
CREATE BITMAP INDEX idx_cliente_centro_id ON cliente(centro_id) TABLESPACE TS_INDICES;
