CREATE TABLE Promotions (
    Promotions_id NVARCHAR(50),
    Promotions_discountCode NVARCHAR(50) PRIMARY KEY,
	Promotions_name NVARCHAR(100),
	Promotions_discount int,
    Promotions_content NVARCHAR(MAX),
    Promotions_picture NVARCHAR(MAX),
    Promotions_startDate DATE,
    Promotions_endDate DATE);

-- 插入假資料到 Promotions 表中
INSERT INTO Promotions (Promotions_id, Promotions_discountCode, Promotions_name, Promotions_discount, Promotions_content, Promotions_picture, Promotions_startDate, Promotions_endDate)
VALUES
    ('1', 'DISCOUNT10', N'滿100折10元', 10, N'滿100元減10元', '/images/promotions/2222.jpg', '2024-03-01', '2024-03-31'),
    ('2', 'SPRING20', N'春季大促銷', 20, N'春季大促銷活動，優惠多多', '/images/promotions/1111.jpg', '2024-04-01', '2024-04-30'),
    ('3', 'EARLYBIRD15', N'早鳥優惠', 15, N'早鳥優惠，提前訂購更優惠', '/images/promotions/3333.png', '2024-05-01', '2024-05-31'),
    ('4', 'SUMMER25', N'夏日限定優惠', 25, N'夏日限定優惠，火熱開啟', '/images/promotions/4444.jpg', '2024-06-01', '2024-06-30'),
    ('5', 'FALL30', N'秋季滿額返利', 30, N'秋季滿額返利，購物再送好禮', '/images/promotions/5555.jpg', '2024-07-01', '2024-07-31'),
    ('6', 'HALLOWEEN20', N'萬聖節特惠', 20, N'萬聖節特惠，驚喜大放送', '/images/promotions/6666.jpg', '2024-08-01', '2024-08-31')