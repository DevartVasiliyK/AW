CREATE TABLE [Production].[ProductCostHistory] (
  [added] [int] NULL,
  [EndDate] [datetime] NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductCostHistory_ModifiedDate] DEFAULT (getdate()),
  [ProductID] [int] NOT NULL,
  [StandardCost] [money] NOT NULL,
  [StartDate] [datetime] NOT NULL,
  CONSTRAINT [PK_ProductCostHistory_ProductID_StartDate] PRIMARY KEY CLUSTERED ([ProductID], [StartDate]),
  CONSTRAINT [CK_ProductCostHistory_EndDate] CHECK ([EndDate]>=[StartDate] OR [EndDate] IS NULL),
  CONSTRAINT [CK_ProductCostHistory_StandardCost] CHECK ([StandardCost]>=(0.00)),
  CONSTRAINT [FK_ProductCostHistory_Product_ProductID] FOREIGN KEY ([productid]) REFERENCES [Production].[Product] ([productid])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Changes in the cost of a product over time.', 'SCHEMA', N'Production', 'TABLE', N'ProductCostHistory'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'ProductCostHistory', 'INDEX', N'PK_ProductCostHistory_ProductID_StartDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'ProductCostHistory', 'CONSTRAINT', N'PK_ProductCostHistory_ProductID_StartDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [EndDate] >= [StartDate] OR [EndDate] IS NULL', 'SCHEMA', N'Production', 'TABLE', N'ProductCostHistory', 'CONSTRAINT', N'CK_ProductCostHistory_EndDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [StandardCost] >= (0.00)', 'SCHEMA', N'Production', 'TABLE', N'ProductCostHistory', 'CONSTRAINT', N'CK_ProductCostHistory_StandardCost'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'ProductCostHistory', 'CONSTRAINT', N'DF_ProductCostHistory_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', 'SCHEMA', N'Production', 'TABLE', N'ProductCostHistory', 'CONSTRAINT', N'FK_ProductCostHistory_Product_ProductID'
GO














