-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.

CREATE TABLE HealthInstitutions
(
    hid INTEGER NOT NULL,
    name VARCHAR(30) NOT NULL ,
    email VARCHAR(30) NOT NULL ,
    phone VARCHAR(15) NOT NULL ,
    address VARCHAR(30) NOT NULL ,
    website VARCHAR(50),
    PRIMARY KEY(hid)
);

CREATE TABLE CommunityClinics
(
    hid INTEGER NOT NULL,
    PRIMARY KEY(hid),
    FOREIGN KEY(hid) REFERENCES HealthInstitutions(hid)
);

CREATE TABLE BirthingCenters
(
    hid INTEGER NOT NULL,
    PRIMARY KEY(hid),
    FOREIGN KEY(hid) REFERENCES HealthInstitutions(hid)
);


CREATE TABLE Midwives
(
    pid INTEGER NOT NULL,
    name VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    worksat INTEGER NOT NULL,
    PRIMARY KEY(pid),
    FOREIGN KEY(worksat) REFERENCES HealthInstitutions(hid)
);

CREATE TABLE Parents
(
    healthid INTEGER NOT NULL,
    name VARCHAR(30) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(30) NOT NULL,
    address VARCHAR(30) NOT NULL,
    profession VARCHAR(30) NOT NULL,
    dateofbirth DATE NOT NULL,
    bloodtype VARCHAR(10),
    PRIMARY KEY(healthid)
);

CREATE TABLE SecondParents
(
    fid INTEGER NOT NULL,
    healthid INTEGER,
    name VARCHAR(30) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(30),
    address VARCHAR(30),
    profession VARCHAR(30) NOT NULL,
    dateofbirth DATE NOT NULL,
    bloodtype VARCHAR(10),
    PRIMARY KEY(fid)
);

CREATE TABLE Couples
(
    cid INTEGER NOT NULL,
    mid INTEGER NOT NULL,
    fid INTEGER,
    PRIMARY KEY(cid),
    FOREIGN KEY(mid) REFERENCES Parents(healthid),
    FOREIGN KEY(fid) REFERENCES SecondParents(fid)
);

CREATE TABLE Pregnancy
(
    cid INTEGER NOT NULL,
    numofpreg INTEGER NOT NULL,
    pid INTEGER NOT NULL,
    backuppid INTEGER NOT NULL,
    numofbabies INTEGER,
    birthloc INTEGER,
    perioddued DATE,
    testdued DATE,
    finaldued DATE,
    esttimeframe DATE NOT NULL,
    isinterested BOOLEAN,
    PRIMARY KEY(cid, numofpreg),
    FOREIGN KEY(cid) REFERENCES Couples(cid),
    FOREIGN KEY(pid) REFERENCES Midwives(pid),
    FOREIGN KEY(backuppid) REFERENCES Midwives(pid),
    FOREIGN KEY(birthloc) REFERENCES BirthingCenters(hid)
);

CREATE TABLE InfoSession
(
    sessionid INTEGER NOT NULL,
    pid INTEGER NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    language VARCHAR(10),
    PRIMARY KEY (sessionid),
    FOREIGN KEY(pid) REFERENCES Midwives(pid)
);

CREATE TABLE AttendInfoSession
(
    sessionid INTEGER NOT NULL,
    cid INTEGER NOT NULL,
    attended BOOLEAN,
    PRIMARY KEY (sessionid, cid),
    FOREIGN KEY(cid) REFERENCES Couples(cid)
);

CREATE TABLE Appointments
(
    aptid INTEGER NOT NULL,
    cid INTEGER NOT NULL,
    numofpreg INTEGER NOT NULL,
    pid INTEGER NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    hid INTEGER,
    PRIMARY KEY (aptid),
    FOREIGN KEY(cid,numofpreg) REFERENCES Pregnancy(cid,numofpreg),
    FOREIGN KEY(pid) REFERENCES Midwives(pid),
    FOREIGN KEY(hid) REFERENCES HealthInstitutions(hid)
);

CREATE TABLE Notes
(
    aptid INTEGER NOT NULL,
    timestamp TIME NOT NULL,
    content VARCHAR(100),
    PRIMARY KEY (aptid, timestamp),
    FOREIGN KEY(aptid) REFERENCES Appointments(aptid)
);

CREATE TABLE Technicians
(
    tid INTEGER NOT NULL,
    name VARCHAR(30),
    phone VARCHAR(15),
    PRIMARY KEY (tid)
);

CREATE TABLE Babies
(
    babyid INTEGER NOT NULL,
    cid INTEGER NOT NULL,
    numofpreg INTEGER NOT NULL,
    name VARCHAR(30),
    gender CHAR,
    date DATE,
    time TIME,
    bloodtype VARCHAR(10) NOT NULL,
    PRIMARY KEY (babyid),
    FOREIGN KEY (cid,numofpreg) REFERENCES Pregnancy(cid,numofpreg)
);

CREATE TABLE Treatments
(
    trid INTEGER NOT NULL,
    type VARCHAR(30) NOT NULL,
    pid INTEGER NOT NULL,
    cid INTEGER,
    numofpreg INTEGER,
    babyid INTEGER,
    tid INTEGER,
    dateprescribed DATE NOT NULL,
    datesampletaken DATE,
    datedone DATE,
    result VARCHAR(50),
    PRIMARY KEY (trid),
    FOREIGN KEY (pid) REFERENCES Midwives(pid),
    FOREIGN KEY (cid,numofpreg) REFERENCES Pregnancy(cid,numofpreg),
    FOREIGN KEY (babyid) REFERENCES Babies(babyid),
    FOREIGN KEY (tid) REFERENCES Technicians(tid)
);



