USE team6;

CREATE TABLE delivery -- 外送訂單
(
	id			  INT IDENTITY(1,1)  primary key,
	Detailsid     INT, --FOREIGN KEY REFERENCES orderDetails(detailsId)
	deliverystate INT ,    --送達狀態
	deliveryEmpid   INT FOREIGN KEY REFERENCES deliveryEmp(empid), -- 外送員工
	address       NVARCHAR(max)		NOT NULL, --送達地址	
);

CREATE TABLE deliveryEmp (
    empid INT IDENTITY(1,1) PRIMARY KEY,
    demp NVARCHAR(MAX),
    daccept TINYINT,
    CONSTRAINT CHK_daccept_range CHECK (daccept >= 0 AND daccept <= 5),
	ordertime    date,  
	orderlasttime date,
	address       NVARCHAR(MAX)		NOT NULL
);

