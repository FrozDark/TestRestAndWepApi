USE [TestDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER TRIGGER [dbo].[Product_LogTrigger_Delete]
   ON  [dbo].[Product] 
   AFTER DELETE
AS 
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.EventLog (EventAction, Description) VALUES ('DELETE', 'dbo.Product');
END
GO

ALTER TABLE [dbo].[Product] ENABLE TRIGGER [Product_LogTrigger_Delete]
GO


CREATE OR ALTER TRIGGER [dbo].[Product_LogTrigger_Insert] 
   ON  [dbo].[Product] 
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.EventLog (EventAction, Description) VALUES ('INSERT', 'dbo.Product');
END
GO

ALTER TABLE [dbo].[Product] ENABLE TRIGGER [Product_LogTrigger_Insert]
GO

CREATE OR ALTER TRIGGER [dbo].[Product_LogTrigger_Update]
   ON  [dbo].[Product] 
   AFTER UPDATE
AS 
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.EventLog (EventAction, Description) VALUES ('UPDATE', 'dbo.Product');
END
GO

ALTER TABLE [dbo].[Product] ENABLE TRIGGER [Product_LogTrigger_Update]
GO

CREATE OR ALTER TRIGGER [dbo].[ProductVersion_LogTrigger_Delete]
   ON  [dbo].[ProductVersion] 
   AFTER DELETE
AS 
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.EventLog (EventAction, Description) VALUES ('DELETE', 'dbo.ProductVersion');
END
GO

ALTER TABLE [dbo].[ProductVersion] ENABLE TRIGGER [ProductVersion_LogTrigger_Delete]
GO

CREATE OR ALTER TRIGGER [dbo].[ProductVersion_LogTrigger_Insert]
   ON  [dbo].[ProductVersion] 
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.EventLog (EventAction, Description) VALUES ('INSERT', 'dbo.ProductVersion');
END
GO

ALTER TABLE [dbo].[ProductVersion] ENABLE TRIGGER [ProductVersion_LogTrigger_Insert]
GO

CREATE OR ALTER TRIGGER [dbo].[ProductVersion_LogTrigger_Update]
   ON  [dbo].[ProductVersion] 
   AFTER UPDATE
AS 
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.EventLog (EventAction, Description) VALUES ('UPDATE', 'dbo.ProductVersion');
END
GO

ALTER TABLE [dbo].[ProductVersion] ENABLE TRIGGER [ProductVersion_LogTrigger_Update]
GO