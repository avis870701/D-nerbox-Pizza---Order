CREATE TABLE memberReserve(
	account nvarchar(20) Not null PRIMARY KEY,
	mName nvarchar(20) Not null,
	password nvarchar(18) Not null,
	mEmail nvarchar(50) Not null,
	mPhone nvarchar(10) Not null,
	birthday date,
	permissions int Not null
);
CREATE TABLE reservation (
    reservationId INT PRIMARY KEY IDENTITY,
    account nvarchar(20) NOT NULL,
    reservationName nvarchar(50) NOT NULL,
	phone nvarchar(50) NOT NULL,
    numberOfPeople INT CHECK (numberOfPeople > 0) NOT NULL,
    reservationTime nvarchar(50) NOT NULL,
    reservationDate date NOT NULL,
	reservationStatus INT NOT NULL,
	note nvarchar(200),
	checkInStatus INT NOT NULL,

    FOREIGN KEY (account) REFERENCES memberReserve(account)
);

select * from [reservation]
select * from memberReserve

DROP TABLE "reservation";
DROP TABLE memberreserve;



INSERT INTO memberReserve
VALUES ('ispanTeam7','team1','ispanTeam1','h60915@gmail.com','0912345678','2020-01-01','1'),
	   ('ispanTeam2','team2','ispanTeam2','ispanTeam2@gmail.com','0912345678','2021-02-02','1'),
	   ('ispanTeam3','team3','ispanTeam3','ispanTeam3@gmail.com','0912345678','2022-03-03','1'),
	   ('ispanTeam4','team4','ispanTeam4','ispanTeam4@gmail.com','0912345678','2023-04-04','1'),
	   ('ispanTeam5','team5','ispanTeam5','ispanTeam5@gmail.com','0912345678','2024-05-05','1'),
	   ('ispanTeam6','team6','ispanTeam6','ispanTeam6@gmail.com','0912345678','2025-06-06','2');

INSERT INTO "reservation" ("account", "numberOfPeople", "reservationName","phone","reservationTime", reservationDate  ,reservationStatus,"note","checkInStatus")
VALUES ('ispanTeam2', '3','王曉au/666明','0919807906', '12:30','2024-04-22','1', '3','1');
