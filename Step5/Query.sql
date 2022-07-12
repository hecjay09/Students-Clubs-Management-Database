-- The entire code works perfectly in both MSSQL Server and MySQL DB.

/* --------------------------------------------------------------------------------------------------
1. A view of all members with their corresponding club and group 
(CREATE VIEW, and update other related SQL to use this view)
----------------------------------------------------------------------------------------------------*/


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
6. Display member who has join more than one group.
----------------------------------------------------------------------------------------------------*/
SELECT m.MemberID, m.FirstName, m.LastName, c.ClubName, cg.GroupName
FROM Member m, Member_Joins_Group mjg, Club_Group cg, Club c
WHERE m.MemberID = mjg.MemberID
AND mjg.ClubID = cg.ClubID
AND mjg.GroupID = cg.GroupID
AND cg.ClubID = c.ClubID
AND m.MemberID IN (
    SELECT MemberID
    FROM Member_Joins_Group
    GROUP BY MemberID
    HAVING COUNT(GroupID) > 1
);


/* --------------------------------------------------------------------------------------------------
7. Display the group information and the events which are held on either Building 'A' or Building 'T'
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


/* --------------------------------------------------------------------------------------------------
9. Display all the groups and whether they are managing any project.
----------------------------------------------------------------------------------------------------*/
SELECT c.ClubName, cg.GroupName, p.ProjectCode, p.ProjectName
FROM Club c
INNER JOIN Club_Group cg ON cg.ClubID = c.ClubID
LEFT JOIN Project p ON p.ClubID = cg.ClubID AND p.GroupID = cg.GroupID;


/* --------------------------------------------------------------------------------------------------
10. Display member who does not work on any funded project 
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


/* --------------------------------------------------------------------------------------------------
13. Display alumnus that has more than 6 months working experience.
----------------------------------------------------------------------------------------------------*/


/* --------------------------------------------------------------------------------------------------
14. Past events (CREATE VIEW)
----------------------------------------------------------------------------------------------------*/


/* --------------------------------------------------------------------------------------------------
15. An alumnus quits a job (UPDATE enddate)
----------------------------------------------------------------------------------------------------*/


/* --------------------------------------------------------------------------------------------------
16. Add an existing member to a new group. (UPDATE)
----------------------------------------------------------------------------------------------------*/


/* --------------------------------------------------------------------------------------------------
17. Raise the member's portion on specific project. (UPDATE)
----------------------------------------------------------------------------------------------------*/


/* --------------------------------------------------------------------------------------------------
18. A group cancels an event (DELETE)
----------------------------------------------------------------------------------------------------*/



/* --------------------------------------------------------------------------------------------------
19. Delete a project, related members records are also deleted (DELETE)
----------------------------------------------------------------------------------------------------*/



/* --------------------------------------------------------------------------------------------------
20. Delete a member that doesn't work on any project (DELETE)
----------------------------------------------------------------------------------------------------*/

