USE team6;
DROP TABLE memberDetail;
DROP TABLE memberAccount;


CREATE TABLE memberAccount(
	maid int identity(1,1) not null primary key,
	mAccount nvarchar(max)  not null ,
	mPassword nvarchar(max) not null,
	permissions int not null
)
CREATE TABLE memberDetail(
	mdid int identity(1,1) primary key,
	fk_maId int references memberAccount(maid) not null,
	mName nvarchar(20) not null,
	mEmail nvarchar(max) not null,
	mPhone nvarchar(10) not null,
	mbirthday date,
	mPhoto nvarchar(max),
	RegistrationDate date not null,
)

INSERT INTO memberAccount(mAccount,mPassword,permissions) 
VALUES ('member01','member01','1'),
	   ('member02','member02','0'),
	   ('member03','member03','1'),
	   ('member04','member04','1'),
	   ('member05','member05','1'),
	   ('member06','member06','1'),
	   ('member07','member07','0'),
	   ('member08','member08','1'),
	   ('member09','member09','1'),
	   ('member10','member10','0'),
	   ('team01','team01','0'),
	   ('team02','team02','1'),
	   ('team03','team03','1'),
	   ('team04','team04','1'),
	   ('team05','team05','0')
INSERT INTO memberDetail(fk_maId,mName,mEmail,mPhone,mbirthday,RegistrationDate)
VALUES ('1','MEMBER01','member01@gmail.com','0987654321','2023-10-05','2024-03-20'),
	   ('2','MEMBER02','member02@gmail.com','0987654321','2023-11-05','2024-03-20'),
	   ('3','MEMBER03','member03@gmail.com','0987654321','2023-12-05','2024-03-20'),
	   ('4','MEMBER04','member04@gmail.com','0987654321','2024-01-05','2024-03-20'),
	   ('5','MEMBER05','member05@gmail.com','0987654321','2024-02-05','2024-03-20'),
	   ('6','MEMBER06','member06@gmail.com','0987654321','2024-03-05','2024-03-20'),
	   ('7','MEMBER07','member07@gmail.com','0987654321','2022-01-05','2024-03-20'),
	   ('8','MEMBER08','member08@gmail.com','0987654321','2022-02-05','2024-03-20'),
	   ('9','MEMBER09','member09@gmail.com','0987654321','2022-03-05','2024-03-20'),
	   ('10','MEMBER10','member10@gmail.com','0987654321','2022-04-05','2024-03-20'),
	   ('11','team1','team1@gmail.com','0987654321','2022-05-05','2024-03-20'),
	   ('12','team2','team2@gmail.com','0987654321','2022-06-05','2024-03-20'),
	   ('13','team3','team3@gmail.com','0987654321','2022-07-05','2024-03-20'),
	   ('14','team4','team4@gmail.com','0987654321','2021-08-05','2024-03-20'),
	   ('15','team5','team5@gmail.com','0987654321','2021-09-05','2024-03-20'),
	   ('15','team6','team6@gmail.com','0987654321','2021-01-05','2024-03-20')


SELECT * FROM memberAccount
SELECT * FROM memberDetail
