USE [TestDB]
GO

/****** Object:  Table [dbo].[EventLog]    Script Date: 21.10.2024 01:21:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EventLog](
	[ID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[EventAction] [varchar](12) NOT NULL,
	[EventDate] [datetime] NOT NULL,
	[Description] [ntext] NULL,
 CONSTRAINT [PK_EventLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[EventLog] ADD  CONSTRAINT [DF_EventLog_ID]  DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[EventLog] ADD  CONSTRAINT [DF_EventLog_EventDate]  DEFAULT (getdate()) FOR [EventDate]
GO


