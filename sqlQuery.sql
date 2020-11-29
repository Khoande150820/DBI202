IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'AssignmentDBI')
BEGIN
	ALTER DATABASE [AssignmentDBI] SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE [AssignmentDBI] SET ONLINE;
	DROP DATABASE [AssignmentDBI];
END
GO

CREATE DATABASE [AssignmentDBI]
GO

USE [AssignmentDBI]
GO

CREATE TABLE Player(
	id CHAR(8) PRIMARY KEY NOT NULL CHECK(id LIKE '[A-Z][A-Z][A-Z]P[0-9][0-9][0-9][0-9]'),
	name NVARCHAR(100),
	gender CHAR(1)  DEFAULT 'M' CHECK(Gender IN('F','M')) NOT NULL,
	role NVARCHAR(10)
)

CREATE TABLE Coach(
	id CHAR(8) PRIMARY KEY NOT NULL CHECK(id LIKE 'KORC[0-9][0-9][0-9][0-9]'),
	name NVARCHAR(100),
	gender CHAR(1)  DEFAULT 'M' CHECK(Gender IN('F','M')) NOT NULL,
	yearExperience INT,
)

CREATE TABLE Team(
	id INT PRIMARY KEY,
	name NVARCHAR(100),
	Owner NVARCHAR(100),
	Status BIT,
	coachId CHAR(8) UNIQUE NOT NULL
	FOREIGN KEY (coachId) REFERENCES Coach(id)
)

CREATE TABLE Season(
	id INT PRIMARY KEY,
	year INT NOT NULL,
	monthBegin INT CHECK (monthBegin BETWEEN 1 AND 12),
	monthEnd INT CHECK (monthEnd BETWEEN 1 AND 12)
)

CREATE TABLE Contract(
	PlayerID CHAR(8),
	TeamID INT,
	DateSign DATE,
	effectiveYear INT,
	FOREIGN KEY (PlayerID) REFERENCES Player(id),
	FOREIGN KEY (TeamID) REFERENCES Team(id),
	PRIMARY KEY (PlayerID, TeamID)
)

CREATE TABLE Achievement(
	TeamID INT,
	SeasonID INT,
	Point INT,
	FOREIGN KEY (TeamID) REFERENCES Team(id),
	FOREIGN KEY (SeasonID) REFERENCES Season(id),
	PRIMARY KEY (TeamID, SeasonID)
)

