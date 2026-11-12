-- CREATE / DROP DATABASE --
DROP DATABASE IF EXISTS HOSPITAL;
CREATE DATABASE HOSPITAL;
USE HOSPITAL;

-- DROP METHODS --
DROP TABLE IF EXISTS Doctors; 
DROP TABLE IF EXISTS Nurses;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Surgeries;
DROP TABLE IF EXISTS Patients; 
DROP TABLE IF EXISTS Departments; 
-- TABLES (SECTION_4) -- 
CREATE TABLE Nurses
(
NurseID   VARCHAR(6),
Name  VARCHAR(20) NOT NULL,
Salary DECIMAL(8,2),
PRIMARY KEY (NurseID)
);

CREATE TABLE Departments
(
DepartmentName VARCHAR(30),
Building ENUM('1', '2', '3', '4'), 
Budget DECIMAL(11,2),
PRIMARY KEY(DepartmentName)
);

CREATE TABLE Rooms 
(
RoomNR DECIMAL(3,0),
Building ENUM('1', '2', '3', '4' ), 
PRIMARY KEY (RoomNR, Building)
);


CREATE TABLE Doctors
(
DoctorID VARCHAR(7),
DepartmentName VARCHAR(30),
Salary DECIMAL(9,2),
Name VARCHAR(20) NOT NULL,
PRIMARY KEY(DOCTORID),
FOREIGN KEY(DepartmentName) REFERENCES Departments(DepartmentName) ON DELETE CASCADE

); 

CREATE TABLE Patients
(
PatientID VARCHAR(10),
RoomNR DECIMAL(3,0),
DoctorID VARCHAR(7),
NurseID   VARCHAR(6),
Name VARCHAR(20) NOT NULL,
PRIMARY KEY(PatientID),
FOREIGN KEY(DoctorID) REFERENCES Doctors(DoctorID),
FOREIGN KEY(NurseID) REFERENCES Nurses(NurseID),
FOREIGN KEY(RoomNR) REFERENCES Rooms(RoomNR)

);

CREATE TABLE Prescriptions 
(
PatientID VARCHAR(10),
MedicineID VARCHAR(5),
MedicineName VARCHAR(20),
Amount DECIMAL(5,0),
PRIMARY KEY (PatientID, MedicineID),
FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE
);

CREATE TABLE Surgeries 
(
PatientID VARCHAR(10),
Date  DATE,
Time TIME,
DoctorID VARCHAR(7),
RoomNR DECIMAL(3,0),
Building ENUM('1', '2', '3', '4'), 
PRIMARY KEY(PatientID, Date, Time, DoctorID),
FOREIGN KEY(PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE,
FOREIGN KEY(DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(RoomNR, Building) REFERENCES Rooms(RoomNR, Building) ON DELETE CASCADE
);



-- TABLES CONTENTS (SECTION_5) --

INSERT Departments (DepartmentName, Building, Budget)VALUES 
('Kirurgisk Afdeling', '2', '200000000.00'),
('Kardiologisk Afdeling', '1', '100000000.00'),
('Ortopædkirurgisk Afdeling', '3', '150000000.00'),
('Akutmodtagelsen', '4', '100000000.00');

INSERT Nurses (NurseID, Name, Salary) VALUES
('483921', 'Mikkel Sorensen', 31000.00),
('726154', 'Anika Kowalska', 28530.00),
('195837', 'Tobias Lindberg', 38100.00),
('842609', 'Freja Nowak', 35250.00),
('361472', 'Emil Petrov', 33670.00),
('957213', 'Nadia Eriksson', 30521.00),
('614085', 'Viktor Hansen', 36560.00);

INSERT Rooms (RoomNR, Building) VALUES
(110,1),
(120,1),
(230,2),
(210,2),
(220,2),
(240,2),
(310,3),
(320,3),
(410,4),
(420,4);

INSERT Doctors (DoctorID, DepartmentName, Salary, Name) VALUES
('5837291', 'Kirurgisk Afdeling', '650000.00', 'Valdemar Ravn'),
('9046172', 'Kardiologisk Afdeling', '720000.00', 'Maria Jensen'),
('2765814', 'Ortopædkirurgisk Afdeling', '1050000.00', 'Lucas Schneider'),
('7382059', 'Kirurgisk Afdeling', '810000.00', 'Matteo Moretti'),
('1459673', 'Akutmodtagelsen', '950000.00', 'Ahmed Al-Hassan'),
('8214037', 'Akutmodtagelsen', '780000.00', 'Frej Anker');

INSERT Patients (PatientID, RoomNR, DoctorID, NurseID, Name) VALUES
('5847291630', '110', '2765814', '483921', 'Mads Jensen'),
('9105738246', '230', '5837291', '726154', 'Emma Nielsen'),
('2674819053', '210', '5837291', '726154', 'Sofie Hansen'),
('7359201846', '120', '2765814', '483921', 'Magnus Møller'),
('1486372950', '420', '9046172', '195837', 'William Andersen'),
('8264057193', '220', '2765814', '842609', 'Freja Pedersen'),
('3917582640', '410', '8214037', '614085', 'Lucas Christensen'),
('6702194385', '320', '1459673', '361472', 'Laura Larsen'),
('9541863207', '240', '2765814', '957213', 'Oliver Sørensen'),
('2038746159', '310', '7382059', '195837', 'Clara Rasmussen	');

INSERT Prescriptions (PatientID, MedicineID, MedicineName, Amount) VALUES
('2038746159', '58321', 'Paracetamol', 3),
('6702194385', '91746', 'Amoxicillin', 7),
('1486372950', '26483', 'Metformin', 2),
('2674819053', '67690', 'Ibuprofen', 3);


INSERT Surgeries (PatientID, Date, Time, DoctorID, RoomNR, Building) VALUES
('9105738246', '2026-02-18', '16:30:00', '5837291', 230, 2),
('2674819053', '2026-04-12', '12:20:00', '5837291', 210, 2),
('8264057193', '2026-03-12', '23:59:59', '2765814', 220, 2),
('9541863207', '2026-09-12', '00:01:00', '2765814', 240, 2);







