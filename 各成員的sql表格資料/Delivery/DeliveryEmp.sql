USE team6;
CREATE TABLE deliveryEmp (
    empid INT IDENTITY(1,1)  PRIMARY KEY,
    demp NVARCHAR(MAX) NOT NULL, -- 外送員工姓名
    Startdelivery DATETIME, -- 外送開始時間
    Enddelivery DATETIME, -- 外送結束時間
    address NVARCHAR(MAX) NOT NULL, -- 外送地址
	state AS CASE WHEN Enddelivery IS NOT NULL THEN 0 ELSE 1 END 
);
SELECT * FROM deliveryEmp
--測試資料
INSERT INTO deliveryEmp(demp,Startdelivery,address) 
VALUES
('曉雯',GETDATE(),'桃園市中壢區中北路200號'),
('宇軒',GETDATE(),'桃園市中壢區健行路229號'),
('嘉琳',GETDATE(),'桃園市中壢區中和路139號'),
('志強',GETDATE(),'桃園市中壢區中華路一段267號'),
('怡萱',GETDATE(),'桃園市中壢區中華路一段450號');
-- 當有結束時間狀態變為0 ， 0為訂單結束
UPDATE deliveryEmp
SET Enddelivery = GETDATE()
WHERE empid = 2;

SELECT * FROM deliveryEmp