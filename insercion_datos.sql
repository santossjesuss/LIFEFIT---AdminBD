--Llenamos tabla dietas
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (1, 'Mediterránea', 'Alta en frutas, verduras, cereales integrales y aceite de oliva.', 'Equilibrada');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (2, 'Keto', 'Alta en grasas y muy baja en carbohidratos.', 'Baja en Carbohidratos');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (3, 'Vegetariana', 'Sin carne ni pescado, incluye productos lácteos y huevos.', 'Equilibrada');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (4, 'Vegana', 'Sin productos de origen animal, solo alimentos vegetales.', 'Equilibrada');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (5, 'Paleolítica', 'Basada en alimentos que se consumían en el período paleolítico.', 'Alta en Proteínas');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (6, 'DASH', 'Diseñada para reducir la hipertensión, alta en frutas, verduras y lácteos bajos en grasa.', 'Equilibrada');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (7, 'Baja en Carbohidratos', 'Reduce significativamente la ingesta de carbohidratos.', 'Baja en Carbohidratos');
INSERT INTO DIETA (ID, NOMBRE, DESCRIPCION, TIPO) VALUES (8, 'Alta en Proteínas', 'Aumenta la ingesta de proteínas para la construcción muscular.', 'Alta en Proteínas');

--Llenamos tabla elementocalen
INSERT INTO ELEMENTOCALEN (fechayhora, entrenador_id) VALUES (TO_DATE('2024-06-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 53);
INSERT INTO ELEMENTOCALEN (fechayhora, entrenador_id) VALUES (TO_DATE('2024-06-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 53);
INSERT INTO ELEMENTOCALEN (fechayhora, entrenador_id) VALUES (TO_DATE('2024-07-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 32);

--Llenamos tabla citas
INSERT INTO CITA (fechayhora, id, modalidad, cliente_id, estado_cita) VALUES (TO_DATE('2024-06-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 53, 'Presencial', 31, 'P');
INSERT INTO CITA (fechayhora, id, modalidad, cliente_id, estado_cita) VALUES (TO_DATE('2024-06-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 53, 'Presencial', 52, 'P');

--Llenamos tabla rutina
INSERT INTO RUTINA (id, nombre, descripcion) VALUES (1, 'pepe', 'rutina de pepe');
INSERT INTO RUTINA (id, nombre, descripcion) VALUES (2, 'juan', 'rutina de juan');
INSERT INTO RUTINA (id, nombre, descripcion) VALUES (3, 'luis', 'rutina de luis');

--Llenamos tabla entrena
INSERT INTO ENTRENA (especialidad, entrenador_id, cliente_id) VALUES ('ENTRENAMIENTO', 53, 31);
INSERT INTO ENTRENA (especialidad, entrenador_id, cliente_id) VALUES ('ENTRENAMIENTO', 53, 52);

--Llenamos tabla plan
INSERT INTO PLAN (inicio, fin, rutina_id, entrena_entrenador_id, entrena_cliente_id) 
VALUES (TO_DATE('2024-06-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), null, 1, 53, 31);
INSERT INTO PLAN (inicio, fin, rutina_id, entrena_entrenador_id, entrena_cliente_id)
VALUES (TO_DATE('2024-06-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), null, 1, 53, 52);

--Llenamos tabla sesion
INSERT INTO SESION (inicio, fin, presencial, descripcion, video, datos_salud, plan_inicio, plan_rutina_id, plan_entrena_entrenador_id, plan_entrena_cliente_id)
VALUES (TO_DATE('2024-06-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-19 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Sí', 'Calentamiento', 'https://www.youtube.com/watch?v=123456', 'Saludable',TO_DATE('2024-06-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS') , 1, 53, 31);
INSERT INTO SESION (inicio, fin, presencial, descripcion, video, datos_salud, plan_inicio, plan_rutina_id, plan_entrena_entrenador_id, plan_entrena_cliente_id)
VALUES (TO_DATE('2024-06-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-30 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'No', 'Calentamiento', 'https://www.youtube.com/watch?v=123456', 'Saludable',TO_DATE('2024-06-30 10:00:00', 'YYYY-MM-DD HH24:MI:SS') , 1, 53, 52);

