CREATE TABLE [HumanResources].[Department] (
  [DepartmentID] [smallint] IDENTITY,
  [Name] [dbo].[Name] NOT NULL,
  [GroupName] [dbo].[Name] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Department_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_Department_DepartmentID] PRIMARY KEY CLUSTERED ([DepartmentID])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_Department_Name]
  ON [HumanResources].[Department] ([Name])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Lookup table containing the departments within the Adventure Works Cycles company.', 'SCHEMA', N'HumanResources', 'TABLE', N'Department'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'Department', 'INDEX', N'AK_Department_Name'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'HumanResources', 'TABLE', N'Department', 'INDEX', N'PK_Department_DepartmentID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'HumanResources', 'TABLE', N'Department', 'CONSTRAINT', N'PK_Department_DepartmentID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'HumanResources', 'TABLE', N'Department', 'CONSTRAINT', N'DF_Department_ModifiedDate'
GO