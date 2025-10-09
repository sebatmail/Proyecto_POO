USE iei_172_n2;

---
-- 1. GUEST (Huésped)
---
CREATE TABLE IF NOT EXISTS guest(
    guest_id INTEGER AUTO_INCREMENT,
    PASSPORT_ID VARCHAR(50) NOT NULL,
    ID_CARD VARCHAR(50)     NOT NULL,
    first_name VARCHAR(50) NOT NULL, -- Corregido: 'name_guest' a 'first_name'
    last_name VARCHAR(50) NOT NULL,  -- Corregido: 'surname' a 'last_name'
    email VARCHAR(100) NOT NULL UNIQUE, -- Aumentado a 100 y añadido UNIQUE
    phone VARCHAR (20) NOT NULL,

    CONSTRAINT pk_guest PRIMARY KEY (guest_id) -- Corregido: 'id' a 'guest_id'
);

---
-- 2. ROOM (Habitación)
---
CREATE TABLE IF NOT EXISTS room(
    room_id INTEGER AUTO_INCREMENT,
    room_number VARCHAR(10) NOT NULL UNIQUE, -- Ej: '101', '205A'
    room_type VARCHAR(50) NOT NULL,          -- Ej: 'Single', 'Double', 'Suite'
    price DECIMAL(10, 2) NOT NULL, -- Precio por noche (con dos decimales)
    is_available BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT pk_room PRIMARY KEY (room_id)
);
-- 3.- CREAR TABLA SERVICIOS 
---
-- 3. REQUESTED_SERVICES (Servicio Adicional)
---
CREATE TABLE IF NOT EXISTS requested_services(
    request_id INTEGER AUTO_INCREMENT,
    service_name VARCHAR(100) NOT NULL UNIQUE, -- Ej: 'Spa Access', 'Laundry Service'
    service_description VARCHAR(255),
    quantity DECIMAL(10, 2) NOT NULL,

    CONSTRAINT pk_service PRIMARY KEY (service_id)
);

---
-- 4. RESERVATION (Reserva)
-- Depende de GUEST y ROOM
---
CREATE TABLE IF NOT EXISTS reservation(
    reservation_id INTEGER AUTO_INCREMENT,
    guest_id INTEGER NOT NULL,          -- FK a la tabla guest
    room_id INTEGER NOT NULL,           -- FK a la tabla room
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    stay_nights DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    is_cancelled BOOLEAN NOT NULL DEFAULT FALSE,

    CONSTRAINT pk_reservation PRIMARY KEY (reservation_id),
    CONSTRAINT fk_reservation_guest FOREIGN KEY (guest_id) REFERENCES guest(guest_id),
    CONSTRAINT fk_reservation_room FOREIGN KEY (room_id) REFERENCES room(room_id),
    CONSTRAINT chk_dates CHECK (check_out_date > check_in_date) -- Regla: Salida después de la entrada
);

---
-- 5. STAY (Estadía)
-- Representa la ocupación actual de la reserva
---
CREATE TABLE IF NOT EXISTS stay(
    stay_id INTEGER AUTO_INCREMENT,
    reservation_id INTEGER NOT NULL UNIQUE, -- FK a la reserva
    check_in_actual DATETIME NOT NULL,
    check_out_actual DATETIME,              -- Puede ser NULL si la estadía está activa
    status VARCHAR(20) NOT NULL,            -- Ej: 'Checked-in', 'Checked-out'

    CONSTRAINT pk_stay PRIMARY KEY (stay_id),
    CONSTRAINT fk_stay_reservation FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id)
);

---
-- 6. INVOICE (Factura)
-- Depende de STAY y se usa para registrar el pago
---
CREATE TABLE IF NOT EXISTS invoice(
    invoice_id INTEGER AUTO_INCREMENT,
    stay_id INTEGER NOT NULL,           -- FK a la estadía
    invoice_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50),
    is_paid BOOLEAN NOT NULL DEFAULT FALSE,

    CONSTRAINT pk_invoice PRIMARY KEY (invoice_id),
    CONSTRAINT fk_invoice_stay FOREIGN KEY (stay_id) REFERENCES stay(stay_id)
);

---
-- Tabla de relación N:M entre Estadia y Servicios Adicionales
---
CREATE TABLE IF NOT EXISTS stay_service(
    stay_service_id INTEGER AUTO_INCREMENT,
    stay_id INTEGER NOT NULL,
    service_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    service_date DATE NOT NULL,
    
    CONSTRAINT pk_stay_service PRIMARY KEY (stay_service_id),
    CONSTRAINT fk_ss_stay FOREIGN KEY (stay_id) REFERENCES stay(stay_id),
    CONSTRAINT fk_ss_service FOREIGN KEY (service_id) REFERENCES additional_service(service_id),
    CONSTRAINT uk_stay_service UNIQUE (stay_id, service_id, service_date) -- Evita duplicados en un mismo día
);