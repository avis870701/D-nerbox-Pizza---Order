CREATE TABLE Promotions (
    Promotions_id NVARCHAR(50),
    Promotions_discountCode NVARCHAR(50) PRIMARY KEY,
	Promotions_name NVARCHAR(100),
	Promotions_discount int,
    Promotions_content NVARCHAR(MAX),
    Promotions_picture NVARCHAR(MAX),
    Promotions_startDate DATE,
    Promotions_endDate DATE);

-- ���J����ƨ� Promotions ��
INSERT INTO Promotions (Promotions_id, Promotions_discountCode, Promotions_name, Promotions_discount, Promotions_content, Promotions_picture, Promotions_startDate, Promotions_endDate)
VALUES
    ('1', 'DISCOUNT10', N'��100��10��', 10, N'��100����10��', '/images/promotions/2222.jpg', '2024-03-01', '2024-03-31'),
    ('2', 'SPRING20', N'�K�u�j�P�P', 20, N'�K�u�j�P�P���ʡA�u�f�h�h', '/images/promotions/1111.jpg', '2024-04-01', '2024-04-30'),
    ('3', 'EARLYBIRD15', N'�����u�f', 15, N'�����u�f�A���e�q�ʧ��u�f', '/images/promotions/3333.png', '2024-05-01', '2024-05-31'),
    ('4', 'SUMMER25', N'�L�魭�w�u�f', 25, N'�L�魭�w�u�f�A�����}��', '/images/promotions/4444.jpg', '2024-06-01', '2024-06-30'),
    ('5', 'FALL30', N'��u���B��Q', 30, N'��u���B��Q�A�ʪ��A�e�n§', '/images/promotions/5555.jpg', '2024-07-01', '2024-07-31'),
    ('6', 'HALLOWEEN20', N'�U�t�`�S�f', 20, N'�U�t�`�S�f�A��ߤj��e', '/images/promotions/6666.jpg', '2024-08-01', '2024-08-31')