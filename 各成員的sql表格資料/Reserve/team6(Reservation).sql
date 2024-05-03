CREATE TABLE memberAccount(
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


CREATE TABLE reservation (
    reservationId INT PRIMARY KEY IDENTITY,/*我和memberAccount的id相同*/
	reservationUuid uniqueidentifier,
    account nvarchar(max) NOT NULL,
    reservationName nvarchar(50) NOT NULL,
	phone nvarchar(50) NOT NULL,
    numberOfPeople INT CHECK (numberOfPeople > 0) NOT NULL,
    reservationTime nvarchar(50) NOT NULL,
    reservationDate date NOT NULL,
	reservationStatus INT NOT NULL,
	note nvarchar(200),
	checkInStatus INT NOT NULL,

    FOREIGN KEY (reservationId) REFERENCES memberAccount(id)
);
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



INSERT INTO "reservation" ("account", "numberOfPeople", "reservationName","phone","reservationTime", reservationDate  ,reservationStatus,"note","checkInStatus")
VALUES ('member01', '3','測試用1','0919807906', '12:30','2024-05-02','3', '3','0');

INSERT INTO memberAccount(mAccount,mPassword) 
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
	   ('15','team6','team6@gmail.com','0987654321','2021-01-05','2024-03-20','1')


select * from reservation
select * from memberAccount
select * from memberDetail

drop table reservation;
drop table memberAccount;
drop table memberDetail;

SELECT md.mEmail
FROM reservation r
JOIN memberAccount ma ON r.account = ma.mAccount
JOIN memberDetail md ON ma.id = md.fk_mId;

SELECT * FROM reservation WHERE CAST(reservationDate AS DATE) = DATEADD(day, 1, CAST(GETDATE() AS DATE)) and reservationStatus=1;



/*CREATE TABLE memberReserve(
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

INSERT INTO memberReserve
VALUES ('ispanTeam7','team1','ispanTeam1','h60915@gmail.com','0912345678','2020-01-01','1'),
	   ('ispanTeam2','team2','ispanTeam2','ispanTeam2@gmail.com','0912345678','2021-02-02','1'),
	   ('ispanTeam3','team3','ispanTeam3','ispanTeam3@gmail.com','0912345678','2022-03-03','1'),
	   ('ispanTeam4','team4','ispanTeam4','ispanTeam4@gmail.com','0912345678','2023-04-04','1'),
	   ('ispanTeam5','team5','ispanTeam5','ispanTeam5@gmail.com','0912345678','2024-05-05','1'),
	   ('ispanTeam6','team6','ispanTeam6','ispanTeam6@gmail.com','0912345678','2025-06-06','2');

select * from [reservation]
select * from memberReserve

DROP TABLE "reservation";
DROP TABLE memberreserve;*/