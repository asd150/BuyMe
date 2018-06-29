DROP DATABASE IF EXISTS BuyMe;
CREATE DATABASE IF NOT EXISTS BuyMe;
USE BuyMe;

CREATE TABLE T_Account (
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	UserName VARCHAR(50) NOT NULL,
	Email VARCHAR(50) NOT NULL,
    Password1 VARCHAR(50) NOT NULL,
    Password2 VARCHAR(50) NOT NULL,
	EndUser BOOLEAN NOT NULL DEFAULT 0,
	Admin BOOLEAN NOT NULL DEFAULT 0,
	CustomerRep BOOLEAN NOT NULL DEFAULT 0,
	PRIMARY KEY(UserName)
);

CREATE TABLE T_EndUser (
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
UserName VARCHAR(50) NOT NULL,
Email VARCHAR(50) NOT NULL,
PRIMARY KEY(UserName),
FOREIGN KEY (UserName) REFERENCES T_Account(UserName) ON DELETE CASCADE ON UPDATE CASCADE
);

delimiter #
CREATE TRIGGER TR_NewUserRep
AFTER INSERT ON T_Account
FOR EACH ROW
BEGIN
IF NEW.CustomerRep THEN
	INSERT INTO T_CustomerRep(FirstName, LastName, UserName, Password1, Email) VALUES (new.FirstName, new.LastName, new.UserName, new.Password1, new.Email);
END IF;
END#

CREATE TRIGGER TR_NewUser 
AFTER INSERT ON T_EndUser
FOR EACH ROW
BEGIN 
	INSERT INTO T_Buyer(UserName) VALUES (new.UserName);
    INSERT INTO T_Seller(UserName) VALUES (new.UserName);
END#

delimiter ;

CREATE TABLE T_Admin (
UserName VARCHAR(50) NOT NULL,
Email VARCHAR(50) NOT NULL,
PRIMARY KEY(UserName),
FOREIGN KEY (UserName) REFERENCES T_Account(UserName) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE T_CustomerRep (
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
UserName VARCHAR(50) NOT NULL,
Password1 VARCHAR(50) NOT NULL,
Email VARCHAR(50) NOT NULL,
PRIMARY KEY(UserName),
FOREIGN KEY (UserName) REFERENCES T_Account(UserName) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE T_Buyer (
BuyerId INT NOT NULL AUTO_INCREMENT,
UserName VARCHAR(50) NOT NULL,
PRIMARY KEY (BuyerId, UserName),
FOREIGN KEY (UserName) REFERENCES T_EndUser(UserName) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE T_Seller (
SellerID INT NOT NULL AUTO_INCREMENT,
UserName VARCHAR(50) NOT NULL,
PRIMARY KEY (SellerId, UserName),
FOREIGN KEY (UserName) REFERENCES T_EndUser(UserName) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE T_Product (
PID INT AUTO_INCREMENT NOT NULL,
StartBid FLOAT NOT NULL,
ReservePrice FLOAT default 0,
Photo LONGTEXT NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
ProductName VARCHAR(50) NOT NULL,
Description VARCHAR(255) NOT NULL,
BuyNow float NOT NULL,
UserName VARCHAR(50) NOT NULL,  
IsActive BOOLEAN NOT NULL DEFAULT 1,
PRIMARY KEY (PID, UserName),
FOREIGN KEY (UserName) REFERENCES T_Seller(UserName) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE T_Bids (
BidId INT auto_increment,
BuyerId INT NOT NULL,
PID INT NOT NULL,
Amount FLOAT NOT NULL,
AutomaticBiding BOOLEAN NOT NULL DEFAULT 0,
SeceretAutoBidingAmout FLOAT,
TimeStamp datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
IsActive BOOLEAN NOT NULL DEFAULT 1,
PRIMARY KEY (BidId, PID, BuyerId),
FOREIGN KEY (BuyerId) REFERENCES T_Buyer(BuyerId) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (PID) REFERENCES T_Product(PID) ON DELETE CASCADE ON UPDATE CASCADE
);

delimiter #
CREATE TRIGGER TR_Bidder 
AFTER INSERT ON T_Bids
FOR EACH ROW
BEGIN 
	INSERT INTO T_PostBid(BuyerId, PID, BidId) VALUES (new.BuyerId, new.PID, new.BidId);
	INSERT INTO T_Ratings(BidId, BuyerId, PID) VALUES (new.BidId, new.BuyerId, new.PID);

END#
delimiter ;

CREATE TABLE T_PostBid (
BidId INT NOT NULL,
BuyerId INT,
PID INT,
primary key(BidId, PID, BuyerId),
FOREIGN KEY (BidId) REFERENCES T_Bids(BidId) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (PID) REFERENCES T_Product(PID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (BuyerId) REFERENCES T_Buyer(BuyerId) ON DELETE CASCADE ON UPDATE CASCADE
);


DELIMITER $$
CREATE TRIGGER bidderNotBiddingItempTheyPosted
BEFORE INSERT ON T_Bids
FOR EACH ROW BEGIN
    IF EXISTS(SELECT PID 
              FROM T_Product P, T_Seller S
              WHERE NEW.PID = P.PID AND
                    NEW.BuyerId = S.SellerID AND
                    P.UserName = S.UserName) THEN
        SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'Seller Can not buy the item they post for sell';
    END IF;
END$$
DELIMITER ;

CREATE TABLE T_Clothes (
PID INT NOT NULL,
Brand VARCHAR(50) NOT NULL,
Size VARCHAR(50) NOT NULL,
Color VARCHAR(50) NOT NULL,
Pants BOOLEAN NOT NULL DEFAULT 0,
Shirt BOOLEAN NOT NULL DEFAULT 0,
T_Shirt BOOLEAN NOT NULL DEFAULT 0,
PRIMARY KEY (PID),
FOREIGN KEY (PID) REFERENCES T_Product(PID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE T_Electronics (
PID INT NOT NULL,
Brand VARCHAR(50) NOT NULL,
Model VARCHAR(50) NOT NULL,
Color VARCHAR(50) NOT NULL,
TV BOOLEAN not null default 0,
Cellphone BOOLEAN not null default 0,
Computer BOOLEAN not null default 0,
PRIMARY KEY (PID),
FOREIGN KEY (PID) REFERENCES T_Product(PID) ON DELETE CASCADE ON UPDATE CASCADE
);

delimiter #
CREATE TRIGGER TR_Alert
AFTER DELETE ON T_Bids
FOR EACH ROW
BEGIN 
	INSERT INTO T_Alert(PID, BuyerId, BidId, Message) VALUES (OLD.PID, OLD.BuyerId, OLD.BidId, 'Your Bid Has Beeen Removed As Requested');
END#
delimiter ;

CREATE TABLE T_Ratings(
PID INT NOT NULL,
BidId INT NOT NULL,
BuyerId INT NOT NULL,
Rating INT NOT NULL DEFAULT 0,
PRIMARY KEY (PID, BuyerId, BidId),
FOREIGN KEY (PID) REFERENCES T_Product(PID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (BuyerId) REFERENCES T_Buyer(BuyerId) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (BidId) REFERENCES T_Bids(BidId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE T_Sales (
PID INT,
BuyerId INT,
FOREIGN KEY (PID) REFERENCES T_Product(PID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (BuyerId) REFERENCES T_Buyer(BuyerId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE T_QAPage (
Question VARCHAR (255),
Answer VARCHAR (255),
UserName VARCHAR(50)
);

CREATE TABLE T_Alert (
AlertId INT auto_increment,
Message VARCHAR(250),
BuyerId INT,
BidId INT ,
PID INT ,
UserName varchar(50),
PRIMARY KEY (AlertId)
);

CREATE TABLE T_Awarded (
PID INT(11) NOT NULL,
BuyerId INT(11) NOT NULL,
SellerId INT(11) NOT NULL,
BidId INT(11) NOT NULL default 0,
SoldAt datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
Rating INT(11) ,
BuyerName VARCHAR(50),
SellerName VARCHAR(50),
PRIMARY KEY (PID, BuyerId, BidId),
FOREIGN KEY (BuyerId) REFERENCES T_Buyer(BuyerId) ON DELETE CASCADE ON UPDATE CASCADE

);

INSERT INTO T_Account (
	FirstName,
	LastName,
	UserName,
	Email,
    Password1,
    Password2,
	EndUser,
	Admin,
	CustomerRep    
) VALUES ('Tom', 'Jose', 'tom5', 'Tom5@gmail.com', "1234","1234", 1, 0, 0),
('John', 'Gow', 'john123', 'john123@gmail.com', "abcd","abcd", 1, 0, 0),
('Jane', 'Doe', 'jane1989', 'jane1989@gmail.com', "abcd12","abcd12", 1, 0, 0),
('kim', 'doe', 'Kim_rutgers', 'kim1992@gmail.com', "rutgers","rutgers", 1, 0, 0),
('Admin', 'Admin', 'Admin', 'Admin@gmail.com', "AD","AD", 0, 1, 0),
('CustomerRep', 'CustomerRep', 'CP', 'CustomerRep@gmail.com', "CP","CP", 0, 0, 1),
('CustomerRep1', 'CustomerRep', 'CP1', 'CustomerRep1@gmail.com', "CP1","CP1", 0, 0, 1),
('CustomerRep2', 'CustomerRep', 'CP2', 'CustomerRep2@gmail.com', "CP2","CP2", 0, 0, 1);

INSERT INTO T_EndUser (
FirstName,
LastName,
UserName,
Email
)VALUES ('Tom', 'Jose', 'tom5', 'Tom5@gmail.com'),
('John', 'Gow', 'john123', 'john123@gmail.com'),
('Jane', 'Doe', 'jane1989', 'jane1989@gmail.com'),
('kim', 'doe', 'Kim_rutgers', 'kim1992@gmail.com');

INSERT INTO T_QAPage (
Question,
Answer,
UserName
)VALUES ('I can not login?', 'Enter your valid UserName and Password on main page if you already have account. Or reset password', ''),
('How to sign up?', 'Go to main page and click sign up and enter all the fields', ''),
('How do CustomerRep Sign in?','They can also sign in from main page with username and passoword',''),
('How do CustomerRep create account?','Their account is created by admin',''),
('I want to delete my auctions', '', 'jane1989'),
('I want to remove my bid delete bid','', 'jane1989');