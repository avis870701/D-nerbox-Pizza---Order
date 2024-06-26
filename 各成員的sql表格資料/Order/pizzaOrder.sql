--order table
create table pizzaOrder(
orderId NVARCHAR(50) PRIMARY KEY not null,
orderTime DATETIME DEFAULT GETDATE(),
account NVARCHAR(MAX),
oriAmount INT,
discount NVARCHAR(50) DEFAULT '',
discountPrice INT DEFAULT 0,
paidAmount INT,
payment NVARCHAR(50) not null,
--現金、LinePay
pickup NVARCHAR(50) not null,
--後台:內用客人、外帶客人 前台:外送、外帶
orderStatus NVARCHAR(50) DEFAULT '訂單待處理(未付款)',
--訂單待處理(未付款)、訂單待處理(已付款)、訂單扣款失敗、餐點製作中、餐點完成、待取餐、外送中、訂單完成、訂單取消
cancelNote NVARCHAR(50) DEFAULT '',
hide INT DEFAULT 0);	


create table orderDetails(
detailsId INT IDENTITY not null,
orderId NVARCHAR(50) FOREIGN KEY REFERENCES pizzaOrder(orderId) not null,
productId INT FOREIGN KEY REFERENCES Product(ProductId) not null,
product NVARCHAR(255) not null,
unitPrice INT,
quantity INT,
subtotal int DEFAULT 0,
note NVARCHAR(MAX) DEFAULT '');

DROP TABLE orderDetails



--觸發器(要一個一個create,不可以一次用)
CREATE TRIGGER UpdateOrderAmount
ON orderDetails
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE o
    SET oriAmount = ISNULL((SELECT SUM(subtotal) FROM orderDetails WHERE orderId = o.orderId), 0)
    FROM pizzaOrder o
    WHERE o.orderId IN (SELECT orderId FROM inserted)
        OR o.orderId IN (SELECT orderId FROM deleted);
END;
GO

CREATE TRIGGER UpdatePaidAmount
ON pizzaOrder
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE o
    SET paidAmount = ISNULL((o.oriAmount - o.discountPrice), 0)
    FROM inserted i
    JOIN pizzaOrder o ON i.orderId = o.orderId;
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

--pizzaOrder fake information
INSERT INTO pizzaOrder(orderId,orderTime, account,oriAmount,discount,discountPrice,paidAmount,payment,pickup,orderStatus)
    VALUES 
('20240503113050','2024-05-03 11:30:50','Liam2044',538,'DISCOUNT10',10,528,'現金','外帶','訂單完成'),
('20240503120214','2024-05-03 12:02:14', 'Michael',574,'',0,574,'LinePay','外送','訂單完成'),
('20240503132324','2024-05-03 13:23:24', 'Emily',979,'DISCOUNT10',10,969,'LinePay','外送','訂單完成'),
('20240503144532','2024-05-03 14:45:32', 'Rodriguez',170,'',0,170,'現金','外帶','訂單完成'),
('20240503163211','2024-05-03 16:32:11', 'Gabriel',525,'',0,525,'LinePay','外帶','訂單完成'),
('20240503181324','2024-05-03 18:13:24','Emily',480,'',0,480,'LinePay','外送','訂單完成'),
('20240503200314','2024-05-03 20:03:14', 'Thomas',538,'',0,538,'LinePay','外帶','訂單完成'),
('20240504121115','2024-05-04 12:11:15', 'William',568,'',0,568,'LinePay','外送','訂單完成'),
('20240504122345','2024-05-04 12:23:45', 'Liam2044',259,'',0,259,'現金','外帶','訂單完成'),
('20240504125553','2024-05-04 12:55:53', 'John1001',765,'',0,765,'現金','外帶','訂單完成'),
('20240504141532','2024-05-04 14:15:32','Matthew',984,'MOTHERSDAY15',15,969,'LinePay','外送','訂單完成'),
('20240504152107','2024-05-04 15:21:07', 'William',439,'',0,439,'現金','外帶','訂單完成'),
('20240504153919','2024-05-04 15:39:19', 'Anderson',279,'BACKTOSCHOOL20',20,259,'LinePay','外送','訂單完成'),
('20240504183345','2024-05-04 18:33:45', 'Sophia',497,'',0,497,'LinePay','外送','訂單完成'),
('20240504192236','2024-05-04 19:22:36','Isabella',555,'',0,555,'LinePay','外帶','訂單完成'),
('20240504195802','2024-05-04 19:58:02','Hernandez', 279,'MOTHERSDAY15',15,264,'LinePay','外送','訂單完成'),
('20240504201115','2024-05-04 20:11:15', 'Benjamin',1253,'',0,1253,'現金','外帶','訂單完成'),
('20240505112107','2024-05-05 11:21:07', 'Jane9609',597,'',0,597,'現金','外帶','訂單完成'),
('20240505114213','2024-05-05 11:42:13','Jackson',170,'',0,170,'LinePay','外送','訂單完成'),
('20240505125426','2024-05-05 12:54:26','Daniel',687, '',0,687,'LinePay','外送','訂單完成'),
('20240505131609','2024-05-05 13:16:09', 'Charlotte',850,'DISCOUNT10',10,840,'LinePay','外帶','訂單完成'),
('20240505153315','2024-05-05 15:33:15','Thompson', 718,'',0,718,'現金','外帶','訂單完成'),
('20240505160718','2024-05-05 16:07:18', 'Olivia',579,'',0,579,'LinePay','外送','訂單完成'),
('20240505163312','2024-05-05 16:33:12', 'Jane9609',170,'',0,170,'LinePay','外送','訂單完成'),
('20240505164734','2024-05-05 14:47:34', 'Smith565',1322,'',0,1322,'現金','外帶','訂單完成'),
('20240505170111','2024-05-05 17:01:11', 'Gabriel',857,'BACKTOSCHOOL20',20,837,'LinePay','外送','訂單完成'),
('20240505181709','2024-05-05 18:17:09', 'Sophia',793,'',0,793,'LinePay','外送','訂單完成'),
('20240505183211','2024-05-05 18:32:11','Anderson',538, '',0,538,'現金','外帶','訂單完成'),
('20240505200112','2024-05-05 20:01:12', 'Benjamin',1020,'',0,1020,'LinePay','外送','訂單完成'),
('20240505203245','2024-05-05 20:32:45','Olivia',1572,'',0,1572,'現金','外帶' ,'訂單完成');


INSERT INTO orderDetails(orderId,productId,product,unitPrice,quantity,note)
    VALUES('20240503113050',1,'夏威夷德國披薩',279,1,'白醬 加起司'),
	      ('20240503113050',4,'牛肉K吧德國披薩',259,1,'紅醬'),
		  ('20240503120214',1,'夏威夷德國披薩',279,1,'紅醬 加洋菇'),
		  ('20240503120214',21,'炸起司條(5)',89,2,''),
		  ('20240503120214',5,'可口可樂',39,3,''),
		  ('20240503132324',3,'鳳梨蝦仁披薩',279,1,'紅醬 加起司'),
		  ('20240503132324',8,'雞肉德國披薩',190,2,'紅醬 加起司'),
		  ('20240503132324',13,'義大利牛肉K吧焗烤麵',170,1,'紅醬'),
		  ('20240503132324',25,'蘋果肉桂德國烤餅',150,1,''),
		  ('20240503144532',14,'義大利雞肉焗烤麵',170,1,'紅醬'),
		  ('20240503163211',15,'起司焗烤麵',120,2,'白醬'),
		  ('20240503163211',22,'薯條',79,1,''),
		  ('20240503163211',23,'雞塊(6)',89,1,''),
		  ('20240503163211',28,'可口可樂',39,2,''),
		  ('20240503163211',29,'雪碧',39,1,''),
		  ('20240503181324',12,'瑪格麗塔披薩',240,2,'白醬 加洋菇'),
		  ('20240503200314',5,'臘腸義大利披薩',269,1,'紅醬'),
		  ('20240503200314',6,'雞肉培根披薩',269,1,'白醬'),
		  ('20240504121115',18,'雞肉焗烤薯條',170,1,'加洋菇'),
		  ('20240504121115',19,'起司焗烤薯條',160,1,''),
		  ('20240504121115',26,'蘋果布丁烤餅',140,1,''),
		  ('20240504121115',30,'蘋果汁',49,2,''),
		  ('20240504122345',4,'牛肉K吧德國披薩',259,1,'紅醬'),
		  ('20240504125553',1,'夏威夷德國披薩',279,2,'紅醬 加起司'),
		  ('20240504125553',24,'炸物拼盤',129,1,''),
		  ('20240504125553',28,'可口可樂',39,2,''),
		  ('20240504141532',1,'夏威夷德國披薩',279,2,'紅醬'),
          ('20240504141532',4,'牛肉K吧德國披薩',259,1,'紅醬'),
		  ('20240504141532',23,'雞塊(6)',89,1,''),
		  ('20240504141532',29,'雪碧',39,2,''),
		  ('20240504152107',5,'臘腸義大利披薩',269,1,'紅醬 加洋菇'),
		  ('20240504152107',10,'鮪魚德國披薩',170,1,'白醬'),
		  ('20240504153919',3,'鳳梨蝦仁披薩',279,1,'白醬 加起司'),
		  ('20240504183345',16,'海鮮焗烤麵',170,2,'白醬'),
		  ('20240504183345',22,'薯條',79,1,''),
          ('20240504183345',29,'雪碧',39,2,''),
		  ('20240504192236',11,'洋菇德國披薩',145,1,'紅醬'),
		  ('20240504192236',12,'瑪格麗塔披薩',240,1,'紅醬 加起司'),
		  ('20240504192236',20,'牛肉K吧焗烤薯條',170,1,''),
		  ('20240504195802',3,'鳳梨蝦仁披薩',279,1,'白醬'),
		  ('20240504201115',9,'培根德國披薩',185,2,'白醬 加洋菇'),
		  ('20240504201115',14,'義大利雞肉焗烤麵',170,1,'紅醬'),
		  ('20240504201115',16,'海鮮焗烤麵',170,1,'白醬'),
		  ('20240504201115',21,'炸起司條(5)',89,2,''),
		  ('20240504201115',23,'雞塊(6)',89,1,''),
		  ('20240504201115',27,'芝麻德國比烤餅',120,1,''),
		  ('20240504201115',28,'可口可樂',39,2,''),
		  ('20240504201115',29,'雪碧',39,2,''),
		  ('20240505112107',5,'臘腸義大利披薩',269,1,'紅醬'),
		  ('20240505112107',17,'鮪魚焗烤薯條',150,1,''),
		  ('20240505112107',23,'雞塊(6)',89,2,''),
		  ('20240505114213',10,'鮪魚德國披薩',170,1,'紅醬 加洋菇'),
		  ('20240505125426',1,'夏威夷德國披薩',279,2,'紅醬'),
		  ('20240505125426',24,'炸物拼盤',129,1,''),
		  ('20240505131609',13,'義大利牛肉K吧焗烤麵',170,2,'紅醬'),
		  ('20240505131609',14,'義大利雞肉焗烤麵',170,2,'紅醬'),
		  ('20240505131609',18,'雞肉焗烤薯條',170,1,''),
		  ('20240505153315',25,'蘋果肉桂德國烤餅',150,3,''),
		  ('20240505153315',20,'牛肉K吧焗烤薯條',170,1,''),
		  ('20240505153315',30,'蘋果汁',49,2,''),
		  ('20240505160718',11,'洋菇德國披薩',145,2,'白醬'),
		  ('20240505160718',2,'海鮮德國披薩',289,1,'紅醬 加洋菇'),
		  ('20240505163312',13,'義大利牛肉K吧焗烤麵',170,1,'紅醬'),
		  ('20240505164734',7,'起司義大利披薩',180,2,'白醬'),
		  ('20240505164734',12,'瑪格麗塔披薩',240,2,'紅醬 加起司'),
		  ('20240505164734',22,'薯條',79,2,''),
		  ('20240505164734',24,'炸物拼盤',129,1,''),
		  ('20240505164734',28,'可口可樂',39,3,''),
		  ('20240505164734',29,'雪碧',39,2,''),
		  ('20240505170111',1,'夏威夷德國披薩',279,1,'紅醬'),
		  ('20240505170111',2,'海鮮德國披薩',289,2,'白醬 加起司 加洋菇'),
		  ('20240505181709',8,'雞肉德國披薩',190,1,'白醬'),
		  ('20240505181709',9,'培根德國披薩',185,1,'白醬'),
		  ('20240505181709',10,'鮪魚德國披薩',170,1,'紅醬 加洋菇'),  
		  ('20240505181709',18,'雞肉焗烤薯條',170,1,'加洋菇'),
		  ('20240505181709',28,'可口可樂',39,2,''),
		  ('20240505183211',6,'雞肉培根披薩',269,2,'白醬 加起司'),
		  ('20240505200112',25,'蘋果肉桂德國烤餅',150,4,''),
		  ('20240505200112',26,'蘋果布丁烤餅',140,3,''),
		  ('20240505203245',5,'臘腸義大利披薩',269,2,'紅醬'),
		  ('20240505203245',7,'起司義大利披薩',180,1,'白醬'),
		  ('20240505203245',12,'瑪格麗塔披薩',240,1,'白醬 加洋菇'),
		  ('20240505203245',19,'起司焗烤薯條',160,1,''),
		  ('20240505203245',15,'起司焗烤麵',120,1,''),
		  ('20240505203245',23,'雞塊(6)',89,2,''),
          ('20240505203245',28,'可口可樂',39,4,'');