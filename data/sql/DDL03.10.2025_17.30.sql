USE iei_172_n2;

-- 1. GUEST (Huésped)
CREATE TABLE IF NOT EXISTS guest(
    guest_id INTEGER AUTO_INCREMENT,
    PASSPORT_ID VARCHAR(50), 
    ID_CARD VARCHAR(50), 
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR (20) NOT NULL,
    nationalidad VARCHAR(50),
    
    CONSTRAINT pk_guest PRIMARY KEY (guest_id)
);

-- 2. ROOM_TYPE (Tipo de Habitación)
CREATE TABLE IF NOT EXISTS room_type (
    room_type_id INTEGER AUTO_INCREMENT,
    type_name VARCHAR(50) NOT NULL UNIQUE,
    max_capacity INTEGER NOT NULL,
    base_price DECIMAL(10, 2) NOT NULL,
    description VARCHAR(255),
    
    CONSTRAINT pk_room_type PRIMARY KEY (room_type_id)
);

-- 3. ROOM (Habitación Específica)
CREATE TABLE IF NOT EXISTS room(
    room_id INTEGER AUTO_INCREMENT,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    floor INTEGER NOT NULL,
    room_type_id INTEGER NOT NULL,
    view_type VARCHAR(50),
    
    CONSTRAINT pk_room PRIMARY KEY (room_id),
    CONSTRAINT fk_room_type FOREIGN KEY (room_type_id) REFERENCES room_type(room_type_id)
);


-- 4. ADDITIONAL_SERVICE (Servicio Adicional)
CREATE TABLE IF NOT EXISTS additional_service(
    service_id INTEGER AUTO_INCREMENT,
    service_name VARCHAR(100) NOT NULL UNIQUE,
    service_description VARCHAR(255),
    service_cost DECIMAL(10, 2) NOT NULL,
    
    CONSTRAINT pk_service PRIMARY KEY (service_id)
);

-- 5. RESERVATION (Reserva)
CREATE TABLE IF NOT EXISTS reservation(
    reservation_id INTEGER AUTO_INCREMENT,
    guest_id INTEGER NOT NULL, 
    room_id INTEGER NOT NULL, 
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    
    CONSTRAINT pk_reservation PRIMARY KEY (reservation_id),
    CONSTRAINT fk_reservation_guest FOREIGN KEY (guest_id) REFERENCES guest(guest_id),
    CONSTRAINT fk_reservation_room FOREIGN KEY (room_id) REFERENCES room(room_id),
    CONSTRAINT chk_dates CHECK (check_out_date > check_in_date)
);

-- 6. STAY (Estadía - Ocupación efectiva)
CREATE TABLE IF NOT EXISTS stay(
    stay_id INTEGER AUTO_INCREMENT,
    reservation_id INTEGER NOT NULL UNIQUE,
    check_in_actual DATETIME NOT NULL,
    check_out_actual DATETIME,
    status VARCHAR(20) NOT NULL,
    
    CONSTRAINT pk_stay PRIMARY KEY (stay_id),
    CONSTRAINT fk_stay_reservation FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id)
);

-- 7. STAY_SERVICE (Relación N:M entre Estadia y Servicios Adicionales)
CREATE TABLE IF NOT EXISTS stay_service(
    stay_service_id INTEGER AUTO_INCREMENT,
    stay_id INTEGER NOT NULL,
    service_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    service_date DATE NOT NULL,
    
    CONSTRAINT pk_stay_service PRIMARY KEY (stay_service_id),
    CONSTRAINT fk_ss_stay FOREIGN KEY (stay_id) REFERENCES stay(stay_id),
    CONSTRAINT fk_ss_service FOREIGN KEY (service_id) REFERENCES additional_service(service_id),
    CONSTRAINT uk_stay_service UNIQUE (stay_id, service_id, service_date)
);

-- 8. INVOICE (Factura)
CREATE TABLE IF NOT EXISTS invoice(
    invoice_id INTEGER AUTO_INCREMENT,
    stay_id INTEGER NOT NULL,
    invoice_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50),
    is_paid BOOLEAN NOT NULL DEFAULT FALSE,
    
    CONSTRAINT pk_invoice PRIMARY KEY (invoice_id),
    CONSTRAINT fk_invoice_stay FOREIGN KEY (stay_id) REFERENCES stay(stay_id)
);

-- 9. DEPARTMENTS (Departamento)
CREATE TABLE IF NOT EXISTS departments(
    department_id INTEGER AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255),
    
    CONSTRAINT pk_department PRIMARY KEY (department_id)
);

-- 10. EMPLOYEES (Empleados)
CREATE TABLE IF NOT EXISTS employees(
    employee_id INTEGER AUTO_INCREMENT,
    department_id INTEGER NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position_title VARCHAR(100),
    hire_date DATE NOT NULL,
    
    CONSTRAINT pk_employee PRIMARY KEY (employee_id),
    CONSTRAINT fk_employee_department FOREIGN KEY (department_id) REFERENCES departments(department_id)
);