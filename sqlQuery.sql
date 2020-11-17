CREATE TABLE Player(
	id INT PRIMARY KEY,
	name NVARCHAR(50),
	role VARCHAR(5),
	teamID INT,
	penalty INT,
)

CREATE TABLE Coach(
	id INT PRIMARY KEY,
	name nvarchar(50),
	teamID INT
)

CREATE TABLE Team(
	id INT PRIMARY KEY,
	name NVARCHAR(50),
	playerID INT,
	coachID INT,
	FOREIGN KEY (playerID) REFERENCES Player(id),
	FOREIGN KEY (coachID) REFERENCES Coach(id)
)

CREATE TABLE Season(
	year INT PRIMARY KEY
)
CREATE TABLE Match(
	ID INT PRIMARY KEY,
	Season int,
	Team1 int,
	Team2 int,
	FOREIGN KEY (Team1) REFERENCES Team(ID),
	FOREIGN KEY (Team2) REFERENCES Team(ID)
)

CREATE TABLE Penalty(
	id INT PRIMARY KEY,
	playerID INT,
	reason NVARCHAR(100),
	fine INT,
	FOREIGN KEY (playerID) REFERENCES Player(ID)
)
