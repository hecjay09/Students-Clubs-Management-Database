CREATE DATABASE StudentClubManagement;
USE StudentClubManagement;


CREATE TABLE Member (
    MemberID INT,
    FirstName VARCHAR(15) NOT NULL,
    LastName VARCHAR(15) NOT NULL,
    MemberType CHAR(2),

    PRIMARY KEY (MemberID),
    CHECK(MemberType = 'ST' OR MemberType = 'AL')
);

CREATE TABLE Club (
    ClubID INT,
    MemberID INT,
    ClubName VARCHAR(30) UNIQUE NOT NULL,

    PRIMARY KEY (ClubID),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE Club_Group (
    ClubID INT,
    GroupID INT,
    MemberID INT,
    GroupName VARCHAR(30) NOT NULL,

    PRIMARY KEY(ClubID, GroupID),
    FOREIGN KEY(ClubID) REFERENCES Club(ClubID),
    FOREIGN KEY(MemberID) REFERENCES Member(MemberID),
);

CREATE TABLE Events (
    EventID INT,
    ClubID INT,
    GroupID INT,
    EventSubject VARCHAR(15) UNIQUE NOT NULL,
    EventDate DATE,
    EventTime TIME,
    RegistrationFee FLOAT,
    Building CHAR(1),
    BuildingFloor INT,
    Room CHAR(4),

    PRIMARY KEY (EventID), 
    FOREIGN KEY (ClubID, GroupID) REFERENCES Club_Group(ClubID, GroupID),
    CHECK (BuildingFloor <= 5),
);

CREATE TABLE Project (
    ProjectCode INT,
    ClubID INT,
    GroupID INT,
    ProjectName VARCHAR(30) NOT NULL,
    Budget FLOAT,

    PRIMARY KEY (ProjectCode),
    FOREIGN KEY (ClubID, GroupID) REFERENCES Club_Group(ClubID, GroupID)
);

CREATE TABLE Member_Joins_Group (
    MemberID INT,
    ClubID INT,
    GroupID INT,

    PRIMARY KEY (MemberID, ClubID, GroupID),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (ClubID, GroupID) REFERENCES Club_Group(ClubID, GroupID)
);

CREATE TABLE Member_WorksOn_Project (
    MemberID INT,
    ProjectCode INT,
    MemberPortion NUMERIC,

    PRIMARY KEY (MemberID, ProjectCode),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (ProjectCode) REFERENCES Project(ProjectCode)
);

CREATE TABLE Alumnus_WorkHistory (
    MemberID INT,
    Company VARCHAR(30),
    Position VARCHAR(15),
    StartDate DATE,
    EndDate DATE,

    PRIMARY KEY (MemberID),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);