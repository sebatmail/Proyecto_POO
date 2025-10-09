-- Reemplaza 'nombre_tu_base_de_datos' con el nombre real de tu base de datos
USE iei_172_n2;
---
-- 1. Inserción de Tipos de Habitación (equivalente a 'marcas' o 'modelos' de autos)
---
-- Se asume una tabla 'tipos_habitacion' con campos (id, nombre_tipo, capacidad_maxima, descripcion, precio_base)
INSERT INTO tipos_habitacion (nombre_tipo, capacidad_maxima, descripcion, precio_base) VALUES
('Sencilla', 2, 'Habitación con una cama matrimonial o dos individuales, baño privado.', 80.00),
('Doble', 4, 'Habitación espaciosa con dos camas matrimoniales, ideal para familias pequeñas.', 120.00),
('Ejecutiva', 2, 'Habitación con escritorio, acceso a internet de alta velocidad, cafetera premium.', 150.00),
('Suite Junior', 3, 'Habitación amplia con zona de estar separada y baño de lujo.', 220.00),
('Suite Presidencial', 5, 'Dos dormitorios, sala de estar, comedor, jacuzzi, balcón con vista panorámica.', 450.00),
('Familiar', 6, 'Habitación con capacidad para hasta 6 personas, con literas o camas adicionales.', 140.00),
('Estudio', 2, 'Habitación con cocina básica (kitchenette) y zona de estar.', 110.00);


---
-- 2. Inserción de Servicios Adicionales (equivalente a 'tipos_mecanico' o 'combustibles')
---
-- Se asume una tabla 'servicios' con campos (id, nombre_servicio, costo_adicional, descripcion)
INSERT INTO servicios (nombre_servicio, costo_adicional, descripcion) VALUES
('Desayuno Buffet', 15.00, 'Acceso ilimitado al desayuno estilo buffet del hotel.'),
('Spa y Masajes', 60.00, 'Sesión de masaje relajante de 60 minutos o acceso completo a las instalaciones del spa.'),
('Lavandería Rápida', 25.00, 'Servicio de lavado, secado y doblado con entrega en menos de 4 horas.'),
('Parking Valet', 10.00, 'Servicio de aparcamiento y recogida de vehículos por el personal del hotel.'),
('Late Check-out', 45.00, 'Permite permanecer en la habitación hasta las 17:00 horas (sujeto a disponibilidad).'),
('Traslado Aeropuerto', 30.00, 'Transporte privado desde o hacia el aeropuerto.'),
('Cama Adicional', 35.00, 'Inclusión de una cama plegable en la habitación.');


---
-- 3. Inserción de Habitaciones Específicas
---
-- Se asume una tabla 'habitaciones' con campos (id, numero_habitacion, piso, id_tipo_habitacion, vista)
-- NOTA: Asumo que tienes una forma de obtener el ID del tipo de habitación, ya sea por ID directo o subconsulta.
INSERT INTO habitaciones (numero_habitacion, piso, id_tipo_habitacion, vista) VALUES
(101, 1, (SELECT id FROM tipos_habitacion WHERE nombre_tipo = 'Sencilla'), 'Ciudad'),
(102, 1, (SELECT id FROM tipos_habitacion WHERE nombre_tipo = 'Doble'), 'Ciudad'),
(205, 2, (SELECT id FROM tipos_habitacion WHERE nombre_tipo = 'Ejecutiva'), 'Piscina'),
(310, 3, (SELECT id FROM tipos_habitacion WHERE nombre_tipo = 'Suite Junior'), 'Mar'),
(401, 4, (SELECT id FROM tipos_habitacion WHERE nombre_tipo = 'Suite Presidencial'), 'Panorámica'),
(215, 2, (SELECT id FROM tipos_habitacion WHERE nombre_tipo = 'Doble'), 'Piscina'),
(301, 3, (SELECT id FROM tipos_habitacion WHERE nombre_tipo = 'Estudio'), 'Mar'),
(115, 1, (SELECT id FROM tipos_habitacion WHERE nombre_tipo = 'Familiar'), 'Ciudad');


---
-- 4. Inserción de Empleados/Departamentos (equivalente a 'comunas' o 'modelos' si los categorizas)
---
-- Se asume una tabla 'departamentos' con campos (id, nombre_departamento, descripcion)
INSERT INTO departamentos (nombre_departamento, descripcion) VALUES
('Recepción', 'Gestión de check-in, check-out, reservas y atención al cliente 24/7.'),
('Limpieza y Mantenimiento', 'Encargados del aseo de habitaciones y áreas comunes, y reparaciones generales.'),
('Alimentos y Bebidas', 'Personal de cocina, meseros y bartenders de los restaurantes y bares.'),
('Administración', 'Gestión financiera, recursos humanos y dirección general del hotel.'),
('Ventas y Marketing', 'Promoción del hotel, gestión de eventos y paquetes vacacionales.');

-- Se asume una tabla 'empleados' con campos (id, nombre, apellido, cargo, id_departamento, fecha_contratacion)
INSERT INTO empleados (nombre, apellido, cargo, id_departamento, fecha_contratacion) VALUES
('Laura', 'Gómez', 'Recepcionista Senior', (SELECT id FROM departamentos WHERE nombre_departamento = 'Recepción'), '2022-01-15'),
('Carlos', 'Díaz', 'Jefe de Cocina', (SELECT id FROM departamentos WHERE nombre_departamento = 'Alimentos y Bebidas'), '2020-07-20'),
('Sofía', 'Ramírez', 'Camarera de Piso', (SELECT id FROM departamentos WHERE nombre_departamento = 'Limpieza y Mantenimiento'), '2023-03-10'),
('Roberto', 'Mena', 'Gerente General', (SELECT id FROM departamentos WHERE nombre_departamento = 'Administración'), '2019-11-01'),
('Ana', 'Pérez', 'Conserje', (SELECT id FROM departamentos WHERE nombre_departamento = 'Recepción'), '2024-05-01');


---
-- 5. Inserción de Huéspedes
---
-- Se asume una tabla 'huespedes' con campos (id, rut, nombre, apellido, email, telefono, nacionalidad)
INSERT INTO huespedes (rut, nombre, apellido, email, telefono, nacionalidad) VALUES
('18123456-7', 'Martín', 'Soto', 'm.soto@ejemplo.com', '+56987654321', 'Chilena'),
('25987654-3', 'Emily', 'Johnson', 'emily.j@mail.com', '+15551234567', 'Estadounidense'),
('A9012345-B', 'Pierre', 'Lefevre', 'p.lefevre@france.fr', '+33612345678', 'Francesa'),
('15678901-2', 'Valentina', 'Rojas', 'v.rojas@mail.cl', '+56998765432', 'Chilena');


---
-- 6. Inserción de Reservas (Ejemplo)
---
-- Se asume una tabla 'reservas' con campos (id, id_huesped, id_habitacion, fecha_llegada, fecha_salida, estado_reserva)
-- Se asume que los IDs de huésped y habitación se obtienen de las inserciones anteriores
INSERT INTO reservas (id_huesped, id_habitacion, fecha_llegada, fecha_salida, estado_reserva) VALUES
((SELECT id FROM huespedes WHERE rut = '18123456-7'), (SELECT id FROM habitaciones WHERE numero_habitacion = 205), '2025-12-10', '2025-12-15', 'Confirmada'),
((SELECT id FROM huespedes WHERE rut = '25987654-3'), (SELECT id FROM habitaciones WHERE numero_habitacion = 401), '2025-11-01', '2025-11-05', 'Confirmada'),
((SELECT id FROM huespedes WHERE rut = 'A9012345-B'), (SELECT id FROM habitaciones WHERE numero_habitacion = 101), '2025-10-25', '2025-10-28', 'Pendiente');