CREATE TABLE [Sales].[CountryRegionCurrency] (
  [CountryRegionCode] [nvarchar](3) NOT NULL,
  [CurrencyCode] [nchar](3) NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_CountryRegionCurrency_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode] PRIMARY KEY CLUSTERED ([CountryRegionCode], [CurrencyCode]),
  CONSTRAINT [FK_CountryRegionCurrency_CountryRegion_CountryRegionCode] FOREIGN KEY ([countryregioncode]) REFERENCES [Person].[CountryRegion] ([countryregioncode]),
  CONSTRAINT [FK_CountryRegionCurrency_Currency_CurrencyCode] FOREIGN KEY ([currencycode]) REFERENCES [Sales].[Currency] ([currencycode])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_CountryRegionCurrency_CurrencyCode]
  ON [Sales].[CountryRegionCurrency] ([CurrencyCode])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping ISO currency codes to a country or region.', 'SCHEMA', N'Sales', 'TABLE', N'CountryRegionCurrency'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'CountryRegionCurrency', 'INDEX', N'IX_CountryRegionCurrency_CurrencyCode'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'CountryRegionCurrency', 'INDEX', N'PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'CountryRegionCurrency', 'CONSTRAINT', N'PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'CountryRegionCurrency', 'CONSTRAINT', N'DF_CountryRegionCurrency_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing CountryRegion.CountryRegionCode.', 'SCHEMA', N'Sales', 'TABLE', N'CountryRegionCurrency', 'CONSTRAINT', N'FK_CountryRegionCurrency_CountryRegion_CountryRegionCode'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Currency.CurrencyCode.', 'SCHEMA', N'Sales', 'TABLE', N'CountryRegionCurrency', 'CONSTRAINT', N'FK_CountryRegionCurrency_Currency_CurrencyCode'
GO