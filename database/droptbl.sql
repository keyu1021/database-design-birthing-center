-- Include your drop table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the drop table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been dropped (reverse of the creation order).

DROP TABLE Treatments;
DROP TABLE Babies;
DROP TABLE Technicians;
DROP TABLE Notes;
DROP TABLE Appointments;
DROP TABLE AttendInfoSession;
DROP TABLE InfoSession;
DROP TABLE Pregnancy;
DROP TABLE Couples;
DROP TABLE SecondParents;
DROP TABLE Parents;
DROP TABLE Midwives;
DROP TABLE CommunityClinics;
DROP TABLE BirthingCenters;
DROP TABLE HealthInstitutions;


