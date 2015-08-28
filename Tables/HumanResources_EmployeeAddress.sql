CREATE TABLE [HumanResources].[EmployeeAddress] (
  [added] [int] NULL,
  [AddressID] [int] NOT NULL,
  [EmployeeID] [int] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_EmployeeAddress_ModifiedDate] DEFAULT (getdate()),
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_EmployeeAddress_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  CONSTRAINT [PK_EmployeeAddress_EmployeeID_AddressID] PRIMARY KEY CLUSTERED ([EmployeeID], [AddressID]),
  CONSTRAINT [FK_EmployeeAddress_Address_AddressID] FOREIGN KEY ([addressid]) REFERENCES [Person].[Address] ([addressid]),
  CONSTRAINT [FK_EmployeeAddress_Employee_EmployeeID] FOREIGN KEY ([employeeid]) REFERENCES [HumanResources].[Employee] ([employeeid])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_EmployeeAddress_rowguid]
  ON [HumanResources].[EmployeeAddress] ([rowguid])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping employees to their address(es).', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'INDEX', N'AK_EmployeeAddress_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'INDEX', N'PK_EmployeeAddress_EmployeeID_AddressID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'CONSTRAINT', N'PK_EmployeeAddress_EmployeeID_AddressID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'CONSTRAINT', N'DF_EmployeeAddress_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'CONSTRAINT', N'DF_EmployeeAddress_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Address.AddressID.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'CONSTRAINT', N'FK_EmployeeAddress_Address_AddressID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Employee.EmployeeID.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeAddress', 'CONSTRAINT', N'FK_EmployeeAddress_Employee_EmployeeID'
GO


















