USE team6;
--常用功能
SELECT * FROM Product;

UPDATE Product SET ProductImg_url = '\product\images\向日葵1.jpg' WHERE ProductId = 3;
SELECT * FROM Product;

DELETE FROM Product WHERE ProductId = 19;

TRUNCATE TABLE Product

DROP TABLE Product
--常用功能

--產品類別表設計
CREATE TABLE ProductCategory (
	CategoryId INT IDENTITY PRIMARY KEY NOT NULL,
	CategoryName  NVARCHAR(100)  NOT NULL
);
--產品類別鍵入值
INSERT INTO ProductCategory(CategoryName)
VALUES
('披薩'),
('焗烤'),
('炸物'),
('甜點'),
('飲料')
;
--
--產品狀態(下架與否)表設計
CREATE TABLE ProductState (
	ProductStateId INT PRIMARY KEY NOT NULL,
	ProductStateName  NVARCHAR(20)  NOT NULL
);
--產品狀態鍵入值
INSERT INTO ProductState(ProductStateId,ProductStateName)
VALUES
(1,'上架中'),
(0,'已下架')
--
--產品表設計
CREATE TABLE Product (
	ProductId INT IDENTITY PRIMARY KEY NOT NULL,
	CategoryId INT NOT NULL,
	ProductName NVARCHAR(500) NOT NULL,
	ProductDesc NVARCHAR(1000) NULL,
	ProductImg_url NVARCHAR(1000) NULL,
	ProductPrice INT NOT NULL,
	ProductStateId INT NOT NULL DEFAULT 1,
	ProductCreateDate Date Not Null,
	FOREIGN KEY (CategoryId) REFERENCES ProductCategory(CategoryId),
	FOREIGN KEY (ProductStateId) REFERENCES ProductState(ProductStateId)
);
--產品表鍵入值
INSERT INTO Product (CategoryId,ProductName,ProductDesc,ProductImg_url,ProductPrice,ProductCreateDate)
VALUES 
(1,'夏威夷德國披薩','火腿鳳梨披薩。白醬，薄餅皮。','\product\images\夏威夷德國比薩.jpg',279, '2024-01-01'),
(1,'海鮮德國披薩','蝦仁、魚、蟹味腿。白醬，薄餅皮。','\product\images\海鮮德國比薩.jpg',289, '2024-01-12'),
(1,'牛肉K吧德國披薩','旋轉烤牛肉。白醬，薄餅皮。','\product\images\牛肉K吧德國比薩.jpg',259, '2024-01-25'),
(1,'臘腸義大利披薩','臘腸。紅醬，薄餅皮。','\product\images\臘腸意大利比薩.jpg',269, '2024-02-18'),
(1,'瑪格麗塔披薩','莫札瑞拉起司。羅勒，番茄，紅醬，薄餅皮。','\product\images\瑪格麗塔披薩.jpg',240, '2024-02-25'),
(2,'義大利牛肉K吧焗烤麵','旋轉烤牛肉。焗烤，白醬，義大利麵。','\product\images\牛肉K吧焗烤麵.jpg',170, '2024-03-15'),
(2,'義大利雞肉焗烤麵','雞肉。焗烤，白醬，義大利麵。','\product\images\義大利雞肉焗烤麵.jpg',170, '2024-03-01'),
(2,'鮪魚焗烤薯條','帕瑪森起司。焗烤，薯條。','\product\images\鮪魚焗烤薯條.jpg',150, '2024-03-05'),
(2,'雞肉焗烤薯條','雞肉。焗烤，薯條。','\product\images\雞肉焗烤薯條.jpg',170, '2024-03-20'),
(2,'牛肉K吧焗烤薯條','旋轉烤牛肉。焗烤，薯條。','\product\images\牛K吧焗烤薯條.jpg',170, '2024-03-31'),
(3,'炸起司條(5)','酥炸起司條搭配番茄醬','\product\images\炸起司條(5條).jpg',89, '2024-04-01'),
(3,'薯條','酥炸薯條佐番茄醬','\product\images\薯條.jpg',79, '2024-01-01'),
(3,'雞塊(6)','酥酥脆脆的雞塊','\product\images\炸雞塊(6塊).jpg',89, '2024-01-05'),
(4,'蘋果肉桂德國烤餅','新鮮蘋果、肉桂與酥脆薄餅的絕妙搭配','\product\images\蘋果肉桂德國烤餅.jpg',150, '2024-04-12'),
(5,'可口可樂','冰涼爽口的可口可樂,主廚推薦','\product\images\可樂.jpg',39, '2020-01-13'),
(5,'雪碧','冰涼爽口的雪碧','\product\images\雪碧.jpg',39, '2020-01-14'),
(5,'蘋果汁','進口蘋果汁','\product\images\蘋果汁.jpg',49, '2024-01-23')
;
--
--產品附加項表設計
CREATE TABLE ProductOption (
	ProductOptionId INT IDENTITY PRIMARY KEY NOT NULL,
	ProductOptionName NVARCHAR(200) NOT NULL,
	ProductOptionPrice INT NOT NULL
);
--產品附加項鍵入值
INSERT INTO ProductOption(ProductOptionName,ProductOptionPrice)
VALUES
('洋菇',25),
('起司',35),
('胡椒',0),
('辣椒',0),
('測試',0)
;
--
--
--以下是測試
--訂單(測試
CREATE TABLE Orders (
	OrderId INT IDENTITY PRIMARY KEY NOT NULL,
	OrderDate DATETIME2 NOT NULL,
	OrderTotal INT NOT NULL
);
--假定一筆訂單,金額後面補
INSERT INTO Orders(OrderDate,OrderTotal)
VALUES
(GETDATE(),0)
;
--時間精確到年/月/日/時/分
SELECT OrderID, FORMAT(OrderDate,'yyyy-MM-dd HH:mm') OrderDate, OrderTotal
FROM Orders
--
--訂單細項(測試
CREATE TABLE OrderDetail (
	OrderDetailId INT IDENTITY PRIMARY KEY NOT NULL,
	OrderId INT NOT NULL,
	ProductId INT NOT NULL,
	Quantity INT NOT NULL,
	FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
		--ON DELETE CASCADE, --訂單編號刪除細項也刪除
	FOREIGN KEY (ProductId) REFERENCES Product(ProductId)
);
--假定訂單詳情海鮮德國PZ(洋菇,起司,辣椒)*2,臘腸義大利PZ(胡椒)*1,薯條*1,可樂*2
INSERT INTO OrderDetail(OrderId,ProductId,Quantity)
VALUES
(1,2,2),
(1,4,1),
(1,12,1),
(1,16,2)
;
--
--訂單客製化詳情(測試
CREATE TABLE OrderDetailOption (
	OrderDetailOptionId INT IDENTITY PRIMARY KEY NOT NULL,
	OrderDetailId INT NOT NULL,
	ProductOptionId INT NOT NULL,
	FOREIGN KEY (OrderDetailId) REFERENCES OrderDetail(OrderDetailId),
		--ON DELETE CASCADE,  --訂單細項編號刪除訂單客製化也刪除
	FOREIGN KEY (ProductOptionId) REFERENCES ProductOption(ProductOptionId)
		--ON DELETE CASCADE   --產品選項編號刪除訂單客製化選項也刪除
);
--假定訂單詳情海鮮德國PZ(洋菇,起司,辣椒)*2,臘腸義大利PZ(胡椒)*1,薯條*1,可樂*2
INSERT INTO OrderDetailOption(OrderDetailId,ProductOptionId)
VALUES
(1,1),
(1,2),
(1,3),
(2,4)
;
--
--查詢訂單細項(測試
SELECT OD.OrderId,
P.ProductName,
ISNULL( STRING_AGG(PO.ProductOptionName, ','), '' ) AS ProductOptions,
OD.Quantity,
(P.ProductPrice +ISNULL( SUM(PO.ProductOptionPrice),0 ) ) * OD.Quantity AS TotalPrice
FROM OrderDetail OD
JOIN Product P ON OD.ProductID = P.ProductId
LEFT JOIN OrderDetailOption ODO ON OD.OrderDetailId = ODO.OrderDetailId
LEFT JOIN ProductOption PO ON ODO.ProductOptionId = PO.ProductOptionId
WHERE OD.OrderId = 1
GROUP BY OD.OrderId,OD.ProductId,OD.Quantity,P.ProductName,P.ProductPrice
ORDER BY OD.ProductId;
--
--更新訂單金額(測試
UPDATE Orders
SET OrderTotal = (
	SELECT SUM(TotalPrice)
	FROM(
		SELECT 
		(P.ProductPrice +ISNULL( SUM(PO.ProductOptionPrice),0 ) ) * OD.Quantity AS TotalPrice
		FROM OrderDetail OD
		JOIN Product P ON OD.ProductId = P.ProductId
		LEFT JOIN OrderDetailOption ODO ON OD.OrderDetailId = ODO.OrderDetailId
		LEFT JOIN ProductOption PO ON ODO.ProductOptionId = PO.ProductOptionId
		WHERE OD.OrderId = 1
		GROUP BY P.ProductPrice,OD.Quantity) AS TotalPrice
);
--訂單現況(測試
SELECT OrderId, FORMAT(OrderDate,'yyyy-MM-dd HH:mm') OrderDate, OrderTotal
FROM Orders
--
--會員表(測試
CREATE TABLE Member (
	Account VARCHAR(16) PRIMARY KEY NOT NULL,
	Password VARCHAR(16) NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	Title NVARCHAR(50) NOT NULL
);
--會員表鍵入值(測試
INSERT INTO Member(Account,Password,Name,Title)
VALUES 
('henry','henry45','李欣瑞','經理'),
('test1','test123','測試1','外送員')

SELECT * FROM Member