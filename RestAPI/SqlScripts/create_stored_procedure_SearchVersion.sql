USE [TestDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[SearchProductVersion] 
	@productName nvarchar(255), 
	@productVersionName nvarchar(255),
	@minValue real,
	@maxValue real
AS
BEGIN
	SELECT pv.ID AS versionID, 
			p.Name AS name, 
			pv.Name AS versionName, 
			pv.Height AS height, 
			pv.Width AS width, 
			pv.Length AS length 
	FROM dbo.Product AS p INNER JOIN dbo.ProductVersion AS pv ON pv.ProductID = p.ID
	WHERE p.NAME LIKE '%' + @productName + '%'
		AND pv.NAME LIKE '%' + @productVersionName + '%'
		AND (pv.Height * pv.Width * pv.Length) > @minValue
		AND (pv.Height * pv.Width * pv.Length) < @maxValue
END
GO


