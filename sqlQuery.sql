

CREATE TABLE Player(
	id CHAR(8) PRIMARY KEY NOT NULL CHECK(id LIKE 'KORP[0-9][0-9][0-9][0-9]'),
	name NVARCHAR(100),
	gender CHAR(1)  DEFAULT 'M' CHECK(Gender IN('F','M')) NOT NULL,
	role NVARCHAR(10)
)

CREATE TABLE Coach(
	id CHAR(8) PRIMARY KEY NOT NULL CHECK(id LIKE 'KORC[0-9][0-9][0-9][0-9]'),
	name NVARCHAR,
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
	year INT PRIMARY KEY,
	monthBegin INT CHECK (monthBegin BETWEEN 1 AND 12),
	monthEnd INT CHECK (monthEnd BETWEEN 1 AND 12 AND monthEnd>monthBegin)
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
	Point INT
	FOREIGN KEY (TeamID) REFERENCES Team(id),
	FOREIGN KEY (SeasonID) REFERENCES Season(year),
	PRIMARY KEY (TeamID, SeasonID)
)