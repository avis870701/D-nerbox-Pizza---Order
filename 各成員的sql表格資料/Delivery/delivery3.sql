USE team6;

CREATE TABLE delivery
(
	id			 INT IDENTITY(1,1)  primary key,
	cname        NVARCHAR(50)       NOT NULL,
	phone        VARCHAR(20)        UNIQUE(phone),
	product      NVARCHAR(MAX)      NOT NULL,
	num          INT                NOT NULL,
	price        INT                NOT NULL,
	ename        NVARCHAR(MAX)      ,
	address      NVARCHAR(MAX)		NOT NULL,
	time		 INT     ,
	delstate    BIT DEFAULT		1
);
-- 0 是刪除
SELECT * FROM delivery WHERE delstate = 'FALSE';
SELECT * FROM delivery
INSERT INTO delivery (cname,phone,product, num, price,ename, address,time)
VALUES
('邱宥瑄','0987331207','夏威夷德國披薩',1,279,'Henry','中壢火車站',10),
('林嘉豪','0921293946','原味布丁',1,50,'Allen','內壢火車站',10),
('李雨婷','0935040199','牛肉k吧德國披薩',1,259,'Henry','中原大學',10),
('黃子軒','0915092878','海鮮德國披薩',1,289,'Allen','健行科技大學',10),
('陳雅琳','0931780999','可口可樂',1,40,'Henry','中壢運動園區',10),
('蔡瑞霖','0986736805','炸物拼盤',1,189,'Allen','家樂福中壢店',10),
('王宇航','0922255802','牛肉k吧焗烤薯條',1,259,'John','家樂福內壢店',10),
('劉韻潔','0987515692','蘋果肉桂德國烤餅',1,160,'David','桃園市立龍興國民中學',10),
('鄭心怡','0968422803','義大利雞肉焗烤麵',1,160,'John','天晟醫院',10)
INSERT INTO delivery (cname,phone,product, num, price,ename, address,time)
VALUES
('邱宥瑄','0987331277','夏威夷德國披薩',1,279,'Henry','中壢火車站',10)


select
        mb1_0.account,
        mb1_0.birthday,
        mb1_0.memail,
        mb1_0.mname,
        mb1_0.mphone,
        mb1_0.password,
        mb1_0.permissions 
    from
        member mb1_0 


		select
        pb1_0.productid,
        pb1_0.categoryid,
        pb1_0.productdesc,
        pb1_0.productimg_url,
        pb1_0.productname,
        pb1_0.productprice,
        pb1_0.productstateid 
    from
        product pb1_0
