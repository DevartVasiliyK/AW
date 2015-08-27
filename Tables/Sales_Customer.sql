CREATE TABLE [Sales].[Customer] (
  [CustomerID] [int] IDENTITY NOT FOR REPLICATION,
  [TerritoryID] [int] NULL,
  [AccountNumber] AS (isnull('AW'+[dbo].[ufnLeadingZeros]([CustomerID]),'')),
  [CustomerType] [nchar](1) NOT NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Customer_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Customer_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_Customer_CustomerID] PRIMARY KEY CLUSTERED ([CustomerID]),
  CONSTRAINT [CK_Customer_CustomerType] CHECK (upper([CustomerType])='I' OR upper([CustomerType])='S'),
  CONSTRAINT [FK_Customer_SalesTerritory_TerritoryID] FOREIGN KEY ([territoryid]) REFERENCES [Sales].[SalesTerritory] ([territoryid])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_Customer_AccountNumber]
  ON [Sales].[Customer] ([AccountNumber])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_Customer_rowguid]
  ON [Sales].[Customer] ([rowguid])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Customer_TerritoryID]
  ON [Sales].[Customer] ([TerritoryID])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Current customer information. Also see the Individual and Store tables.', 'SCHEMA', N'Sales', 'TABLE', N'Customer'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'INDEX', N'AK_Customer_AccountNumber'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'INDEX', N'AK_Customer_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'INDEX', N'IX_Customer_TerritoryID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'INDEX', N'PK_Customer_CustomerID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'CONSTRAINT', N'PK_Customer_CustomerID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [CustomerType]=''I'' OR [CustomerType]=''i'' OR [CustomerType]=''S'' OR [CustomerType]=''s''', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'CONSTRAINT', N'CK_Customer_CustomerType'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'CONSTRAINT', N'DF_Customer_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'CONSTRAINT', N'DF_Customer_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SalesTerritory.TerritoryID.', 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'CONSTRAINT', N'FK_Customer_SalesTerritory_TerritoryID'
GO