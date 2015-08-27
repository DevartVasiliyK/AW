CREATE TABLE [Sales].[SalesTerritory] (
  [TerritoryID] [int] IDENTITY,
  [Name] [dbo].[Name] NOT NULL,
  [CountryRegionCode] [nvarchar](3) NOT NULL,
  [Group] [nvarchar](50) NOT NULL,
  [SalesYTD] [money] NOT NULL CONSTRAINT [DF_SalesTerritory_SalesYTD] DEFAULT (0.00),
  [SalesLastYear] [money] NOT NULL CONSTRAINT [DF_SalesTerritory_SalesLastYear] DEFAULT (0.00),
  [CostYTD] [money] NOT NULL CONSTRAINT [DF_SalesTerritory_CostYTD] DEFAULT (0.00),
  [CostLastYear] [money] NOT NULL CONSTRAINT [DF_SalesTerritory_CostLastYear] DEFAULT (0.00),
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesTerritory_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesTerritory_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_SalesTerritory_TerritoryID] PRIMARY KEY CLUSTERED ([TerritoryID]),
  CONSTRAINT [CK_SalesTerritory_CostLastYear] CHECK ([CostLastYear]>=(0.00)),
  CONSTRAINT [CK_SalesTerritory_CostYTD] CHECK ([CostYTD]>=(0.00)),
  CONSTRAINT [CK_SalesTerritory_SalesLastYear] CHECK ([SalesLastYear]>=(0.00)),
  CONSTRAINT [CK_SalesTerritory_SalesYTD] CHECK ([SalesYTD]>=(0.00))
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_SalesTerritory_Name]
  ON [Sales].[SalesTerritory] ([Name])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_SalesTerritory_rowguid]
  ON [Sales].[SalesTerritory] ([rowguid])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Sales territory lookup table.', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'INDEX', N'AK_SalesTerritory_Name'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'INDEX', N'AK_SalesTerritory_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'INDEX', N'PK_SalesTerritory_TerritoryID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'CONSTRAINT', N'PK_SalesTerritory_TerritoryID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [CostLastYear] >= (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'CONSTRAINT', N'CK_SalesTerritory_CostLastYear'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [CostYTD] >= (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'CONSTRAINT', N'CK_SalesTerritory_CostYTD'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [SalesLastYear] >= (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'CONSTRAINT', N'CK_SalesTerritory_SalesLastYear'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [SalesYTD] >= (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'CONSTRAINT', N'CK_SalesTerritory_SalesYTD'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'CONSTRAINT', N'DF_SalesTerritory_CostLastYear'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'CONSTRAINT', N'DF_SalesTerritory_CostYTD'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'CONSTRAINT', N'DF_SalesTerritory_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'CONSTRAINT', N'DF_SalesTerritory_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'CONSTRAINT', N'DF_SalesTerritory_SalesLastYear'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'CONSTRAINT', N'DF_SalesTerritory_SalesYTD'
GO