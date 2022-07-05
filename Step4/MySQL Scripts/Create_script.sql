-- MySQL Version of scripts for creating tables
--
-- The feature constraint check in table 'Member' and 'Event' works in MSSQL but doesn't work in MySQL 
-- because it doesn't support constraint check.
-- The code does not throw error in both MySQL and MSSQL.

USE Project_Gr8_Student_Club;


CREATE TABLE Member (
    MemberID    INT,
    FirstName   VARCHAR(25) NOT NULL,
    LastName    VARCHAR(25) NOT NULL,
    MemberType  CHAR(2)     NOT NULL,

    PRIMARY KEY (MemberID),
    CONSTRAINT cnstr_member_type CHECK (MemberType = 'ST' OR MemberType = 'AL')
);


CREATE TABLE Club (
    ClubID          INT,
    LeadMemberID    INT,
    ClubName        VARCHAR(50) UNIQUE  NOT NULL,

    PRIMARY KEY (ClubID),
    FOREIGN KEY (LeadMemberID) REFERENCES Member(MemberID) ON DELETE SET NULL
);


CREATE TABLE Club_Group (
    ClubID          INT,
    GroupID         INT,
    HeadMemberID    INT,
    GroupName       VARCHAR(50) NOT NULL,

    PRIMARY KEY(ClubID, GroupID),
    FOREIGN KEY(ClubID) REFERENCES Club(ClubID) ON DELETE CASCADE,
    FOREIGN KEY(HeadMemberID) REFERENCES Member(MemberID) ON DELETE SET NULL
);


CREATE TABLE Event (
    EventID         INT,
    ClubID          INT,
    GroupID         INT,
    EventSubject    VARCHAR(50) NOT NULL,
    EventDate       DATE        NOT NULL,
    EventTime       TIME,
    RegistrationFee FLOAT,
    Building        CHAR(1),
    BuildingFloor   INT,
    Room            CHAR(4),

    PRIMARY KEY (EventID), 
    FOREIGN KEY (ClubID, GroupID) REFERENCES Club_Group(ClubID, GroupID) ON DELETE CASCADE,
    CONSTRAINT cnstr_building_floor CHECK (BuildingFloor <= 5)
);


CREATE TABLE Project (
    ProjectCode     VARCHAR(10),
    ClubID          INT,
    GroupID         INT,
    ProjectName     VARCHAR(50) NOT NULL,
    Budget          FLOAT       NOT NULL,

    PRIMARY KEY (ProjectCode),
    FOREIGN KEY (ClubID, GroupID) REFERENCES Club_Group(ClubID, GroupID) ON DELETE SET NULL
);


CREATE TABLE Member_Joins_Group (
    MemberID    INT,
    ClubID      INT,
    GroupID     INT,

    PRIMARY KEY (MemberID, ClubID, GroupID),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (ClubID, GroupID) REFERENCES Club_Group(ClubID, GroupID) ON DELETE CASCADE
);


CREATE TABLE Member_WorksOn_Project (
    MemberID        INT,
    ProjectCode     VARCHAR(10),
    MemberPortion   NUMERIC(10,2),

    PRIMARY KEY (MemberID, ProjectCode),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (ProjectCode) REFERENCES Project(ProjectCode) ON DELETE CASCADE
);


CREATE TABLE Alumnus_WorkHistory (
    AlumnusID   INT,
    WorkID      INT,
    Company     VARCHAR(100)    NOT NULL,
    Position    VARCHAR(50)     NOT NULL,
    StartDate   DATE            NOT NULL,
    EndDate     DATE,

    PRIMARY KEY (AlumnusID, WorkID),
    FOREIGN KEY (AlumnusID) REFERENCES Member(MemberID) ON DELETE CASCADE
);
