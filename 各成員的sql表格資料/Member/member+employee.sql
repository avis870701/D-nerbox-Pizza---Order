USE team6;
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

INSERT INTO memberAccount(mAccount,mPassword,permissions,hidden)
VALUES ('member01','member01','1','1'),
	   ('member02','member02','0','1'),
	   ('member03','member03','1','1'),
	   ('member04','member04','1','1'),
	   ('member05','member05','1','1'),
	   ('member06','member06','1','1'),
	   ('member07','member07','0','1'),
	   ('member08','member08','1','1'),
	   ('member09','member09','1','1'),
	   ('member10','member10','0','1'),
	   ('team01','team01','0','1'),
	   ('team02','team02','1','1'),
	   ('team03','team03','1','1'),
	   ('team04','team04','1','1'),
	   ('team05','team05','0','1'),
	   ('team06','team06','0','1')
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
	   ('16','team6','team6@gmail.com','0987654321','2021-01-05','2024-03-20')

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
SELECT * FROM EmployeeDetail edt join EmployeeAccount ea on ea.empid = edt.fk_empId join EmployeeDept edp on edt.fk_deptno=edp.deptno

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