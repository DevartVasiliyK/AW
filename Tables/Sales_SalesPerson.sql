CREATE TABLE [Sales].[SalesPerson] (
  [added] [int] NULL,
  [Bonus] [money] NOT NULL CONSTRAINT [DF_SalesPerson_Bonus] DEFAULT (0.00),
  [CommissionPct] [smallmoney] NOT NULL CONSTRAINT [DF_SalesPerson_CommissionPct] DEFAULT (0.00),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesPerson_ModifiedDate] DEFAULT (getdate()),
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesPerson_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [SalesLastYear] [money] NOT NULL CONSTRAINT [DF_SalesPerson_SalesLastYear] DEFAULT (0.00),
  [SalesPersonID] [int] NOT NULL,
  [SalesQuota] [money] NULL,
  [SalesYTD] [money] NOT NULL CONSTRAINT [DF_SalesPerson_SalesYTD] DEFAULT (0.00),
  [TerritoryID] [int] NULL,
  CONSTRAINT [PK_SalesPerson_SalesPersonID] PRIMARY KEY CLUSTERED ([SalesPersonID]),
  CONSTRAINT [CK_SalesPerson_Bonus] CHECK ([Bonus]>=(0.00)),
  CONSTRAINT [CK_SalesPerson_CommissionPct] CHECK ([CommissionPct]>=(0.00)),
  CONSTRAINT [CK_SalesPerson_SalesLastYear] CHECK ([SalesLastYear]>=(0.00)),
  CONSTRAINT [CK_SalesPerson_SalesQuota] CHECK ([SalesQuota]>(0.00)),
  CONSTRAINT [CK_SalesPerson_SalesYTD] CHECK ([SalesYTD]>=(0.00)),
  CONSTRAINT [FK_SalesPerson_Employee_SalesPersonID] FOREIGN KEY ([salespersonid]) REFERENCES [HumanResources].[Employee] ([employeeid]),
  CONSTRAINT [FK_SalesPerson_SalesTerritory_TerritoryID] FOREIGN KEY ([territoryid]) REFERENCES [Sales].[SalesTerritory] ([territoryid])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_SalesPerson_rowguid]
  ON [Sales].[SalesPerson] ([rowguid])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Sales representative current information.', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'INDEX', N'AK_SalesPerson_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'INDEX', N'PK_SalesPerson_SalesPersonID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'CONSTRAINT', N'PK_SalesPerson_SalesPersonID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [Bonus] >= (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'CONSTRAINT', N'CK_SalesPerson_Bonus'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [CommissionPct] >= (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'CONSTRAINT', N'CK_SalesPerson_CommissionPct'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [SalesLastYear] >= (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'CONSTRAINT', N'CK_SalesPerson_SalesLastYear'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [SalesQuota] > (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'CONSTRAINT', N'CK_SalesPerson_SalesQuota'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [SalesYTD] >= (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'CONSTRAINT', N'CK_SalesPerson_SalesYTD'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'CONSTRAINT', N'DF_SalesPerson_Bonus'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'CONSTRAINT', N'DF_SalesPerson_CommissionPct'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'CONSTRAINT', N'DF_SalesPerson_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'CONSTRAINT', N'DF_SalesPerson_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'CONSTRAINT', N'DF_SalesPerson_SalesLastYear'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'CONSTRAINT', N'DF_SalesPerson_SalesYTD'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Employee.EmployeeID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'CONSTRAINT', N'FK_SalesPerson_Employee_SalesPersonID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SalesTerritory.TerritoryID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'CONSTRAINT', N'FK_SalesPerson_SalesTerritory_TerritoryID'
GO




































