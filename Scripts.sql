-- SELECT

SELECT * 
FROM COACH
ORDER BY yearExperience ASC


--INNER JOIN
SELECT p.*, t.name AS [Team]
FROM Player p INNER JOIN Contract a ON p.id = a.PlayerID INNER JOIN Team t ON a.TeamID = t.id

--AGGREGATE FUNCTIONS
-- count number of player in each team
SELECT t.name AS [Team], COUNT(p.id) AS [Number Of Player]
FROM Player p INNER JOIN Contract a ON p.id = a.PlayerID INNER JOIN Team t ON a.TeamID = t.id
GROUP BY t.name

--GROUP BY and HAVING clauses
-- Select team with more than one player
SELECT t.name AS [Team], COUNT(p.id) AS [Number Of Player]
FROM Player p INNER JOIN Contract a ON p.id = a.PlayerID INNER JOIN Team t ON a.TeamID = t.id
GROUP BY t.name
HAVING COUNT(p.id) > 1

----sub-query as relation
-- Select player not in SBTC
SELECT p.*
FROM Player p INNER JOIN Contract c ON p.id = c.PlayerID
WHERE c.TeamID NOT IN (
	SELECT c.TeamID
	FROM Contract c INNER JOIN Team t on c.TeamID = t.id
	WHERE t.name LIKE 'SBCT'
)


 --sub-query in WHERE Clause
 -- select team that sign new player first in 2018
 SELECT t.name
 FROM Team t INNER JOIN Contract c ON t.id = c.TeamID
 WHERE c.DateSign = (
						SELECT TOP 1 c.DateSign
						FROM Contract c
						WHERE YEAR(c.DateSign) = 2018
						ORDER BY c.DateSign DESC
)

-- A query that uses partial matching in the WHERE clause
-- Select player where name contain the letter 'E'
SELECT *
FROM Player
WHERE name LIKE '%e%'

-- A query that use self join 
SELECT	id,
		CONVERT(varchar(2), monthBegin) + '-' + CONVERT(varchar(4), year) AS [Begin Time], 
		CONVERT(varchar(2), monthEnd) + '-' + CONVERT(varchar(4), year) AS [End Time]
FROM Season

GO
-- Procedure to count player in team
CREATE PROC proc_count_player
(
	@team nvarchar(100),
	@count int output
)
AS
BEGIN
		set @count =
	(
		SELECT COUNT(p.id) AS [Number Of Player]
		FROM Player p INNER JOIN Contract a ON p.id = a.PlayerID INNER JOIN Team t ON a.TeamID = t.id
		GROUP BY t.name
		HAVING t.name = @team
	)
END

GO
-- Trigger to print out 
CREATE TRIGGER Trig
ON Coach
FOR INSERT
AS
BEGIN 

    Select * from inserted

END
