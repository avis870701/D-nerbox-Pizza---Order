USE team6;
DROP TABLE member;
DROP TABLE bossAccount;

CREATE TABLE bossAccount(
	account nvarchar(20) Not null PRIMARY KEY,
	mName nvarchar(20) Not null,
	password nvarchar(18) Not null
);

INSERT INTO bossAccount
VALUES ('bossTeam6','BOSS','bossTeam6');

SELECT password FROM bossAccount WHERE account='bossTeam6';

CREATE TABLE member(
	account nvarchar(20) Not null PRIMARY KEY,
	mName nvarchar(20) Not null,
	password nvarchar(18) Not null,
	mEmail nvarchar(50) Not null,
	mPhone nvarchar(10) Not null,
	birthday date,
	permissions int Not null
);

INSERT INTO member
VALUES ('ispanTeam1','team1','ispanTeam1','ispanTeam1@gmail.com','0912345678','2020-01-01','1'),
	   ('ispanTeam2','team2','ispanTeam2','ispanTeam2@gmail.com','0912345678','2021-02-02','1'),
	   ('ispanTeam3','team3','ispanTeam3','ispanTeam3@gmail.com','0912345678','2022-03-03','1'),
	   ('ispanTeam4','team4','ispanTeam4','ispanTeam4@gmail.com','0912345678','2023-04-04','1'),
	   ('ispanTeam5','team5','ispanTeam5','ispanTeam5@gmail.com','0912345678','2024-05-05','1'),
	   ('ispanTeam6','team6','ispanTeam6','ispanTeam6@gmail.com','0912345678','2025-06-06','1');
	   SELECT * FROM member;

	 --  SELECT e.empno,e.ename,e.hiredate, e.salary, d.DNAME, e.title
	 --  FROM employee e JOIN department d  ON e.deptno = d.DEPTNO 
	 --  WHERE e.ename LIKE '%p%'