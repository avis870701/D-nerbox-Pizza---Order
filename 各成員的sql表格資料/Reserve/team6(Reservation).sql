CREATE TABLE memberAccount(
	maid int identity(1,1) not null primary key,
	mAccount nvarchar(max)  not null ,
	mPassword nvarchar(max) not null,
	permissions int not null,
	hidden int not null
)
CREATE TABLE memberDetail(
	mdid int identity(1,1) primary key,
	fk_maId int references memberAccount(maid) not null,
	mName nvarchar(20),
	mEmail nvarchar(max) not null,
	mPhone nvarchar(10),
	mbirthday date,
	mPhoto nvarchar(max),
	RegistrationDate date not null,
)

CREATE TABLE reservation (
    reservationId INT PRIMARY KEY IDENTITY,/*我和memberAccount的id相同*/
	/*fk_maId int references memberAccount(maid) not null, */
	reservationUuid uniqueidentifier,
    account nvarchar(max) NOT NULL,
    reservationName nvarchar(50) NOT NULL,
	phone nvarchar(50) ,
	mail nvarchar(50) , 
    numberOfPeople INT CHECK (numberOfPeople > 0) NOT NULL,
    reservationTime nvarchar(50) NOT NULL,
    reservationDate date NOT NULL,
	reservationStatus INT NOT NULL,
	note nvarchar(200),
	checkInStatus INT NOT NULL,


	FOREIGN KEY (reservationId) REFERENCES memberAccount(maid)

);

SELECT md.mEmail FROM reservation r JOIN memberAccount ma ON r.reservationid = ma.maid JOIN memberDetail md ON ma.maid = md.fk_maId where reservationDate = '2024-05-08';

INSERT INTO memberAccount(mAccount,mPassword,permissions,hidden)
VALUES('John1001', '123456', '1', '1'),
('Jane9609', '123456', '0', '1'),
('Michael', '123456', '1', '1'),
('Emily', '123456', '1', '1'),
('William', '123456', '1', '1'),
('Sophia', '123456', '1', '1'),
('Matthew', '123456', '1', '1'),
('Olivia', '123456', '1', '1'),
('Daniel', '123456', '1', '1'),
('Rodriguez', '123456', '1', '1'),
('Hernandez', '123456', '1', '1'),
('Isabella', '123456', '1', '1'),
('Charlotte', '123456', '0', '1'),
('Liam2044', '123456', '1', '1'),
('Emma6842', '123456', '1', '1'),
('Zoe48098', '123456', '1', '1'),
('Smith565', '123456', '1', '1'),
('Anderson', '123456', '1', '1'),
('Benjamin', '123456', '1', '1'),
('Thomas691', '123456', '1', '1'),
('Anderson', '123456', '1', '1'),
('Benjamin', '123456', '0', '1'),
('Thomas', '123456', '1', '1'),
('ChloeWhite', '123456', '1', '1'),
('Jackson', '123456', '0', '0'),
('GraceHall', '123456', '1', '1'),
('Thompson', '123456', '1', '1'),
('LilyLewis', '123456', '0', '0'),
('Gabriel', '123456', '1', '1'),
('Zoe48098', '123456', '1', '1'),
('ispan6','123456','1','1');
INSERT INTO memberDetail(fk_maId,mName,mEmail,mPhone,mbirthday,mPhoto,RegistrationDate)
VALUES ('1', 'John Doe', 'john.doe@gmail.com', '1234567890', '1995-08-15','/images/member/user.png', '2004-03-26'),
('2', 'Jane Smith', 'jane.smith@gmail.com', '2345678901', '1990-06-25','/images/member/user.png', '1997-10-20'),
('3', 'Michael Johnson', 'michael.johnson@gmail.com', '3456789012', '1988-12-10','/images/member/user.png', '2001-07-11'),
('4', 'Emily Brown', 'emily.brown@gmail.com', '4567890123', '1992-03-30','/images/member/user.png', '1993-02-05'),
('5', 'William Wilson', 'william.wilson@gmail.com', '5678901234', '1987-11-20','/images/member/user.png', '2018-09-14'),
('6', 'Sophia Lee', 'sophia.lee@gmail.com', '6789012345', '1998-09-05','/images/member/user.png', '1994-06-02'),
('7', 'Matthew Kim', 'matthew.kim@gmail.com', '7890123456', '1993-07-12','/images/member/user.png', '2006-12-30'),
('8', 'Olivia Garcia', 'olivia.garcia@gmail.com', '8901234567', '1996-04-18','/images/member/user.png', '2015-08-01'),
('9', 'Daniel Martinez', 'daniel.martinez@gmail.com', '9012345678', '1991-02-28', '/images/member/user.png','1999-11-25'),
('10', 'Ava Rodriguez', 'ava.rodriguez@gmail.com', '0123456789', '1994-10-08','/images/member/user.png', '2008-04-19'),
('11', 'Ethan Hernandez', 'ethan.hernandez@gmail.com', '0987654321', '1985-05-20', '/images/member/user.png','2012-03-17'),
('12', 'Isabella Lopez', 'isabella.lopez@gmail.com', '9876543210', '1989-01-15', '/images/member/user.png','2019-02-22'),
('13', 'James Perez', 'james.perez@gmail.com', '8765432109', '1997-06-02','/images/member/user.png', '2017-11-08'),
('14', 'Mia Gonzalez', 'mia.gonzalez@gmail.com', '7654321098', '1990-11-25', '/images/member/user.png','2010-10-10'),
('15', 'Alexander Wilson', 'alexander.wilson@gmail.com', '6543210987', '1986-04-05','/images/member/user.png', '1995-04-01'),
('16', 'Charlotte Taylor', 'charlotte.taylor@gmail.com', '5432109876', '1999-08-18', '/images/member/user.png','2000-12-18'),
('17', 'Liam Brown', 'liam.brown@gmail.com', '4321098765', '1993-03-15','/images/member/user.png', '2013-06-09'),
('18', 'Emma Johnson', 'emma.johnson@gmail.com', '3210987654', '1998-01-28','/images/member/user.png', '2014-07-30'),
('19', 'Noah Smith', 'noah.smith@gmail.com', '2109876543', '1994-07-10','/images/member/user.png', '1996-09-05'),
('20', 'Sophie Anderson', 'sophie.anderson@gmail.com', '1098765432', '1990-09-12','/images/member/user.png', '1999-08-12'),
('21', 'Benjamin Martin', 'benjamin.martin@gmail.com', '9876543210', '1997-10-01','/images/member/user.png', '2003-05-28'),
('22', 'Avery Thomas', 'avery.thomas@gmail.com', '8765432109', '1988-12-08', '/images/member/user.png','2011-02-14'),
('23', 'Chloe White', 'chloe.white@gmail.com', '7654321098', '1992-06-30', '/images/member/user.png','2016-10-03'),
('24', 'Jackson Clark', 'jackson.clark@gmail.com', '6543210987', '1995-04-15','/images/member/user.png', '2005-08-27'),
('25', 'Grace Hall', 'grace.hall@gmail.com', '5432109876', '1991-08-24', '/images/member/user.png','2018-04-09'),
('26', 'Lucas Thompson', 'lucas.thompson@gmail.com', '4321098765', '1996-03-05','/images/member/user.png', '2010-12-21'),
('27', 'Aubrey Rodriguez', 'aubrey.rodriguez@gmail.com', '3210987654', '1987-11-03','/images/member/user.png', '1998-11-14'),
('28', 'Lily Lewis', 'lily.lewis@gmail.com', '2109876543', '1994-01-18','/images/member/user.png', '2017-07-26'),
('29', 'Gabriel Martinez', 'gabriel.martinez@gmail.com', '1098765432', '1989-07-27','/images/member/user.png', '2009-09-02'),
('30', 'Zoe Hill', 'zoe.hill@gmail.com', '0987654321', '1993-12-09','/images/member/user.png', '2012-01-05'),
('31','ispan6','ispanteam6@gmail.com','0919807906','1993-12-12','/images/member/user.png','2015-08-08');

INSERT INTO "reservation" ("account", "numberOfPeople", "reservationName","phone","reservationTime", reservationDate  ,reservationStatus,"note","checkInStatus")
VALUES ('Jane9609', '3','測試用1','0919807906', '12:30','2024-05-02','3', '3','0');

/*
reservationStatus
0:店家未確認報到
1:店家已確認報到(客人前一天仍未確認)
2:客人前一天取消
3:客人前一天確定會報到
4:現場客

checkInStatus
0:客人尚未到店
1:客人用餐中
2:用餐完畢客人離開
*/
select * from reservation
select * from memberAccount
select * from memberDetail

drop table memberDetail;
drop table reservation;
drop table memberAccount;



SELECT * FROM reservation WHERE YEAR(reservationDate) = 2024 AND MONTH(reservationDate) = 5;
SELECT * FROM reservation WHERE CAST(reservationDate AS DATE) = DATEADD(day, 1, CAST(GETDATE() AS DATE)) and reservationStatus=1;




/*CREATE TABLE memberAccount(
	id int identity(1,1) not null primary key,
	mAccount nvarchar(max)  not null,
	mPassword nvarchar(max) not null
)
CREATE TABLE memberDetail(
	id int identity(1,1) primary key,
	fk_mId int references memberAccount(id) not null,
	mName nvarchar(20) not null,
	mEmail nvarchar(max) not null,
	mPhone nvarchar(10) not null,
	mbirthday date,
	mPhoto nvarchar(max),
	RegistrationDate date not null,
	permissions int not null
)

/*INSERT INTO memberAccount(mAccount,mPassword) 
VALUES ('member01','member01'),
	   ('member02','member02'),
	   ('member03','member03'),
	   ('member04','member04'),
	   ('member05','member05'),
	   ('member06','member06'),
	   ('member07','member07'),
	   ('member08','member08'),
	   ('member09','member09'),
	   ('member10','member10'),
	   ('team01','team01'),
	   ('team02','team02'),
	   ('team03','team03'),
	   ('team04','team04'),
	   ('team05','team05')
INSERT INTO memberDetail(fk_mId,mName,mEmail,mPhone,mbirthday,RegistrationDate,permissions)
VALUES ('1','MEMBER01','member01@gmail.com','0987654321','2023-10-05','2024-03-20','1'),
	   ('2','MEMBER02','member02@gmail.com','0987654321','2023-11-05','2024-03-20','0'),
	   ('3','MEMBER03','member03@gmail.com','0987654321','2023-12-05','2024-03-20','1'),
	   ('4','MEMBER04','member04@gmail.com','0987654321','2024-01-05','2024-03-20','1'),
	   ('5','MEMBER05','member05@gmail.com','0987654321','2024-02-05','2024-03-20','1'),
	   ('6','MEMBER06','member06@gmail.com','0987654321','2024-03-05','2024-03-20','1'),
	   ('7','MEMBER07','member07@gmail.com','0987654321','2022-01-05','2024-03-20','1'),
	   ('8','MEMBER08','member08@gmail.com','0987654321','2022-02-05','2024-03-20','0'),
	   ('9','MEMBER09','member09@gmail.com','0987654321','2022-03-05','2024-03-20','1'),
	   ('10','MEMBER10','member10@gmail.com','0987654321','2022-04-05','2024-03-20','1'),
	   ('11','team1','team1@gmail.com','0987654321','2022-05-05','2024-03-20','1'),
	   ('12','team2','team2@gmail.com','0987654321','2022-06-05','2024-03-20','1'),
	   ('13','team3','team3@gmail.com','0987654321','2022-07-05','2024-03-20','1'),
	   ('14','team4','team4@gmail.com','0987654321','2021-08-05','2024-03-20','1'),
	   ('15','team5','team5@gmail.com','0987654321','2021-09-05','2024-03-20','1'),
	   ('15','team6','team6@gmail.com','0987654321','2021-01-05','2024-03-20','1')*/




*/