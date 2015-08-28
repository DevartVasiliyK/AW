CREATE TABLE [Purchasing].[ProductVendor] (
  [added] [int] NULL,
  [AverageLeadTime] [int] NOT NULL,
  [LastReceiptCost] [money] NULL,
  [LastReceiptDate] [datetime] NULL,
  [MaxOrderQty] [int] NOT NULL,
  [MinOrderQty] [int] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductVendor_ModifiedDate] DEFAULT (getdate()),
  [OnOrderQty] [int] NULL,
  [ProductID] [int] NOT NULL,
  [StandardPrice] [money] NOT NULL,
  [UnitMeasureCode] [nchar](3) NOT NULL,
  [VendorID] [int] NOT NULL,
  CONSTRAINT [PK_ProductVendor_ProductID_VendorID] PRIMARY KEY CLUSTERED ([ProductID], [VendorID]),
  CONSTRAINT [CK_ProductVendor_AverageLeadTime] CHECK ([AverageLeadTime]>=(1)),
  CONSTRAINT [CK_ProductVendor_LastReceiptCost] CHECK ([LastReceiptCost]>(0.00)),
  CONSTRAINT [CK_ProductVendor_MaxOrderQty] CHECK ([MaxOrderQty]>=(1)),
  CONSTRAINT [CK_ProductVendor_MinOrderQty] CHECK ([MinOrderQty]>=(1)),
  CONSTRAINT [CK_ProductVendor_OnOrderQty] CHECK ([OnOrderQty]>=(0)),
  CONSTRAINT [CK_ProductVendor_StandardPrice] CHECK ([StandardPrice]>(0.00)),
  CONSTRAINT [FK_ProductVendor_Product_ProductID] FOREIGN KEY ([productid]) REFERENCES [Production].[Product] ([productid]),
  CONSTRAINT [FK_ProductVendor_UnitMeasure_UnitMeasureCode] FOREIGN KEY ([unitmeasurecode]) REFERENCES [Production].[UnitMeasure] ([unitmeasurecode]),
  CONSTRAINT [FK_ProductVendor_Vendor_VendorID] FOREIGN KEY ([vendorid]) REFERENCES [Purchasing].[Vendor] ([vendorid])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_ProductVendor_UnitMeasureCode]
  ON [Purchasing].[ProductVendor] ([UnitMeasureCode])
  ON [PRIMARY]
GO

CREATE INDEX [IX_ProductVendor_VendorID]
  ON [Purchasing].[ProductVendor] ([VendorID])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping vendors with the products they supply.', 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'INDEX', N'IX_ProductVendor_UnitMeasureCode'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'INDEX', N'IX_ProductVendor_VendorID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'INDEX', N'PK_ProductVendor_ProductID_VendorID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'CONSTRAINT', N'PK_ProductVendor_ProductID_VendorID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [AverageLeadTime] >= (1)', 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'CONSTRAINT', N'CK_ProductVendor_AverageLeadTime'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [LastReceiptCost] > (0.00)', 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'CONSTRAINT', N'CK_ProductVendor_LastReceiptCost'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [MaxOrderQty] >= (1)', 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'CONSTRAINT', N'CK_ProductVendor_MaxOrderQty'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [MinOrderQty] >= (1)', 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'CONSTRAINT', N'CK_ProductVendor_MinOrderQty'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [OnOrderQty] >= (0)', 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'CONSTRAINT', N'CK_ProductVendor_OnOrderQty'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [StandardPrice] > (0.00)', 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'CONSTRAINT', N'CK_ProductVendor_StandardPrice'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'CONSTRAINT', N'DF_ProductVendor_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'CONSTRAINT', N'FK_ProductVendor_Product_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing UnitMeasure.UnitMeasureCode.', 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'CONSTRAINT', N'FK_ProductVendor_UnitMeasure_UnitMeasureCode'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Vendor.VendorID.', 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'CONSTRAINT', N'FK_ProductVendor_Vendor_VendorID'
GO


































