CREATE TABLE [Sales].[SalesTerritoryHistory] (
  [added] [int] NULL,
  [EndDate] [datetime] NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesTerritoryHistory_ModifiedDate] DEFAULT (getdate()),
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesTerritoryHistory_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [SalesPersonID] [int] NOT NULL,
  [StartDate] [datetime] NOT NULL,
  [TerritoryID] [int] NOT NULL,
  CONSTRAINT [PK_SalesTerritoryHistory_SalesPersonID_StartDate_TerritoryID] PRIMARY KEY CLUSTERED ([SalesPersonID], [StartDate], [TerritoryID]),
  CONSTRAINT [CK_SalesTerritoryHistory_EndDate] CHECK ([EndDate]>=[StartDate] OR [EndDate] IS NULL),
  CONSTRAINT [FK_SalesTerritoryHistory_SalesPerson_SalesPersonID] FOREIGN KEY ([salespersonid]) REFERENCES [Sales].[SalesPerson] ([salespersonid]),
  CONSTRAINT [FK_SalesTerritoryHistory_SalesTerritory_TerritoryID] FOREIGN KEY ([territoryid]) REFERENCES [Sales].[SalesTerritory] ([territoryid])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_SalesTerritoryHistory_rowguid]
  ON [Sales].[SalesTerritoryHistory] ([rowguid])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Sales representative transfers to other sales territories.', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory', 'INDEX', N'AK_SalesTerritoryHistory_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory', 'INDEX', N'PK_SalesTerritoryHistory_SalesPersonID_StartDate_TerritoryID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory', 'CONSTRAINT', N'PK_SalesTerritoryHistory_SalesPersonID_StartDate_TerritoryID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [EndDate] >= [StartDate] OR [EndDate] IS NULL', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory', 'CONSTRAINT', N'CK_SalesTerritoryHistory_EndDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory', 'CONSTRAINT', N'DF_SalesTerritoryHistory_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory', 'CONSTRAINT', N'DF_SalesTerritoryHistory_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SalesPerson.SalesPersonID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory', 'CONSTRAINT', N'FK_SalesTerritoryHistory_SalesPerson_SalesPersonID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SalesTerritory.TerritoryID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory', 'CONSTRAINT', N'FK_SalesTerritoryHistory_SalesTerritory_TerritoryID'
GO




















