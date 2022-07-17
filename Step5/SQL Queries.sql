-- The entire code works perfectly in both MSSQL Server and MySQL DB.
USE ProjectSQL;
/* --------------------------------------------------------------------------------------------------
1. A view of all members with their corresponding club and group 
(CREATE VIEW, and update other related SQL to use this view)

This query is not working on ms sql
----------------------------------------------------------------------------------------------------*/
CREATE VIEW Members_Club_Group AS
SELECT m.MemberID, m.FirstName, m.LastName, m.MemberType, c.ClubID, c.ClubName, cg.GroupID, cg.GroupName
FROM Member m, Member_Joins_Group mjg, Club c, Club_Group cg
WHERE mjg.MemberID = m.MemberID
AND c.ClubID = mjg.ClubID
AND cg.ClubID = mjg.ClubID AND cg.GroupID = mjg.GroupID
ORDER BY MemberID;


/* --------------------------------------------------------------------------------------------------
2. Display the information of all the clubs and corresponding groups.
----------------------------------------------------------------------------------------------------*/
SELECT c.ClubID, c.ClubName, cg.GroupID, cg.GroupName
FROM Club c INNER JOIN Club_Group cg ON cg.ClubID = c.ClubID;


/* --------------------------------------------------------------------------------------------------
3. Display the group that has the least members
----------------------------------------------------------------------------------------------------*/
SELECT c.ClubID, c.ClubName, cg.GroupID, cg.GroupName
FROM Club c, Club_Group cg, 
(
    SELECT ClubID, GroupID 
    FROM Member_Joins_Group 
    GROUP BY ClubID, GroupID
    HAVING COUNT(MemberID) = 
    (
        SELECT MIN(NoOfMember)
        FROM 
        (
            SELECT ClubID, GroupID, COUNT(MemberID) AS 'NoOfMember'
            FROM Member_Joins_Group
            GROUP BY ClubID, GroupID
        ) g
    )
) gm
WHERE cg.ClubID = c.ClubID
AND gm.ClubID = cg.ClubID 
AND gm.GroupID = cg.GroupID;


/* --------------------------------------------------------------------------------------------------
4. Display all members who are leading a club.
----------------------------------------------------------------------------------------------------*/
SELECT m.MemberID, m.FirstName, m.LastName, m.MemberType, c.ClubName
FROM Member m
LEFT JOIN Club c ON c.LeadMemberID = m.MemberID
WHERE c.ClubName IS NOT NULL;


/* --------------------------------------------------------------------------------------------------
5. Display all members who are neither a lead or head.
----------------------------------------------------------------------------------------------------*/
SELECT DISTINCT m.MemberID, m.FirstName, m.LastName, m.MemberType
FROM Member m
WHERE NOT EXISTS (
    SELECT c.LeadMemberID 
    FROM Club c 
    WHERE c.LeadMemberID = m.MemberID
    UNION
    SELECT cg.HeadMemberID 
    FROM Club_Group cg 
    WHERE cg.HeadMemberID = m.MemberID
);


/* --------------------------------------------------------------------------------------------------
6. Display member who has join more than one group. Using the view Member_Joins_Group previously 
created.
----------------------------------------------------------------------------------------------------*/
SELECT mcg.MemberID, mcg.FirstName, mcg.LastName, mcg.ClubName, mcg.GroupName
FROM Members_Club_Group mcg
WHERE mcg.MemberID IN (
    SELECT MemberID
    FROM Member_Joins_Group
    GROUP BY MemberID
    HAVING COUNT(GroupID) > 1
);


/* --------------------------------------------------------------------------------------------------
7. Display the group information and the events which are held on either Building 'A' or Building 'T'.
----------------------------------------------------------------------------------------------------*/
SELECT c.ClubName, cg.GroupName, e.EventSubject, e.EventDate, e.EventTime, 
    e.RegistrationFee, e.Building, e.Room
FROM Club c
CROSS JOIN Club_Group cg
CROSS JOIN Event e
WHERE e.Building IN ('A', 'T')
AND e.ClubID = cg.ClubID
AND e.GroupID = cg.GroupID
AND cg.ClubID = c.ClubID;


/* --------------------------------------------------------------------------------------------------
8. Display the future events that member can join according to their group.
----------------------------------------------------------------------------------------------------*/
SELECT DISTINCT m.MemberID, m.FirstName, m.LastName, e.EventSubject
FROM Member m, Member_Joins_Group mjg, Event e
WHERE m.MemberID = mjg.MemberID
AND mjg.ClubID = e.ClubID
AND mjg.GroupID = e.GroupID
AND e.EventDate > SYSDATE()
ORDER BY m.MemberID;

/*This version only works on mssql*/
SELECT DISTINCT m.MemberID, m.FirstName, m.LastName, e.EventSubject
FROM Member m, Member_Joins_Group mjg, Event e
WHERE m.MemberID = mjg.MemberID
AND mjg.ClubID = e.ClubID
AND mjg.GroupID = e.GroupID
AND e.EventDate > SYSDATETIME()
ORDER BY m.MemberID; 

/* --------------------------------------------------------------------------------------------------
9. Display all the groups and whether they are managing any project.
----------------------------------------------------------------------------------------------------*/
SELECT c.ClubName, cg.GroupName, p.ProjectCode, p.ProjectName
FROM Club c
INNER JOIN Club_Group cg ON cg.ClubID = c.ClubID
LEFT JOIN Project p ON p.ClubID = cg.ClubID AND p.GroupID = cg.GroupID;


/* --------------------------------------------------------------------------------------------------
10. Display member who does not work on any funded project.
----------------------------------------------------------------------------------------------------*/
SELECT m.MemberID, m.FirstName, m.LastName, m.MemberType
FROM Member m
WHERE NOT EXISTS (
    SELECT DISTINCT MemberID FROM Member_WorksOn_Project WHERE MemberID = m.MemberID
);


/* --------------------------------------------------------------------------------------------------
11. Display the member and project information whose member portion received is below the average of 
all other members that are working in all funded projects.
----------------------------------------------------------------------------------------------------*/
SELECT m.MemberID, m.FirstName, m.LastName, p.ProjectCode, p.ProjectName, mwp.MemberPortion
FROM Member m, Member_WorksOn_Project mwp, Project p
WHERE m.MemberID = mwp.MemberID
AND mwp.ProjectCode = p.ProjectCode
AND mwp.MemberPortion < (
    SELECT AVG(MemberPortion)
    FROM Member_WorksOn_Project
    WHERE ProjectCode = mwp.ProjectCode
    GROUP BY ProjectCode
);


/* --------------------------------------------------------------------------------------------------
12. Display the project budget, its total amount of member portion assigned, and also the remaining 
budget.
----------------------------------------------------------------------------------------------------*/
SELECT p.ProjectCode, p.ProjectName, p.Budget, pb.TotalMemberPortion, 
    (p.Budget - pb.TotalMemberPortion) AS 'RemainingBudget'
FROM Project p
NATURAL JOIN
(
    SELECT ProjectCode, SUM(MemberPortion) AS 'TotalMemberPortion'
    FROM Member_WorksOn_Project
    GROUP BY ProjectCode
) pb;

/*MS SQL Version of the query*/
SELECT p.ProjectCode, p.ProjectName, p.Budget, pb.TotalMemberPortion, 
    (p.Budget - pb.TotalMemberPortion) AS 'RemainingBudget'
FROM Project p
    JOIN
(
    SELECT ProjectCode, SUM(MemberPortion) AS 'TotalMemberPortion'
    FROM Member_WorksOn_Project
    GROUP BY ProjectCode
) pb

    ON p.ProjectCode = pb.ProjectCode;


/* --------------------------------------------------------------------------------------------------
13. Display alumnus that has more than 6 months working experience.
----------------------------------------------------------------------------------------------------*/
-- SELECT FirstName, LastName, Company, StartDate, EndDate, DATEDIFF(MONTH, StartDate, EndDate) AS MonthsWorking
-- FROM Member M JOIN Alumnus_WorkHistory AW ON M.MemberID = AW.AlumnusID
-- WHERE DATEDIFF(MONTH, StartDate, EndDate) > 6;


/* 
Yenny: 
Below work in mysql, please check if either one work in mssql 
Notes: 
1) datediff(MONTH, sd, ed) is not working on MySQL. MySQL can use timestampdiff(Month, sd, ed)

2) I think using datediff or timestampdiff doesn't really reflect on month because it only count 11 monthes for the first member
but it is more realistic if it counts as 12

3) we also need to count those whose work doesn't have end date (null), that means currently working.
According to the test data, all of alumni works more than 6 months, so I suggest to change the description to 
'more than or equal to 12 months' so we can filter out one record

*/
-- So this one is most prefer, dividing the date difference by 30.5 days a month (average day of month in a year) and then round it.
-- see if this works in MSSQL
-- 4 records retrieved
SELECT FirstName, LastName, Company, StartDate, EndDate, MonthsWorking
FROM Member m
JOIN (
    SELECT AlumnusID, Company, StartDate, Enddate, ROUND(DATEDIFF(EndDate, StartDate)/30.5) AS MonthsWorking
    FROM Alumnus_WorkHistory
    WHERE EndDate IS NOT NULL
    UNION
    SELECT AlumnusID, Company, StartDate, Enddate, ROUND(DATEDIFF(SYSDATE(), StartDate)/30.5) AS MonthsWorking
    FROM Alumnus_WorkHistory
    WHERE EndDate IS NULL
) aw
ON m.MemberID = aw.AlumnusID
AND MonthsWorking >= 12;

/*This version only works on ms sql*/
SELECT FirstName, LastName, Company, StartDate, EndDate, MonthsWorking
FROM Member m
JOIN (
    SELECT AlumnusID, Company, StartDate, Enddate, (DATEDIFF(Month, EndDate, StartDate) * -1) AS MonthsWorking
    FROM Alumnus_WorkHistory
    WHERE EndDate IS NOT NULL
    UNION
    SELECT AlumnusID, Company, StartDate, Enddate, (DATEDIFF(Month, SYSDATETIME(), StartDate) * -1) AS MonthsWorking
    FROM Alumnus_WorkHistory
    WHERE EndDate IS NULL
) aw
ON m.MemberID = aw.AlumnusID
AND MonthsWorking >= 12;

SELECT *
FROM Alumnus_WorkHistory;

-- this one using timestampdiff and work in MySQL, but it count 11 months for first member, so it is filtered out
-- 3 records retrieved
-- Hector: maybe just do the query above then?
SELECT FirstName, LastName, Company, StartDate, EndDate, MonthsWorking
FROM Member m
JOIN (
    SELECT AlumnusID, Company, StartDate, Enddate, TIMESTAMPDIFF(MONTH, StartDate, EndDate) AS MonthsWorking
    FROM Alumnus_WorkHistory
    WHERE EndDate IS NOT NULL
    UNION
    SELECT AlumnusID, Company, StartDate, Enddate, TIMESTAMPDIFF(MONTH, StartDate, SYSDATE()) AS MonthsWorking
    FROM Alumnus_WorkHistory
    WHERE EndDate IS NULL
) aw
ON m.MemberID = aw.AlumnusID
AND MonthsWorking >= 12;


/* --------------------------------------------------------------------------------------------------
14. A view on past events.
----------------------------------------------------------------------------------------------------*/
-- CREATE VIEW Past_Events AS
-- SELECT EventID, EventSubject, EventDate
-- FROM Event
-- WHERE EventDate < SYSDATETIME();


-- Yenny: 
-- SYSDATETIME not support in MySQL, SYSDATE can return datetime in MySQL using below SQL. Does SYSDATE also
-- show time on MSSQL? Hector: yes, but it is not very important if it does show time or not.
-- SELECT SYSDATE() FROM DUAL;
CREATE VIEW Past_Events AS
SELECT EventID, EventSubject, EventDate
FROM Event
WHERE EventDate < SYSDATE();

/*This query only works on ms sql*/
CREATE VIEW Past_Events AS
SELECT EventID, EventSubject, EventDate
FROM Event
WHERE EventDate < SYSDATETIME();

SELECT *
FROM Past_Events;


/* --------------------------------------------------------------------------------------------------
15. An alumnus quits a job.
----------------------------------------------------------------------------------------------------*/
UPDATE Alumnus_WorkHistory
SET EndDate = '2022-06-15'
WHERE AlumnusID = 10001007 AND WorkID = 1


/* --------------------------------------------------------------------------------------------------
16. Switch a member's current group to a new group.
----------------------------------------------------------------------------------------------------*/
UPDATE Member_Joins_Group
SET GroupID = 2
WHERE MemberID = 10001020 AND ClubID = 2000;


/* --------------------------------------------------------------------------------------------------
17. Every member that is working on COMP001 project, their MemberPortion got raised by $250.
----------------------------------------------------------------------------------------------------*/
UPDATE Member_WorksOn_Project
SET MemberPortion = MemberPortion + 250.00
WHERE ProjectCode = 'COMP001'


/* --------------------------------------------------------------------------------------------------
18. A group cancels an event.
----------------------------------------------------------------------------------------------------*/
DELETE FROM Event
WHERE EventID = 203;


/* --------------------------------------------------------------------------------------------------
19. Delete a project, related members records are also deleted.
----------------------------------------------------------------------------------------------------*/
DELETE FROM Project
WHERE ProjectCode = 'SPT001'


/* --------------------------------------------------------------------------------------------------
20. Delete all member that doesn't work on any project.
----------------------------------------------------------------------------------------------------*/
DELETE M
FROM Member M LEFT JOIN Member_WorksOn_Project MWP ON M.MemberID = MWP.MemberID
WHERE ProjectCode IS NULL;

