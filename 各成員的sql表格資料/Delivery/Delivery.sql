USE team6;
CREATE TABLE delivery (
    id INT IDENTITY(1,1) PRIMARY KEY,
    Detailsid INT, -- ���]�o�O�P���ĭq��Ա��������H���]�i��ݭn��M�^
    deliverystate INT, -- �~�e���A
    deliveryEmpid INT, -- �~�e���u ID�A�~�����p deliveryEmp ��
    address NVARCHAR(MAX) NOT NULL, -- �~�e�a�}
    --FOREIGN KEY (Detailsid) REFERENCES pizzaOrder(orderId), -- �Ѧҩ��ĭq���������
    FOREIGN KEY (deliveryEmpid) REFERENCES deliveryEmp(empid) -- �Ѧҥ~�e���u�� empid
);
SELECT * FROM delivery
