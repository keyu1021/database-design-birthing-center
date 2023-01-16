-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!

-- This is only an example of how you add INSERT statements to this file.
--   You may remove it.
INSERT INTO HealthInstitutions VALUES
(501, 'Lac-Saint-Louis', 'lacsaintlouis.gmail.com', '12345', '100 Ave Can', 'www.lacSaintlouis.ca')
,(502, 'Quebec BC', 'quebec.bc.gmail.com', '43812', '3210 Sherbrook', 'www.quebecbc.ca')
,(503, 'Ontario BC', 'ontario.bc.gmail.com', '19328', '132 Young', 'www.ontbc.ca')
,(504, 'Quebec CC', 'quebec.cc.gmail.com', '43850', '450 Sherbrook', 'www.quebeccc.ca')
,(505, 'Ontario CC', 'ontario.cc.gmail.com', '43613', '20 King', 'www.ontcc.ca')
;

INSERT INTO CommunityClinics VALUES
(504), (505);

INSERT INTO BirthingCenters VALUES
(501), (502), (503)
;

INSERT INTO Midwives VALUES
(001, 'Monica Geller', 'monicag@gmail.com', '77777', 501)
,(002, 'Marion Girard', 'mariong@gmail.com', '43876', 501)
,(003, 'Rachel Green', 'rachelg@gmail.com', '13249', 502)
,(004, 'Amy Green', 'amyg@gmail.com', '43819', 503)
,(005, 'Kerry Wang', 'kerryw@gmail.com', '01203', 504)
,(006, 'Kate Park', 'katep@gmail.com', '32813', 502)
,(007, 'Will Smith', 'wills@gmail.com', '23891', 503)
,(008, 'Taylor Swift', 'taylors@gmail.com', '19281', 504)
,(009, 'Ariana Grande', 'arianag@gmail.com', '28498', 501)
,(010, 'Doja Cat', 'dojac@gmail.com', '19382', 501)
,(011, 'Jisun No', 'jisunn@gmail.com', '18282', 501)
;

INSERT INTO Parents VALUES
(1001, 'Suri Man', '23232', 'suriman@gmail.com', '122 Ruoyan', 'Dancer', '2000-06-12', 'O')
,(1002, 'Mina Myoi', '13853', 'mina.twice@gmail.com', '205 Gangdong', 'Singer', '1997-03-24','O')
,(1003, 'Tiffany Kim', '23918', 'tiffanykim@gmail.com', '347 Rue Durocher', 'Engineer', '1992-05-24','A')
,(1004, 'Zendaya Coleman', '45829', 'zendaya@gmail.com', '291 College', 'Actor', '1996-09-01','AB')
,(1005, 'Lily Colins', '45678', 'lilycollins@gmail.com', '12 Queen', 'waitress', '1989-03-18','B')
,(1006, 'Victoria Gutierrez', '438599', 'Victoria@gmail.com', '250 Ave Parc', 'CEO', '2000-10-07','O')
;

INSERT INTO SecondParents VALUES
(2002, null,'Keyu Yao', '15850', 'keyuyao1021@gmail.com', '205 Gangdong', 'Student', '2000-10-21','AB')
,(2003, null, 'Sam Smith', '18900', 'samsmith@gmail.com', '19 Awa', 'waiter', '1980-06-21','B')
,(2004, null, 'Henry Bill', '45791', 'Henrybill@gmail.com', '291 College', 'Actor', '1998-12-21','O')
,(2005, null,'Tom What', '23456', 'tomwhat@gmail.com', null, 'Worker', '1989-09-16', null)
,(2006, null, 'Karen White', '17328', null, '205 Ace', 'Student', '1994-01-10','AB')
;

INSERT INTO Couples VALUES
(01, 1001, null)
,(02, 1002, 2002)
,(03, 1003, 2003)
,(04, 1004, 2004)
,(05, 1005, 2005)
,(06, 1006, 2006)
,(14, 1001, 2004)
;

INSERT INTO Pregnancy VALUES
--cid,num,pid,bpid,numofb,birthloc, perioddued, testdued, finaldued, est, interested
(01, 1, 005, 008, 1, 503, '2021-03-20', '2021-03-29', null, '2021-03-01', 1)
,(06, 1, 004, 007, 1, 502, '2021-04-10', '2021-04-16', '2021-04-16', '2021-04-01', 1)
,(02, 1, 006, 003, 1, 501, '2021-04-14', '2021-04-29', '2021-04-29', '2021-04-01', 1)
,(05, 1, 003, 006, 2, 502, '2021-07-19', '2021-07-25', '2021-07-25', '2021-08-01', 1)
,(14, 1, 002, 001, 2, 503, '2022-06-22', '2022-06-29', null, '2022-07-01', 1)
,(04, 1, 001, 002, 3, 501, '2022-06-22', '2022-07-02', '2022-07-02', '2022-07-01', 1)
,(03, 1, 002, 001, 1, 501, '2022-07-20', '2022-07-20', '2022-07-20', '2022-07-01', 1)
,(06, 2, 001, 002, 1, 501, '2022-02-10', '2022-02-20', '2022-02-10', '2022-02-01', 1)
,(05, 2, 007, 004, 1, 501, '2022-11-01', '2022-10-25', '2022-11-01', '2022-11-01', 1)
;

INSERT INTO InfoSession VALUES
(901, 002, '2020-12-04', '14:30:00', 'Chinese')
,(902, 001, '2021-01-26', '10:00:00', 'French')
,(903, 004, '2021-02-02', '10:00:00', 'English')
,(904, 006, '2021-12-04', '14:30:00', 'French')
,(905, 003, '2022-01-01', '10:00:00', 'English')
,(906, 003, '2022-02-01', '10:00:00', 'English')
,(907, 004, '2022-03-04', '17:00:00', 'Spanish')
,(908, 005, '2022-03-17', '10:00:00', 'English')
,(909, 001, '2022-04-03', '17:00:00', 'English')
,(910, 002, '2022-05-19', '09:00:00', 'English')
;

INSERT INTO AttendInfoSession VALUES
(901, 01, 1)
,(902, 06, 1)
,(903, 02, 1)
,(904, 14, 1)
,(905, 04, 1)
,(906, 03, 1)
,(907, 03, 0)
,(908, 03, 1)
,(909, 05, 1)
;

INSERT INTO Appointments VALUES
--aptid,cid,num,pid,    date, time, hid
(10101, 01, 1, 005, '2020-11-03', '10:30:00', 504)
,(10601, 06, 1, 004, '2020-12-10', '10:30:00', 503)
,(10201, 02, 1, 006, '2021-01-19', '16:30:00', 502)
,(10501, 05, 1, 003, '2021-03-29', '09:30:00', 502)
,(11401, 14, 1, 002, '2022-01-30', '10:00:00', 501)
,(11402, 14, 1, 002, '2022-03-21', '10:00:00', 501)
,(11403, 14, 1, 002, '2022-03-25', '10:00:00', 501)
,(10401, 04, 1, 001, '2022-04-21', '14:00:00', 501)
,(10301, 03, 1, 002, '2022-03-23', '14:00:00', 501)
,(20601, 06, 2, 001, '2021-10-01', '09:30:00', 501)
,(20602, 06, 2, 001, '2022-01-01', '09:30:00', 501)
;

INSERT INTO Notes VALUES
(10101, '11:03:00', '')
,(10101, '11:35:00', '')
,(10601, '14:30:00', '')
,(10201, '15:00:00', '')
,(10401, '10:45:00', '')
;

INSERT INTO Technicians VALUES
(301, 'Max Tech', '27169')
,(302, 'Carol Tech', '28371')
,(303, 'Amanda Tech', '38178')
,(304, 'Nick Tech', '40204')
,(305, 'Lexi Tech', '23023')
;

INSERT INTO Babies VALUES
--bbid,cid,num,name, gender, date, time, blood
(60101, 01, 1, 'Emma', 'F', '2021-03-28', '09:29:00', 'A')
,(60601, 06, 1, 'Zack', 'M', '2021-04-16', '01:22:00', 'O')
,(60201, 02, 1, 'Mac', 'M', '2021-04-29', '03:22:00', 'O')
,(60501, 05, 1, 'Natalie', 'F', '2021-07-28', '15:20:00','A')
,(60502, 05, 1, 'Jade', 'M', '2021-07-28', '15:22:00','B')
,(60602, 06, 2, 'Maggie', 'F', '2022-02-10', '12:02:00', 'O')
,(61401, 14, 1, 'Allen', 'M', null, null, 'A')
,(61402, 14, 1, 'Amy', 'F', null, null, 'B')
,(60401, 04, 1, null, 'M', null, null, 'O')
,(60402, 04, 1, null, 'M', null, null, 'O')
,(60403, 04, 1, null, 'M', null, null, 'O')
,(60301, 03, 1, 'Perry', 'M', null, null, 'B')
,(60503, 05, 2, 'Edith', 'F', null, null, 'AB')
;

INSERT INTO Treatments VALUES
--trid,  type,         pid, cid,num,bb, tid, dateprescribed
(810101, 'blood iron', 005, 01, 1, null, 301, '2020-11-03', '2020-11-04', '2020-11-05', 'Normal')
,(810102, 'first trimester ultrasound', 005, 01, 1, null, 303, '2020-11-03', '2020-12-01', '2020-12-17', 'nice baby')
,(810601, 'blood iron', 004, 06, 1, null, 302, '2020-12-10', '2020-12-10', '2020-12-10', 'High')
,(820601, 'blood iron', 002, 06, 2, null, 301, '2021-10-01', '2021-10-03', '2021-10-24', 'Low')
,(820602, 'blood iron', 002, 06, 2, null, 302, '2022-01-10', '2022-01-20', '2022-01-24', 'Normal')
,(810301, 'first trimester ultrasound', 004, null, null, 60301, 305, '2022-8-11', null, null, null)
;
