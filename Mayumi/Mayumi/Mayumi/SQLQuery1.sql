CREATE TABLE Room (
    roomId INT PRIMARY KEY IDENTITY(200,1),
    room_num INT NOT NULL,
    maxGuest INT NOT NULL,
    floor_num INT NOT NULL,
    roomClassId INT NOT NULL,
    imageURL NVARCHAR(255), 
    FOREIGN KEY (roomClassId) REFERENCES RoomClass(roomClassId)
);

CREATE TABLE Member (
    memId INT PRIMARY KEY IDENTITY(2000,1),
    fn NVARCHAR(64) NOT NULL,
    sn NVARCHAR(64) NOT NULL,
    email NVARCHAR(64) NOT NULL,
    phone NVARCHAR(16) NOT NULL,
    password NVARCHAR(128) NOT NULL,
);

CREATE TABLE Booking (
    bookId INT PRIMARY KEY IDENTITY(1000,1),
    checkIn DATETIME NOT NULL,
    checkOut DATETIME NOT NULL,
    num_adults INT NOT NULL,
    num_children INT NOT NULL,
    totalGuests INT NOT NULL,
    nights INT NOT NULL,
);

CREATE TABLE RoomClass (
    roomClassId INT PRIMARY KEY IDENTITY(300,1),
    className NVARCHAR(50) NOT NULL,
    roomPrice DECIMAL(10,2) NOT NULL
);

CREATE TABLE BookingRoom (
    bookingRoomId INT PRIMARY KEY IDENTITY(400,1),
    bookId INT NOT NULL,
    roomId INT NOT NULL,
    FOREIGN KEY (bookId) REFERENCES Booking(bookId),
    FOREIGN KEY (roomId) REFERENCES Room(roomId)
);

CREATE TABLE Feature (
    featureId INT PRIMARY KEY IDENTITY(3000,1),
    featureName NVARCHAR(50) NOT NULL,
    featurePrice DECIMAL(10,2) NOT NULL
);

CREATE TABLE BookingFeatures (
    bookingFeatureId INT PRIMARY KEY IDENTITY(800,2),
    bookId INT NOT NULL,
    featureId INT NOT NULL,
    quantity INT DEFAULT 1,
    FOREIGN KEY (bookId) REFERENCES Booking(bookId),
    FOREIGN KEY (featureId) REFERENCES Feature(featureId) 
);

DROP TABLE RoomClassFeature;
DROP TABLE Feature;
EXEC sp_rename 'RoomFeature', 'Feature';

INSERT INTO RoomClass (className, roomPrice) VALUES ('Deluxe Double Room', 180.00), ('Deluxe Triple Room', 190.00), ('Suite', 250.00), ('Deluxe Family Room', 220.00);

INSERT INTO Room (room_num, maxGuest, floor_num, roomClassId, imageURL)
VALUES 
(201, 2, 2, 300, 'images/DeluxeRoom.png'),
(301, 3, 3, 301, 'images/DeluxeTripleRoom.png'),
(401, 4, 4, 303, 'images/FamilyRoom.png'),
(501, 2, 5, 302, 'images/Suite.png');

INSERT INTO Feature (featureName, featurePrice) VALUES ('Early Check In', 20.00), ('Late Check Out', 20.00), ('Birthday Surprise', 35.00), ('Romance Bundle', 35.00);

UPDATE booking 
SET totalGuests = 0 
WHERE totalGuests IS NULL;

SELECT r.roomId, r.room_num, r.maxGuest, rc.className, rc.roomPrice, r.imageURL
FROM Room r
JOIN RoomClass rc ON r.roomClassId = rc.roomClassId
WHERE r.maxGuest >= @totalGuests  
AND r.roomId NOT IN (
    SELECT br.roomId
    FROM BookingRoom br
    JOIN Booking b ON br.bookId = b.bookId
    WHERE (@checkin BETWEEN b.checkIn AND b.checkOut)
       OR (@checkout BETWEEN b.checkIn AND b.checkOut)
       OR (b.checkIn BETWEEN @checkin AND @checkout)  
       OR (b.checkOut BETWEEN @checkin AND @checkout)
);

ALTER TABLE Member
ADD description NVARCHAR(255);

ALTER TABLE Feature
ADD featureImage NVARCHAR(255);


UPDATE Feature
SET featurePrice = '60.00'
WHERE featureName = 'Romance Bundle';

UPDATE Feature
SET description = 'Would you like to sleep in? We can offer you a special rate on a late check out by 13:00.'
WHERE featureName = 'Late Check Out';


UPDATE Feature
SET featureImage = 'images/RomanceBundle.png'
WHERE featureName = 'Romance Bundle';

ALTER TABLE Booking
ADD memId INT;

ALTER TABLE Booking 
ADD CONSTRAINT fk_booking_member
FOREIGN KEY (memId)
REFERENCES Member(memId);

CREATE TABLE BookingFeature (
    bookFeatureId INT PRIMARY KEY,
    bookId INT,
    featureId INT,  
    totalFeaturePrice DECIMAL(10, 2), 
    FOREIGN KEY (bookId) REFERENCES Booking(bookId),
    FOREIGN KEY (featureId) REFERENCES Feature(featureId)
);

ALTER TABLE Booking
ADD totalPrice DECIMAL(10,2);

ALTER TABLE BookingRoom
DROP CONSTRAINT FK__BookingRo__featu__14270015;

ALTER TABLE BookingRoom
DROP COLUMN featureId;

ALTER TABLE BookingFeature
DROP CONSTRAINT PK_BookingFeature; 

INSERT INTO Room (room_num, maxGuest, floor_num, roomClassId, imageURL)
VALUES 
(202, 2, 2, 300, 'images/DeluxeRoom.png'),
(302, 3, 3, 301, 'images/DeluxeTripleRoom.png'),
(402, 4, 4, 303, 'images/FamilyRoom.png'),
(502, 2, 5, 302, 'images/Suite.png');