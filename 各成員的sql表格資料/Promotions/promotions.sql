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
    ('6', 'HALLOWEEN20', N'�U�t�`�S�f', 20, N'�U�t�`�S�f�A��ߤj��e', '/images/promotions/6666.jpg', '2024-08-01', '2024-08-31'),
    ('7', 'THANKSGIVING10', N'�P���`���w', 10, N'�P���`���w�u�f�A�P�¦^�X', 'path/to/picture7.jpg', '2024-09-01', '2024-09-30'),
    ('8', 'WINTER50', N'�V�u�g�w�j�P��', 50, N'�V�u�g�w�j�P��A��������', 'path/to/picture8.jpg', '2024-10-01', '2024-10-31'),
    ('9', 'NEWYEAR45', N'�s�~�y��', 45, N'�s�~�y��A�ﱵ�s���@�~', 'path/to/picture9.jpg', '2024-11-01', '2024-11-30'),
    ('10', 'VALENTINE25', N'���H�`���', 25, N'���H�`��ߡA�R�����T��', 'path/to/picture10.jpg', '2024-12-01', '2024-12-31'),
    ('11', 'EASTER20', N'�_���`�u�f', 20, N'�_���`�u�f�A�K�Ѫ�§��', 'path/to/picture11.jpg', '2025-01-01', '2025-01-31'),
    ('12', 'MOTHERSDAY15', N'���˸`�y��', 15, N'���˸`�y��A�P�����R', 'path/to/picture12.jpg', '2025-02-01', '2025-02-28'),
    ('13', 'FATHERSDAY10', N'���˸`�S�f', 10, N'���˸`�S�f�A�R�P��j', 'path/to/picture13.jpg', '2025-03-01', '2025-03-31'),
    ('14', 'BACKTOSCHOOL20', N'����u�f', 20, N'����u�f�A�}�ǩu�j�d�m', 'path/to/picture14.jpg', '2025-04-01', '2025-04-30'),
    ('15', 'LABORDAY25', N'�Ұʸ`�y��', 25, N'�Ұʸ`�y���A���Ԥu�@���^�X', 'path/to/picture15.jpg', '2025-05-01', '2025-05-31'),
    ('16', 'CHRISTMAS30', N'�t�ϸ`�S��', 30, N'�t�ϸ`�S�ѡA�R�P�M�����`��', 'path/to/picture16.jpg', '2025-06-01', '2025-06-30'),
    ('17', 'BLACKFRIDAY40', N'�¦�P�����j�P�P', 40, N'�¦�P�����j�P�P�A�ʪ��g�w�`', 'path/to/picture17.jpg', '2025-07-01', '2025-07-31'),
    ('18', 'CYBERMONDAY35', N'���ʬP���@�u�f', 35, N'���ʬP���@�u�f�A�u�W�g�w�ʪ��`', 'path/to/picture18.jpg', '2025-08-01', '2025-08-31'),
    ('19', 'YEAR-ENDSALE50', N'�~���j���', 50, N'�~���j���A�����A���ʪ�����', 'path/to/picture19.jpg', '2025-09-01', '2025-09-30')