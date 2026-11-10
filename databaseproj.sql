-- Use your existing database
USE `Database_project`;

-- -------------------------
-- Table Department
-- -------------------------
DROP TABLE IF EXISTS `Department`;
CREATE TABLE `Department` (
  `DepartmentID` INT NOT NULL,
  `DepartmentName` VARCHAR(50) NULL,
  `PhoneNumber` VARCHAR(15) NULL,
  `address` VARCHAR(100) NULL,
  PRIMARY KEY (`DepartmentID`)
) ENGINE=InnoDB;

-- -------------------------
-- Table Staff
-- -------------------------
DROP TABLE IF EXISTS `Staff`;
CREATE TABLE `Staff` (
  `StaffID` INT NOT NULL,
  `FirstName` VARCHAR(30) NULL,
  `LastName` VARCHAR(30) NULL,
  `JobTitle` VARCHAR(30) NULL,
  `HireDate` DATE NULL,
  `Phone` VARCHAR(15) NULL,
  `Department_DepartmentID` INT NOT NULL,
  PRIMARY KEY (`StaffID`, `Department_DepartmentID`),
  CONSTRAINT `fk_Staff_Department`
    FOREIGN KEY (`Department_DepartmentID`) REFERENCES `Department` (`DepartmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE INDEX `fk_Staff_Department_idx` ON `Staff` (`Department_DepartmentID`);

-- -------------------------
-- Table Patient
-- -------------------------
DROP TABLE IF EXISTS `Patient`;
CREATE TABLE `Patient` (
  `PatientID` INT NOT NULL,
  `FirstName` VARCHAR(30) NULL,
  `LastName` VARCHAR(30) NULL,
  `DateOfBirth` DATE NULL,
  `Gender` VARCHAR(10) NULL,
  `Phone` VARCHAR(15) NULL,
  `Email` VARCHAR(50) NULL,
  `Address` VARCHAR(100) NULL,
  `MedicalHistory` TEXT NULL,
  PRIMARY KEY (`PatientID`)
) ENGINE=InnoDB;

-- -------------------------
-- Table Treatment
-- -------------------------
DROP TABLE IF EXISTS `Treatment`;
CREATE TABLE `Treatment` (
  `TreatmentID` INT NOT NULL,
  `TreatmentName` VARCHAR(50) NULL,
  `Description` TEXT NULL,
  `Cost` DECIMAL(10,2) NULL,
  `Type` VARCHAR(30) NULL,
  `Department_DepartmentID` INT NOT NULL,
  PRIMARY KEY (`TreatmentID`, `Department_DepartmentID`),
  CONSTRAINT `fk_Treatment_Department`
    FOREIGN KEY (`Department_DepartmentID`) REFERENCES `Department`(`DepartmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE INDEX `fk_Treatment_Department_idx` ON `Treatment` (`Department_DepartmentID`);

-- -------------------------
-- Table Appointment
-- -------------------------
DROP TABLE IF EXISTS `Appointment`;
CREATE TABLE `Appointment` (
  `AppointmentID` INT NOT NULL,
  `PatientID` INT NOT NULL,
  `StaffID` INT NOT NULL,
  `TreatmentID` INT NOT NULL,
  `DepartmentID` INT NOT NULL,
  `AppointmentDateTime` DATETIME NULL,
  PRIMARY KEY (`AppointmentID`, `PatientID`, `StaffID`, `TreatmentID`, `DepartmentID`),

  -- Link to Staff (StaffID + DepartmentID)
  CONSTRAINT `fk_Appointment_Staff`
    FOREIGN KEY (`StaffID`, `DepartmentID`) REFERENCES `Staff`(`StaffID`, `Department_DepartmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  -- Link to Patient
  CONSTRAINT `fk_Appointment_Patient`
    FOREIGN KEY (`PatientID`) REFERENCES `Patient`(`PatientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  -- Link to Treatment (TreatmentID + DepartmentID)
  CONSTRAINT `fk_Appointment_Treatment`
    FOREIGN KEY (`TreatmentID`, `DepartmentID`) REFERENCES `Treatment`(`TreatmentID`, `Department_DepartmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE INDEX `fk_Appointment_Staff_idx` ON `Appointment` (`PatientID`, `StaffID`);
CREATE INDEX `fk_Appointment_Patient_idx` ON `Appointment` (`TreatmentID`);
CREATE INDEX `fk_Appointment_Treatment_idx` ON `Appointment` (`DepartmentID`);



INSERT INTO Department VALUES (2, 'Orthopedics', '01-8765432', 'Building B, Floor 1');
INSERT INTO Department VALUES (3, 'Pediatrics', '01-1234987', 'Building C, Floor 3');
INSERT INTO Department VALUES (4, 'Neurology', '01-5647382', 'Building A, Floor 4');
INSERT INTO Department VALUES (5, 'Dermatology', '01-9988776', 'Building D');
INSERT INTO Department VALUES (6, 'Oncology', '01-5566771', 'Building E');
INSERT INTO Department VALUES (7, 'ENT', '01-7788990', 'Building B, Floor 2');
INSERT INTO Department VALUES (8, 'Gastroenterology', '01-3456721', 'Building F');
INSERT INTO Department VALUES (9, 'Urology', '01-1122334', 'Building C, Floor 1');
INSERT INTO Department VALUES (10, 'Emergency', '01-9001122', 'Building A, Ground Floor');
-- Task 10: Add one new record to each table
INSERT INTO Department VALUES (11, 'Psychology', '01-2223334', 'Building G');

INSERT INTO Staff VALUES (1, 'John', 'Smith', 'Doctor', '2018-03-12', '0851234567', 1);
INSERT INTO Staff VALUES (2, 'Emily', 'Johnson', 'Nurse', '2020-06-01', '0857654321', 2);
INSERT INTO Staff VALUES (3, 'Michael', 'Brown', 'Doctor', '2015-11-20', '0861112222', 3);
INSERT INTO Staff VALUES (4, 'Sarah', 'Davis', 'Surgeon', '2017-09-05', '0873334444', 2);
INSERT INTO Staff VALUES (5, 'David', 'Wilson', 'Doctor', '2019-02-14', '0895556666', 4);
INSERT INTO Staff VALUES (6, 'Anna', 'Taylor', 'Nurse', '2016-12-30', '0837778888', 1);
INSERT INTO Staff VALUES (7, 'Chris', 'Martin', 'Technician', '2021-04-18', '0899990000', 5);
INSERT INTO Staff VALUES (8, 'Sophia', 'Moore', 'Doctor', '2013-07-22', '0864445555', 6);
INSERT INTO Staff VALUES (9, 'Paul', 'Anderson', 'Nurse', '2022-01-10', '0852223333', 7);
INSERT INTO Staff VALUES (10, 'Laura', 'White', 'Doctor', '2014-05-16', '0879991111', 3);
INSERT INTO Staff VALUES (11, 'Kavin', 'Smith', 'Doctor', '2020-05-10', '0897001122', 1);
-- Task 10: Add one new record to each table
INSERT INTO Staff VALUES (12, 'Maria', 'Fagan', 'Nurse', '2022-09-01', '0851003003', 20);
INSERT INTO Staff (StaffID, FirstName, LastName, JobTitle, HireDate, Phone, Department_DepartmentID) VALUES (999, 'Michael', 'Dean', 'CEO', '2020-01-01', '0890000000', 1);


INSERT INTO Patient VALUES (1468, 'James', 'Miller', '1985-04-12', 'Male', '0891112222', 'j.miller@mail.com', '12 Green Road', 'Diabetes');
INSERT INTO Patient VALUES (2235, 'Olivia', 'Clark', '1992-11-02', 'Female', '0893334444', 'olivia.c@mail.com', '45 Park Street', 'Asthma');
INSERT INTO Patient VALUES (3223, 'Noah', 'Lewis', '2001-07-18', 'Male', '0895556666', 'noah.lewis@mail.com', '78 Hill Avenue', 'Healthy');
INSERT INTO Patient VALUES (4467, 'Emma', 'Walker', '1988-12-25', 'Female', '0897778888', 'emma.w@mail.com', '9 Forest Drive', 'Allergy');
INSERT INTO Patient VALUES (5457, 'Liam', 'Hall', '1979-09-30', 'Male', '0861234567', 'liam.h@mail.com', '23 River Road', 'Heart Disease');
INSERT INTO Patient VALUES (3456, 'Ava', 'Young', '1995-01-15', 'Female', '0873456789', 'ava.young@mail.com', '10 Wood Street', 'Migraine');
INSERT INTO Patient VALUES (7356, 'William', 'King', '1972-03-05', 'Male', '0859876543', 'w.king@mail.com', '34 Mountain Road', 'Cancer');
INSERT INTO Patient VALUES (8468, 'Mia', 'Scott', '2003-10-11', 'Female', '0862345678', 'mia.s@mail.com', '56 Oak Lane', 'Healthy');
INSERT INTO Patient VALUES (9345, 'Henry', 'Green', '1999-02-08', 'Male', '0892223333', 'henry.green@mail.com', '67 Lake View', 'Back Pain');
INSERT INTO Patient VALUES (5612, 'John', 'Bob', '1983-08-27', 'Male', '0894445555', 'john.bob@mail.com', '89 Meadow Road', 'Skin Condition');
-- Task 10: Add one new record to each table
INSERT INTO Patient VALUES (9500, 'Tom', 'River', '1993-09-20', 'Male', '0861119999', 'tom@mail.com', '44 Willow Road', 'Asthma');

INSERT INTO Treatment VALUES (1, 'Heart Surgery', 'Cardiac bypass procedure', 9500.00, 'Surgery', 1);
INSERT INTO Treatment VALUES (2, 'Knee Replacement', 'Orthopedic knee repair', 5200.00, 'Surgery', 2);
INSERT INTO Treatment VALUES (3, 'Child Checkup', 'Pediatric health examination', 120.00, 'Consultation', 3);
INSERT INTO Treatment VALUES (4, 'Brain MRI', 'Neurological imaging scan', 450.00, 'Diagnostic', 4);
INSERT INTO Treatment VALUES (5, 'Skin Biopsy', 'Dermatology tissue test', 300.00, 'Diagnostic', 5);
INSERT INTO Treatment VALUES (6, 'Chemotherapy', 'Cancer treatment therapy', 3500.00, 'Therapy', 6);
INSERT INTO Treatment VALUES (7, 'Sinus Cleaning', 'ENT sinus treatment', 180.00, 'Procedure', 7);
INSERT INTO Treatment VALUES (8, 'Endoscopy', 'Gastrointestinal examination', 650.00, 'Diagnostic', 8);
INSERT INTO Treatment VALUES (9, 'Kidney Ultrasound', 'Urology imaging scan', 200.00, 'Diagnostic', 9);
INSERT INTO Treatment VALUES (10, 'Emergency Care', 'Immediate medical help', 500.00, 'Procedure', 10);
-- Task 10: Add one new record to each table
INSERT INTO Treatment VALUES (20, 'Rehab Session', 'Physical training', 150.00, 'Therapy', 20);


INSERT INTO Appointment VALUES (1, 1, 1, 1, 1, '2025-01-15 09:00:00');
INSERT INTO Appointment VALUES (2, 2, 2, 2, 2, '2025-01-16 10:30:00');
INSERT INTO Appointment VALUES (3, 3, 3, 3, 3, '2025-01-17 11:00:00');
INSERT INTO Appointment VALUES (4, 4, 4, 4, 4, '2025-01-18 14:00:00');
INSERT INTO Appointment VALUES (5, 5, 5, 5, 4, '2025-01-19 15:30:00');
INSERT INTO Appointment VALUES (6, 6, 6, 6, 1, '2025-01-20 12:45:00');
INSERT INTO Appointment VALUES (7, 7, 8, 6, 6, '2025-01-21 08:30:00');
INSERT INTO Appointment VALUES (8, 8, 9, 7, 7, '2025-01-22 16:00:00');
INSERT INTO Appointment VALUES (9, 9, 10, 4, 4, '2025-01-23 13:20:00');
INSERT INTO Appointment VALUES (10, 10, 1, 10, 10, '2025-01-24 17:10:00');
-- Task 4: Schedule a new medical appointment
INSERT INTO Appointment VALUES (50, 3456, 1, 1, 1, '2025-02-10 09:00:00');
INSERT INTO Appointment VALUES (200, 1, 11, 1, 1, '2025-03-01 10:00:00');
INSERT INTO Appointment VALUES (300, 9500, 20, 20, 20, '2025-03-11 13:00:00');

-- Task 1: Show details of all medical departments of hospital
SELECT * FROM Department;
-- Task 2: Find the contact details of patient “John Bob” whose patient ID is 5612
SELECT PatientID, FirstName, LastName, Phone, Email, Address
FROM Patient
WHERE PatientID = 5612 AND FirstName = 'John' AND LastName = 'Bob';
-- Task 3: Update the patient ID number 3456 contact details
UPDATE Patient SET Phone = '0891000000',Email = 'newemail@mail.com',Address = 'New Street 12' WHERE PatientID = 3456;

-- Task 5: Find details of all patients who have Diabetes
SELECT * FROM Patient WHERE MedicalHistory LIKE 'Diabetes';

-- Task 6: Display first name and surname of all patients under Dr. Kavin Smith
SELECT p.FirstName, p.LastName FROM Appointment a JOIN Patient p ON a.PatientID = p.PatientID JOIN Staff s ON a.StaffID = s.StaffID
WHERE s.FirstName = 'Kavin' AND s.LastName = 'Smith';
-- Task 7: Change all patients in Orthopedics department to Orthopedic Surgery Department
UPDATE Department SET DepartmentName = 'Orthopedic Surgery' WHERE DepartmentName = 'Orthopedics';
-- Task 8: Display first name, surname, and hire date of all doctors sorted by descending hire date
SELECT FirstName, LastName, HireDate FROM Staff WHERE JobTitle = 'Doctor' ORDER BY HireDate DESC;
-- Task 9: Count how many patients are undergoing 'Heart Surgery' treatment
SELECT COUNT(*) AS HeartSurgeryPatients 
FROM Appointment a JOIN Treatment t ON a.TreatmentID = t.TreatmentID 
WHERE t.TreatmentName = 'Heart Surgery';
-- Task 11: Delete one record from all tables
DELETE FROM Appointment WHERE AppointmentID = 300;
DELETE FROM Treatment WHERE TreatmentID = 20;
DELETE FROM Staff WHERE StaffID = 12; 
DELETE FROM Patient WHERE PatientID = 9500;
DELETE FROM Department WHERE DepartmentID = 11;
-- Task 12: Find total number of days off for all staff, order by least days off
CREATE TABLE StafDaysOff (
    StaffID INT PRIMARY KEY,
    DaysOff INT
);

INSERT INTO StafDaysOff VALUES (1, 5);
INSERT INTO StafDaysOff VALUES (2, 2);
INSERT INTO StafDaysOff VALUES (3, 7);
INSERT INTO StafDaysOff VALUES (4, 1);
INSERT INTO StafDaysOff VALUES (5, 4);
INSERT INTO StafDaysOff VALUES (6, 3);
INSERT INTO StafDaysOff VALUES (7, 0);
INSERT INTO StafDaysOff VALUES (8, 6);
INSERT INTO StafDaysOff VALUES (9, 2);
INSERT INTO StafDaysOff VALUES (10, 5);
INSERT INTO StafDaysOff VALUES (11, 1);
-- Task 13: Change the role of all staff with job title 'Office worker' to 'Administrator'
SELECT s.FirstName, s.LastName, d.DaysOff
FROM Staff s JOIN StafDaysOff d ON s.StaffID = d.StaffID
ORDER BY d.DaysOff ASC;
-- Task 14: Set the Orthopedics department phone number to 01-7654321
UPDATE Department SET PhoneNumber = '01-7654321' WHERE DepartmentID = 2;
UPDATE Staff s JOIN (SELECT StaffID FROM Staff WHERE JobTitle = 'Office worker') tmp ON s.StaffID = tmp.StaffID
SET s.JobTitle = 'Administrator';
-- Task 15: Set the chief executive officer (CEO) of the hospital to be called Michael Dean
UPDATE Staff SET FirstName = 'Michael', LastName = 'Dean' WHERE StaffID = 999;
-- Task 16: Show all staff members who have been working there for longer than 3 years
SELECT StaffID, FirstName, LastName, JobTitle, HireDate FROM Staff WHERE DATEDIFF(CURDATE(), HireDate) > 3 * 365;
-- Task 17: Show details of all patient names, medical history, appointment dates, times, and treatment
SELECT  p.FirstName AS PatientFirstName,p.LastName AS PatientLastName,p.MedicalHistory,a.AppointmentDateTime,t.TreatmentName
FROM Appointment a JOIN Patient p ON a.PatientID = p.PatientID JOIN Treatment t ON a.TreatmentID = t.TreatmentID;
-- Task 18: Identify how many patients have the word 'road' in their address
SELECT COUNT(*) AS PatientsWithRoad fROM Patient WHERE LOWER(Address) LIKE 'road';
-- Task 19: Create a view showing information from three tables at once
CREATE VIEW SimplePatientAppointments AS
sELECT p.FirstName AS PatientFirstName,p.LastName AS PatientLastName,s.FirstName AS StaffFirstName,s.LastName AS StaffLastName,a.AppointmentDateTime
FROM Appointment a JOIN Patient p ON a.PatientID = p.PatientID JOIN Staff s ON a.StaffID = s.StaffID;
-- Task 20: Drop all information contained in the appointments relation
DROP TABLE Appointment;