USE team6;
CREATE TABLE Promotions (
    Promotions_id NVARCHAR(50),
    Promotions_discountCode NVARCHAR(50) PRIMARY KEY,
 Promotions_name NVARCHAR(100),
 Promotions_discount int,
    Promotions_content NVARCHAR(MAX),
    Promotions_picture NVARCHAR(MAX),
    Promotions_startDate DATE,
    Promotions_endDate DATE)