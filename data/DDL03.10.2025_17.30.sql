USE iei_172_n2;

CREATE TABLE IF NOT EXISTS guest(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    id_guest CHAR(5) NOT NULL,
    name_guest VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL, 
    email   VARCHAR(50) NOT NULL,
    phone   VARCHAR (20) NOT NULL,
);

