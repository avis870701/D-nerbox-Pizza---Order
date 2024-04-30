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
-- 0 �O�R��
SELECT * FROM delivery WHERE delstate = 'FALSE';
SELECT * FROM delivery
INSERT INTO delivery (cname,phone,product, num, price,ename, address,time)
VALUES
('����ޱ','0987331207','�L�¦i�w�����',1,279,'Henry','���c������',10),
('�L�Ż�','0921293946','������B',1,50,'Allen','���c������',10),
('���B�@','0935040199','����k�a�w�����',1,259,'Henry','����j��',10),
('���l�a','0915092878','���A�w�����',1,289,'Allen','�����ޤj��',10),
('�����Y','0931780999','�i�f�i��',1,40,'Henry','���c�B�ʶ��',10),
('�����M','0986736805','�������L',1,189,'Allen','�a�ֺ֤��c��',10),
('���t��','0922255802','����k�a�K�N����',1,259,'John','�a�ֺ֤��c��',10),
('�B����','0987515692','ī�G�׮ۼw��N��',1,160,'David','��饫���s���������',10),
('�G�ߩ�','0968422803','�q�j�Q�����K�N��',1,160,'John','������|',10)
INSERT INTO delivery (cname,phone,product, num, price,ename, address,time)
VALUES
('����ޱ','0987331277','�L�¦i�w�����',1,279,'Henry','���c������',10)


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
