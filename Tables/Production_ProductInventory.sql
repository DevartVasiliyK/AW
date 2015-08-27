CREATE TABLE [Production].[ProductInventory] (
  [ProductID] [int] NOT NULL,
  [LocationID] [smallint] NOT NULL,
  [Shelf] [nvarchar](10) NOT NULL,
  [Bin] [tinyint] NOT NULL,
  [Quantity] [smallint] NOT NULL CONSTRAINT [DF_ProductInventory_Quantity] DEFAULT (0),
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ProductInventory_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductInventory_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_ProductInventory_ProductID_LocationID] PRIMARY KEY CLUSTERED ([ProductID], [LocationID]),
  CONSTRAINT [CK_ProductInventory_Bin] CHECK ([Bin]>=(0) AND [Bin]<=(100)),
  CONSTRAINT [CK_ProductInventory_Shelf] CHECK ([Shelf] like '[A-Za-z]' OR [Shelf]='N/A'),
  CONSTRAINT [FK_ProductInventory_Location_LocationID] FOREIGN KEY ([locationid]) REFERENCES [Production].[Location] ([locationid]),
  CONSTRAINT [FK_ProductInventory_Product_ProductID] FOREIGN KEY ([productid]) REFERENCES [Production].[Product] ([productid])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Product inventory information.', 'SCHEMA', N'Production', 'TABLE', N'ProductInventory'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'INDEX', N'PK_ProductInventory_ProductID_LocationID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'CONSTRAINT', N'PK_ProductInventory_ProductID_LocationID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [Bin] BETWEEN (0) AND (100)', 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'CONSTRAINT', N'CK_ProductInventory_Bin'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [Shelf] like ''[A-Za-z]'' OR [Shelf]=''N/A''', 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'CONSTRAINT', N'CK_ProductInventory_Shelf'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'CONSTRAINT', N'DF_ProductInventory_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0', 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'CONSTRAINT', N'DF_ProductInventory_Quantity'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'CONSTRAINT', N'DF_ProductInventory_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Location.LocationID.', 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'CONSTRAINT', N'FK_ProductInventory_Location_LocationID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'CONSTRAINT', N'FK_ProductInventory_Product_ProductID'
GO