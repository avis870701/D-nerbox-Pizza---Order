USE team6;

CREATE TABLE DeliveryEmp (
    id INT IDENTITY(1,1)  PRIMARY KEY�@,
	Did NVARCHAR(MAX) ,
    Emp NVARCHAR(100),
	Starttime DATETIME, -- �~�e�}�l�ɶ�
    Endtime DATETIME, -- �~�e�����ɶ�
	address�@NVARCHAR(100),
    state�@tinyint DEFAULT 0,�@-- 0 �~�e�}�l 1 �~�e����
);
SELECT * FROM DeliveryEmp
--���ո��
INSERT INTO deliveryEmp(Dorder,Dname,Starttime,address) 
VALUES
('20240313213000','�ŵY',GETDATE(),'��饫���c�Ϥ��ظ�139��')
('20240303013120','�t�a',GETDATE(),'��饫���c�ϰ����229��'),
('20240303013000','�嶲',GETDATE(),'��饫���c�Ϥ��_��200��'),
--('�ӱj',GETDATE(),'��饫���c�Ϥ��ظ��@�q267��'),
--('�ɸ�',GETDATE(),'��饫���c�Ϥ��ظ��@�q450��');
*/
SELECT * FROM DeliveryEmp
-- �������ɶ����A�ܬ��� �A �����q�浲��
UPDATE DeliveryEmp 
SET Endtime = GETDATE(),state = 1 
WHERE  id = 3;
