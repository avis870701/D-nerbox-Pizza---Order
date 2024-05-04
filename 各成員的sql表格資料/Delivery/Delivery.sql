USE team6;

CREATE TABLE DeliveryStatus (
    statusid tinyint PRIMARY KEY,
    status_name VARCHAR(50)
);

SELECT * FROM DeliveryStatus
INSERT INTO DeliveryStatus (statusid, status_name)
VALUES
    (1, '待處理'),
    (2, '已接單'),
    (3, '外送中'),
    (4, '已送達'),
    (5, '已取消');

SELECT * FROM Delivery
CREATE TABLE Delivery (
    delivery_id INT	IDENTITY PRIMARY KEY,
	order_id NVARCHAR(max),
    date DATE,
    address NVARCHAR(MAX),
    status tinyint DEFAULT 1,
    FOREIGN KEY (status) REFERENCES DeliveryStatus(statusid),
);

INSERT INTO DeliveryStatus (statusid, status_name)
VALUES (2, '已接單');
INSERT INTO delivery(date,address)
VALUES 
(GETDATE(), '桃園市中壢區中山東路二段510號')


SELECT *
FROM delivery 
JOIN DeliveryStatus ds ON status = statusid
WHERE status = 2;

--status_name = 1 的訂單
SELECT delivery_id,order_id,date,address ,status_name
FROM delivery  
JOIN DeliveryStatus ds ON status = statusid
WHERE status = 1;

UPDATE Delivery SET order_id = '20240303013000' WHERE delivery_id = 1;
--INSERT INTO delivery(Detailsid,address) 
--VALUES
--(20240303013000,,'桃園市中壢區中山東路二段510號'),
--(20240312153000,,'桃園市中壢區中山東路二段510號'),
--(20240323133000,,'桃園市中壢區中山東路二段510號'),
--(20240113153000,,'桃園市中壢區中山東路二段510號'),
--(20240121153000,,'桃園市中壢區中山東路二段510號'),
--(20240131153000,,'桃園市中壢區中山東路二段510號'),
--(20240403013000,,'桃園市中壢區健行路229號'),
--(20240413123000,,'桃園市中壢區中山東路二段510號'),
--(20240423153000,,'桃園市中壢區中山東路二段510號'),
--(20240430113000,,'桃園市中壢區中山東路二段510號');
