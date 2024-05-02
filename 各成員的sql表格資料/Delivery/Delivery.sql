USE team6;
CREATE TABLE delivery (
    id INT IDENTITY(1,1) PRIMARY KEY,
    Detailsid INT, -- 假設這是與披薩訂單詳情相關的信息（可能需要澄清）
    deliverystate INT, -- 外送狀態
    deliveryEmpid INT, -- 外送員工 ID，外鍵關聯 deliveryEmp 表
    address NVARCHAR(MAX) NOT NULL, -- 外送地址
    --FOREIGN KEY (Detailsid) REFERENCES pizzaOrder(orderId), -- 參考披薩訂單相關的表
    FOREIGN KEY (deliveryEmpid) REFERENCES deliveryEmp(empid) -- 參考外送員工表的 empid
);
SELECT * FROM delivery
