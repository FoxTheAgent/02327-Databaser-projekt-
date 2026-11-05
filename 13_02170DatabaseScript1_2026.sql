-- CREATE / DROP DATABASE --
DROP DATABASE IF EXISTS HOSPITAL;
CREATE DATABASE HOSPITAL;

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
Salary DECIMAL(6,2),
PRIMARY KEY (NurseID)
);

CREATE TABLE Rooms 
(
RoomNR DECIMAL(3,0),
Building ENUM('1', '2', '3', '4' ), 
PRIMARY KEY (RoomNR, Building)
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
FOREIGN KEY(DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE,
FOREIGN KEY(DoctorID) REFERENCES Doctors(DoctorID) ON UPDATE CASCADE,
FOREIGN KEY(RoomNR, Building) REFERENCES Rooms(RoomNR, Building) ON DELETE CASCADE
);


CREATE TABLE Doctors
(
DoctorID VARCHAR(7),
DepartmentName VARCHAR(20),
Salary DECIMAL(7,2),
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
FOREIGN KEY(DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE,
FOREIGN KEY(NurseID) REFERENCES Nurses(NurseID) ON DELETE CASCADE,
FOREIGN KEY(Rooms) REFERENCES RoomNR(RoomNR) ON DELETE CASCADE

);

CREATE TABLE Departments
(
DepartmentName VARCHAR(20),
Building ENUM('1', '2', '3', '4'), 
Budget DECIMAL(10,2),
PRIMARY KEY(DepartmentName)
);

-- TABLES CONTENTS (SECTION_5) --

-- INSERT ______ VALUES (Value1, Value2.... ValueN); u can input more rows at the same time by just replacing ; with , --

INSERT Nurses VALUES
(),
(),
(),
(),
(),
(),
();

INSERT Rooms VALUES
(),
(),
(),
(),
(),
(),
(),
(),
(),
();

INSERT Prescriptions VALUES
(),
(),
(),
();


INSERT Surgeries VALUES 
(),
(),
(),
();

INSERT Doctors VALUES
(),
(),
(),
(),
(),
();

INSERT Patients VALUES
(),
(),
(),
(),
(),
(),
(),
(),
(),
();

INSERT Departments VALUES 
(),
(),
(),
();
