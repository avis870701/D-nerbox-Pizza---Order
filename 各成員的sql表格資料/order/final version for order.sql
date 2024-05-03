--關聯資料表(尚未設計好)


create table pizzaOrder(
orderId NVARCHAR(50) PRIMARY KEY not null,
orderTime DATETIME DEFAULT GETDATE(),
acoount NVARCHAR(20) FOREIGN KEY REFERENCES member not null,
oriAmount INT not null,
discount NVARCHAR(50) DEFAULT '' FOREIGN KEY REFERENCES Promotions,
discountPrice INT DEFAULT 0,
paidAmount INT not null,
payment NVARCHAR(50) not null,
--現金、LinePay
pickup NVARCHAR(50) not null,
--後台:內用客人、外帶客人 前台:外送、外帶
orderStatus NVARCHAR(50) DEFAULT '訂單待處理(未付款)',
--訂單待處理(未付款)、訂單待處理(已付款)、餐點製作中、餐點完成、待取餐、外送中、訂單完成、訂單取消
cancelNote NVARCHAR(50) DEFAULT '',
hide INT DEFAULT 0 not null);	


create table orderDetails(
detailsId INT IDENTITY not null,
orderId INT FOREIGN KEY REFERENCES pizzaOrder(orderId) not null,
productId INT FOREIGN KEY REFERENCES Product(productId) not null,
product NVARCHAR(255) not null,
unitPrice INT,
quantity INT,
subtotal int DEFAULT 0,
note NVARCHAR(MAX) DEFAULT '');



--觸發器
CREATE TRIGGER UpdateOrderAmount
ON orderDetails
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE o
    SET paidAmount = ISNULL((SELECT SUM(subtotal) FROM orderDetails WHERE orderId = o.orderId), 0)
    FROM pizzaOrder o
    WHERE o.orderId IN (SELECT orderId FROM inserted)
        OR o.orderId IN (SELECT orderId FROM deleted);
END;
GO


CREATE TRIGGER calculate_subtotal
ON orderDetails
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE od
    SET od.subtotal = i.unitPrice * i.quantity
    FROM orderDetails od
    INNER JOIN inserted i ON od.detailsId = i.detailsId;
END;
GO
