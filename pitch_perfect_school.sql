-- Creating a database for a music school, which will keep track of all the registered students, schedule, registration and the teachers/classes.
CREATE DATABASE pitch_perfect_school;

USE pitch_perfect_school;

-- Creating tables in the pitch perfect school database and normalising the DB by splitting the data out in tables where appropriate.

CREATE TABLE students (
student_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(25) NOT NULL,
last_name VARCHAR(25) NOT NULL,
email_address VARCHAR(25),
enrollment_date DATE
);

CREATE TABLE teachers (
teacher_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(25) NOT NULL,
last_name VARCHAR(25) NOT NULL,
email_address VARCHAR(25),
specialisation VARCHAR(50) NOT NULL
); 

CREATE TABLE classes (
class_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
class_name VARCHAR(25) NOT NULL,
teacher_id INTEGER,
schedule VARCHAR(25) NOT NULL,
room INTEGER NOT NULL
);

-- Adding a foreign key constraint on the classes table.

ALTER TABLE classes
ADD CONSTRAINT fk_teacher_id
FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id);

-- Adding data into tables.

INSERT INTO students
(first_name, last_name, email_address, enrollment_date)
VALUES
("Becca",	"Miller", "becca.miller@pitch.com", "2001-07-20"),
("Mark", "Flanders", "mark.flanders@pitch.com", "2001-07-12"),
("Billy", "Smith", "billy.smith@pitch.com", "2002-08-15"),
("Mary", "Hill", "mary.hill@pitch.com", "2001-08-10"),
("Elly", "Gregor", "elly.gregor@pitch.com", "2001-08-05"),
("Simon", "Cow", "simon.cow@pitch.com", "2001-07-06"),
("Adele", "May", "adele.may@pitch.com", "2002-08-20"),
("Jay", "Z", "jay.z@pitch.com", "2001-07-03"),
("Kelly", "Rolly", "kelly.rolly@pitch.com", "2002-08-01"),
("Lady", "Gaga", "lady.gaga@pitch.com", "2001-07-04"); 

INSERT INTO teachers
(first_name, last_name, email_address, specialisation)
VALUES
("Kendrick", "Lemar", "kendrick.lemar@pitch.com", "Rap"),
("Bon", "Jovi", "bon.jovi@pitch.com", "Rock"),
("Elton", "John", "elton.john@pitch.com", "Pop"),
("Drake", "Graham", "drake.graham@pitch.com", "Gospel"),
("Kanye", "West", "kanye.west@pitch.com", "Country"),
("Zayn", "Malik", "zayn.malik@pitch.com", "Hiphop"),
("Cleo", "Sol", "cleo.sol@pitch.com", "Jazz"),
("Little", "Simz", "little.simz@pitch.com", "Electronic");

INSERT INTO classes
(class_name, teacher_id,schedule, room)
VALUES
("Hip to the Hop", "2", "Monday 09:00", "201"),
("Rock your socks off", "1", "Monday 12:00", "212"),
("Glorious Gospel", "4","Tuesday 09:00", "590"),
("Smooth Jazz", "5", "Tuesday 10:00", "300"),
("Pop your socks off", "3", "Tuesday 15:00", "312"),
("Rap Battle", "7","Thursday 09:00", "212"),
("Our Country", "8","Thursday 12:00", "590"),
("Shocking Electronic", "6", "Friday 11:00", "201");

-- Adding another table to the database to track registration and payment information.

CREATE TABLE registration (
registration_id INTEGER PRIMARY KEY AUTO_INCREMENT,
student_id INTEGER,
class_id INTEGER,
enrollment_date DATE,
status VARCHAR(25),
payment_amount FLOAT(4),
payment_status VARCHAR(25)
);

-- Adding foreign key constraints to link the registration table to the student and class tables.

ALTER TABLE registration
ADD CONSTRAINT fk_student_id
FOREIGN KEY (student_id) REFERENCES students(student_id);

ALTER TABLE registration
ADD CONSTRAINT fk_class_id
FOREIGN KEY (class_id) REFERENCES classes(class_id);

-- Demonstrating how to delete a column within an exsisting table.

ALTER TABLE registration
DROP COLUMN enrollment_date;

ALTER TABLE registration
DROP COLUMN status;

-- Adding data to registration table.

INSERT INTO registration
(student_id, class_id, payment_amount, payment_status)
VALUES
("2", "5", "52.50", "Pending"),
("4", "8", "80.00", "Pending"),
("6", "6", "45.80", "Pending"),
("8", "4", "67.50", "Pending"),
("10", "1", "99.30", "Approved"),
("3", "2", "30.80", "Approved"),
("5", "3", "25.25", "Pending"),
("7", "7", "98.50", "Approved"),
("9", "7", "42.00", "Pending"),
("1", "8", "12.50", "Approved");

-- Retrieving data using 5 different queries, e.g viewing a list of student emails, viewing students payment statuses 

SELECT email_address
FROM students;

SELECT DISTINCT first_name, last_name, specialisation
FROM teachers
ORDER BY last_name ASC;

SELECT student_id, payment_amount, payment_status
FROM registration
WHERE payment_status = 'Approved';

SELECT student_id, payment_amount, payment_status
FROM registration
WHERE payment_status = 'Pending'
AND payment_amount > 20
ORDER BY payment_amount DESC;

SELECT class_name, schedule
FROM classes
WHERE class_name
LIKE 'R%';

-- Use at least 2 aggregate functions, finding the maximum payment amount and the count of pending payments
SELECT MAX(r.payment_amount)
FROM registration r;

SELECT COUNT(r.payment_status)
FROM registration r
WHERE r.payment_status = 'Pending';

-- Use at least 2 joins, firstly joining the students and the registration tables to show the email address of the students and the class they have registered to
SELECT s.first_name, s.last_name, s.email_address, r.class_id
FROM students s 
INNER JOIN registration r
ON s.student_id = r.student_id;

-- 2nd join, showing the student last name and their registation along with payment amount
SELECT r.registration_id, s.last_name, r.payment_amount
FROM registration r
INNER JOIN students s 
ON r.student_id = s.student_id;

-- Use at least 2 additional in-built functions (to the two aggregate functions already counted in previous point), 
-- eg upper to make all of the teachers specification bold or local time to show current date and time
SELECT UPPER(specialisation)
FROM teachers;

SELECT LOCALTIME();

-- Use data sorting for majority of queries with ORDER BY, see other data retrieving queries for ORDER BY demonstration
SELECT s.student_id, s.last_name, s.first_name
FROM students s
ORDER BY s.last_name;

-- Creating and using one stored procedure to achieve a goal - to select a distinct student details 
DELIMITER //

CREATE PROCEDURE SelectAllStudent 
(first_name VARCHAR(25), last_name VARCHAR(25))
BEGIN
SELECT DISTINCT (first_name, last_name)
FROM students;
END //

DELIMITER ;

CALL SelectAllStudent (first_name = 'Becca' , @last_name = 'Miller');

DELIMITER //

-- Scenario of use: some who workd within registration team wanted a view of students, registration details but not classes info or teachers info
CREATE VIEW registration_team
AS
    SELECT s.student_id, s.first_name, s.last_name, r.payment_status,r.payment_amount
    FROM students s
    INNER JOIN registration r
    ON s.student_id = r.student_id;

SELECT * FROM registration_team;







