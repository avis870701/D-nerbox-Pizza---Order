USE team6;
CREATE TABLE deliveryEmp (
    empid INT IDENTITY(1,1)  PRIMARY KEY,
    demp NVARCHAR(MAX) NOT NULL, -- �~�e���u�m�W
    Startdelivery DATETIME, -- �~�e�}�l�ɶ�
    Enddelivery DATETIME, -- �~�e�����ɶ�
    address NVARCHAR(MAX) NOT NULL, -- �~�e�a�}
	state AS CASE WHEN Enddelivery IS NOT NULL THEN 0 ELSE 1 END 
);
SELECT * FROM deliveryEmp
--���ո��
INSERT INTO deliveryEmp(demp,Startdelivery,address) 
VALUES
('�嶲',GETDATE(),'��饫���c�Ϥ��_��200��'),
('�t�a',GETDATE(),'��饫���c�ϰ����229��'),
('�ŵY',GETDATE(),'��饫���c�Ϥ��M��139��'),
('�ӱj',GETDATE(),'��饫���c�Ϥ��ظ��@�q267��'),
('�ɸ�',GETDATE(),'��饫���c�Ϥ��ظ��@�q450��');
-- �������ɶ����A�ܬ�0 �A 0���q�浲��
UPDATE deliveryEmp
SET Enddelivery = GETDATE()
WHERE empid = 2;

SELECT * FROM deliveryEmp