USE team6;
--創建表格
CREATE TABLE Delivery (
    delivery_id INT	IDENTITY PRIMARY KEY,
	order_id NVARCHAR(max) not null,
    date DATE,
    address NVARCHAR(MAX),
	status INT DEFAULT 1
);

CREATE TABLE Delivery (
    delivery_id INT	IDENTITY(1,1) PRIMARY KEY,
	order_id NVARCHAR(max) not null,
    date DATE,
    address NVARCHAR(MAX),
	status INT DEFAULT 1,
	ename NVARCHAR(max),
	starttime DATETIME,
	endtime DATETIME
);


--新增假資料
INSERT INTO delivery(order_id,date,address,status,ename,starttime,endtime)
VALUES
('20240503120214','2024-05-03','桃園市中壢區健行路229號',4,'James','2024-05-03 12:20:14.910','2024-05-03 12:30:00.910'),
('20240503132324','2024-05-03','桃園市中壢區中華路一段267號',4,'Robert','2024-05-03 13:30:09.910','2024-05-03 13:46:00.910'),
('20240503181324','2024-05-03','桃園市中壢區中華路一段267號',4,'John','2024-05-03 18:20:09.910','2024-05-03 18:35:00.910'),
('20240504121115','2024-05-04','桃園市中壢區中北路200號',4,'Michael','2024-05-05 18:20:09.910','2024-05-15 14:11:00.910'),
('20240504141532','2024-05-04', '桃園市中壢區健行路229號',4,'William','2024-05-05 18:20:09.910','2024-05-15 14:11:00.910'),
('20240504153919','2024-05-04','桃園市中壢區中和路139號',4,'William','2024-05-05 18:20:09.910','2024-05-15 14:11:00.910'),
('20240504183345','2024-05-04','桃園市中壢區遠東路135號',4,'William','2024-05-05 18:20:09.910','2024-05-15 14:11:00.910'),
('20240504195802','2024-05-04','桃園市中壢區健行路229號',4,'John','2024-05-05 18:20:09.910','2024-05-15 14:11:00.910'),
('20240505114213','2024-05-05','桃園市中壢區健行路229號',4,'John','2024-05-05 18:20:09.910','2024-05-15 14:11:00.910'),
('20240505125426','2024-05-05','桃園市中壢區中華路一段267號',4,'Michael','2024-05-05 18:20:09.910','2024-05-15 14:11:00.910'),
('20240505160718','2024-05-05','桃園市中壢區健行路229號',4,'James','2024-05-05 18:20:09.910','2024-05-15 14:11:00.910'),
('20240505163312','2024-05-05','桃園市中壢區中和路139號',4,'Robert','2024-05-05 18:20:09.910','2024-05-15 14:11:00.910'),
('20240505170111','2024-05-05','桃園市中壢區健行路229號',4,'James','2024-05-05 17:20:09.910','2024-05-15 17:30:00.910'),
('20240505181709','2024-05-05','桃園市中壢區中和路139號',4,'Robert','2024-05-05 18:30:09.910','2024-05-15 18:30:09.910');
INSERT INTO delivery(order_id,date,address,status)
VALUES
('20240505200112','2024-05-05','桃園市中壢區健行路229號',1);
SELECT * FROM Delivery

--測試
UPDATE Delivery 
SET status = 3, starttime = GETDATE() 
WHERE delivery_id = 13;
SELECT * FROM Delivery

UPDATE Delivery 
SET status = 3, endtime = GETDATE() 
WHERE delivery_id = 13;
SELECT * FROM Delivery


UPDATE Delivery SET status = 3 WHERE status = 4;

UPDATE Delivery SET status = 4 ,endtime = GETDATE()  WHERE status = 3
INSERT INTO Delivery(order_id,date,address) VALUES ('20240505200113',GETDATE() ,'桃園市中壢區健行路229號');