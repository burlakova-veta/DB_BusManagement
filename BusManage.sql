CREATE DATABASE ��������������
ON
PRIMARY (NAME=BusManage, 
	FILENAME='D:\university\�����\���� ������\��������\bm\BusManage.mdf', 
	SIZE=5,  
	MAXSIZE=10,
	FILEGROWTH=10%)
LOG ON (NAME= BusManage_log,
	FILENAME='D:\university\�����\���� ������\��������\bm\BusManage.ldf', 
	SIZE=1, 
	MAXSIZE=5,
	FILEGROWTH=10%)

CREATE TABLE ���������
	(�����_����� INTEGER IDENTITY(1,1) PRIMARY KEY,
	��������� VARCHAR(10) NOT NULL)

CREATE TABLE ��������
	(�����_������ INTEGER IDENTITY(1,1) PRIMARY KEY,
	������� VARCHAR(20) NOT NULL,
	��� VARCHAR(15) NOT NULL,
	�������� VARCHAR(25),
	�����_����� INTEGER NOT NULL,
	FOREIGN KEY (�����_�����) REFERENCES ��������� (�����_�����) ON DELETE CASCADE,
	������� CHAR(11) NOT NULL UNIQUE,
	������� CHAR(12) NOT NULL UNIQUE,
	����_���� DATE NOT NULL,
	����� VARCHAR(25) NOT NULL,
	����� VARCHAR(40) NOT NULL,
	�����_����_������ VARCHAR(14) NOT NULL UNIQUE,
	���_��_����� VARCHAR(35) NOT NULL,
	�����_���_��_����� VARCHAR(20) NOT NULL,
	�������_����� CHAR(10) DEFAULT '0',
	����� CHAR(17) NOT NULL UNIQUE,
	����_����_����� CHAR(20) NOT NULL UNIQUE,
	����� SMALLINT CHECK (����� >= 0 AND ����� <= 3),
	����_�����_���_���� DATE)

CREATE TABLE ���������
	(����_����� CHAR(3) DEFAULT '000' PRIMARY KEY,
	����� VARCHAR(10) NOT NULL,
	���_��_�����_���� INTEGER NOT NULL DEFAULT 0,
	�����_����_���� INTEGER NOT NULL,
	���_���������� INTEGER NOT NULL,
	���_������� INTEGER NOT NULL)

CREATE TABLE ���_����
	(�����_���� INTEGER IDENTITY(1,1) PRIMARY KEY,
	���_���� VARCHAR(8))

CREATE TABLE ������������
	(�����_������ INTEGER IDENTITY(1,1),
	�����_������ INTEGER NOT NULL,
	FOREIGN KEY (�����_������) REFERENCES �������� (�����_������) ON DELETE CASCADE,
	����_����� CHAR(3) NOT NULL,
	FOREIGN KEY (����_�����) REFERENCES ��������� (����_�����) ON DELETE CASCADE,
	�����_���� INTEGER NOT NULL,
	FOREIGN KEY (�����_����) REFERENCES ���_���� (�����_����) ON DELETE CASCADE,
	����_������ DATE NOT NULL)

CREATE TABLE ����_����������
	(�����_���_������ INTEGER IDENTITY(1,1) PRIMARY KEY,
	���_������ VARCHAR(10) NOT NULL)

CREATE TABLE �������
	(�����_���� INTEGER NOT NULL PRIMARY KEY,
	�����_���_������ INTEGER NOT NULL,
	FOREIGN KEY (�����_���_������) REFERENCES ����_���������� (�����_���_������) ON DELETE CASCADE,
	������_���� FLOAT NOT NULL,
	���_��_����� SMALLINT NOT NULL CHECK (���_��_����� >= 0),
	����� MONEY NOT NULL,
	�������_����� BIT DEFAULT 1,
	�����_������ TIME NOT NULL,
	�����_������ TIME NOT NULL)

CREATE TABLE ������
	(�����_������ INTEGER IDENTITY(1,1) PRIMARY KEY,
	�����_������ INTEGER NOT NULL,
	FOREIGN KEY (�����_������) REFERENCES �������� (�����_������) ON DELETE CASCADE,
	�����_���� INTEGER NOT NULL,
	FOREIGN KEY (�����_����) REFERENCES ������� (�����_����) ON DELETE CASCADE,
	����_������ DATE NOT NULL,
	����� INTEGER NOT NULL CHECK (����� >= 0 AND ����� <= 2),
	����_���� INTEGER DEFAULT 0,
	����_����_����� INTEGER DEFAULT 0,
	����_����� INTEGER DEFAULT 0,
	����_�����_����� INTEGER DEFAULT 0,
	�����_������ TIME,
	�����_������ TIME)

CREATE NONCLUSTERED INDEX index_���
ON �������� (�������, ���, ��������)

INSERT INTO ���������(���������)
SELECT '��������'
UNION ALL
SELECT '������'
UNION ALL
SELECT '���������'

INSERT INTO ��������(�������, ���, ��������, �����_�����, �������, �������, ����_����, �����, �����, �����_����_������, ���_��_�����, �����_���_��_�����, �������_�����, �����, ����_����_�����, �����, ����_�����_���_����)
SELECT '���������', '����', '����������', 1, '7516 298163', '+79485697821', '09-05-1997', '����', '�� ���������, � 21 �� 46', '��-V 5453892', '������', '101010 0253697', '�� 0915874', '156-485-875 89', '48569127943761825040', '1', '29-03-2014'
UNION ALL
SELECT '�������', '������', '����������', 2, '7419 982731', '+79218764290', '28-10-1975', '����', '�� ������, � 142 �� 87', '��-III 9486270', '�������������', '152697483015', '�� 9451875', '457-987-251 07', '31279480615043798451', '', ''
UNION ALL
SELECT '��������', '�����', '�������', 3, '7629 536281', '+79461378154', '16-08-1992', '����������', '�� �������, � 69', '��-II 9486270', '������', '�� 549732', '', '521-012-745 54', '14852140364209817530', '', ''
UNION ALL
SELECT '������', '����', '����������', 1, '7614 829903', '+75612497845', '01-12-1978', '��������', '�� ������, � 78', '��-IV 9486270', '������', '549761 9735154', '�� 1204657', '102-946-439 97', '74521803961253703109', '3', '16-08-1997'
UNION ALL
SELECT '����������', '�����', '������������', 2, '7623 213794', '+79632480102', '07-07-1982', '��������', '�� �����, � 65 �� 11', '��-V 0184752', '������', '94672154001345', '�� 2458715', '846-845-488 02', '74100026581324963266', '', ''
UNION ALL
SELECT '�������', '������', '����������', 1, '7416 548754', '+79248756021', '25-06-1975', '����', '�� �����������, � 42 �� 8', '��-III 7412548', '������', '216497 7845079', '�� 9764273', '457-653-251 07', '18542032658741256388', '1', '03-10-2003'
UNION ALL
SELECT '���������', '�������', '��������', 3, '7627 159375', '+79243197658', '16-08-1992', '����', '�� ������, � 10', '��-II 8945123', '������', '�� 056429', '', '513-012-219 54', '84653274094875683494', '', ''
UNION ALL
SELECT '��������', '�����', '����������', 1, '7615 784521', '+76792150032', '15-02-1978', '��������', '�� ���������, � 78', '��-IV 9461705', '������', '012497 9463721', '', '102-945-946 02', '09289257047328031942', '3', '16-08-1997'
UNION ALL
SELECT '�����', '������', '�������������', 2, '7623 142768', '+79546780109', '11-04-1982', '����', '�� ������, � 38 �� 13', '��-V 9461275', '�������������', '346791 2584034', '�� 9457621', '124-845-278 02', '65235785704065749823', '', ''
UNION ALL
SELECT '�����', '������', '����������', 1, '7419 845111', '+79992167340', '30-05-1975', '����', '�� ��������, � 180 �� 40', '��-III 8154270', '������', '�� 845469', '', '457-751-169 07', '90275476223413744385', '0', '19-04-1998'
UNION ALL
SELECT '���������', '���������', '����������', 2, '7622 780645', '+79962158437', '09-04-1992', '����������', '�� ������, � 64', '��-II 3194562', '�������������', '�� 987454', '�� 0123049', '485-012-979 54', '64583765273265468378', '', ''
UNION ALL
SELECT '����������', '����', '�����', 1, '7614 485155', '+79963248870', '03-06-1978', '��������', '�� �������, � 154', '��-IV 8457216', '������', '954164 8413548', '�� 3400768', '162-023-437 97', '09234776534792092341', '3', '16-08-1997'
UNION ALL
SELECT '�������', '�����', '��������', 2, '7621 984156', '+79143769810', '26-11-1982', '����', '�� ���������, � 49 �� 87', '��-V 2137957', '������', '321747 4189431', '�� 9450273', '412-845-013 02', '24079389651238971907', '', ''
UNION ALL
SELECT '���������', '����', '����������', 1, '7417 541545', '+79140123647', '17-03-1984', '����', '�� ���������, � 32� �� 14', '��-III 3124679', '������', '649721573278', '', '457-956-125 07', '87465236498263953438', '1', '21-08-2006'
UNION ALL
SELECT '�������', '������', '���������', 3, '7618 879821', '+79994812739', '19-10-1992', '����������', '�� �������������, � 55, �� 18', '��-II 1023458', '������', '�� 549732', '�� 0134961', '502-012-109 54', '90237948195464274937', '', ''
UNION ALL
SELECT '������', '����', '���������', 1, '7614 218410', '+72225497604', '21-12-1978', '����', '�� �����������, � 15, �� 21', '��-IV 6427918', '������', '231486 9841687', '�� 7945621', '712-946-439 90', '01927864512468278378', '3', '16-08-1997'
UNION ALL
SELECT '������', '���������', '����������', 1, '7619 987461', '+79264410794', '20-12-1982', '����', '�� ������, � 48 �� 2', '��-V 2184672', '������', '641321 8641219', '', '258-620-488 80', '83646091326426892713', '1', '20-12-2000'
UNION ALL
SELECT '���������', '�������', '����������', 1, '7621 321841', '+79145791035', '10-05-1982', '��������', '�� ����������, � 54', '��-V 3148756', '������', '2194578601278451', '�� 5498749', '945-845-656 02', '98657426498273871243', '2', '30-04-2012'
UNION ALL
SELECT '�������', '����', '�����', 1, '7615 193294', '+79264628794', '16-12-1979', '����', '�� �������������, � 15 �� 2', '��-III 9874613', '������', '641845 8641219', '�� 9485126', '845-153-488 80', '01246193562638102734', '1', '29-01-1999'
UNION ALL
SELECT '���������', '����', '������������', 1, '7621 762342', '+79145811035', '19-05-1989', '����', '�� ���������, � 98', '��-IV 2568756', '������', '943421 7451264', '�� 1812459', '444-999-656 92', '17834687622312097436', '2', '06-10-2008'

INSERT INTO ���������(����_�����, �����, ���_��_�����_����, �����_����_����, ���_����������, ���_�������)
SELECT 154, '����', 28, 85, 2019, 1996
UNION ALL
SELECT 107, '����', 36, 68, 2013, 1974
UNION ALL
SELECT 218, '���', 36, 52, 2017, 1979
UNION ALL
SELECT 114, '���', 36, 76, 2017, 1980
UNION ALL
SELECT 128, '����', 28, 68, 2019, 1997
UNION ALL
SELECT 203, '����', 42, 85, 2019, 1997
UNION ALL
SELECT 137, '���', 28, 85, 2016, 1995
UNION ALL
SELECT 187, '���', 36, 76, 2012, 1973
UNION ALL
SELECT 192, '����', 42, 52, 2019, 1987

INSERT INTO ���_����(���_����)
SELECT '�����'
UNION ALL
SELECT '������'
UNION ALL
SELECT '��������'

INSERT INTO ������������(�����_������, ����_�����, �����_����, ����_������)
SELECT 9, 154, 1, '09-09-2022'
UNION ALL
SELECT 9, 154, 1, '11-09-2022'
UNION ALL
SELECT 9, 154, 1, '09-11-2022'
UNION ALL
SELECT 5, 187, 3, '10-09-2022'
UNION ALL
SELECT 2, 192, 2, '10-09-2022'
UNION ALL
SELECT 5, 203, 2, '11-09-2022'
UNION ALL
SELECT 9, 203, 3, '12-09-2022'
UNION ALL
SELECT 2, 107, 3, '13-09-2022'
UNION ALL
SELECT 2, 218, 1, '13-09-2022'
UNION ALL
SELECT 9, 154, 2, '14-09-2022'
UNION ALL
SELECT 5, 192, 3, '14-09-2022'
UNION ALL
SELECT 5, 218, 1, '14-09-2022'
UNION ALL
SELECT 2, 203, 3, '21-05-2023'
UNION ALL
SELECT 2, 203, 3, '22-05-2023'
UNION ALL
SELECT 2, 203, 3, '23-05-2023'
UNION ALL
SELECT 2, 203, 3, '25-05-2023'
UNION ALL
SELECT 9, 154, 1, '25-05-2023'

INSERT INTO ����_����������(���_������)
SELECT '�������'
UNION ALL
SELECT '����������'

INSERT INTO �������(�����_����, �����_���_������, ������_����, ���_��_�����, �����, �������_�����, �����_������, �����_������)
SELECT 1, 2, 42.6, 18, 32, 1, '6:47', '21:37'
UNION ALL
SELECT 2, 2, 28.2, 21, 32, 1, '5:43', '20:49'
UNION ALL
SELECT 3, 2, 36.3, 16, 32, 1, '5:57', '19:47'
UNION ALL
SELECT 6, 2, 41.9, 20, 32, 1, '6:21', '20:18'
UNION ALL
SELECT 17, 1, 43.8, 1, 32, 1, '6:18', '19:52'
UNION ALL
SELECT 9, 1, 36.2, 2, 30, 1, '6:47', '19:40'
UNION ALL
SELECT 87, 1, 28.2, 2, 33, 1, '5:46', '18:27'
UNION ALL
SELECT 102, 1, 41.9, 2, 36, 1, '5:53', '17:26'
UNION ALL
SELECT 41, 1, 32.5, 1, 36, 1, '7:20', '19:02'
UNION ALL
SELECT 19, 1, 34.7, 3, 32, 1, '7:03', '15:42'
UNION ALL
SELECT 30, 1, 41.6, 2, 32, 1, '6:09', '19:56'
UNION ALL
SELECT 5, 1, 42.3, 4, 38, 1, '6:15', '22:07'
UNION ALL
SELECT 44, 1, 39.7, 1, 35, 1, '7:43', '17:57'

INSERT INTO ������(�����_������, �����_����, ����_������, �����, ����_����, ����_����_�����, ����_�����, ����_�����_�����, �����_������, �����_������)
SELECT 6, 17, '2022-09-09', 0, 58, 36, 25, 81, '6:21', '19:48'
UNION ALL
SELECT 1, 41, '2022-09-09', 2, 64, 21, 52, 41, '7:35', '18:52'
UNION ALL
SELECT 4, 30, '2022-09-09', 0, 52, 63, 14, 15, '6:15', '20:13'
UNION ALL
SELECT 12, 19, '2022-09-10', 1, 25, 36, 15, 26, '7:00', '13:45'
UNION ALL
SELECT 20, 44, '2022-09-10', 2, 28, 64, 34, 26, '8:02', '17:52'
UNION ALL
SELECT 17, 5, '2022-09-10', 2, 102, 36, 26, 48, '6:18', '22:05'
UNION ALL
SELECT 8, 102, '2022-09-10', 0, 89, 59, 24, 39, '5:27', '21:51'
UNION ALL
SELECT 14, 3, '2022-09-11', 0, 102, 36, 105, 34, '5:58', '19:44'
UNION ALL
SELECT 1, 2, '2022-09-11', 0, 106, 42, 107, 39, '5:44', '20:51'
UNION ALL
SELECT 16, 3, '2022-09-11', 0, 95, 36, 48, 92, '6:00', '19:49'
UNION ALL
SELECT 10, 9, '2022-09-11', 1, 59, 68, 17, 43, '6:46', '19:38'
UNION ALL
SELECT 12, 17, '2022-09-12', 2, 15, 12, 34, 29, '6:15', '20:05'
UNION ALL
SELECT 18, 87, '2022-09-12', 2, 25, 24, 18, 43, '5:53', '18:23'
UNION ALL
SELECT 4, 44, '2022-09-12', 1, 82, 62, 15, 43, '7:45', '18:03'
UNION ALL
SELECT 6, 41, '2022-09-12', 1, 34, 62, 52, 15, '7:20', '15:42'
UNION ALL
SELECT 19, 30, '2022-09-13', 2, 16, 84, 22, 64, '6:26', '19:49'
UNION ALL
SELECT 14, 17, '2022-09-13', 0, 48, 26, 35, 18, '6:28', '19:57'
UNION ALL
SELECT 20, 102, '2022-09-13', 0, 152, 64, 29, 38, '5:52', '21:42'
UNION ALL
SELECT 14, 17, '2023-05-20', 0, 48, 26, 35, 18, '6:28', '19:57'
UNION ALL
SELECT 16, 102, '2023-05-20', 0, 152, 64, 29, 38, '', ''
UNION ALL
SELECT 3, 41, '2023-05-22', 2, 64, 21, 52, 41, '', ''
UNION ALL
SELECT 9, 30, '2023-05-22', 0, 52, 63, 14, 15, '6:15', '20:13'
UNION ALL
SELECT 17, 19, '2023-05-25', 1, 25, 36, 15, 26, '7:00', '13:45'
UNION ALL
SELECT 13, 44, '2023-05-25', 2, 28, 64, 34, 26, '', ''
UNION ALL
SELECT 5, 5, '2023-05-25', 2, 102, 36, 26, 48, '', ''

SELECT * FROM ���������
SELECT * FROM ��������
SELECT * FROM ���������
SELECT * FROM ���_����
SELECT * FROM ������������
SELECT * FROM ����_����������
SELECT * FROM �������
SELECT * FROM ������

CREATE VIEW ����������
AS
SELECT �������+' '+���+' '+�������� as [������ ���], ����_����, ����� FROM ��������
WHERE ����� = 1 AND YEAR(����_����) < YEAR(GETDATE())-40

SELECT * FROM ����������

CREATE VIEW �����32
AS
SELECT �������+' '+���+' '+�������� as [������ ���], ������.�����_���� FROM ��������, ������
INNER JOIN �������
ON ������.�����_���� = �������.�����_����
WHERE ����� = 32 AND ��������.�����_������ = ������.�����_������
GROUP BY �������+' '+���+' '+��������, ������.�����_����

SELECT * FROM �����32

CREATE VIEW ��������
AS
SELECT �������+' '+���+' '+�������� as [���] FROM ��������
WHERE (�����_������ IN (SELECT �����_������ FROM ������
WHERE ����_������ = CONVERT(DATE, GETDATE()) AND (�����_������ = '')))

SELECT * FROM ��������

CREATE VIEW ������
AS
SELECT ����_�����, ���_����, COUNT(���_����) as [���������� �� 2022 ���] FROM ���_����, ������������
WHERE ������������.�����_���� = ���_����.�����_���� AND YEAR(����_������) = 2022
GROUP BY ���_����, ����_�����

SELECT * FROM ������

SELECT DISTINCT(�������+' '+���+' '+��������) as ���,
	COUNT(�����_������) OVER (PARTITION BY �������+' '+���+' '+��������) [���������� ������� � ���� ����],
	SUM(����_�����+����_����) OVER (PARTITION BY �������+' '+���+' '+��������) [���������� ��� �����],
	SUM(����_�����_�����+����_����_�����) OVER (PARTITION BY �������+' '+���+' '+��������) [���������� � ��������],
	SUM(����_�����+����_�����_�����+����_����+����_����_�����) OVER (PARTITION BY �������+' '+���+' '+��������) [����� ����� ����������]
FROM ������ �
INNER JOIN �������� �
ON �.�����_������ = �.�����_������
WHERE YEAR(����_������) = YEAR(GETDATE())
GROUP BY �������+' '+���+' '+��������, �����_������, ����_�����, ����_����, ����_�����_�����, +����_����_�����;

UPDATE ������
SET �����_������ = '6:23'
WHERE �����_������ = 3

DELETE ������������
WHERE ����_������ = '2022-09-09'

DELETE ������������
WHERE ����_����� IN (SELECT ����_����� FROM ���������
WHERE (YEAR(GETDATE())-���_������� > 40))

/*������ ��������� �����*/
BACKUP DATABASE ��������������
TO DISK = 'D:\university\�����\���� ������\��������\bm\backup\BusManage.bak'
/*������������ ��������� �����*/
BACKUP DATABASE ��������������
TO DISK='D:\university\�����\���� ������\��������\bm\backup\BusManage.bak' 
WITH DIFFERENTIAL
/*�������� ������� ������ �������������� ������*/
ALTER DATABASE ��������������
SET RECOVERY SIMPLE
/*�������������� ��*/
RESTORE DATABASE ��������������
FROM DISK='D:\university\�����\���� ������\��������\bm\backup\BusManage.bak'

CREATE PROCEDURE getFlight
AS
	SELECT �����_������, �����_����, ����_������
	FROM ������
	WHERE ����_������ >= '2022-09-11'

EXEC getFlight /*�����*/
DROP PROCEDURE getFlight /*��������*/

CREATE PROCEDURE ����������_������
	@��_������ INT OUT,
	@��_��� INTEGER,
	@�����_���� INTEGER,
	@���� DATE,
	@����� INTEGER,
	@����_���� INTEGER,
	@����_����_����� INTEGER,
	@����_����� INTEGER,
	@����_�����_����� INTEGER,
	@�����_������ TIME,
	@�����_������ TIME
AS
INSERT ������ (�����_������, �����_����, ����_������, �����, ����_����, ����_����_�����, ����_�����, ����_�����_�����, �����_������, �����_������)
VALUES (@��_���, @�����_����, @����, @�����, @����_����, @����_����_�����, @����_�����, @����_�����_�����, @�����_������, @�����_������)
SET @��_������=@@IDENTITY

DECLARE @��_������ INT
EXEC ����������_������
@��_��� = 14,
@�����_���� = 102,
@���� = '2023-05-25',
@����� = 2,
@����_���� = 54,
@����_����_����� = 23,
@����_����� = 82,
@����_�����_����� = 71,
@�����_������ = '6:48',
@�����_������ = '20:51',
@��_������ = @��_������ OUTPUT
SELECT @��_������ as '����� ���������� ������������ �����'

CREATE FUNCTION ������_������� (@data DATE)
RETURNS INT AS
BEGIN
	DECLARE @cnt INT
	SET @cnt=(SELECT COUNT(�����_������) FROM ������
	WHERE ����_������=@data AND �����_������='')
	RETURN (@cnt)
END

SELECT dbo.������_�������(CONVERT(DATE, GETDATE()))

CREATE FUNCTION ���������()
RETURNS TABLE
AS RETURN
	(SELECT �����_����, ����_������, �����,
	����_�����+����_���� as [���������� ��� �����],
	����_�����_�����+����_����_����� as [���������� � ��������],
	����_�����+����_�����_�����+����_����+����_����_����� as [����� ����� ����������]
	FROM ������
	WHERE ����_������ = CONVERT(DATE, GETDATE()))

SELECT * FROM ���������()

CREATE TRIGGER [���������� ����� ����������] ON ����_����������
INSTEAD OF INSERT
AS
BEGIN
	PRINT '���������� ������� � ������ ������� ����������.'
END

INSERT ����_���������� (���_������)
VALUES ('�������')

ALTER TABLE ������ ADD UpdateBy VARCHAR(25), UpdateWhen DATETIME;

CREATE TRIGGER [������������ ���������] ON ������
AFTER INSERT, UPDATE, DELETE
AS
	UPDATE ������
	SET ������.UpdateBy = USER_NAME(),
		������.UpdateWhen = GETDATE()
	FROM inserted, ������
	WHERE inserted.�����_������ = ������.�����_������;

DISABLE TRIGGER [���������� ����� ����������] ON ����_����������; /*���������� ��������*/
ENABLE TRIGGER [���������� ����� ����������] ON ����_����������; /*��������� ��������*/

UPDATE ������
SET �����_������ = 6
WHERE �����_������ = 12

SELECT * FROM ������

CREATE LOGIN Admins WITH PASSWORD='ADMINpass'
GO
CREATE USER AdminUser FOR LOGIN Admins
GO
GRANT ALL ON ��������� TO AdminUser
GRANT ALL ON �������� TO AdminUser
GRANT ALL ON ��������� TO AdminUser
GRANT ALL ON ���_���� TO AdminUser
GRANT ALL ON ������������ TO AdminUser
GRANT ALL ON ����_���������� TO AdminUser
GRANT ALL ON ������� TO AdminUser
GRANT ALL ON ������ TO AdminUser

CREATE LOGIN Director WITH PASSWORD='DIRECTORpass'
GO
CREATE USER DirectorUser FOR LOGIN Director
GO
GRANT SELECT, INSERT, UPDATE, DELETE ON ��������� TO DirectorUser
GRANT SELECT, INSERT, UPDATE, DELETE ON �������� TO DirectorUser
GRANT SELECT, INSERT, UPDATE, DELETE ON ��������� TO DirectorUser
GRANT SELECT, INSERT, UPDATE, DELETE ON ���_���� TO DirectorUser
GRANT SELECT ON ������������ TO DirectorUser
GRANT SELECT, INSERT, UPDATE, DELETE ON ����_���������� TO DirectorUser
GRANT SELECT, INSERT, UPDATE, DELETE ON ������� TO DirectorUser
GRANT SELECT, DELETE ON ������ TO DirectorUser

CREATE LOGIN Disp_Helen WITH PASSWORD='DISPpass'
GO
CREATE USER DispUser1 FOR LOGIN Disp_Helen
GO
GRANT SELECT ON ��������� TO DispUser1
GRANT SELECT ON �������� TO DispUser1
GRANT SELECT, UPDATE ON ��������� TO DispUser1
GRANT SELECT ON ���_���� TO DispUser1
GRANT SELECT, INSERT, UPDATE, DELETE ON ������������ TO DispUser1
GRANT SELECT, INSERT, UPDATE, DELETE ON ����_���������� TO DispUser1
GRANT SELECT, INSERT, UPDATE, DELETE ON ������� TO DispUser1
GRANT SELECT, INSERT, UPDATE, DELETE ON ������ TO DispUser1

CREATE LOGIN Disp_Nadezda WITH PASSWORD='DISPpass'
GO
CREATE USER DispUser2 FOR LOGIN Disp_Nadezda
GO
GRANT SELECT ON ��������� TO DispUser2
GRANT SELECT ON �������� TO DispUser2
GRANT SELECT, UPDATE ON ��������� TO DispUser2
GRANT SELECT ON ���_���� TO DispUser2
GRANT SELECT, INSERT, UPDATE, DELETE ON ������������ TO DispUser2
GRANT SELECT, INSERT, UPDATE, DELETE ON ����_���������� TO DispUser2
GRANT SELECT, INSERT, UPDATE, DELETE ON ������� TO DispUser2
GRANT SELECT, INSERT, UPDATE, DELETE ON ������ TO DispUser2

CREATE LOGIN Disp_Daniil WITH PASSWORD='DISPpass'
GO
CREATE USER DispUser3 FOR LOGIN Disp_Daniil
GO
GRANT SELECT ON ��������� TO DispUser3
GRANT SELECT ON �������� TO DispUser3
GRANT SELECT, UPDATE ON ��������� TO DispUser3
GRANT SELECT ON ���_���� TO DispUser3
GRANT SELECT, INSERT, UPDATE, DELETE ON ������������ TO DispUser3
GRANT SELECT, INSERT, UPDATE, DELETE ON ����_���������� TO DispUser3
GRANT SELECT, INSERT, UPDATE, DELETE ON ������� TO DispUser3
GRANT SELECT, INSERT, UPDATE, DELETE ON ������ TO DispUser3