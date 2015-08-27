CREATE TABLE [HumanResources].[EmployeeDepartmentHistory] (
  [EmployeeID] [int] NOT NULL,
  [DepartmentID] [smallint] NOT NULL,
  [ShiftID] [tinyint] NOT NULL,
  [StartDate] [datetime] NOT NULL,
  [EndDate] [datetime] NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_EmployeeDepartmentHistory_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_EmployeeDepartmentHistory_EmployeeID_StartDate_DepartmentID] PRIMARY KEY CLUSTERED ([EmployeeID], [StartDate], [DepartmentID], [ShiftID]),
  CONSTRAINT [CK_EmployeeDepartmentHistory_EndDate] CHECK ([EndDate]>=[StartDate] OR [EndDate] IS NULL),
  CONSTRAINT [FK_EmployeeDepartmentHistory_Department_DepartmentID] FOREIGN KEY ([departmentid]) REFERENCES [HumanResources].[Department] ([departmentid]),
  CONSTRAINT [FK_EmployeeDepartmentHistory_Employee_EmployeeID] FOREIGN KEY ([employeeid]) REFERENCES [HumanResources].[Employee] ([employeeid]),
  CONSTRAINT [FK_EmployeeDepartmentHistory_Shift_ShiftID] FOREIGN KEY ([shiftid]) REFERENCES [HumanResources].[Shift] ([shiftid])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_EmployeeDepartmentHistory_DepartmentID]
  ON [HumanResources].[EmployeeDepartmentHistory] ([DepartmentID])
  ON [PRIMARY]
GO

CREATE INDEX [IX_EmployeeDepartmentHistory_ShiftID]
  ON [HumanResources].[EmployeeDepartmentHistory] ([ShiftID])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Employee department transfers.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory', 'INDEX', N'IX_EmployeeDepartmentHistory_DepartmentID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory', 'INDEX', N'IX_EmployeeDepartmentHistory_ShiftID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory', 'INDEX', N'PK_EmployeeDepartmentHistory_EmployeeID_StartDate_DepartmentID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory', 'CONSTRAINT', N'PK_EmployeeDepartmentHistory_EmployeeID_StartDate_DepartmentID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [EndDate] >= [StartDate] OR [EndDate] IS NUL', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory', 'CONSTRAINT', N'CK_EmployeeDepartmentHistory_EndDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory', 'CONSTRAINT', N'DF_EmployeeDepartmentHistory_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Department.DepartmentID.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory', 'CONSTRAINT', N'FK_EmployeeDepartmentHistory_Department_DepartmentID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Employee.EmployeeID.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory', 'CONSTRAINT', N'FK_EmployeeDepartmentHistory_Employee_EmployeeID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Shift.ShiftID', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory', 'CONSTRAINT', N'FK_EmployeeDepartmentHistory_Shift_ShiftID'
GO