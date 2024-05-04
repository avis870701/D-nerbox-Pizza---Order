USE team6;

CREATE TABLE DeliveryStatus (
    statusid tinyint PRIMARY KEY,
    status_name VARCHAR(50)
);

SELECT * FROM DeliveryStatus
INSERT INTO DeliveryStatus (statusid, status_name)
VALUES
    (1, '�ݳB�z'),
    (2, '�w����'),
    (3, '�~�e��'),
    (4, '�w�e�F'),
    (5, '�w����');

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
VALUES (2, '�w����');
INSERT INTO delivery(date,address)
VALUES 
(GETDATE(), '��饫���c�Ϥ��s�F���G�q510��')


SELECT *
FROM delivery 
JOIN DeliveryStatus ds ON status = statusid
WHERE status = 2;

--status_name = 1 ���q��
SELECT delivery_id,order_id,date,address ,status_name
FROM delivery  
JOIN DeliveryStatus ds ON status = statusid
WHERE status = 1;

UPDATE Delivery SET order_id = '20240303013000' WHERE delivery_id = 1;
--INSERT INTO delivery(Detailsid,address) 
--VALUES
--(20240303013000,,'��饫���c�Ϥ��s�F���G�q510��'),
--(20240312153000,,'��饫���c�Ϥ��s�F���G�q510��'),
--(20240323133000,,'��饫���c�Ϥ��s�F���G�q510��'),
--(20240113153000,,'��饫���c�Ϥ��s�F���G�q510��'),
--(20240121153000,,'��饫���c�Ϥ��s�F���G�q510��'),
--(20240131153000,,'��饫���c�Ϥ��s�F���G�q510��'),
--(20240403013000,,'��饫���c�ϰ����229��'),
--(20240413123000,,'��饫���c�Ϥ��s�F���G�q510��'),
--(20240423153000,,'��饫���c�Ϥ��s�F���G�q510��'),
--(20240430113000,,'��饫���c�Ϥ��s�F���G�q510��');
