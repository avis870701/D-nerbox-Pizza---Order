USE team6;
DROP TABLE forgot_pwd;
DROP TABLE memberDetail;
DROP TABLE memberAccount;
DROP TABLE EmployeeDetail;
DROP TABLE EmployeeDept;
DROP TABLE EmployeeAccount;

----------------------------------------------------------------------------------------
--------------------------------使用者方---------------------------------------------

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
CREATE TABLE forgot_pwd(
	id int identity(1,1) primary key,
	maid int  not null ,
	token varchar(max) not null,
	registration_date datetime2 not null
)

INSERT INTO memberAccount(mAccount,mPassword,permissions,hidden)
VALUES('John1001', '123456', '1', '1'),
('Jane9609', '123456', '0', '1'),
('Michael', '123456', '1', '1'),
('Emily', '123456', '1', '1'),
('William', '123456', '1', '1'),
('Sophia7', '123456', '1', '1'),
('Matthew3', '123456', '1', '1'),
('Olivia5', '123456', '1', '1'),
('Daniel7', '123456', '1', '1'),
('Rodriguez5', '123456', '1', '1'),
('Hernandez456', '123456', '1', '1'),
('Isabella9', '123456', '1', '1'),
('Charlotte78', '123456', '0', '1'),
('Liam2044', '123456', '1', '1'),
('Emma6842', '123456', '1', '1'),
('Zoe48098', '123456', '1', '1'),
('Smith565', '123456', '1', '1'),
('Anderson76', '123456', '1', '1'),
('Benjamin786', '123456', '1', '1'),
('Thomas691', '123456', '1', '1'),
('Anderson565', '123456', '1', '1'),
('Benjamin46546', '123456', '0', '1'),
('Thomas566', '123456', '1', '1'),
('ChloeWhite7587', '123456', '1', '1'),
('Jackson783', '123456', '0', '0'),
('GraceHall45', '123456', '1', '1'),
('Thompson86', '123456', '1', '1'),
('LilyLewis453', '123456', '0', '0'),
('Gabriel53', '123456', '1', '1'),
('Zoe414546', '123456', '1', '1');
INSERT INTO memberDetail(fk_maId,mName,mEmail,mPhone,mbirthday,mPhoto,RegistrationDate)
VALUES ('1', 'John Doe', 'john.doe@gmail.com', '1234567890', '1995-08-15','/images/member/users/user01.jpg', '2004-03-26'),
('2', 'Jane Smith', 'jane.smith@gmail.com', '2345678901', '1990-06-25','/images/member/users/user02.jpg', '1997-10-20'),
('3', 'Michael Johnson', 'michael.johnson@gmail.com', '3456789012', '1988-12-10','/images/member/users/user03.jpg', '2001-07-11'),
('4', 'Emily Brown', 'emily.brown@gmail.com', '4567890123', '1992-03-30','/images/member/users/user04.jpg', '1993-02-05'),
('5', 'William Wilson', 'william.wilson@gmail.com', '5678901234', '1987-11-20','/images/member/users/user05.jpg', '2018-09-14'),
('6', 'Sophia Lee', 'sophia.lee@gmail.com', '6789012345', '1998-09-05','/images/member/users/user06.jpg', '1994-06-02'),
('7', 'Matthew Kim', 'matthew.kim@gmail.com', '7890123456', '1993-07-12','/images/member/users/user01.jpg', '2006-12-30'),
('8', 'Olivia Garcia', 'olivia.garcia@gmail.com', '8901234567', '1996-04-18','/images/member/users/user02.jpg', '2015-08-01'),
('9', 'Daniel Martinez', 'daniel.martinez@gmail.com', '9012345678', '1991-02-28', '/images/member/users/user03.jpg','1999-11-25'),
('10', 'Ava Rodriguez', 'ava.rodriguez@gmail.com', '0123456789', '1994-10-08','/images/member/users/user04.jpg', '2008-04-19'),
('11', 'Ethan Hernandez', 'ethan.hernandez@gmail.com', '0987654321', '1985-05-20', '/images/member/users/user05.jpg','2012-03-17'),
('12', 'Isabella Lopez', 'isabella.lopez@gmail.com', '9876543210', '1989-01-15', '/images/member/users/user06.jpg','2019-02-22'),
('13', 'James Perez', 'james.perez@gmail.com', '8765432109', '1997-06-02','/images/member/users/user01.jpg', '2017-11-08'),
('14', 'Mia Gonzalez', 'mia.gonzalez@gmail.com', '7654321098', '1990-11-25', '/images/member/users/user02.jpg','2010-10-10'),
('15', 'Alexander Wilson', 'alexander.wilson@gmail.com', '6543210987', '1986-04-05','/images/member/users/user03.jpg', '1995-04-01'),
('16', 'Charlotte Taylor', 'charlotte.taylor@gmail.com', '5432109876', '1999-08-18', '/images/member/users/user04.jpg','2000-12-18'),
('17', 'Liam Brown', 'liam.brown@gmail.com', '4321098765', '1993-03-15','/images/member/users/user05.jpg', '2013-06-09'),
('18', 'Emma Johnson', 'emma.johnson@gmail.com', '3210987654', '1998-01-28','/images/member/users/user06.jpg', '2014-07-30'),
('19', 'Noah Smith', 'noah.smith@gmail.com', '2109876543', '1994-07-10','/images/member/users/user01.jpg', '1996-09-05'),
('20', 'Sophie Anderson', 'sophie.anderson@gmail.com', '1098765432', '1990-09-12','/images/member/users/user02.jpg', '1999-08-12'),
('21', 'Benjamin Martin', 'benjamin.martin@gmail.com', '9876543210', '1997-10-01','/images/member/users/user03.jpg', '2003-05-28'),
('22', 'Avery Thomas', 'avery.thomas@gmail.com', '8765432109', '1988-12-08', '/images/member/users/user04.jpg','2011-02-14'),
('23', 'Chloe White', 'chloe.white@gmail.com', '7654321098', '1992-06-30', '/images/member/users/user05.jpg','2016-10-03'),
('24', 'Jackson Clark', 'jackson.clark@gmail.com', '6543210987', '1995-04-15','/images/member/users/user06.jpg', '2005-08-27'),
('25', 'Grace Hall', 'grace.hall@gmail.com', '5432109876', '1991-08-24', '/images/member/users/user01.jpg','2018-04-09'),
('26', 'Lucas Thompson', 'lucas.thompson@gmail.com', '4321098765', '1996-03-05','/images/member/users/user02.jpg', '2010-12-21'),
('27', 'Aubrey Rodriguez', 'aubrey.rodriguez@gmail.com', '3210987654', '1987-11-03','/images/member/users/user03.jpg', '1998-11-14'),
('28', 'Lily Lewis', 'lily.lewis@gmail.com', '2109876543', '1994-01-18','/images/member/users/user04.jpg', '2017-07-26'),
('29', 'Gabriel Martinez', 'gabriel.martinez@gmail.com', '1098765432', '1989-07-27','/images/member/users/user05.jpg', '2009-09-02'),
('30', 'Zoe Hill', 'zoe.hill@gmail.com', '0987654321', '1993-12-09','/images/member/users/user06.jpg', '2012-01-05');


----------------------------------------------------------------------------------------
--------------------------------公司---------------------------------------------

CREATE TABLE EmployeeAccount(
	empid int identity(1,1) not null  primary key,
	empAccount nvarchar(max) not null,
	empPassword nvarchar(max) not null,
	empPermissions int not null
)
CREATE TABLE EmployeeDept(
	deptno int identity(601,1) not null primary key,
	deptname nvarchar(max) not null
)
CREATE TABLE EmployeeDetail(
	empdid int identity(1000,1) primary key not null,
	fk_empId int references EmployeeAccount(empid) not null,
	empName nvarchar(20) not null,
	empEmail nvarchar(max) not null,
	empPhone nvarchar(10) not null,
	empbirthday date,
	hiredate date not null,
	mgr int references EmployeeDetail(empdid),
	job nvarchar(max),
	salary decimal(7,2),
	comm decimal(7,2),
	fk_deptno int references EmployeeDept(deptno)
)

INSERT INTO EmployeeAccount(empAccount,empPassword,empPermissions) 
VALUES ('bossTeam6','bossTeam6','1'),
	   ('member','member','2'),
	   ('product','product','2'),
	   ('order','order','2'),
	   ('Promotions','Promotions','2'),
	   ('reservation','reservation','2'),
	   ('delivery','delivery','2'),
	   ('DeliveryBoy1','123456','3'),
	   ('DeliveryBoy2','123456','3'),
	   ('DeliveryBoy3','123456','3'),
	   ('DeliveryBoy4','123456','3'),
	   ('DeliveryBoy5','123456','3'),
	   ('DeliveryBoy6','123456','3'),
	   ('DeliveryBoy7','123456','3'),
	   ('DeliveryBoy8','123456','3'),
	   ('staff1','123456','3'),
	   ('staff2','123456','3'),
	   ('staff3','123456','3'),
	   ('staff4','123456','3'),
	   ('staff5','123456','3'),
	   ('staff6','123456','3'),
	   ('staff7','123456','3'),
	   ('staff8','123456','3'),
	   ('staff9','123456','3'),
	   ('staff10','123456','3')

INSERT INTO EmployeeDept(deptname) 
VALUES ('member'),
	   ('product'),
	   ('order'),
	   ('Promotions'),
	   ('reservation'), 
	   ('delivery');
INSERT INTO EmployeeDetail(fk_empId,empName,empEmail,empPhone,empbirthday,hiredate,job,salary)
VALUES ('1','NIKI-BOSS','bossTeam6@gmail.com','0921666333','2001-01-24','2023-12-14','boss','90000')
INSERT INTO EmployeeDetail(fk_empId,empName,empEmail,empPhone,empbirthday,hiredate,job,fk_deptno,mgr,salary,comm)
VALUES ('2','嘉璐','member@gmail.com','0912345678','2001-01-24','2023-12-14','memberMGR','601','1000','34680','546'),
	   ('3','颯氣a瑞','product@gmail.com','0912345678','1990-01-01','2023-12-14','productMGR','602','1000','32120','0'),
	   ('4','思羽','order@gmail.com','0912345678','1990-01-01','2023-12-14','orderMGR','603','1000','1212.45',null),
	   ('5','重鈞','Promotions@gmail.com','0912345678','1990-01-01','2023-12-14','PromotionsMGR','604','1000','12120',null),
	   ('6','宇豪','reservation@gmail.com','0912345678','1990-01-01','2023-12-14','reservationMGR','605','1000','54520',null),
	   ('7','青樺','delivery@gmail.com','0912345678','1990-01-01','2023-12-14','deliveryMGR','606','1000','2131',null),
	   ('8','外送員1','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','2135.21',null),
	   ('9','外送員2','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','5123','0'),
	   ('10','外送員3','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','2454','584'),
	   ('11','外送員4','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','549.45',null),
	   ('12','外送員5','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','456','5454'),
	   ('13','外送員6','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','7891.22',null),
	   ('14','外送員7','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','879',null),
	   ('15','外送員8','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','1032.8',null),
	   ('16','員工1','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','601','1001','879.85',null),
	   ('17','員工2','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','601','1001','951','0'),
	   ('18','員工3','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','602','1002','2121',null),
	   ('19','員工4','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','602','1002','56.99',null),
	   ('20','員工5','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','603','1003','654.3',null),
	   ('21','員工6','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','603','1003','1354.4','795'),
	   ('22','員工7','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','604','1004','452','564'),
	   ('23','員工8','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','604','1004','1456.9',null),
	   ('24','員工9','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','605','1005','3254','564'),
	   ('25','員工10','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','605','1005','7745',null)

--====================================================================================================================DeliveryBoy
--====================================================================================================================staff
SELECT * FROM memberAccount
SELECT * FROM memberDetail
SELECT * FROM memberAccount a join memberDetail d on a.maid= d.fk_maId where d.mName like '%e%' or a.mAccount like '%e%' ORDER BY a.maid
SELECT * FROM EmployeeDept
SELECT * FROM EmployeeAccount
SELECT * FROM EmployeeDetail
SELECT * FROM EmployeeDetail edt join EmployeeAccount ea on ea.empid = edt.fk_empId join EmployeeDept edp on edt.fk_deptno=edp.deptno Where empPermissions=1 or empPermissions=2
SELECT * FROM forgot_pwd

--SELECT (SELECT * FROM memberAccount WHERE hidden = 1) FROM memberAccount  a join memberDetail d on a.maid= d.fk_maId WHERE a.mAccount like '%e%'
SELECT * FROM memberAccount  a join memberDetail d on a.maid= d.fk_maId WHERE a.hidden = 1 and (a.mAccount like '%i%' or d.mName like '%i%') ORDER BY a.maid
--================================================================================
-----------------------------------------操作邏輯--------------

--做 翻頁 動作
SELECT * FROM EmployeeDetail
ORDER BY empdid --要做翻頁一定要有排序
OFFSET 0*10 ROWS -- 從第 ? (0)筆開始
FETCH NEXT 10 ROWS only; -- 往後算 ? (10)筆

--要幾頁
SELECT COUNT(*)'總數', COUNT(*)/10'分幾頁(if 餘數!=0 ，要記得+1頁)' FROM EmployeeAccount;

--斷開 外來鍵約束 關聯
--UPDATE EmployeeDetail SET fk_empAccountId = null, fk_deptno = null WHERE id=3;
--================================================================================