CREATE TABLE [dbo].[DatabaseLog] (
  [DatabaseLogID] [int] IDENTITY,
  [PostTime] [datetime] NOT NULL,
  [DatabaseUser] [sysname],
  [Event] [sysname],
  [Schema] [sysname] NULL,
  [Object] [sysname] NULL,
  [TSQL] [nvarchar](max) NOT NULL,
  [XmlEvent] [xml] NOT NULL,
  CONSTRAINT [PK_DatabaseLog_DatabaseLogID] PRIMARY KEY NONCLUSTERED ([DatabaseLogID])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Audit table tracking all DDL changes made to the AdventureWorks database. Data is captured by the database trigger ddlDatabaseTriggerLog.', 'SCHEMA', N'dbo', 'TABLE', N'DatabaseLog'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index created by a primary key constraint.', 'SCHEMA', N'dbo', 'TABLE', N'DatabaseLog', 'INDEX', N'PK_DatabaseLog_DatabaseLogID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (nonclustered) constraint', 'SCHEMA', N'dbo', 'TABLE', N'DatabaseLog', 'CONSTRAINT', N'PK_DatabaseLog_DatabaseLogID'
GO