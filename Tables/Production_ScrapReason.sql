﻿CREATE TABLE [Production].[ScrapReason] (
  [ScrapReasonID] [smallint] IDENTITY,
  [Name] [dbo].[Name] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ScrapReason_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_ScrapReason_ScrapReasonID] PRIMARY KEY CLUSTERED ([ScrapReasonID])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_ScrapReason_Name]
  ON [Production].[ScrapReason] ([Name])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Manufacturing failure reasons lookup table.', 'SCHEMA', N'Production', 'TABLE', N'ScrapReason'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'ScrapReason', 'INDEX', N'AK_ScrapReason_Name'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'ScrapReason', 'INDEX', N'PK_ScrapReason_ScrapReasonID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'ScrapReason', 'CONSTRAINT', N'PK_ScrapReason_ScrapReasonID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'ScrapReason', 'CONSTRAINT', N'DF_ScrapReason_ModifiedDate'
GO