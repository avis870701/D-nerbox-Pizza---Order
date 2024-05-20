USE team6;

CREATE TABLE DeliveryEmp (
    id INT IDENTITY(1,1)  PRIMARY KEY　,
	Did NVARCHAR(MAX) ,
    Emp NVARCHAR(100),
	Starttime DATETIME, -- 外送開始時間
    Endtime DATETIME, -- 外送結束時間
	address　NVARCHAR(100),
    state　tinyint DEFAULT 0,　-- 0 外送開始 1 外送結束
);
SELECT * FROM DeliveryEmp
--測試資料
INSERT INTO deliveryEmp(Dorder,Dname,Starttime,address) 
VALUES
('20240313213000','嘉琳',GETDATE(),'桃園市中壢區中華路139號')
('20240303013120','宇軒',GETDATE(),'桃園市中壢區健行路229號'),
('20240303013000','曉雯',GETDATE(),'桃園市中壢區中北路200號'),
--('志強',GETDATE(),'桃園市中壢區中華路一段267號'),
--('怡萱',GETDATE(),'桃園市中壢區中華路一段450號');
*/
SELECT * FROM DeliveryEmp
-- 當有結束時間狀態變為１ ， １為訂單結束
UPDATE DeliveryEmp 
SET Endtime = GETDATE(),state = 1 
WHERE  id = 3;
