CREATE TABLE [Sales].[SalesTaxRate] (
  [SalesTaxRateID] [int] IDENTITY,
  [StateProvinceID] [int] NOT NULL,
  [TaxType] [tinyint] NOT NULL,
  [TaxRate] [smallmoney] NOT NULL CONSTRAINT [DF_SalesTaxRate_TaxRate] DEFAULT (0.00),
  [Name] [dbo].[Name] NOT NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesTaxRate_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesTaxRate_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_SalesTaxRate_SalesTaxRateID] PRIMARY KEY CLUSTERED ([SalesTaxRateID]),
  CONSTRAINT [CK_SalesTaxRate_TaxType] CHECK ([TaxType]>=(1) AND [TaxType]<=(3)),
  CONSTRAINT [FK_SalesTaxRate_StateProvince_StateProvinceID] FOREIGN KEY ([stateprovinceid]) REFERENCES [Person].[StateProvince] ([stateprovinceid])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_SalesTaxRate_rowguid]
  ON [Sales].[SalesTaxRate] ([rowguid])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_SalesTaxRate_StateProvinceID_TaxType]
  ON [Sales].[SalesTaxRate] ([StateProvinceID], [TaxType])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Tax rate lookup table.', 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'INDEX', N'AK_SalesTaxRate_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'INDEX', N'AK_SalesTaxRate_StateProvinceID_TaxType'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'INDEX', N'PK_SalesTaxRate_SalesTaxRateID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'CONSTRAINT', N'PK_SalesTaxRate_SalesTaxRateID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [TaxType] BETWEEN (1) AND (3)', 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'CONSTRAINT', N'CK_SalesTaxRate_TaxType'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'CONSTRAINT', N'DF_SalesTaxRate_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'CONSTRAINT', N'DF_SalesTaxRate_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'CONSTRAINT', N'DF_SalesTaxRate_TaxRate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing StateProvince.StateProvinceID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'CONSTRAINT', N'FK_SalesTaxRate_StateProvince_StateProvinceID'
GO