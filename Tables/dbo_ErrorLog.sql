CREATE TABLE [dbo].[ErrorLog] (
  [ErrorLogID] [int] IDENTITY,
  [ErrorTime] [datetime] NOT NULL CONSTRAINT [DF_ErrorLog_ErrorTime] DEFAULT (getdate()),
  [UserName] [sysname],
  [ErrorNumber] [int] NOT NULL,
  [ErrorSeverity] [int] NULL,
  [ErrorState] [int] NULL,
  [ErrorProcedure] [nvarchar](126) NULL,
  [ErrorLine] [int] NULL,
  [ErrorMessage] [nvarchar](4000) NOT NULL,
  CONSTRAINT [PK_ErrorLog_ErrorLogID] PRIMARY KEY CLUSTERED ([ErrorLogID])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Audit table tracking errors in the the AdventureWorks database that are caught by the CATCH block of a TRY...CATCH construct. Data is inserted by stored procedure dbo.uspLogError when it is executed from inside the CATCH block of a TRY...CATCH construct.', 'SCHEMA', N'dbo', 'TABLE', N'ErrorLog'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'dbo', 'TABLE', N'ErrorLog', 'INDEX', N'PK_ErrorLog_ErrorLogID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'dbo', 'TABLE', N'ErrorLog', 'CONSTRAINT', N'PK_ErrorLog_ErrorLogID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'dbo', 'TABLE', N'ErrorLog', 'CONSTRAINT', N'DF_ErrorLog_ErrorTime'
GO