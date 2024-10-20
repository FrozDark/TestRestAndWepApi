USE [TestDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

INSERT INTO dbo.Product (ID, Name, Description) 
VALUES 
	('BE559E45-9B28-43ED-1215-08DCF1396B99', 'Спрайт', '')
	,('17160778-1039-48EC-1218-08DCF1396B99', 'Пепси', 'Аналог кока колы')
	,('41035AFB-A2D6-4ABC-1219-08DCF1396B99', 'Шоколад', 'От альпен гольд')
	,('0B74BBA0-38F8-42A5-121A-08DCF1396B99', 'Машина', 'Большая')
	,('F880E7A4-80E3-4BB4-121C-08DCF1396B99', 'Самолёт', 'Ил-22')
	,('62460C54-2600-4D27-121D-08DCF1396B99', 'Кружка', 'Чёрная')
	,('EF935C18-7461-4004-AFCB-8DED35C71DF8', 'Куртка', 'Описания нет')
	,('DEEA6C9C-A885-487C-A1D2-9F81CB4A3E65', 'Гитара', 'Описания нет')
	,('5B45D8D1-D5E3-401C-9AEB-A6AEDAB6BFC2', 'Dobriy Fanta', 'No description provided')
	,('97C6FB42-C244-417E-BB6E-FAC792D2FE07', 'Dobriy Cola', 'No description provided');
GO

INSERT INTO dbo.ProductVersion (ProductID, Name, Description, CreatingDate, Height, Width, Length)
VALUES
	('DEEA6C9C-A885-487C-A1D2-9F81CB4A3E65', 'Версия номер 1', 'Тут описание версии 1', '2024-10-20 18:13:59.753', 10.2, 15.6, 20.35)
	,('DEEA6C9C-A885-487C-A1D2-9F81CB4A3E65', 'Версия номер 2', 'Тут описание версии 2', '2024-10-20 18:14:21.377', 23.2, 26.6, 40.35);
GO