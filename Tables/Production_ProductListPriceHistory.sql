CREATE TABLE [Production].[ProductListPriceHistory] (
  [ProductID] [int] NOT NULL,
  [StartDate] [datetime] NOT NULL,
  [EndDate] [datetime] NULL,
  [ListPrice] [money] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductListPriceHistory_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_ProductListPriceHistory_ProductID_StartDate] PRIMARY KEY CLUSTERED ([ProductID], [StartDate]),
  CONSTRAINT [CK_ProductListPriceHistory_EndDate] CHECK ([EndDate]>=[StartDate] OR [EndDate] IS NULL),
  CONSTRAINT [CK_ProductListPriceHistory_ListPrice] CHECK ([ListPrice]>(0.00)),
  CONSTRAINT [FK_ProductListPriceHistory_Product_ProductID] FOREIGN KEY ([productid]) REFERENCES [Production].[Product] ([productid])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Changes in the list price of a product over time.', 'SCHEMA', N'Production', 'TABLE', N'ProductListPriceHistory'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'ProductListPriceHistory', 'INDEX', N'PK_ProductListPriceHistory_ProductID_StartDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'ProductListPriceHistory', 'CONSTRAINT', N'PK_ProductListPriceHistory_ProductID_StartDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [EndDate] >= [StartDate] OR [EndDate] IS NULL', 'SCHEMA', N'Production', 'TABLE', N'ProductListPriceHistory', 'CONSTRAINT', N'CK_ProductListPriceHistory_EndDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [ListPrice] > (0.00)', 'SCHEMA', N'Production', 'TABLE', N'ProductListPriceHistory', 'CONSTRAINT', N'CK_ProductListPriceHistory_ListPrice'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'ProductListPriceHistory', 'CONSTRAINT', N'DF_ProductListPriceHistory_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', 'SCHEMA', N'Production', 'TABLE', N'ProductListPriceHistory', 'CONSTRAINT', N'FK_ProductListPriceHistory_Product_ProductID'
GO