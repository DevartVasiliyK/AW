CREATE TABLE [Sales].[Currency] (
  [CurrencyCode] [nchar](3) NOT NULL,
  [Name] [dbo].[Name] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Currency_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_Currency_CurrencyCode] PRIMARY KEY CLUSTERED ([CurrencyCode])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_Currency_Name]
  ON [Sales].[Currency] ([Name])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Lookup table containing standard ISO currencies.', 'SCHEMA', N'Sales', 'TABLE', N'Currency'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'Currency', 'INDEX', N'AK_Currency_Name'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'Currency', 'INDEX', N'PK_Currency_CurrencyCode'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'Currency', 'CONSTRAINT', N'PK_Currency_CurrencyCode'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'Currency', 'CONSTRAINT', N'DF_Currency_ModifiedDate'
GO