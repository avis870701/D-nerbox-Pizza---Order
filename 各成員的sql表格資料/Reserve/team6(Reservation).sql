use team6;

drop table reservation;

CREATE TABLE reservation (
    reservationId INT PRIMARY KEY IDENTITY,/*我和memberAccount的id相同*/
	reservationUuid uniqueidentifier,
    account nvarchar(max) NOT NULL,
    reservationName nvarchar(50) NOT NULL,
	phone nvarchar(50) ,
	mail nvarchar(50) , 
    numberOfPeople INT CHECK (numberOfPeople > 0) NOT NULL,
    reservationTime nvarchar(50) NOT NULL,
    reservationDate date NOT NULL,
	reservationStatus INT NOT NULL,
	note nvarchar(200),
	checkInStatus INT NOT NULL,

	FOREIGN KEY (reservationId) REFERENCES memberAccount(maid)
);

INSERT INTO "reservation" ("account", "numberOfPeople", "reservationName", "phone", "reservationTime", "reservationDate", "reservationStatus", "note", "checkInStatus") VALUES 
-----------------past----------------
('Emily', 4, '張偉', '0934567890', '18:30', '2024-05-10', 1, '無', 2),
('Sophia', 6, '陳春樹', '0912345678', '12:00', '2024-05-12', 1, '吃素', 2),
('Rodriguez', 2, '徐顥瑋', '0923456789', '13:30', '2024-05-12', 4, '蛋奶素', 2),
('William', 9, '徐偉鈞', '0956789123', '14:00', '2024-05-15', 2, '不吃豬肉', 0),
('Jane9609', 3, '林千惠', '0955109876', '11:50', '2024-05-17', 4, '', 2),
('Olivia', 3, '蔡文婷', '0912345321', '13:00', '2024-05-14', 4, '五辛素', 2),
('Emma6842', 6, '黃雅婷', '0934567543', '16:45', '2024-05-24', 4, '', 2),
('Thomas691', 2, '白冰冰', '0923456234', '21:00', '2024-05-21', 3, '', 0),
('Liam2044', 9, '蔡宗衡', '0956789345', '11:45', '2024-05-21', 3, '', 0),
-----------------day----------------
('Anderson', 4, '張善立', '0912345456', '16:30', '2024-05-29', 2, '愛吃菜', 0),
('Emma6842', 7, '朱彥衡', '0934567654', '18:00', '2024-05-29', 3, '', 0),
('Daniel', 5, '江哲佳', '0923456456', '14:30', '2024-05-29', 3, '請給我免洗餐具', 2),
('Smith565', 3, '蔡建華', '0956789456', '17:00', '2024-05-29', 3, '不吃羊', 1),
('Charlotte', 1, '張志強', '0912345768', '15:00', '2024-05-29', 4, '海鮮過敏', 1),
('Zoe48098', 8, '劉雅芬', '0934567891', '13:30', '2024-05-29', 4, '蛋奶素', 2),
-----------------future----------------
('Olivia', 3, '王中華', '0912345987', '15:45', '2024-06-05', 1, '', 0),
('William', 7, '梁信鈞', '0934567123', '17:30', '2024-06-18', 1, '吃素', 0),
('Liam2044', 5, '李欣瑞', '0912345432', '11:30', '2024-06-08', 1, '不吃辣', 0),
('GraceHall', 8, '陳德華', '0923456987', '20:00', '2024-06-29', 0, '不吃牛', 0),
('Emily', 1, '李昀昀', '0956789432', '19:15', '2024-06-22', 0, '愛吃辣', 0);

select * from reservation;

/*
reservationStatus
0:店家未確認報到
1:店家已確認報到(客人前一天仍未確認)
2:客人前一天取消
3:客人前一天確定會報到
4:現場客

checkInStatus
0:客人尚未到店
1:客人用餐中
2:用餐完畢客人離開
*/







