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
    ('6', 'HALLOWEEN20', N'萬聖節特惠', 20, N'萬聖節特惠，驚喜大放送', '/images/promotions/6666.jpg', '2024-08-01', '2024-08-31'),
    ('7', 'THANKSGIVING10', N'感恩節限定', 10, N'感恩節限定優惠，感謝回饋', 'path/to/picture7.jpg', '2024-09-01', '2024-09-30'),
    ('8', 'WINTER50', N'冬季狂歡大銷售', 50, N'冬季狂歡大銷售，全面降價', 'path/to/picture8.jpg', '2024-10-01', '2024-10-31'),
    ('9', 'NEWYEAR45', N'新年慶典', 45, N'新年慶典，迎接新的一年', 'path/to/picture9.jpg', '2024-11-01', '2024-11-30'),
    ('10', 'VALENTINE25', N'情人節驚喜', 25, N'情人節驚喜，愛的交響曲', 'path/to/picture10.jpg', '2024-12-01', '2024-12-31'),
    ('11', 'EASTER20', N'復活節優惠', 20, N'復活節優惠，春天的禮物', 'path/to/picture11.jpg', '2025-01-01', '2025-01-31'),
    ('12', 'MOTHERSDAY15', N'母親節慶典', 15, N'母親節慶典，感恩母愛', 'path/to/picture12.jpg', '2025-02-01', '2025-02-28'),
    ('13', 'FATHERSDAY10', N'父親節特惠', 10, N'父親節特惠，愛與堅強', 'path/to/picture13.jpg', '2025-03-01', '2025-03-31'),
    ('14', 'BACKTOSCHOOL20', N'返校優惠', 20, N'返校優惠，開學季大鉅獻', 'path/to/picture14.jpg', '2025-04-01', '2025-04-30'),
    ('15', 'LABORDAY25', N'勞動節慶祝', 25, N'勞動節慶祝，辛勤工作的回饋', 'path/to/picture15.jpg', '2025-05-01', '2025-05-31'),
    ('16', 'CHRISTMAS30', N'聖誕節特供', 30, N'聖誕節特供，愛與和平的節日', 'path/to/picture16.jpg', '2025-06-01', '2025-06-30'),
    ('17', 'BLACKFRIDAY40', N'黑色星期五大促銷', 40, N'黑色星期五大促銷，購物狂歡節', 'path/to/picture17.jpg', '2025-07-01', '2025-07-31'),
    ('18', 'CYBERMONDAY35', N'網購星期一優惠', 35, N'網購星期一優惠，線上狂歡購物節', 'path/to/picture18.jpg', '2025-08-01', '2025-08-31'),
    ('19', 'YEAR-ENDSALE50', N'年末大拍賣', 50, N'年末大拍賣，滿足你的購物慾望', 'path/to/picture19.jpg', '2025-09-01', '2025-09-30')