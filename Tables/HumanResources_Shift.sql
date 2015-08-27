CREATE TABLE [HumanResources].[Shift] (
  [ShiftID] [tinyint] IDENTITY,
  [Name] [dbo].[Name] NOT NULL,
  [StartTime] [datetime] NOT NULL,
  [EndTime] [datetime] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Shift_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_Shift_ShiftID] PRIMARY KEY CLUSTERED ([ShiftID])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_Shift_Name]
  ON [HumanResources].[Shift] ([Name])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_Shift_StartTime_EndTime]
  ON [HumanResources].[Shift] ([StartTime], [EndTime])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Work shift lookup table.', 'SCHEMA', N'HumanResources', 'TABLE', N'Shift'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'Shift', 'INDEX', N'AK_Shift_Name'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'Shift', 'INDEX', N'AK_Shift_StartTime_EndTime'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'HumanResources', 'TABLE', N'Shift', 'INDEX', N'PK_Shift_ShiftID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'HumanResources', 'TABLE', N'Shift', 'CONSTRAINT', N'PK_Shift_ShiftID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'HumanResources', 'TABLE', N'Shift', 'CONSTRAINT', N'DF_Shift_ModifiedDate'
GO