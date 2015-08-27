CREATE TABLE [Sales].[SpecialOfferProduct] (
  [SpecialOfferID] [int] NOT NULL,
  [ProductID] [int] NOT NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SpecialOfferProduct_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SpecialOfferProduct_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_SpecialOfferProduct_SpecialOfferID_ProductID] PRIMARY KEY CLUSTERED ([SpecialOfferID], [ProductID]),
  CONSTRAINT [FK_SpecialOfferProduct_Product_ProductID] FOREIGN KEY ([productid]) REFERENCES [Production].[Product] ([productid]),
  CONSTRAINT [FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID] FOREIGN KEY ([specialofferid]) REFERENCES [Sales].[SpecialOffer] ([specialofferid])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_SpecialOfferProduct_rowguid]
  ON [Sales].[SpecialOfferProduct] ([rowguid])
  ON [PRIMARY]
GO

CREATE INDEX [IX_SpecialOfferProduct_ProductID]
  ON [Sales].[SpecialOfferProduct] ([ProductID])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping products to special offer discounts.', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOfferProduct'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOfferProduct', 'INDEX', N'AK_SpecialOfferProduct_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOfferProduct', 'INDEX', N'IX_SpecialOfferProduct_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOfferProduct', 'INDEX', N'PK_SpecialOfferProduct_SpecialOfferID_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOfferProduct', 'CONSTRAINT', N'PK_SpecialOfferProduct_SpecialOfferID_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOfferProduct', 'CONSTRAINT', N'DF_SpecialOfferProduct_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOfferProduct', 'CONSTRAINT', N'DF_SpecialOfferProduct_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOfferProduct', 'CONSTRAINT', N'FK_SpecialOfferProduct_Product_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SpecialOffer.SpecialOfferID.', 'SCHEMA', N'Sales', 'TABLE', N'SpecialOfferProduct', 'CONSTRAINT', N'FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID'
GO