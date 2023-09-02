CREATE DATABASE АвтоУправление
ON
PRIMARY (NAME=BusManage, 
	FILENAME='D:\university\забгу\базы данных\курсовая\bm\BusManage.mdf', 
	SIZE=5,  
	MAXSIZE=10,
	FILEGROWTH=10%)
LOG ON (NAME= BusManage_log,
	FILENAME='D:\university\забгу\базы данных\курсовая\bm\BusManage.ldf', 
	SIZE=1, 
	MAXSIZE=5,
	FILEGROWTH=10%)

CREATE TABLE Должности
	(Идент_должн INTEGER IDENTITY(1,1) PRIMARY KEY,
	Должность VARCHAR(10) NOT NULL)

CREATE TABLE Персонал
	(Идент_работн INTEGER IDENTITY(1,1) PRIMARY KEY,
	Фамилия VARCHAR(20) NOT NULL,
	Имя VARCHAR(15) NOT NULL,
	Отчество VARCHAR(25),
	Идент_должн INTEGER NOT NULL,
	FOREIGN KEY (Идент_должн) REFERENCES Должности (Идент_должн) ON DELETE CASCADE,
	Паспорт CHAR(11) NOT NULL UNIQUE,
	Телефон CHAR(12) NOT NULL UNIQUE,
	Дата_рожд DATE NOT NULL,
	Город VARCHAR(25) NOT NULL,
	Адрес VARCHAR(40) NOT NULL,
	Номер_труд_книжки VARCHAR(14) NOT NULL UNIQUE,
	Док_об_образ VARCHAR(35) NOT NULL,
	Номер_док_об_образ VARCHAR(20) NOT NULL,
	Военный_билет CHAR(10) DEFAULT '0',
	СНИЛС CHAR(17) NOT NULL UNIQUE,
	Рекв_банк_карты CHAR(20) NOT NULL UNIQUE,
	Класс SMALLINT CHECK (Класс >= 0 AND Класс <= 3),
	Дата_получ_вод_прав DATE)

CREATE TABLE Транспорт
	(Борт_номер CHAR(3) DEFAULT '000' PRIMARY KEY,
	Марка VARCHAR(10) NOT NULL,
	Кол_во_посад_мест INTEGER NOT NULL DEFAULT 0,
	Объем_топл_бака INTEGER NOT NULL,
	Год_постановки INTEGER NOT NULL,
	Год_выпуска INTEGER NOT NULL)

CREATE TABLE Вид_обсл
	(Идент_обсл INTEGER IDENTITY(1,1) PRIMARY KEY,
	Вид_обсл VARCHAR(8))

CREATE TABLE Обслуживание
	(Номер_заявки INTEGER IDENTITY(1,1),
	Идент_работн INTEGER NOT NULL,
	FOREIGN KEY (Идент_работн) REFERENCES Персонал (Идент_работн) ON DELETE CASCADE,
	Борт_номер CHAR(3) NOT NULL,
	FOREIGN KEY (Борт_номер) REFERENCES Транспорт (Борт_номер) ON DELETE CASCADE,
	Идент_обсл INTEGER NOT NULL,
	FOREIGN KEY (Идент_обсл) REFERENCES Вид_обсл (Идент_обсл) ON DELETE CASCADE,
	Дата_обслуж DATE NOT NULL)

CREATE TABLE Виды_транспорта
	(Идент_вид_трансп INTEGER IDENTITY(1,1) PRIMARY KEY,
	Вид_трансп VARCHAR(10) NOT NULL)

CREATE TABLE Маршрут
	(Номер_марш INTEGER NOT NULL PRIMARY KEY,
	Идент_вид_трансп INTEGER NOT NULL,
	FOREIGN KEY (Идент_вид_трансп) REFERENCES Виды_транспорта (Идент_вид_трансп) ON DELETE CASCADE,
	Протяж_марш FLOAT NOT NULL,
	Кол_во_машин SMALLINT NOT NULL CHECK (Кол_во_машин >= 0),
	Тариф MONEY NOT NULL,
	Наличие_льгот BIT DEFAULT 1,
	Время_выезда TIME NOT NULL,
	Время_заезда TIME NOT NULL)

CREATE TABLE Выезды
	(Идент_выезда INTEGER IDENTITY(1,1) PRIMARY KEY,
	Идент_работн INTEGER NOT NULL,
	FOREIGN KEY (Идент_работн) REFERENCES Персонал (Идент_работн) ON DELETE CASCADE,
	Номер_марш INTEGER NOT NULL,
	FOREIGN KEY (Номер_марш) REFERENCES Маршрут (Номер_марш) ON DELETE CASCADE,
	Дата_выезда DATE NOT NULL,
	Смена INTEGER NOT NULL CHECK (Смена >= 0 AND Смена <= 2),
	Пасс_терм INTEGER DEFAULT 0,
	Пасс_терм_льгот INTEGER DEFAULT 0,
	Пасс_билет INTEGER DEFAULT 0,
	Пасс_билет_льгот INTEGER DEFAULT 0,
	Время_выезда TIME,
	Время_заезда TIME)

CREATE NONCLUSTERED INDEX index_ФИО
ON Персонал (Фамилия, Имя, Отчество)

INSERT INTO Должности(Должность)
SELECT 'Водитель'
UNION ALL
SELECT 'Техник'
UNION ALL
SELECT 'Диспетчер'

INSERT INTO Персонал(Фамилия, Имя, Отчество, Идент_должн, Паспорт, Телефон, Дата_рожд, Город, Адрес, Номер_труд_книжки, Док_об_образ, Номер_док_об_образ, Военный_билет, СНИЛС, Рекв_банк_карты, Класс, Дата_получ_вод_прав)
SELECT 'Харлецкий', 'Петр', 'Дмитриевич', 1, '7516 298163', '+79485697821', '09-05-1997', 'Чита', 'ул Весенняяя, д 21 кв 46', 'ТК-V 5453892', 'Диплом', '101010 0253697', 'АС 0915874', '156-485-875 89', '48569127943761825040', '1', '29-03-2014'
UNION ALL
SELECT 'Горбань', 'Леонид', 'Максимович', 2, '7419 982731', '+79218764290', '28-10-1975', 'Чита', 'ул Ленина, д 142 кв 87', 'ТК-III 9486270', 'Свидетельство', '152697483015', 'НК 9451875', '457-987-251 07', '31279480615043798451', '', ''
UNION ALL
SELECT 'Дьяченко', 'Елена', 'Юрьевна', 3, '7629 536281', '+79461378154', '16-08-1992', 'Атамановка', 'ул Рабочая, д 69', 'ТК-II 9486270', 'Диплом', 'КТ 549732', '', '521-012-745 54', '14852140364209817530', '', ''
UNION ALL
SELECT 'Петров', 'Иван', 'Васильевич', 1, '7614 829903', '+75612497845', '01-12-1978', 'Смоленка', 'ул Лесная, д 78', 'ТК-IV 9486270', 'Диплом', '549761 9735154', 'НП 1204657', '102-946-439 97', '74521803961253703109', '3', '16-08-1997'
UNION ALL
SELECT 'Меланченко', 'Игорь', 'Владимирович', 2, '7623 213794', '+79632480102', '07-07-1982', 'Антипиха', 'ул Ясная, д 65 кв 11', 'ТК-V 0184752', 'Диплом', '94672154001345', 'АС 2458715', '846-845-488 02', '74100026581324963266', '', ''
UNION ALL
SELECT 'Рогожин', 'Леонид', 'Степанович', 1, '7416 548754', '+79248756021', '25-06-1975', 'Чита', 'ул Богомягкова, д 42 кв 8', 'ТК-III 7412548', 'Диплом', '216497 7845079', 'НК 9764273', '457-653-251 07', '18542032658741256388', '1', '03-10-2003'
UNION ALL
SELECT 'Кирьянова', 'Надежда', 'Петровна', 3, '7627 159375', '+79243197658', '16-08-1992', 'Чита', 'ул Бутина, д 10', 'ТК-II 8945123', 'Диплом', 'КТ 056429', '', '513-012-219 54', '84653274094875683494', '', ''
UNION ALL
SELECT 'Ткаченко', 'Дарья', 'Михайловна', 1, '7615 784521', '+76792150032', '15-02-1978', 'Смоленка', 'ул Советская, д 78', 'ТК-IV 9461705', 'Диплом', '012497 9463721', '', '102-945-946 02', '09289257047328031942', '3', '16-08-1997'
UNION ALL
SELECT 'Чижов', 'Михаил', 'Владиславович', 2, '7623 142768', '+79546780109', '11-04-1982', 'Чита', 'ул Шилова, д 38 кв 13', 'ТК-V 9461275', 'Свидетельство', '346791 2584034', 'АС 9457621', '124-845-278 02', '65235785704065749823', '', ''
UNION ALL
SELECT 'Чебан', 'Таисия', 'Валерьевна', 1, '7419 845111', '+79992167340', '30-05-1975', 'Чита', 'ул Балябина, д 180 кв 40', 'ТК-III 8154270', 'Диплом', 'КТ 845469', '', '457-751-169 07', '90275476223413744385', '0', '19-04-1998'
UNION ALL
SELECT 'Кореньков', 'Владислав', 'Леонидович', 2, '7622 780645', '+79962158437', '09-04-1992', 'Атамановка', 'ул Ленина, д 64', 'ТК-II 3194562', 'Свидетельство', 'КТ 987454', 'АЕ 0123049', '485-012-979 54', '64583765273265468378', '', ''
UNION ALL
SELECT 'Костюченко', 'Петр', 'Ильич', 1, '7614 485155', '+79963248870', '03-06-1978', 'Смоленка', 'ул Чкалова, д 154', 'ТК-IV 8457216', 'Диплом', '954164 8413548', 'НП 3400768', '162-023-437 97', '09234776534792092341', '3', '16-08-1997'
UNION ALL
SELECT 'Назимов', 'Игорь', 'Олегович', 2, '7621 984156', '+79143769810', '26-11-1982', 'Чита', 'ул Ангарская, д 49 кв 87', 'ТК-V 2137957', 'Диплом', '321747 4189431', 'АС 9450273', '412-845-013 02', '24079389651238971907', '', ''
UNION ALL
SELECT 'Череповец', 'Анна', 'Дмитриевна', 1, '7417 541545', '+79140123647', '17-03-1984', 'Чита', 'ул Бабушкина, д 32Б кв 14', 'ТК-III 3124679', 'Диплом', '649721573278', '', '457-956-125 07', '87465236498263953438', '1', '21-08-2006'
UNION ALL
SELECT 'Укропин', 'Даниил', 'Сергеевич', 3, '7618 879821', '+79994812739', '19-10-1992', 'Атамановка', 'ул Ленинградская, д 55, кв 18', 'ТК-II 1023458', 'Диплом', 'КТ 549732', 'АЕ 0134961', '502-012-109 54', '90237948195464274937', '', ''
UNION ALL
SELECT 'Панько', 'Иван', 'Данилович', 1, '7614 218410', '+72225497604', '21-12-1978', 'Чита', 'ул Энтузиастов, д 15, кв 21', 'ТК-IV 6427918', 'Диплом', '231486 9841687', 'НП 7945621', '712-946-439 90', '01927864512468278378', '3', '16-08-1997'
UNION ALL
SELECT 'Калько', 'Анастасия', 'Валерьевна', 1, '7619 987461', '+79264410794', '20-12-1982', 'Чита', 'ул Рахова, д 48 кв 2', 'ТК-V 2184672', 'Диплом', '641321 8641219', '', '258-620-488 80', '83646091326426892713', '1', '20-12-2000'
UNION ALL
SELECT 'Ворошилов', 'Дмитрий', 'Степанович', 1, '7621 321841', '+79145791035', '10-05-1982', 'Антипиха', 'ул Ивановская, д 54', 'ТК-V 3148756', 'Диплом', '2194578601278451', 'АС 5498749', '945-845-656 02', '98657426498273871243', '2', '30-04-2012'
UNION ALL
SELECT 'Сидоров', 'Олег', 'Ильич', 1, '7615 193294', '+79264628794', '16-12-1979', 'Чита', 'ул Курнатовского, д 15 кв 2', 'ТК-III 9874613', 'Диплом', '641845 8641219', 'НП 9485126', '845-153-488 80', '01246193562638102734', '1', '29-01-1999'
UNION ALL
SELECT 'Карнаухов', 'Петр', 'Владимирович', 1, '7621 762342', '+79145811035', '19-05-1989', 'Чита', 'ул Кенонская, д 98', 'ТК-IV 2568756', 'Диплом', '943421 7451264', 'КТ 1812459', '444-999-656 92', '17834687622312097436', '2', '06-10-2008'

INSERT INTO Транспорт(Борт_номер, Марка, Кол_во_посад_мест, Объем_топл_бака, Год_постановки, Год_выпуска)
SELECT 154, 'ЛиАЗ', 28, 85, 2019, 1996
UNION ALL
SELECT 107, 'ЛиАЗ', 36, 68, 2013, 1974
UNION ALL
SELECT 218, 'ЗиУ', 36, 52, 2017, 1979
UNION ALL
SELECT 114, 'ЗиУ', 36, 76, 2017, 1980
UNION ALL
SELECT 128, 'ЛиАЗ', 28, 68, 2019, 1997
UNION ALL
SELECT 203, 'ЛиАЗ', 42, 85, 2019, 1997
UNION ALL
SELECT 137, 'ВМЗ', 28, 85, 2016, 1995
UNION ALL
SELECT 187, 'БТЗ', 36, 76, 2012, 1973
UNION ALL
SELECT 192, 'ЛиАЗ', 42, 52, 2019, 1987

INSERT INTO Вид_обсл(Вид_обсл)
SELECT 'Помыв'
UNION ALL
SELECT 'Ремонт'
UNION ALL
SELECT 'Заправка'

INSERT INTO Обслуживание(Идент_работн, Борт_номер, Идент_обсл, Дата_обслуж)
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

INSERT INTO Виды_транспорта(Вид_трансп)
SELECT 'Автобус'
UNION ALL
SELECT 'Троллейбус'

INSERT INTO Маршрут(Номер_марш, Идент_вид_трансп, Протяж_марш, Кол_во_машин, Тариф, Наличие_льгот, Время_выезда, Время_заезда)
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

INSERT INTO Выезды(Идент_работн, Номер_марш, Дата_выезда, Смена, Пасс_терм, Пасс_терм_льгот, Пасс_билет, Пасс_билет_льгот, Время_выезда, Время_заезда)
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

SELECT * FROM Должности
SELECT * FROM Персонал
SELECT * FROM Транспорт
SELECT * FROM Вид_обсл
SELECT * FROM Обслуживание
SELECT * FROM Виды_транспорта
SELECT * FROM Маршрут
SELECT * FROM Выезды

CREATE VIEW Классность
AS
SELECT Фамилия+' '+Имя+' '+Отчество as [Полное имя], Дата_рожд, Класс FROM Персонал
WHERE Класс = 1 AND YEAR(Дата_рожд) < YEAR(GETDATE())-40

SELECT * FROM Классность

CREATE VIEW Тариф32
AS
SELECT Фамилия+' '+Имя+' '+Отчество as [Полное имя], Выезды.Номер_марш FROM Персонал, Выезды
INNER JOIN Маршрут
ON Выезды.Номер_марш = Маршрут.Номер_марш
WHERE Тариф = 32 AND Персонал.Идент_работн = Выезды.Идент_работн
GROUP BY Фамилия+' '+Имя+' '+Отчество, Выезды.Номер_марш

SELECT * FROM Тариф32

CREATE VIEW НеВыходы
AS
SELECT Фамилия+' '+Имя+' '+Отчество as [ФИО] FROM Персонал
WHERE (Идент_работн IN (SELECT Идент_работн FROM Выезды
WHERE Дата_выезда = CONVERT(DATE, GETDATE()) AND (Время_выезда = '')))

SELECT * FROM НеВыходы

CREATE VIEW Сервис
AS
SELECT Борт_номер, Вид_обсл, COUNT(Вид_обсл) as [Количество за 2022 год] FROM Вид_обсл, Обслуживание
WHERE Обслуживание.Идент_обсл = Вид_обсл.Идент_обсл AND YEAR(Дата_обслуж) = 2022
GROUP BY Вид_обсл, Борт_номер

SELECT * FROM Сервис

SELECT DISTINCT(Фамилия+' '+Имя+' '+Отчество) as ФИО,
	COUNT(Идент_выезда) OVER (PARTITION BY Фамилия+' '+Имя+' '+Отчество) [Количество выездов в этом году],
	SUM(Пасс_билет+Пасс_терм) OVER (PARTITION BY Фамилия+' '+Имя+' '+Отчество) [Пассажиров без льгот],
	SUM(Пасс_билет_льгот+Пасс_терм_льгот) OVER (PARTITION BY Фамилия+' '+Имя+' '+Отчество) [Пассажиров с льготами],
	SUM(Пасс_билет+Пасс_билет_льгот+Пасс_терм+Пасс_терм_льгот) OVER (PARTITION BY Фамилия+' '+Имя+' '+Отчество) [Общее число пассажиров]
FROM Выезды В
INNER JOIN Персонал П
ON В.Идент_работн = П.Идент_работн
WHERE YEAR(Дата_выезда) = YEAR(GETDATE())
GROUP BY Фамилия+' '+Имя+' '+Отчество, Идент_выезда, Пасс_билет, Пасс_терм, Пасс_билет_льгот, +Пасс_терм_льгот;

UPDATE Выезды
SET Время_выезда = '6:23'
WHERE Идент_выезда = 3

DELETE Обслуживание
WHERE Дата_обслуж = '2022-09-09'

DELETE Обслуживание
WHERE Борт_номер IN (SELECT Борт_номер FROM Транспорт
WHERE (YEAR(GETDATE())-Год_выпуска > 40))

/*полная резервная копия*/
BACKUP DATABASE АвтоУправление
TO DISK = 'D:\university\забгу\базы данных\курсовая\bm\backup\BusManage.bak'
/*инкрементная резервная копия*/
BACKUP DATABASE АвтоУправление
TO DISK='D:\university\забгу\базы данных\курсовая\bm\backup\BusManage.bak' 
WITH DIFFERENTIAL
/*задается простая модель восстановления данных*/
ALTER DATABASE АвтоУправление
SET RECOVERY SIMPLE
/*восстановление БД*/
RESTORE DATABASE АвтоУправление
FROM DISK='D:\university\забгу\базы данных\курсовая\bm\backup\BusManage.bak'

CREATE PROCEDURE getFlight
AS
	SELECT Идент_работн, Номер_марш, Дата_выезда
	FROM Выезды
	WHERE Дата_выезда >= '2022-09-11'

EXEC getFlight /*ВЫЗОВ*/
DROP PROCEDURE getFlight /*УДАЛЕНИЕ*/

CREATE PROCEDURE Добавление_выезда
	@ИД_выезда INT OUT,
	@ИД_раб INTEGER,
	@Номер_марш INTEGER,
	@Дата DATE,
	@Смена INTEGER,
	@Пасс_терм INTEGER,
	@Пасс_терм_льгот INTEGER,
	@Пасс_билет INTEGER,
	@Пасс_билет_льгот INTEGER,
	@Время_выезда TIME,
	@Время_заезда TIME
AS
INSERT Выезды (Идент_работн, Номер_марш, Дата_выезда, Смена, Пасс_терм, Пасс_терм_льгот, Пасс_билет, Пасс_билет_льгот, Время_выезда, Время_заезда)
VALUES (@ИД_раб, @Номер_марш, @Дата, @Смена, @Пасс_терм, @Пасс_терм_льгот, @Пасс_билет, @Пасс_билет_льгот, @Время_выезда, @Время_заезда)
SET @ИД_выезда=@@IDENTITY

DECLARE @ИД_выезда INT
EXEC добавление_выезда
@ИД_раб = 14,
@Номер_марш = 102,
@Дата = '2023-05-25',
@Смена = 2,
@Пасс_терм = 54,
@Пасс_терм_льгот = 23,
@Пасс_билет = 82,
@Пасс_билет_льгот = 71,
@Время_выезда = '6:48',
@Время_заезда = '20:51',
@ИД_выезда = @ИД_выезда OUTPUT
SELECT @ИД_выезда as 'Номер последнего добавленного рейса'

CREATE FUNCTION Выезды_сегодня (@data DATE)
RETURNS INT AS
BEGIN
	DECLARE @cnt INT
	SET @cnt=(SELECT COUNT(Идент_выезда) FROM Выезды
	WHERE Дата_выезда=@data AND Время_выезда='')
	RETURN (@cnt)
END

SELECT dbo.Выезды_сегодня(CONVERT(DATE, GETDATE()))

CREATE FUNCTION Пассажиры()
RETURNS TABLE
AS RETURN
	(SELECT Номер_марш, Дата_выезда, Смена,
	Пасс_билет+Пасс_терм as [Пассажиров без льгот],
	Пасс_билет_льгот+Пасс_терм_льгот as [Пассажиров с льготами],
	Пасс_билет+Пасс_билет_льгот+Пасс_терм+Пасс_терм_льгот as [Общее число пассажиров]
	FROM Выезды
	WHERE Дата_выезда = CONVERT(DATE, GETDATE()))

SELECT * FROM Пассажиры()

CREATE TRIGGER [Добавление видов транспорта] ON Виды_транспорта
INSTEAD OF INSERT
AS
BEGIN
	PRINT 'Добавление записей в данную таблицу невозможно.'
END

INSERT Виды_транспорта (Вид_трансп)
VALUES ('Трамвай')

ALTER TABLE Выезды ADD UpdateBy VARCHAR(25), UpdateWhen DATETIME;

CREATE TRIGGER [Отслеживание изменений] ON Выезды
AFTER INSERT, UPDATE, DELETE
AS
	UPDATE Выезды
	SET Выезды.UpdateBy = USER_NAME(),
		Выезды.UpdateWhen = GETDATE()
	FROM inserted, Выезды
	WHERE inserted.Идент_выезда = Выезды.Идент_выезда;

DISABLE TRIGGER [Добавление видов транспорта] ON Виды_транспорта; /*отключение триггера*/
ENABLE TRIGGER [Добавление видов транспорта] ON Виды_транспорта; /*включение триггера*/

UPDATE Выезды
SET Идент_работн = 6
WHERE Идент_выезда = 12

SELECT * FROM Выезды

CREATE LOGIN Admins WITH PASSWORD='ADMINpass'
GO
CREATE USER AdminUser FOR LOGIN Admins
GO
GRANT ALL ON Должности TO AdminUser
GRANT ALL ON Персонал TO AdminUser
GRANT ALL ON Транспорт TO AdminUser
GRANT ALL ON Вид_обсл TO AdminUser
GRANT ALL ON Обслуживание TO AdminUser
GRANT ALL ON Виды_транспорта TO AdminUser
GRANT ALL ON Маршрут TO AdminUser
GRANT ALL ON Выезды TO AdminUser

CREATE LOGIN Director WITH PASSWORD='DIRECTORpass'
GO
CREATE USER DirectorUser FOR LOGIN Director
GO
GRANT SELECT, INSERT, UPDATE, DELETE ON Должности TO DirectorUser
GRANT SELECT, INSERT, UPDATE, DELETE ON Персонал TO DirectorUser
GRANT SELECT, INSERT, UPDATE, DELETE ON Транспорт TO DirectorUser
GRANT SELECT, INSERT, UPDATE, DELETE ON Вид_обсл TO DirectorUser
GRANT SELECT ON Обслуживание TO DirectorUser
GRANT SELECT, INSERT, UPDATE, DELETE ON Виды_транспорта TO DirectorUser
GRANT SELECT, INSERT, UPDATE, DELETE ON Маршрут TO DirectorUser
GRANT SELECT, DELETE ON Выезды TO DirectorUser

CREATE LOGIN Disp_Helen WITH PASSWORD='DISPpass'
GO
CREATE USER DispUser1 FOR LOGIN Disp_Helen
GO
GRANT SELECT ON Должности TO DispUser1
GRANT SELECT ON Персонал TO DispUser1
GRANT SELECT, UPDATE ON Транспорт TO DispUser1
GRANT SELECT ON Вид_обсл TO DispUser1
GRANT SELECT, INSERT, UPDATE, DELETE ON Обслуживание TO DispUser1
GRANT SELECT, INSERT, UPDATE, DELETE ON Виды_транспорта TO DispUser1
GRANT SELECT, INSERT, UPDATE, DELETE ON Маршрут TO DispUser1
GRANT SELECT, INSERT, UPDATE, DELETE ON Выезды TO DispUser1

CREATE LOGIN Disp_Nadezda WITH PASSWORD='DISPpass'
GO
CREATE USER DispUser2 FOR LOGIN Disp_Nadezda
GO
GRANT SELECT ON Должности TO DispUser2
GRANT SELECT ON Персонал TO DispUser2
GRANT SELECT, UPDATE ON Транспорт TO DispUser2
GRANT SELECT ON Вид_обсл TO DispUser2
GRANT SELECT, INSERT, UPDATE, DELETE ON Обслуживание TO DispUser2
GRANT SELECT, INSERT, UPDATE, DELETE ON Виды_транспорта TO DispUser2
GRANT SELECT, INSERT, UPDATE, DELETE ON Маршрут TO DispUser2
GRANT SELECT, INSERT, UPDATE, DELETE ON Выезды TO DispUser2

CREATE LOGIN Disp_Daniil WITH PASSWORD='DISPpass'
GO
CREATE USER DispUser3 FOR LOGIN Disp_Daniil
GO
GRANT SELECT ON Должности TO DispUser3
GRANT SELECT ON Персонал TO DispUser3
GRANT SELECT, UPDATE ON Транспорт TO DispUser3
GRANT SELECT ON Вид_обсл TO DispUser3
GRANT SELECT, INSERT, UPDATE, DELETE ON Обслуживание TO DispUser3
GRANT SELECT, INSERT, UPDATE, DELETE ON Виды_транспорта TO DispUser3
GRANT SELECT, INSERT, UPDATE, DELETE ON Маршрут TO DispUser3
GRANT SELECT, INSERT, UPDATE, DELETE ON Выезды TO DispUser3