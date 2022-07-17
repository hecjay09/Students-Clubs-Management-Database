-- MySQL Version of scripts for inserting data to tables.
-- The entire code works perfectly in MSSQL Server.
USE ProjectSQL;

-- Member: 20 records
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001001,'Hector','Onato','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001002,'Yan Fung Yenny','Hou','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001003,'Blanche','Sitznski','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001004,'Natasha','Romanoff','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001005,'Landi','Umberto','AL');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001006,'Fred','Myers','AL');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001007,'Marc','Scott','AL');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001008,'Hugo','Etherlinck','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001009,'Mora','Cathrine ','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001010,'Scott ','Summers','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001011,'Yuriko','Oyama','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001012,'Wilson','Wade','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001013,'Bram ','Velsing','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001014,'Daisy ','Johnson','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001015,'Elektra','Natchios','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001016,'Max','Dillon','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001017,'Ivory ','Shadow','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001018,'Dan','Rubenstein','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001019,'Norman','Osborn','ST');
INSERT INTO Member (MemberID, FirstName, LastName, MemberType) VALUES (10001020,'Jack','Danner','AL');

-- Club: 4 records
INSERT INTO Club (ClubID, LeadMemberID, ClubName) VALUES (1000,10001001,'Computing Club');
INSERT INTO Club (ClubID, LeadMemberID, ClubName) VALUES (2000,10001001,'Biology Club');
INSERT INTO Club (ClubID, LeadMemberID, ClubName) VALUES (3000,10001002,'Sport Club');
INSERT INTO Club (ClubID, LeadMemberID, ClubName) VALUES (4000,10001003,'Dance Club');

-- Club_Group: 11 records
INSERT INTO Club_Group (ClubID, GroupID, HeadMemberID, GroupName) VALUES (1000,1,10001004,'Database');
INSERT INTO Club_Group (ClubID, GroupID, HeadMemberID, GroupName) VALUES (1000,2,10001005,'Java');
INSERT INTO Club_Group (ClubID, GroupID, HeadMemberID, GroupName) VALUES (1000,3,10001006,'C++');
INSERT INTO Club_Group (ClubID, GroupID, HeadMemberID, GroupName) VALUES (2000,1,10001008,'Plant Research');
INSERT INTO Club_Group (ClubID, GroupID, HeadMemberID, GroupName) VALUES (2000,2,10001008,'Insect Research');
INSERT INTO Club_Group (ClubID, GroupID, HeadMemberID, GroupName) VALUES (2000,3,10001009,'Animal Research');
INSERT INTO Club_Group (ClubID, GroupID, HeadMemberID, GroupName) VALUES (3000,1,10001010,'Swimming');
INSERT INTO Club_Group (ClubID, GroupID, HeadMemberID, GroupName) VALUES (3000,2,10001011,'Running');
INSERT INTO Club_Group (ClubID, GroupID, HeadMemberID, GroupName) VALUES (3000,3,10001012,'Cycling');
INSERT INTO Club_Group (ClubID, GroupID, HeadMemberID, GroupName) VALUES (4000,1,10001013,'Jazz');
INSERT INTO Club_Group (ClubID, GroupID, HeadMemberID, GroupName) VALUES (4000,2,10001014,'Latin');

-- Event: 7 records
INSERT INTO Event (EventID, ClubID, GroupID, EventSubject, EventDate, EventTime, RegistrationFee, Building, BuildingFloor, Room) VALUES (101,1000,1,'Become a Data Analyst','2022/06/15','12:30:00',5,'A',1,'122A');
INSERT INTO Event (EventID, ClubID, GroupID, EventSubject, EventDate, EventTime, RegistrationFee, Building, BuildingFloor, Room) VALUES (102,1000,2,'How to write your first Java program','2022/07/04','09:30:00',5,'B',0,'019');
INSERT INTO Event (EventID, ClubID, GroupID, EventSubject, EventDate, EventTime, RegistrationFee, Building, BuildingFloor, Room) VALUES (103,1000,2,'Java Summer Code Camp','2022/08/06','09:30:00',20,'A',1,'122A');
INSERT INTO Event (EventID, ClubID, GroupID, EventSubject, EventDate, EventTime, RegistrationFee, Building, BuildingFloor, Room) VALUES (201,2000,1,'Biology Club Orientation - Plant Research','2022/08/16','10:00:00',0,'T',5,'530');
INSERT INTO Event (EventID, ClubID, GroupID, EventSubject, EventDate, EventTime, RegistrationFee, Building, BuildingFloor, Room) VALUES (202,2000,2,'Biology Club Orientation - Insect Research','2022/08/16','10:00:00',0,'T',5,'530');
INSERT INTO Event (EventID, ClubID, GroupID, EventSubject, EventDate, EventTime, RegistrationFee, Building, BuildingFloor, Room) VALUES (203,2000,3,'Biology Club Orientation - Animal Research','2022/08/16','10:00:00',0,'T',5,'530');
INSERT INTO Event (EventID, ClubID, GroupID, EventSubject, EventDate, EventTime, RegistrationFee, Building, BuildingFloor, Room) VALUES (401,4000,1,'Latin Competition','2022/09/20','08:30:00',10,'G',1,'105');

-- Project: 6 records
INSERT INTO Project (ProjectCode, ClubID, GroupID, ProjectName, Budget) VALUES ('COMP001',1000,1,'Database Migration',6000);
INSERT INTO Project (ProjectCode, ClubID, GroupID, ProjectName, Budget) VALUES ('COMP002',1000,3,'Registration System Revamp',6000);
INSERT INTO Project (ProjectCode, ClubID, GroupID, ProjectName, Budget) VALUES ('BIO001',2000,1,'Plant Research',5000);
INSERT INTO Project (ProjectCode, ClubID, GroupID, ProjectName, Budget) VALUES ('BIO002',2000,2,'Insect Research',5000);
INSERT INTO Project (ProjectCode, ClubID, GroupID, ProjectName, Budget) VALUES ('BIO003',2000,3,'Animal Research',5000);
INSERT INTO Project (ProjectCode, ClubID, GroupID, ProjectName, Budget) VALUES ('SPT001',3000,2,'Vancouver Marathon',4000);

-- Member_Joins_Group: 22 records
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001001,1000,2);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001001,2000,1);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001002,3000,2);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001003,4000,1);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001004,1000,1);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001005,1000,2);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001006,1000,3);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001007,1000,1);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001008,2000,1);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001008,2000,2);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001009,2000,3);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001010,3000,1);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001011,3000,2);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001012,3000,3);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001013,4000,1);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001014,4000,2);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001015,3000,2);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001016,2000,2);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001017,3000,1);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001018,3000,3);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001019,4000,2);
INSERT INTO Member_Joins_Group (MemberID, ClubID, GroupID) VALUES (10001020,2000,3);

-- Member_WorksOn_Project: 13 records
INSERT INTO Member_WorksOn_Project (MemberID, ProjectCode, MemberPortion) VALUES (10001001,'COMP001',1500);
INSERT INTO Member_WorksOn_Project (MemberID, ProjectCode, MemberPortion) VALUES (10001003,'COMP001',1500);
INSERT INTO Member_WorksOn_Project (MemberID, ProjectCode, MemberPortion) VALUES (10001003,'COMP002',1000);
INSERT INTO Member_WorksOn_Project (MemberID, ProjectCode, MemberPortion) VALUES (10001004,'COMP002',2000);
INSERT INTO Member_WorksOn_Project (MemberID, ProjectCode, MemberPortion) VALUES (10001005,'COMP002',1500);
INSERT INTO Member_WorksOn_Project (MemberID, ProjectCode, MemberPortion) VALUES (10001008,'BIO001',500);
INSERT INTO Member_WorksOn_Project (MemberID, ProjectCode, MemberPortion) VALUES (10001008,'BIO002',600);
INSERT INTO Member_WorksOn_Project (MemberID, ProjectCode, MemberPortion) VALUES (10001001,'BIO001',700);
INSERT INTO Member_WorksOn_Project (MemberID, ProjectCode, MemberPortion) VALUES (10001009,'BIO003',700);
INSERT INTO Member_WorksOn_Project (MemberID, ProjectCode, MemberPortion) VALUES (10001020,'BIO003',700);
INSERT INTO Member_WorksOn_Project (MemberID, ProjectCode, MemberPortion) VALUES (10001002,'SPT001',500);
INSERT INTO Member_WorksOn_Project (MemberID, ProjectCode, MemberPortion) VALUES (10001015,'SPT001',500);
INSERT INTO Member_WorksOn_Project (MemberID, ProjectCode, MemberPortion) VALUES (10001011,'SPT001',500);

-- Alumnus_WorkHistory: 5 records
INSERT INTO Alumnus_WorkHistory (AlumnusID, WorkID, Company, Position, StartDate, EndDate) VALUES (10001006,1,'Google','Software Engineer','2018/10/01','2021/09/30');
INSERT INTO Alumnus_WorkHistory (AlumnusID, WorkID, Company, Position, StartDate, EndDate) VALUES (10001006,2,'Facebook','Full Stack Web Developer','2021/11/01',NULL);
INSERT INTO Alumnus_WorkHistory (AlumnusID, WorkID, Company, Position, StartDate, EndDate) VALUES (10001007,1,'Yahoo','Data Analyst','2020/09/01',NULL);
INSERT INTO Alumnus_WorkHistory (AlumnusID, WorkID, Company, Position, StartDate, EndDate) VALUES (10001005,1,'Amazon','Software Engineer','2019/08/01','2020/07/31');
INSERT INTO Alumnus_WorkHistory (AlumnusID, WorkID, Company, Position, StartDate, EndDate) VALUES (10001005,2,'Amazon','System Analyst','2021/04/01',NULL);

