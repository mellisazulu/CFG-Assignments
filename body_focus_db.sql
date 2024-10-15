CREATE DATABASE body_focus;

USE body_focus;

CREATE TABLE services (
service_id INTEGER AUTO_INCREMENT PRIMARY KEY,
service_name VARCHAR(100),
duration INTEGER,
price DECIMAL(10, 2)
);

CREATE TABLE employees (
employee_id INTEGER AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
position VARCHAR(100)
);

INSERT INTO services 
(service_name, duration, price)
VALUES
('Group Mat Pilates', 60, 75.00),
('Reformer Pilates', 45, 95.00),
('Hot Yoga', 35, 50.00),
('Yoga', 50, 65.00);

INSERT INTO employees
(first_name, last_name, position)
Values
('Alice', 'Smith', 'Instructor'),
('Carol', 'Williams', 'Trainee'),
('Frank', 'Miller', 'Lead Instructor');

SELECT * FROM body_focus.employees;

