USE team6;
SELECT* FROM products 
DROP TABLE TestPage
CREATE TABLE TestPage(
	tid int primary key identity(1,1) not null,
	tname1 NVARCHAR(20) not null,
	tname2 NVARCHAR(20) not null,
	tname3 NVARCHAR(20) not null,
	tname4 NVARCHAR(20) not null,
	tname5 NVARCHAR(20) not null,
	tname6 NVARCHAR(20) not null,
	tstate tinyint NOT NULL 
);

INSERT INTO TestPage(tname1, tname2, tname3, tname4, tname5 ,tname6, tstate) 
VALUES
('����1', '������1', '��������1', '��������1','����������1', '���������1',1),
('����2', '������2', '��������2', '��������2','����������2', '���������2',1),
('����3', '������3', '��������3', '��������3','����������3', '���������3',1),
('����4', '������4', '��������4', '��������4','����������4', '���������4',1),
('����5', '������5', '��������5', '��������5','����������5', '���������5',1),
('����6', '������6', '��������6', '��������6','����������6', '���������6',1),
('����7', '������7', '��������7', '��������7','����������7', '���������7',1),
('����8', '������8', '��������8', '��������8','����������8', '���������8',1),
('����9', '������9', '��������9', '��������9','����������9', '���������9',1),
('����10', '������10', '��������10', '��������10','����������10', '���������10',0),
('����11', '������11', '��������11', '��������11','����������11', '���������11',0),
('����12', '������12', '��������12', '��������12','����������12', '���������12',0),
('����13', '������13', '��������13', '��������13','����������13', '���������13',0),
('����14', '������14', '��������14', '��������14','����������14', '���������14',1),
('����15', '������15', '��������15', '��������15','����������15', '���������15',0),
('����16', '������16', '��������16', '��������16','����������16', '���������16',1),
('����17', '������17', '��������17', '��������17','����������17', '���������17',0),
('����18', '������18', '��������18', '��������18','����������18', '���������18',0),
('����19', '������19', '��������19', '��������19','����������19', '���������19',0),
('����20', '������20', '��������20', '��������20','����������20', '���������20',1),
('����21', '������21', '��������21', '��������21','����������21', '���������21',0),
('����22', '������22', '��������22', '��������22','����������22', '���������22',0),
('����23', '������23', '��������23', '��������23','����������23', '���������23',1),
('����24', '������24', '��������24', '��������24','����������24', '���������24',0)

SELECT *FROM TestPage