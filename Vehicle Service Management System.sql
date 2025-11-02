CREATE DATABASE VehicleServiceDB;
USE VehicleServiceDB;


-- Customer Table
CREATE TABLE Customer (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  phone VARCHAR(15) NOT NULL UNIQUE,
  email VARCHAR(100),
  address VARCHAR(255)
);

-- Vehicle Table
CREATE TABLE Vehicle (
  vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  registration_no VARCHAR(20) NOT NULL UNIQUE,
  make VARCHAR(50),
  model VARCHAR(50),
  year INT CHECK (year >= 1990 AND year <= 2100),
  km_reading INT DEFAULT 0,
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Mechanic Table
CREATE TABLE Mechanic (
  mechanic_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  phone VARCHAR(15) UNIQUE,
  specialization VARCHAR(50)
);

-- Service Table
CREATE TABLE Service (
  service_id INT AUTO_INCREMENT PRIMARY KEY,
  vehicle_id INT NOT NULL,
  mechanic_id INT,
  service_date DATE NOT NULL,
  status VARCHAR(20) DEFAULT 'Pending', -- Pending / Completed
  remarks VARCHAR(255),
  FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id),
  FOREIGN KEY (mechanic_id) REFERENCES Mechanic(mechanic_id)
);

-- ServiceItem Table
CREATE TABLE ServiceItem (
  item_id INT AUTO_INCREMENT PRIMARY KEY,
  service_id INT NOT NULL,
  description VARCHAR(100) NOT NULL,
  quantity INT DEFAULT 1 CHECK (quantity > 0),
  unit_cost DECIMAL(10,2) CHECK (unit_cost >= 0),
  FOREIGN KEY (service_id) REFERENCES Service(service_id)
);

-- Invoice Table
CREATE TABLE Invoice (
  invoice_id INT AUTO_INCREMENT PRIMARY KEY,
  service_id INT NOT NULL UNIQUE,
  invoice_date DATE NOT NULL,
  total_amount DECIMAL(10,2) CHECK (total_amount >= 0),
  paid_status VARCHAR(10) DEFAULT 'No',
  FOREIGN KEY (service_id) REFERENCES Service(service_id)
);


-- Customers
INSERT INTO Customer (full_name, phone, email, address) VALUES
('Ravi Sharma', '9876543210', 'ravi@gmail.com', 'Sector 10, Chandigarh'),
('Anita Verma', '9123456780', 'anita@gmail.com', 'Panchkula'),
('Suresh Kumar', '9988776655', NULL, 'Phase 7, Mohali');

-- Vehicles
INSERT INTO Vehicle (customer_id, registration_no, make, model, year, km_reading) VALUES
(1, 'CH01AB1234', 'Maruti', 'Swift', 2018, 45000),
(2, 'PB10CD5678', 'Honda', 'City', 2019, 30000),
(3, 'HR26EF9876', 'Toyota', 'Innova', 2016, 80000);

-- Mechanics
INSERT INTO Mechanic (name, phone, specialization) VALUES
('Sunil Kumar', '9000011111', 'Engine'),
('Meera Singh', '9000022222', 'Electrical'),
('Amit Raj', '9000033333', 'AC Specialist');

-- Services
INSERT INTO Service (vehicle_id, mechanic_id, service_date, status, remarks) VALUES
(1, 1, '2025-10-01', 'Completed', 'Full service done'),
(2, 2, '2025-10-05', 'Pending', 'AC repair scheduled'),
(3, 3, '2025-10-10', 'Completed', 'AC overhaul completed');

-- Service Items
INSERT INTO ServiceItem (service_id, description, quantity, unit_cost) VALUES
(1, 'Engine Oil Change', 1, 1200),
(1, 'General Checkup', 1, 500),
(2, 'AC Gas Top-up', 1, 1500),
(3, 'Compressor Repair', 1, 5000),
(3, 'AC Cleaning', 1, 800);

-- Invoices
INSERT INTO Invoice (service_id, invoice_date, total_amount, paid_status) VALUES
(1, '2025-10-02', 1700, 'Yes'),
(3, '2025-10-11', 5800, 'No');



-- View: Show all service history
CREATE OR REPLACE VIEW ServiceHistory AS
SELECT s.service_id, c.full_name AS customer, v.registration_no, 
       s.service_date, s.status, s.remarks
FROM Service s
JOIN Vehicle v ON s.vehicle_id = v.vehicle_id
JOIN Customer c ON v.customer_id = c.customer_id;

-- 1️⃣ Show all customers and their vehicles
SELECT c.full_name, v.registration_no, v.make, v.model
FROM Customer c
JOIN Vehicle v ON c.customer_id = v.customer_id;

-- 2️⃣ Show completed services with total invoice amount
SELECT s.service_id, c.full_name, v.registration_no, i.total_amount, i.paid_status
FROM Service s
JOIN Vehicle v ON s.vehicle_id = v.vehicle_id
JOIN Customer c ON v.customer_id = c.customer_id
JOIN Invoice i ON s.service_id = i.service_id
WHERE s.status = 'Completed';

-- 3️⃣ Total income per mechanic
SELECT m.name AS mechanic_name, SUM(i.total_amount) AS total_earned
FROM Mechanic m
JOIN Service s ON m.mechanic_id = s.mechanic_id
JOIN Invoice i ON s.service_id = i.service_id
GROUP BY m.name;

-- 4️⃣ Pending payments (HAVING example)
SELECT c.full_name, v.registration_no, SUM(i.total_amount) AS pending_amount
FROM Customer c
JOIN Vehicle v ON c.customer_id = v.customer_id
JOIN Service s ON v.vehicle_id = s.vehicle_id
JOIN Invoice i ON s.service_id = i.service_id
WHERE i.paid_status = 'No'
GROUP BY c.full_name, v.registration_no
HAVING pending_amount > 0;

-- 5️⃣ View full service history
SELECT * FROM ServiceHistory;

