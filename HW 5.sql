USE ALee_2019

GO
/*drop tables*/
DROP TABLE IF EXISTS RoomStay;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS GuestLevel;
DROP TABLE IF EXISTS GuestClass;
DROP TABLE IF EXISTS Counts;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Guest;
DROP TABLE IF EXISTS GuestStatus;
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS ServiceStatus;
DROP TABLE IF EXISTS SuppliesReceived;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS Tavern;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Roles;


CREATE TABLE Roles(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	Description VARCHAR(MAX)

);
CREATE TABLE Location(
	ID INT identity Primary Key,
	Name VARCHAR(250)
);
CREATE TABLE Users(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	RoleID INT FOREIGN KEY REFERENCES Roles(ID)
);

/* Created tables */
CREATE TABLE Tavern(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	LocationID INT FOREIGN KEY REFERENCES Location(ID),
	OwnerID INT FOREIGN KEY REFERENCES Users(ID)
);

CREATE TABLE Supplies(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	Unit VARCHAR(50),
);
CREATE TABLE SuppliesReceived(
	ID INT identity Primary Key,
	Date DATETIME,
	QTY DECIMAL,
	COST DECIMAL,
	SupplyID INT,
	TavernID INT FOREIGN KEY REFERENCES Tavern(ID)
);
CREATE TABLE ServiceStatus(
	ID INT identity Primary Key,
	Name VARCHAR(250)
);

CREATE TABLE Service(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	StatusID INT FOREIGN KEY REFERENCES ServiceStatus(ID),
	TavernID INT FOREIGN KEY REFERENCES Tavern(ID)
);

CREATE TABLE GuestStatus(
	ID INT identity Primary Key,
	Name VARCHAR(100)
);

CREATE TABLE Guest(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	Notes VARCHAR(250),
	Birthdate Date,
	CakeDays date,
	GuestStatusID INT FOREIGN KEY REFERENCES GuestStatus(ID)
);
CREATE TABLE Sales(
	ID INT identity Primary Key,
	ServiceID INT FOREIGN KEY REFERENCES Service(ID),
	GuestID INT FOREIGN KEY REFERENCES Guest(ID),
	Price DECIMAL,
	PurchaseDate DATE,
	Amount DECIMAL,
	TavernID INT FOREIGN KEY REFERENCES Tavern(ID)
);
CREATE TABLE Counts(
	SupplyID INT identity Primary Key,
	Date Date,
	TavernID INT FOREIGN KEY REFERENCES Tavern(ID),
	Count DECIMAL
);
CREATE TABLE GuestClass(
	ID INT identity Primary Key,
	Name VARCHAR(250)
);


CREATE TABLE GuestLevel(
	ID INT identity Primary Key,
	GuestID INT FOREIGN KEY REFERENCES Guest(ID),
	ClassID INT FOREIGN KEY REFERENCES GuestClass(ID),
	Date date
);

/* creates rooms*/
CREATE TABLE Rooms(
	ID INT IDENTITY Primary Key,
	Status VARCHAR(250),
	TavernID INT FOREIGN KEY REFERENCES Tavern(ID)
);

/*Creates rooms stayed in */
CREATE TABLE RoomStay(
	ID INT IDENTITY Primary Key,
	SaleID INT,
	GuestID INT FOREIGN KEY REFERENCES Guest(ID),
	RoomID INT FOREIGN KEY REFERENCES Rooms(ID),
	Date Date,
	Rate DECIMAL
);

/*
/*Adds a primary key to table user*/
ALTER TABLE Users ADD PRIMARY KEY ID;

/*Adds to the supplies table a foreign key that references another table */
ALTER TABLE SuppliesReceived ADD FOREIGN KEY (TavernID) References Tavern(TavernID);
ALTER TABLE SuppliesReceived ADD FOREIGN KEY (SupplyID) References Supplies(SupplyID);

/*Alter a table in some way by dropping the TestDrop text field in SuppliesReceived*/
ALTER TABLE SuppliesReceived DROP COLUMN EmployeeReceiverName;
*/

/* adding data to the tavern */



INSERT INTO Roles
VALUES
('Manager', 'manages the place'),
('greeter', 'greets guest'),
('maid',' cleans the joint'),
('cook', 'cooks food'),
('idiot', 'let people make fun of him');
/*adding data to location*/
INSERT INTO Location
VALUES
('Philly'),
('Springfield'),
('Mt Laurel'),
('Chester'),
('Not Philly
');
/* adding data to the user */

INSERT INTO Users
VALUES
('Joanna', '1'),
('Peter', '2'),
('Steven','3'),
('Rob', '4'),
('Carrie', '5');
INSERT INTO Tavern 
VALUES
('Howl By the Moon','1', '1'),
('Moes Tavern', '2', '2'),
('Miller Ale House', '3','3'),
('Maggies Pub', '4','4'),
('Xfinity', '5','5');

/* adding data to the supplies */
INSERT INTO Supplies
VALUES
('Miller Lite','ounces'),
('Toilet Paper','roll'),
('Mugs','pounds'),
('Water','gallons'),
('Apple Cider Vinegar','jugs');

/* adding data to the supplies being received */

INSERT INTO SuppliesReceived
VALUES
(01/01/2011, 100, 1000,1,2),
(02/02/2012, 50, 500,5,3),
(03/03/2013, 99, 12,2,5),
(04/04/2014, 23, 3,3,2),
(05/05/2015, 4, 66,1,3);

/* adding data to the statuses of the service */
INSERT INTO ServiceStatus
VALUE
('Active'),
('Inactive'),
('Out of Stock'),
('Discontinued');

/* adding data to the services */
INSERT INTO Service
VALUES
('Room Service' , 1,5),
('Chiropractor' , 2,4),
('Television' , 1,3),
('Grub Hub' , 2,2),
('Room Service' , 1,2);

INSERT INTO GuestStatus
VALUE
('Sick'),
('0HP'),
('Alive'),
('Hungry'),
('Excited');

INSERT INTO Guest
VALUES
('Eric','manager',2/12/2012,5/23/1990,2),
('Bruce','CEO',3/31/1990,5/23/2011,3),
('Clark','reporter',5/30/2012,3/03/1930,1),
('Barry','scientist',1/11/2011,2/26/2000,5),
('Dianna','amazon',12/12/2012,10/2010,2);

/* adding data to the sales */

INSERT INTO Sales
VALUE
(3,3,199.99,01/12/2020,199.99,4),
(2,2,67.45,12/11/2000,199.99,5),
(3,5,150.00,05/11/1999,150.0,1),
(5,2,1099.00,01/12/2020,35.0,2),
(1,1,245.02,01/12/2020,245.02,3);


INSERT INTO Counts
VALUE
(3,11/11/2011,5,10.1),
(2,12/12/2012,5,10.1),
(4,03/23/1993,5,10.1),
(1,04/05/1996,5,10.1),
(3,08/14/2019,5,10.1);


INSERT INTO GuestClass
VALUE
('Warrior'),
('Mge'),
('Archer'),
('Thief'),
('Pirate');

INSERT INTO Rooms
VALUES
('Vacant',1),
('Occupied',2),
('Out of Order', 3),
('No longer avaiable',4),
('redesigning',5);

INSERT INTO RoomStay
VALUES
(1,4,5,'03/10/2019',10.00),
(2,1,5,'12/10/2012',1.00),
(3,3,5,'08/10/2015',23.50),
(4,2,5,'04/10/2017',154.00),
(5,2,5,'01/10/2020',999.00);

--1. Write a query to return a “report” of all users and their roles 
SELECT Users.Name,Roles.Description FROM Users Inner Join  Roles ON Users.RoleID = Roles.ID GROUP BY Users.Name;

--2. Write a query to return all classes and the count of guests that hold those classes 
SELECT GuestClass.Name,COUNT(GuestLevel.ID) As GuestCount 
FROM GuestClass Inner JOIN GuestLevel ON GuestClass.ID = GuestLevel.ClassID GROUP BY GuestClass.Name;

--3. Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels. 
--Add a column that labels them beginner (lvl 1-5), intermediate (5-10) and expert (10+) for their classes (Don’t alter the table for this)
SELECT Guest.Name, GuestClass.Name, GuestLevel.ID, 
(CASE 
WHEN GuestLevel.ID BETWEEN 1 AND 5 THEN 'Beginner'
WHEN GuestLevel.ID BETWEEN 6 AND 10 THEN 'Intermediate'
ELSE 'Expert'
END)
FROM Guest Inner JOIN GuestLevel ON Guest.ID = GuestLevel.ID
Inner JOIN GuestClass ON GuestLevel.ID = GuestClass.ID
ORDER BY Guest.Name;

--4. Write a function that takes a level and returns a “grouping” from question 3 (e.g. 1-5, 5-10, 10+, etc)
IF OBJECT_ID (N'dbo.getLevelGroup', N'FN') IS NOT NULL      
DROP FUNCTION getLevelGroup;  
GO  
CREATE FUNCTION dbo.getLevelGroup(@GuestLevel INT)  
RETURNS VARCHAR(100) AS BEGIN
RETURN
(CASE
WHEN @GuestLevel BETWEEN 1 AND 5 THEN 'Beginner'
WHEN @GuestLevel BETWEEN 6 AND 10 THEN 'Intermediate'
ELSE 'Expert'
END);

--5. Write a function that returns a report of all open rooms (not used) on a particular day (input) and which tavern they belong to 
IF OBJECT_ID (N'dbo.OpenRooms', N'FN') IS NOT NULL      
DROP FUNCTION OpenRooms;  
GO
CREATE FUNCTION dbo.OpenRooms(@RoomOpen Date)  
RETURNS TABLE AS BEGIN
RETURN(
SELECT Rooms.ID, Tavern.Name FROM RoomStay 
Inner Join Rooms ON RoomStay.RoomID = Rooms.ID
Inner Join Tavern ON Rooms.TavernID = Tavern.ID
WHERE RoomStay.Date != @RoomOpen
);
--6. Modify the same function from 5 to instead return a report of prices in a range (min and max prices) - Return Rooms and their taverns based on price inputs
IF OBJECT_ID (N'dbo.PriceRange', N'FN') IS NOT NULL      
DROP FUNCTION PriceRange;  
GO
CREATE FUNCTION dbo.PriceRange(@MinPrice INT, @MaxPrice INT)  
RETURNS TABLE AS 
RETURN(
SELECT Rooms.ID,RoomStay.Rate,Tavern.Name FROM RoomStay
Inner Join Rooms ON RoomStay.ID = Rooms.ID
Inner Join Tavern ON Rooms.TavernID = Tavern.ID
WHERE RoomStay.Rate BETWEEN @MinPrice AND @MaxPrice
);
--7. Write a command that uses the result from 6 to Create a Room in another tavern that undercuts (is less than) the cheapest room by a penny - thereby making the new room the cheapest one
-- Probably not doing this right cuz im getting denied right here,I'll keep thinking about this part on getting the result
SELECT * FROM dbo.PriceRange WHERE @MinPrice BETWEEN 1.00 AND 3.00; 
--would've added to rooms
INSERT INTO Rooms
VALUES ('Occupied', 6);
--would've added to taverns
INSERT INTO Tavern
VALUES('Another Tavrern', 3,6);
