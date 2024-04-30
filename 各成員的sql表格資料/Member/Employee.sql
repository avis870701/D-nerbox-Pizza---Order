USE team6;
DROP TABLE EmployeeDetail;
DROP TABLE EmployeeDept;
DROP TABLE EmployeeAccount;


CREATE TABLE EmployeeAccount(
	empid int identity(1,1) not null  primary key,
	empAccount nvarchar(max) not null,
	empPassword nvarchar(max) not null
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

INSERT INTO EmployeeAccount(empAccount,empPassword) 
VALUES ('bossTeam6','bossTeam6'),
	   ('member','member'),
	   ('product','product'),
	   ('order','order'),
	   ('Promotions','Promotions'),
	   ('reservation','reservation'),
	   ('delivery','delivery'),
	   ('DeliveryBoy1','123456'),
	   ('DeliveryBoy2','123456'),
	   ('DeliveryBoy3','123456'),
	   ('DeliveryBoy4','123456'),
	   ('DeliveryBoy5','123456'),
	   ('DeliveryBoy6','123456'),
	   ('DeliveryBoy7','123456'),
	   ('DeliveryBoy8','123456'),
	   ('staff1','123456'),
	   ('staff2','123456'),
	   ('staff3','123456'),
	   ('staff4','123456'),
	   ('staff5','123456'),
	   ('staff6','123456'),
	   ('staff7','123456'),
	   ('staff8','123456'),
	   ('staff9','123456'),
	   ('staff10','123456')

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
VALUES ('2','���i','member@gmail.com','0912345678','2001-01-24','2023-12-14','memberMGR','601','1000','34680','546'),
	   ('3','���a��','product@gmail.com','0912345678','1990-01-01','2023-12-14','productMGR','602','1000','32120','0'),
	   ('4','���','order@gmail.com','0912345678','1990-01-01','2023-12-14','orderMGR','603','1000','1212.45',null),
	   ('5','���v','Promotions@gmail.com','0912345678','1990-01-01','2023-12-14','PromotionsMGR','604','1000','12120',null),
	   ('6','�t��','reservation@gmail.com','0912345678','1990-01-01','2023-12-14','reservationMGR','605','1000','54520',null),
	   ('7','�C��','delivery@gmail.com','0912345678','1990-01-01','2023-12-14','deliveryMGR','606','1000','2131',null),
	   ('8','�~�e��1','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','2135.21',null),
	   ('9','�~�e��2','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','5123','0'),
	   ('10','�~�e��3','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','2454','584'),
	   ('11','�~�e��4','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','549.45',null),
	   ('12','�~�e��5','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','456','5454'),
	   ('13','�~�e��6','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','7891.22',null),
	   ('14','�~�e��7','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','879',null),
	   ('15','�~�e��8','delivery@gmail.com','0912345678','1990-01-01','2024-02-14','delivery','606','1006','1032.8',null),
	   ('16','���u1','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','601','1001','879.85',null),
	   ('17','���u2','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','601','1001','951','0'),
	   ('18','���u3','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','602','1002','2121',null),
	   ('19','���u4','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','602','1002','56.99',null),
	   ('20','���u5','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','603','1003','654.3',null),
	   ('21','���u6','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','603','1003','1354.4','795'),
	   ('22','���u7','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','604','1004','452','564'),
	   ('23','���u8','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','604','1004','1456.9',null),
	   ('24','���u9','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','605','1005','3254','564'),
	   ('25','���u10','staff@gmail.com','0912345678','1990-01-01','2024-02-14','staff','605','1005','7745',null)


SELECT * FROM EmployeeDept
SELECT * FROM EmployeeAccount
SELECT * FROM EmployeeDetail