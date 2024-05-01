USE team6;

CREATE TABLE delivery -- �~�e�q��
(
	id			  INT IDENTITY(1,1)  primary key,
	Detailsid     INT, --FOREIGN KEY REFERENCES orderDetails(detailsId)
	deliverystate INT ,    --�e�F���A
	deliveryEmpid   INT FOREIGN KEY REFERENCES deliveryEmp(empid), -- �~�e���u
	address       NVARCHAR(max)		NOT NULL, --�e�F�a�}	
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

