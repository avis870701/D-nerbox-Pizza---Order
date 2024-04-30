USE team6;

--建表順序 products cteate -> insert values
--create pizzaOrder & orderDetails -> 先create 觸發器 (要一個一個創)
--創完之後才可以insert values
--虛假產品表格
CREATE TABLE products(
productId NVARCHAR PRIMARY KEY NOT NULL,
product NVARCHAR(255) NOT NULL,
pdesc NVARCHAR(MAX) NOT NULL,
unitPrice INT NOT NULL);

SELECT * FROM orderDetails;

--(目前是假資料,未跟Product連結)
INSERT INTO products
    VALUES ('1','香菇意大利比薩', '香菇,洋菇,番茄肉醬,洋蔥', 150);

INSERT INTO products
    VALUES ('2','夏威夷德國比薩', '鳳梨,火腿,美乃滋,蛋黃醬', 130);

INSERT INTO products
    VALUES ('3','起司義大利比薩', '莫札瑞拉起司,帕瑪森起司粉,番茄肉醬', 180);

INSERT INTO products
    VALUES ('4','義大利雞肉焗烤麵', '雞肉,通心麵,番茄肉醬,莫札瑞拉起司', 220);

INSERT INTO products
    VALUES ('5','蘋果肉桂德國烤餅', '蘋果,肉桂粉,麵粉', 130);

INSERT INTO products
    VALUES ('6','炸雞塊(6塊)', '雞肉塊', 60);

INSERT INTO products
    VALUES ('7','炸起司條(5條)', '莫札瑞拉起司,麵粉', 60);

--訂單
CREATE TABLE pizzaOrder(
orderId NVARCHAR(300) PRIMARY KEY NOT NULL,
--orderId INT IDENTITY PRIMARY KEY NOT NULL,
--orderTime DATETIME DEFAULT CONVERT(varchar, GETDATE(), 120) NOT NULL,  
orderTime DATETIME DEFAULT GETDATE() NOT NULL,
customerName NVARCHAR(255) NOT NULL,
amount INT,
payment NVARCHAR(50) NOT NULL,
pickup NVARCHAR(50) NOT NULL,
orderStatus NVARCHAR(50) DEFAULT '已下單');  --已下單,餐點製作中,外送中,已完成

 --訂單明細
CREATE TABLE orderDetails(
detailsId int identity not null,
orderId NVARCHAR(300) FOREIGN KEY REFERENCES pizzaOrder(orderId),
productId NVARCHAR FOREIGN KEY REFERENCES products(productID),
product NVARCHAR(255),
unitPrice INT,
quantity INT,
subtotal int,
note NVARCHAR(MAX));

drop table orderDetails
drop table pizzaOrder
drop table products

--觸發器
CREATE TRIGGER UpdateOrderAmount
ON orderDetails
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE o
    SET amount = ISNULL((SELECT SUM(subtotal) FROM orderDetails WHERE orderId = o.orderId), 0)
    FROM pizzaOrder o
    WHERE o.orderId IN (SELECT orderId FROM inserted)
        OR o.orderId IN (SELECT orderId FROM deleted);
END;

CREATE TRIGGER calculate_subtotal
ON orderDetails
AFTER INSERT, UPDATE
AS
BEGIN
    -- 更新已插入或更新的每一行的 subtotal
    UPDATE od
    SET od.subtotal = i.unitPrice * i.quantity
    FROM orderDetails od
    INNER JOIN inserted i ON od.detailsId = i.detailsId;
END;




SELECT * FROM orderDetails
SELECT * FROM pizzaOrder;

INSERT INTO pizzaOrder(orderId,customerName,payment,pickup,orderStatus)
    VALUES('emp001','王小明', '信用卡' ,'外帶', '已完成');

INSERT INTO pizzaOrder(orderId,customerName,payment,pickup,orderStatus)
    VALUES('emp002','林小明',  '現金' , '內用', '已完成');

INSERT INTO pizzaOrder(orderId,customerName,payment,pickup,orderStatus)
    VALUES('emp003','陳小明', '現金', '內用', '已完成');

INSERT INTO pizzaOrder(orderId,customerName,payment,pickup,orderStatus)
    VALUES('emp004','黃小明',  '信用卡', '外送', '已完成');

INSERT INTO pizzaOrder(orderId,customerName,payment,pickup,orderStatus)
    VALUES('emp005','彭小明',  '信用卡', '外送', '已完成');

INSERT INTO pizzaOrder(orderId,customerName,payment,pickup)
VALUES('emp006','彭小明',  '信用卡', '外送');

INSERT INTO pizzaOrder(orderId,customerName,payment,pickup)
VALUES('emp007','彭小明',  '信用卡', '外送');


INSERT INTO orderDetails(orderId, productId, product, unitPrice, quantity, note)
    VALUES ('emp001', 1, '香菇意大利比薩', 150, 1, '起司少一點'),
           ('emp001', 2, '夏威夷德國比薩', 130, 1, '鳳梨多一點');

INSERT INTO orderDetails(orderId, productId, product, unitPrice, quantity, note)
    VALUES('emp002', 2, '夏威夷德國比薩', 180, 1, NULL),
		  ('emp002', 6, '炸雞塊(6塊)', 60, 2, '醬料請給番茄醬');

INSERT INTO orderDetails(orderId, productId, product, unitPrice, quantity, note)
	VALUES('emp003', 3, '起司義大利比薩', 180, 1, NULL),
	      ('emp003', 4, '義大利雞肉焗烤麵', 200, 1, '起司多一點'),
		  ('emp003', 7, '炸起司條(5條)', 60, 2 , '撒胡椒粉');

INSERT INTO orderDetails(orderId, productId, product, unitPrice, quantity, note)
    VALUES('emp004', 1, '香菇意大利比薩', 150, 1, NULL),
		  ('emp004', 3, '起司義大利比薩', 180, 2, NULL),
		  ('emp004', 5, '蘋果肉桂德國烤餅', 130, 2 ,NULL),
		  ('emp004', 6, '炸雞塊(6塊)', 60, 1, NULL),
		  ('emp004', 7, '炸起司條(5條)', 60, 1, '最後做');
		  
INSERT INTO orderDetails(orderId, productId, product, unitPrice, quantity, note)
    VALUES('emp005', 5, '蘋果肉桂德國烤餅', 220, 2, '醬少一點');

INSERT INTO orderDetails(orderId, productId, product, unitPrice, quantity, note)
    VALUES('emp006', 4, '義大利雞肉焗烤麵', 220, 2, '起司放多點');

INSERT INTO orderDetails(orderId, productId, product, unitPrice, quantity, note)
    VALUES('emp007', 4, '義大利雞肉焗烤麵', 220, 2, '麵多一點');
		 
