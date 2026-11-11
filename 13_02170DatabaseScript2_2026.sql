
#SELECT PatientID, Name, MedicineName FROM Patients NATURAL JOIN Prescriptions GROUP BY PatientID;
	

#SELECT DepartmentName, COUNT(DoctorID) FROM Departments NATURAL LEFT OUTER JOIN Doctors GROUP BY DepartmentName;


#SELECT PatientID, Name FROM Patients WHERE PatientID NOT IN(SELECT PatientID FROM prescriptions) GROUP BY PatientID;
-- USE OF THE MAIN DATABASE (REMEBER TO RUN DATABASE FILE FIRST BEFOE RUNNING THIS FILE --
USE HOSPITAL;
-- DROP METHODS --
DROP FUNCTION IF EXISTS PatientCountForNurse;
DROP PROCEDURE IF EXISTS AddPatient;
DROP TRIGGER IF EXISTS CheckPrescriptionAmount; 
DELETE FROM Patients WHERE PatientID = '5768127387';
DELETE FROM prescriptions WHERE MedicineID = '12345';
DROP USER IF EXISTS 'Nurses'@'localhost';
DROP USER IF EXISTS 'Reception'@'localhost';

-- Your queries below
SELECT * FROM Patients;    
DELIMITER //
CREATE FUNCTION PatientCountForNurse(vNurseName VARCHAR(20)) RETURNS INT
BEGIN
    DECLARE vPatientCount INT;
    SELECT COUNT(p.PatientID)
	INTO vPatientCount
	FROM Nurses n
	LEFT JOIN Patients p ON p.NurseID = n.NurseID
	WHERE n.Name = vNurseName;

    RETURN vPatientCount;
END //
DELIMITER ;


SELECT Name AS NurseName,
       PatientCountForNurse(Name) AS Patients
FROM Nurses
ORDER BY Patients DESC;

DELIMITER //
CREATE PROCEDURE AddPatient
	(IN vPatientID VARCHAR(10), IN vRoomNR DECIMAL(3,0), IN vDoctorID VARCHAR(7), IN vNurseID VARCHAR(6), IN vName VARCHAR(20))
BEGIN
	INSERT Patients(PatientID, RoomNR, DoctorID, NurseID, Name)
		VALUES(vPatientID, vRoomNR, vDoctorID, vNurseID, vName);
END //
DELIMITER ;

CALL AddPatient('5768127387', '220', '1459673', '726154', 'Winson Churchull');
SELECT * FROM Patients;


DELIMITER //
CREATE TRIGGER CheckPrescriptionAmount
BEFORE INSERT ON Prescriptions 
FOR EACH ROW
BEGIN
	IF NEW.Amount <= 0 THEN
		SET New.Amount = 1;
	END IF;
END //
DELIMITER ;


INSERT INTO Prescriptions VALUES ('9105738246', '12345', 'Cyclophosphamide', '0');

SELECT * FROM Prescriptions;

UPDATE Patients SET Name = 'Winston Churchill' 
	WHERE PatientID = '5768127387';
    
SELECT * FROM Patients;

DELETE FROM Patients WHERE PatientID = '5768127387';

SELECT * FROM Patients;


CREATE USER 'Nurses'@'localhost'
	IDENTIFIED BY '1234';
    
CREATE USER 'Reception'@'localhost'
	IDENTIFIED BY '4321';
    
GRANT UPDATE (Amount) ON Hospital.Prescriptions TO 'Nurses'@'localhost';

GRANT SELECT ON Hospital.* TO 'Reception'@'localhost';

CREATE VIEW ReceptionPatients AS
SELECT PatientID, Name, RoomNR, DoctorID
FROM Patients;

GRANT SELECT ON HOSPITAL.ReceptionPatients TO 'Reception'@'localhost';

CREATE VIEW NursePatientDetails AS
SELECT Patients.PatientID,
       Patients.Name,
       Patients.RoomNR,
       Nurses.Name AS NurseName,
       Prescriptions.MedicineName,
       Prescriptions.Amount
FROM Patients
JOIN Nurses ON Nurses.NurseID = Patients.NurseID
LEFT JOIN Prescriptions
    ON Prescriptions.PatientID = Patients.PatientID;

GRANT SELECT ON HOSPITAL.NursePatientDetails TO 'Nurses'@'localhost';