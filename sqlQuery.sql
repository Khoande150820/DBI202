create database assignment
use assignment

CREATE TABLE Team(
	id INT PRIMARY KEY,
	name NVARCHAR(50),
	playerID INT,
	coachID INT,
)


CREATE TABLE Player(
	id INT PRIMARY KEY,
	name NVARCHAR(50),
	role VARCHAR(5),
	teamID INT,
	penalty INT,
	FOREIGN KEY (teamID) REFERENCES Team(ID)
)

CREATE TABLE Coach(
	id INT PRIMARY KEY,
	name nvarchar(50),
	teamID INT,
	FOREIGN KEY (teamID) REFERENCES Team(ID)
)


CREATE TABLE Season(
	year INT PRIMARY KEY,
	teamID int,
	teamPoint int,
	MatchID int,
	FOREIGN KEY (teamID) REFERENCES Team(id)
)

CREATE TABLE Match(
	ID INT PRIMARY KEY,
	Date date,
	Team1 int,
	Team2 int,
	winner int,
	Season int,
	FOREIGN KEY (Season) REFERENCES Season(Year)
)


CREATE TABLE Penalty(
	id INT PRIMARY KEY,
	playerID INT,
	reason NVARCHAR(100),
	fine INT,
	FOREIGN KEY (playerID) REFERENCES Player(ID)
)