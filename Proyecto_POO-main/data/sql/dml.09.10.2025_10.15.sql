USE iei_172_n2;

-- ---------------------------------------
-- 1. LIMPIEZA DE DATOS EXISTENTES (TRUNCATE)
-- ---------------------------------------

-- Deshabilitar comprobación de claves foráneas para truncar tablas con dependencias
SET FOREIGN_KEY_CHECKS = 0;

-- Borrar datos de las tablas dependientes primero  (opcional)
TRUNCATE TABLE invoice;
TRUNCATE TABLE stay_service;
TRUNCATE TABLE stay;
TRUNCATE TABLE reservation;

-- Borrar datos de las tablas principales (opcional)
TRUNCATE TABLE guest;
TRUNCATE TABLE room;
TRUNCATE TABLE room_type;
TRUNCATE TABLE additional_service;
TRUNCATE TABLE employees;
TRUNCATE TABLE departments;

-- Habilitar comprobación de claves foráneas
SET FOREIGN_KEY_CHECKS = 1;


-- ---------------------------------------
-- 2. INSERCIÓN DE DATOS NUEVOS (DML)
-- ---------------------------------------

-- 2.1. Inserción de Tipos de Habitación (ROOM_TYPE)
INSERT INTO room_type (type_name, max_capacity, description, base_price) VALUES
('Sencilla', 2, 'Habitación con una cama matrimonial o dos individuales, baño privado.', 80.00),
('Doble', 4, 'Habitación espaciosa con dos camas matrimoniales, ideal para familias pequeñas.', 120.00),
('Ejecutiva', 2, 'Habitación con escritorio, acceso a internet de alta velocidad, cafetera premium.', 150.00),
('Suite Junior', 3, 'Habitación amplia con zona de estar separada y baño de lujo.', 220.00),
('Suite Presidencial', 5, 'Dos dormitorios, sala de estar, comedor, jacuzzi, balcón con vista panorámica.', 450.00),
('Familiar', 6, 'Habitación con capacidad para hasta 6 personas, con literas o camas adicionales.', 140.00),
('Estudio', 2, 'Habitación con cocina básica (kitchenette) y zona de estar.', 110.00);

-- 2.2. Inserción de Habitaciones Específicas (ROOM)
INSERT INTO room (room_number, floor, room_type_id, view_type) VALUES
('101', 1, (SELECT room_type_id FROM room_type WHERE type_name = 'Sencilla'), 'Ciudad'),
('102', 1, (SELECT room_type_id FROM room_type WHERE type_name = 'Doble'), 'Ciudad'),
('205', 2, (SELECT room_type_id FROM room_type WHERE type_name = 'Ejecutiva'), 'Piscina'),
('310', 3, (SELECT room_type_id FROM room_type WHERE type_name = 'Suite Junior'), 'Mar'),
('401', 4, (SELECT room_type_id FROM room_type WHERE type_name = 'Suite Presidencial'), 'Panorámica'),
('215', 2, (SELECT room_type_id FROM room_type WHERE type_name = 'Doble'), 'Piscina'),
('301', 3, (SELECT room_type_id FROM room_type WHERE type_name = 'Estudio'), 'Mar'),
('115', 1, (SELECT room_type_id FROM room_type WHERE type_name = 'Familiar'), 'Ciudad');

-- 2.3. Inserción de Servicios Adicionales (ADDITIONAL_SERVICE)
INSERT INTO additional_service (service_name, service_description, service_cost) VALUES
('Desayuno Buffet', 'Acceso ilimitado al desayuno estilo buffet del hotel.', 15.00),
('Spa y Masajes', 'Sesión de masaje relajante de 60 minutos o acceso completo a las instalaciones del spa.', 60.00),
('Lavandería Rápida', 'Servicio de lavado, secado y doblado con entrega en menos de 4 horas.', 25.00),
('Parking Valet', 'Servicio de aparcamiento y recogida de vehículos por el personal del hotel.', 10.00),
('Late Check-out', 'Permite permanecer en la habitación hasta las 17:00 horas.', 45.00),
('Traslado Aeropuerto', 'Transporte privado desde o hacia el aeropuerto.', 30.00),
('Cama Adicional', 'Inclusión de una cama plegable en la habitación.', 35.00);

-- 2.4. Inserción de Departamentos (DEPARTMENTS)
INSERT INTO departments (department_name, description) VALUES
('Recepción', 'Gestión de check-in, check-out, reservas y atención al cliente 24/7.'),
('Limpieza y Mantenimiento', 'Encargados del aseo de habitaciones y áreas comunes, y reparaciones generales.'),
('Alimentos y Bebidas', 'Personal de cocina, meseros y bartenders de los restaurantes y bares.'),
('Administración', 'Gestión financiera, recursos humanos y dirección general del hotel.'),
('Ventas y Marketing', 'Promoción del hotel, gestión de eventos y paquetes vacacionales.');

-- 2.5. Inserción de Empleados (EMPLOYEES)
INSERT INTO employees (first_name, last_name, position_title, department_id, hire_date) VALUES
('Laura', 'Gómez', 'Recepcionista Senior', (SELECT department_id FROM departments WHERE department_name = 'Recepción'), '2022-01-15'),
('Carlos', 'Díaz', 'Jefe de Cocina', (SELECT department_id FROM departments WHERE department_name = 'Alimentos y Bebidas'), '2020-07-20'),
('Sofía', 'Ramírez', 'Camarera de Piso', (SELECT department_id FROM departments WHERE department_name = 'Limpieza y Mantenimiento'), '2023-03-10'),
('Roberto', 'Mena', 'Gerente General', (SELECT department_id FROM departments WHERE department_name = 'Administración'), '2019-11-01'),
('Ana', 'Pérez', 'Conserje', (SELECT department_id FROM departments WHERE department_name = 'Recepción'), '2024-05-01');

-- 2.6. Inserción de Huéspedes (GUEST)
INSERT INTO guest (ID_CARD, first_name, last_name, email, phone, nationalidad) VALUES
('18123456-7', 'Martín', 'Soto', 'm.soto@ejemplo.com', '+56987654321', 'Chilena'),
('25987654-3', 'Emily', 'Johnson', 'emily.j@mail.com', '+15551234567', 'Estadounidense'),
('A9012345-B', 'Pierre', 'Lefevre', 'p.lefevre@france.fr', '+33612345678', 'Francesa'),
('15678901-2', 'Valentina', 'Rojas', 'v.rojas@mail.cl', '+56998765432', 'Chilena');

-- 2.7. Inserción de Reservas (RESERVATION)
INSERT INTO reservation (guest_id, room_id, check_in_date, check_out_date, total_price, status) VALUES
((SELECT guest_id FROM guest WHERE ID_CARD = '18123456-7'), (SELECT room_id FROM room WHERE room_number = '205'), '2025-12-10', '2025-12-15', 750.00, 'Confirmada'),
((SELECT guest_id FROM guest WHERE ID_CARD = '25987654-3'), (SELECT room_id FROM room WHERE room_number = '401'), '2025-11-01', '2025-11-05', 1800.00, 'Confirmada'),
((SELECT guest_id FROM guest WHERE ID_CARD = 'A9012345-B'), (SELECT room_id FROM room WHERE room_number = '101'), '2025-10-25', '2025-10-28', 240.00, 'Pendiente');

-- 2.8. INSERCIÓN DE STAY (Estadía)
-- Se asume que las dos primeras reservas confirmadas tienen ID 1 y 2
INSERT INTO stay (reservation_id, check_in_actual, status) VALUES
(1, '2025-12-10 14:30:00', 'Checked-in'),
(2, '2025-11-01 15:00:00', 'Checked-in');

-- 2.9. INSERCIÓN DE STAY_SERVICE (Servicios adicionales solicitados)
-- Se asignan servicios a la primera estadía (stay_id = 1, Martín Soto)
INSERT INTO stay_service (stay_id, service_id, quantity, service_date) VALUES
(1, (SELECT service_id FROM additional_service WHERE service_name = 'Desayuno Buffet'), 2, '2025-12-11'),
(1, (SELECT service_id FROM additional_service WHERE service_name = 'Parking Valet'), 5, '2025-12-10');

-- 2.10. INSERCIÓN DE INVOICE (Factura)
-- Se genera una factura para la segunda estadía (stay_id = 2, Emily Johnson)
INSERT INTO invoice (stay_id, invoice_date, total_amount, payment_method, is_paid) VALUES
(2, '2025-11-05', 1800.00, 'Tarjeta de Crédito', TRUE);