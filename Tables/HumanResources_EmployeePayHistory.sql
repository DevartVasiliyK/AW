CREATE TABLE [HumanResources].[EmployeePayHistory] (
  [EmployeeID] [int] NOT NULL,
  [RateChangeDate] [datetime] NOT NULL,
  [Rate] [money] NOT NULL,
  [PayFrequency] [tinyint] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_EmployeePayHistory_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_EmployeePayHistory_EmployeeID_RateChangeDate] PRIMARY KEY CLUSTERED ([EmployeeID], [RateChangeDate]),
  CONSTRAINT [CK_EmployeePayHistory_PayFrequency] CHECK ([PayFrequency]=(2) OR [PayFrequency]=(1)),
  CONSTRAINT [CK_EmployeePayHistory_Rate] CHECK ([Rate]>=(6.50) AND [Rate]<=(200.00)),
  CONSTRAINT [FK_EmployeePayHistory_Employee_EmployeeID] FOREIGN KEY ([employeeid]) REFERENCES [HumanResources].[Employee] ([employeeid])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Employee pay history.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeePayHistory'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeePayHistory', 'INDEX', N'PK_EmployeePayHistory_EmployeeID_RateChangeDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeePayHistory', 'CONSTRAINT', N'PK_EmployeePayHistory_EmployeeID_RateChangeDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [PayFrequency]=(3) OR [PayFrequency]=(2) OR [PayFrequency]=(1)', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeePayHistory', 'CONSTRAINT', N'CK_EmployeePayHistory_PayFrequency'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [Rate] >= (6.50) AND [Rate] <= (200.00)', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeePayHistory', 'CONSTRAINT', N'CK_EmployeePayHistory_Rate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeePayHistory', 'CONSTRAINT', N'DF_EmployeePayHistory_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Employee.EmployeeID.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeePayHistory', 'CONSTRAINT', N'FK_EmployeePayHistory_Employee_EmployeeID'
GO