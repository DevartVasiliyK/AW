CREATE TABLE [HumanResources].[Employee] (
  [added] [int] NULL,
  [BirthDate] [datetime] NOT NULL,
  [ContactID] [int] NOT NULL,
  [CurrentFlag] [dbo].[Flag] NOT NULL CONSTRAINT [DF_Employee_CurrentFlag] DEFAULT (1),
  [EmployeeID] [int] IDENTITY,
  [Gender] [nchar](1) NOT NULL,
  [HireDate] [datetime] NOT NULL,
  [LoginID] [nvarchar](256) NOT NULL,
  [ManagerID] [int] NULL,
  [MaritalStatus] [nchar](1) NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Employee_ModifiedDate] DEFAULT (getdate()),
  [NationalIDNumber] [nvarchar](15) NOT NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Employee_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [SalariedFlag] [dbo].[Flag] NOT NULL CONSTRAINT [DF_Employee_SalariedFlag] DEFAULT (1),
  [SickLeaveHours] [smallint] NOT NULL CONSTRAINT [DF_Employee_SickLeaveHours] DEFAULT (0),
  [Title] [nvarchar](50) NOT NULL,
  [VacationHours] [smallint] NOT NULL CONSTRAINT [DF_Employee_VacationHours] DEFAULT (0),
  CONSTRAINT [PK_Employee_EmployeeID] PRIMARY KEY CLUSTERED ([EmployeeID]),
  CONSTRAINT [CK_Employee_BirthDate] CHECK ([BirthDate]>='1930-01-01' AND [BirthDate]<=dateadd(year,(-18),getdate())),
  CONSTRAINT [CK_Employee_HireDate] CHECK ([HireDate]>='1996-07-01' AND [HireDate]<=dateadd(day,(1),getdate())),
  CONSTRAINT [CK_Employee_SickLeaveHours] CHECK ([SickLeaveHours]>=(0) AND [SickLeaveHours]<=(120)),
  CONSTRAINT [FK_Employee_Contact_ContactID] FOREIGN KEY ([contactid]) REFERENCES [Person].[Contact] ([contactid]),
  CONSTRAINT [FK_Employee_Employee_ManagerID] FOREIGN KEY ([managerid]) REFERENCES [HumanResources].[Employee] ([employeeid])
)
ON [PRIMARY]
GO

ALTER TABLE [HumanResources].[Employee] WITH NOCHECK
  ADD CONSTRAINT [CK_Employee_Gender] CHECK (upper([Gender])='F' OR upper([Gender])='M')
GO

ALTER TABLE [HumanResources].[Employee]
  NOCHECK CONSTRAINT [CK_Employee_Gender]
GO

ALTER TABLE [HumanResources].[Employee] WITH NOCHECK
  ADD CONSTRAINT [CK_Employee_MaritalStatus] CHECK (upper([MaritalStatus])='S' OR upper([MaritalStatus])='M')
GO

ALTER TABLE [HumanResources].[Employee]
  CHECK CONSTRAINT [CK_Employee_MaritalStatus]
GO

ALTER TABLE [HumanResources].[Employee] WITH NOCHECK
  ADD CONSTRAINT [CK_Employee_VacationHours] CHECK ([VacationHours]>=(-40) AND [VacationHours]<=(240))
GO

ALTER TABLE [HumanResources].[Employee]
  CHECK CONSTRAINT [CK_Employee_VacationHours]
GO

CREATE UNIQUE INDEX [AK_Employee_LoginID]
  ON [HumanResources].[Employee] ([LoginID])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_Employee_NationalIDNumber]
  ON [HumanResources].[Employee] ([NationalIDNumber])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_Employee_rowguid]
  ON [HumanResources].[Employee] ([rowguid])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Employee_ManagerID]
  ON [HumanResources].[Employee] ([ManagerID])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE TRIGGER [dEmployee] ON [HumanResources].[Employee] 
INSTEAD OF DELETE NOT FOR REPLICATION AS 
BEGIN
DECLARE @Count int;
SET @Count = @@ROWCOUNT;
IF @Count = 0 
RETURN;
SET NOCOUNT ON;
BEGIN
RAISERROR
(N'Employees cannot be deleted. They can only be marked as not current.', -- Message
10, -- Severity.
1); -- State.
IF @@TRANCOUNT > 0
BEGIN
ROLLBACK TRANSACTION;
END
END;
END;
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [Gender]=''f'' OR [Gender]=''m'' OR [Gender]=''F'' OR [Gender]=''M''', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'CONSTRAINT', N'CK_Employee_Gender'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [MaritalStatus]=''s'' OR [MaritalStatus]=''m'' OR [MaritalStatus]=''S'' OR [MaritalStatus]=''M''', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'CONSTRAINT', N'CK_Employee_MaritalStatus'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [VacationHours] >= (-40) AND [VacationHours] <= (240)', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'CONSTRAINT', N'CK_Employee_VacationHours'
GO

DISABLE TRIGGER [HumanResources].[dEmployee] ON [HumanResources].Employee
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'INSTEAD OF DELETE trigger which keeps Employees from being deleted.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'TRIGGER', N'dEmployee'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Employee information such as salary, department, and title.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'INDEX', N'AK_Employee_LoginID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'INDEX', N'AK_Employee_NationalIDNumber'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'INDEX', N'AK_Employee_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'INDEX', N'IX_Employee_ManagerID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'INDEX', N'PK_Employee_EmployeeID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'CONSTRAINT', N'PK_Employee_EmployeeID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [BirthDate] >= ''1930-01-01'' AND [BirthDate] <= dateadd(year,(-18),GETDATE())', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'CONSTRAINT', N'CK_Employee_BirthDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [HireDate] >= ''1996-07-01'' AND [HireDate] <= dateadd(day,(1),GETDATE())', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'CONSTRAINT', N'CK_Employee_HireDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [SickLeaveHours] >= (0) AND [SickLeaveHours] <= (120)', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'CONSTRAINT', N'CK_Employee_SickLeaveHours'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 1', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'CONSTRAINT', N'DF_Employee_CurrentFlag'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'CONSTRAINT', N'DF_Employee_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'CONSTRAINT', N'DF_Employee_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 1 (TRUE)', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'CONSTRAINT', N'DF_Employee_SalariedFlag'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'CONSTRAINT', N'DF_Employee_SickLeaveHours'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'CONSTRAINT', N'DF_Employee_VacationHours'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Contact.ContactID.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'CONSTRAINT', N'FK_Employee_Contact_ContactID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Employee.ManagerID.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'CONSTRAINT', N'FK_Employee_Employee_ManagerID'
GO

ALTER TABLE [HumanResources].[Employee] WITH NOCHECK
  ADD 

ALTER TABLE [HumanResources].[Employee]
  NOCHECK CONSTRAINT [CK_Employee_Gender]
GO

ALTER TABLE [HumanResources].[Employee] WITH NOCHECK
  ADD 

ALTER TABLE [HumanResources].[Employee]
  CHECK CONSTRAINT [CK_Employee_MaritalStatus]
GO

ALTER TABLE [HumanResources].[Employee] WITH NOCHECK
  ADD 

ALTER TABLE [HumanResources].[Employee]
  CHECK CONSTRAINT [CK_Employee_VacationHours]
GO

















DISABLE TRIGGER [HumanResources].[dEmployee] ON [HumanResources].Employee
GO







































ALTER TABLE [HumanResources].[Employee] WITH NOCHECK
  ADD 

ALTER TABLE [HumanResources].[Employee]
  NOCHECK CONSTRAINT [CK_Employee_Gender]
GO

ALTER TABLE [HumanResources].[Employee] WITH NOCHECK
  ADD 

ALTER TABLE [HumanResources].[Employee]
  CHECK CONSTRAINT [CK_Employee_MaritalStatus]
GO

ALTER TABLE [HumanResources].[Employee] WITH NOCHECK
  ADD 

ALTER TABLE [HumanResources].[Employee]
  CHECK CONSTRAINT [CK_Employee_VacationHours]
GO

















DISABLE TRIGGER [HumanResources].[dEmployee] ON [HumanResources].Employee
GO






































