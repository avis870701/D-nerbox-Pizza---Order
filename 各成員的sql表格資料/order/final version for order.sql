--���p��ƪ�(�|���]�p�n)


create table pizzaOrder(
orderId NVARCHAR(50) PRIMARY KEY not null,
orderTime DATETIME DEFAULT GETDATE(),
acoount NVARCHAR(20) FOREIGN KEY REFERENCES member not null,
oriAmount INT not null,
discount NVARCHAR(50) DEFAULT '' FOREIGN KEY REFERENCES Promotions,
discountPrice INT DEFAULT 0,
paidAmount INT not null,
payment NVARCHAR(50) not null,
--�{���BLinePay
pickup NVARCHAR(50) not null,
--��x:���ΫȤH�B�~�a�ȤH �e�x:�~�e�B�~�a
orderStatus NVARCHAR(50) DEFAULT '�q��ݳB�z(���I��)',
--�q��ݳB�z(���I��)�B�q��ݳB�z(�w�I��)�B�\�I�s�@���B�\�I�����B�ݨ��\�B�~�e���B�q�槹���B�q�����
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



--Ĳ�o��
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
