CREATE TABLE [Sales].[CurrencyRate] (
  [added] [int] NULL,
  [AverageRate] [money] NOT NULL,
  [CurrencyRateDate] [datetime] NOT NULL,
  [CurrencyRateID] [int] IDENTITY,
  [EndOfDayRate] [money] NOT NULL,
  [FromCurrencyCode] [nchar](3) NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_CurrencyRate_ModifiedDate] DEFAULT (getdate()),
  [ToCurrencyCode] [nchar](3) NOT NULL,
  CONSTRAINT [PK_CurrencyRate_CurrencyRateID] PRIMARY KEY CLUSTERED ([CurrencyRateID]),
  CONSTRAINT [FK_CurrencyRate_Currency_FromCurrencyCode] FOREIGN KEY ([fromcurrencycode]) REFERENCES [Sales].[Currency] ([currencycode]),
  CONSTRAINT [FK_CurrencyRate_Currency_ToCurrencyCode] FOREIGN KEY ([tocurrencycode]) REFERENCES [Sales].[Currency] ([currencycode])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_CurrencyRate_CurrencyRateDate_FromCurrencyCode_ToCurrencyCode]
  ON [Sales].[CurrencyRate] ([CurrencyRateDate], [FromCurrencyCode], [ToCurrencyCode])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Currency exchange rates.', 'SCHEMA', N'Sales', 'TABLE', N'CurrencyRate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'CurrencyRate', 'INDEX', N'AK_CurrencyRate_CurrencyRateDate_FromCurrencyCode_ToCurrencyCode'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'CurrencyRate', 'INDEX', N'PK_CurrencyRate_CurrencyRateID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'CurrencyRate', 'CONSTRAINT', N'PK_CurrencyRate_CurrencyRateID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'CurrencyRate', 'CONSTRAINT', N'DF_CurrencyRate_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Currency.FromCurrencyCode.', 'SCHEMA', N'Sales', 'TABLE', N'CurrencyRate', 'CONSTRAINT', N'FK_CurrencyRate_Currency_FromCurrencyCode'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Currency.ToCurrencyCode.', 'SCHEMA', N'Sales', 'TABLE', N'CurrencyRate', 'CONSTRAINT', N'FK_CurrencyRate_Currency_ToCurrencyCode'
GO
















