CREATE TABLE [Person].[StateProvince] (
  [StateProvinceID] [int] IDENTITY,
  [StateProvinceCode] [nchar](3) NOT NULL,
  [CountryRegionCode] [nvarchar](3) NOT NULL,
  [IsOnlyStateProvinceFlag] [dbo].[Flag] NOT NULL CONSTRAINT [DF_StateProvince_IsOnlyStateProvinceFlag] DEFAULT (1),
  [Name] [dbo].[Name] NOT NULL,
  [TerritoryID] [int] NOT NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StateProvince_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_StateProvince_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_StateProvince_StateProvinceID] PRIMARY KEY CLUSTERED ([StateProvinceID]),
  CONSTRAINT [FK_StateProvince_CountryRegion_CountryRegionCode] FOREIGN KEY ([countryregioncode]) REFERENCES [Person].[CountryRegion] ([countryregioncode]),
  CONSTRAINT [FK_StateProvince_SalesTerritory_TerritoryID] FOREIGN KEY ([territoryid]) REFERENCES [Sales].[SalesTerritory] ([territoryid])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_StateProvince_Name]
  ON [Person].[StateProvince] ([Name])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_StateProvince_rowguid]
  ON [Person].[StateProvince] ([rowguid])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_StateProvince_StateProvinceCode_CountryRegionCode]
  ON [Person].[StateProvince] ([StateProvinceCode], [CountryRegionCode])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'State and province lookup table.', 'SCHEMA', N'Person', 'TABLE', N'StateProvince'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'INDEX', N'AK_StateProvince_Name'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'INDEX', N'AK_StateProvince_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'INDEX', N'AK_StateProvince_StateProvinceCode_CountryRegionCode'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'INDEX', N'PK_StateProvince_StateProvinceID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'CONSTRAINT', N'PK_StateProvince_StateProvinceID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 1 (TRUE)', 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'CONSTRAINT', N'DF_StateProvince_IsOnlyStateProvinceFlag'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'CONSTRAINT', N'DF_StateProvince_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'CONSTRAINT', N'DF_StateProvince_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing CountryRegion.CountryRegionCode.', 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'CONSTRAINT', N'FK_StateProvince_CountryRegion_CountryRegionCode'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SalesTerritory.TerritoryID.', 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'CONSTRAINT', N'FK_StateProvince_SalesTerritory_TerritoryID'
GO