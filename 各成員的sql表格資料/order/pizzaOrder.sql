USE team6;

--�ت��� products cteate -> insert values
--create pizzaOrder & orderDetails -> ��create Ĳ�o�� (�n�@�Ӥ@�ӳ�)
--�Ч�����~�i�Hinsert values
--�갲���~���
CREATE TABLE products(
productId NVARCHAR PRIMARY KEY NOT NULL,
product NVARCHAR(255) NOT NULL,
pdesc NVARCHAR(MAX) NOT NULL,
unitPrice INT NOT NULL);

SELECT * FROM orderDetails;

--(�ثe�O�����,����Product�s��)
INSERT INTO products
    VALUES ('1','��ۣ�N�j�Q����', '��ۣ,�vۣ,�f�X����,�v��', 150);

INSERT INTO products
    VALUES ('2','�L�¦i�w�����', '���,���L,���D��,�J����', 130);

INSERT INTO products
    VALUES ('3','�_�q�q�j�Q����', '������԰_�q,�����˰_�q��,�f�X����', 180);

INSERT INTO products
    VALUES ('4','�q�j�Q�����K�N��', '����,�q����,�f�X����,������԰_�q', 220);

INSERT INTO products
    VALUES ('5','ī�G�׮ۼw��N��', 'ī�G,�׮ۯ�,�ѯ�', 130);

INSERT INTO products
    VALUES ('6','������(6��)', '���׶�', 60);

INSERT INTO products
    VALUES ('7','���_�q��(5��)', '������԰_�q,�ѯ�', 60);

--�q��
CREATE TABLE pizzaOrder(
orderId NVARCHAR(300) PRIMARY KEY NOT NULL,
--orderId INT IDENTITY PRIMARY KEY NOT NULL,
--orderTime DATETIME DEFAULT CONVERT(varchar, GETDATE(), 120) NOT NULL,  
orderTime DATETIME DEFAULT GETDATE() NOT NULL,
customerName NVARCHAR(255) NOT NULL,
amount INT,
payment NVARCHAR(50) NOT NULL,
pickup NVARCHAR(50) NOT NULL,
orderStatus NVARCHAR(50) DEFAULT '�w�U��');  --�w�U��,�\�I�s�@��,�~�e��,�w����

 --�q�����
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

--Ĳ�o��
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
    -- ��s�w���J�Χ�s���C�@�檺 subtotal
    UPDATE od
    SET od.subtotal = i.unitPrice * i.quantity
    FROM orderDetails od
    INNER JOIN inserted i ON od.detailsId = i.detailsId;
END;




SELECT * FROM orderDetails
SELECT * FROM pizzaOrder;

INSERT INTO pizzaOrder(orderId,customerName,payment,pickup,orderStatus)
    VALUES('emp001','���p��', '�H�Υd' ,'�~�a', '�w����');

INSERT INTO pizzaOrder(orderId,customerName,payment,pickup,orderStatus)
    VALUES('emp002','�L�p��',  '�{��' , '����', '�w����');

INSERT INTO pizzaOrder(orderId,customerName,payment,pickup,orderStatus)
    VALUES('emp003','���p��', '�{��', '����', '�w����');

INSERT INTO pizzaOrder(orderId,customerName,payment,pickup,orderStatus)
    VALUES('emp004','���p��',  '�H�Υd', '�~�e', '�w����');

INSERT INTO pizzaOrder(orderId,customerName,payment,pickup,orderStatus)
    VALUES('emp005','�^�p��',  '�H�Υd', '�~�e', '�w����');

INSERT INTO pizzaOrder(orderId,customerName,payment,pickup)
VALUES('emp006','�^�p��',  '�H�Υd', '�~�e');

INSERT INTO pizzaOrder(orderId,customerName,payment,pickup)
VALUES('emp007','�^�p��',  '�H�Υd', '�~�e');


INSERT INTO orderDetails(orderId, productId, product, unitPrice, quantity, note)
    VALUES ('emp001', 1, '��ۣ�N�j�Q����', 150, 1, '�_�q�֤@�I'),
           ('emp001', 2, '�L�¦i�w�����', 130, 1, '����h�@�I');

INSERT INTO orderDetails(orderId, productId, product, unitPrice, quantity, note)
    VALUES('emp002', 2, '�L�¦i�w�����', 180, 1, NULL),
		  ('emp002', 6, '������(6��)', 60, 2, '��ƽе��f�X��');

INSERT INTO orderDetails(orderId, productId, product, unitPrice, quantity, note)
	VALUES('emp003', 3, '�_�q�q�j�Q����', 180, 1, NULL),
	      ('emp003', 4, '�q�j�Q�����K�N��', 200, 1, '�_�q�h�@�I'),
		  ('emp003', 7, '���_�q��(5��)', 60, 2 , '���J�ԯ�');

INSERT INTO orderDetails(orderId, productId, product, unitPrice, quantity, note)
    VALUES('emp004', 1, '��ۣ�N�j�Q����', 150, 1, NULL),
		  ('emp004', 3, '�_�q�q�j�Q����', 180, 2, NULL),
		  ('emp004', 5, 'ī�G�׮ۼw��N��', 130, 2 ,NULL),
		  ('emp004', 6, '������(6��)', 60, 1, NULL),
		  ('emp004', 7, '���_�q��(5��)', 60, 1, '�̫ᰵ');
		  
INSERT INTO orderDetails(orderId, productId, product, unitPrice, quantity, note)
    VALUES('emp005', 5, 'ī�G�׮ۼw��N��', 220, 2, '��֤@�I');

INSERT INTO orderDetails(orderId, productId, product, unitPrice, quantity, note)
    VALUES('emp006', 4, '�q�j�Q�����K�N��', 220, 2, '�_�q��h�I');

INSERT INTO orderDetails(orderId, productId, product, unitPrice, quantity, note)
    VALUES('emp007', 4, '�q�j�Q�����K�N��', 220, 2, '�Ѧh�@�I');
		 
