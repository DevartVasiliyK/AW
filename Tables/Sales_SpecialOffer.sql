CREATE TABLE [Sales].[SpecialOffer] (
  [SpecialOfferID] [int] IDENTITY,
  [Description] [nvarchar](255) NOT NULL,
  [DiscountPct] [smallmoney] NOT NULL CONSTRAINT [DF_SpecialOffer_DiscountPct] DEFAULT (0.00),
  [Type] [nvarchar](50) NOT NULL,
  [Category] [nvarchar](50) NOT NULL,
  [StartDate] [datetime] NOT NULL,
  [EndDate] [datetime] NOT NULL,
  [MinQty] [int] NOT NULL CONSTRAINT [DF_SpecialOffer_MinQty] DEFAULT (0),
  [MaxQty] [int] NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SpecialOffer_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SpecialOffer_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_SpecialOffer_SpecialOfferID] PRIMARY KEY CLUSTERED ([SpecialOfferID]),
  CONSTRAINT [CK_SpecialOffer_DiscountPct] CHECK ([DiscountPct]>=(0.00)),
  CONSTRAINT [CK_SpecialOffer_EndDate] CHECK ([EndDate]>=[StartDate]),
  CONSTRAINT [CK_SpecialOffer_MaxQty] CHECK ([MaxQty]>=(0)),
  CONSTRAINT [CK_SpecialOffer_MinQty] CHECK ([MinQty]>=(0))
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_SpecialOffer_rowguid]
  ON [Sales].[SpecialOffer] ([rowguid])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Sale discounts lookup table.', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'INDEX', N'AK_SpecialOffer_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'INDEX', N'PK_SpecialOffer_SpecialOfferID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'CONSTRAINT', N'PK_SpecialOffer_SpecialOfferID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [DiscountPct] >= (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'CONSTRAINT', N'CK_SpecialOffer_DiscountPct'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [EndDate] >= [StartDate]', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'CONSTRAINT', N'CK_SpecialOffer_EndDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [MaxQty] >= (0)', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'CONSTRAINT', N'CK_SpecialOffer_MaxQty'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [MinQty] >= (0)', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'CONSTRAINT', N'CK_SpecialOffer_MinQty'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'CONSTRAINT', N'DF_SpecialOffer_DiscountPct'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'CONSTRAINT', N'DF_SpecialOffer_MinQty'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'CONSTRAINT', N'DF_SpecialOffer_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'CONSTRAINT', N'DF_SpecialOffer_rowguid'
GO