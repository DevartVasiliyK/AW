CREATE TABLE [Production].[Product] (
  [added] [int] NULL,
  [Class] [nchar](2) NULL,
  [Color] [nvarchar](15) NULL,
  [DaysToManufacture] [int] NOT NULL,
  [DiscontinuedDate] [datetime] NULL,
  [FinishedGoodsFlag] [dbo].[Flag] NOT NULL CONSTRAINT [DF_Product_FinishedGoodsFlag] DEFAULT (1),
  [ListPrice] [money] NOT NULL,
  [MakeFlag] [dbo].[Flag] NOT NULL CONSTRAINT [DF_Product_MakeFlag] DEFAULT (1),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Product_ModifiedDate] DEFAULT (getdate()),
  [Name] [dbo].[Name] NOT NULL,
  [ProductID] [int] IDENTITY,
  [ProductLine] [nchar](2) NULL,
  [ProductModelID] [int] NULL,
  [ProductNumber] [nvarchar](25) NOT NULL,
  [ProductSubcategoryID] [int] NULL,
  [ReorderPoint] [smallint] NOT NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Product_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [SafetyStockLevel] [smallint] NOT NULL,
  [SellEndDate] [datetime] NULL,
  [SellStartDate] [datetime] NOT NULL,
  [Size] [nvarchar](5) NULL,
  [SizeUnitMeasureCode] [nchar](3) NULL,
  [StandardCost] [money] NOT NULL,
  [Style] [nchar](2) NULL,
  [Weight] [decimal](8, 2) NULL,
  [WeightUnitMeasureCode] [nchar](3) NULL,
  CONSTRAINT [PK_Product_ProductID] PRIMARY KEY CLUSTERED ([ProductID]),
  CONSTRAINT [CK_Product_Class] CHECK (upper([Class])='H' OR upper([Class])='M' OR upper([Class])='L' OR [Class] IS NULL),
  CONSTRAINT [CK_Product_DaysToManufacture] CHECK ([DaysToManufacture]>=(0)),
  CONSTRAINT [CK_Product_ListPrice] CHECK ([ListPrice]>=(0.00)),
  CONSTRAINT [CK_Product_ProductLine] CHECK (upper([ProductLine])='R' OR upper([ProductLine])='M' OR upper([ProductLine])='T' OR upper([ProductLine])='S' OR [ProductLine] IS NULL),
  CONSTRAINT [CK_Product_ReorderPoint] CHECK ([ReorderPoint]>(0)),
  CONSTRAINT [CK_Product_SafetyStockLevel] CHECK ([SafetyStockLevel]>(0)),
  CONSTRAINT [CK_Product_SellEndDate] CHECK ([SellEndDate]>=[SellStartDate] OR [SellEndDate] IS NULL),
  CONSTRAINT [CK_Product_StandardCost] CHECK ([StandardCost]>=(0.00)),
  CONSTRAINT [CK_Product_Style] CHECK (upper([Style])='U' OR upper([Style])='M' OR upper([Style])='W' OR [Style] IS NULL),
  CONSTRAINT [CK_Product_Weight] CHECK ([Weight]>(0.00)),
  CONSTRAINT [FK_Product_ProductModel_ProductModelID] FOREIGN KEY ([productmodelid]) REFERENCES [Production].[ProductModel] ([productmodelid]),
  CONSTRAINT [FK_Product_ProductSubcategory_ProductSubcategoryID] FOREIGN KEY ([productsubcategoryid]) REFERENCES [Production].[ProductSubcategory] ([productsubcategoryid]),
  CONSTRAINT [FK_Product_UnitMeasure_SizeUnitMeasureCode] FOREIGN KEY ([sizeunitmeasurecode]) REFERENCES [Production].[UnitMeasure] ([unitmeasurecode]),
  CONSTRAINT [FK_Product_UnitMeasure_WeightUnitMeasureCode] FOREIGN KEY ([weightunitmeasurecode]) REFERENCES [Production].[UnitMeasure] ([unitmeasurecode])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_Product_Name]
  ON [Production].[Product] ([Name])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_Product_ProductNumber]
  ON [Production].[Product] ([ProductNumber])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_Product_rowguid]
  ON [Production].[Product] ([rowguid])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Products sold or used in the manfacturing of sold products.', 'SCHEMA', N'Production', 'TABLE', N'Product'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'Product', 'INDEX', N'AK_Product_Name'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'Product', 'INDEX', N'AK_Product_ProductNumber'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Production', 'TABLE', N'Product', 'INDEX', N'AK_Product_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'Product', 'INDEX', N'PK_Product_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'PK_Product_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [Class]=''h'' OR [Class]=''m'' OR [Class]=''l'' OR [Class]=''H'' OR [Class]=''M'' OR [Class]=''L'' OR [Class] IS NULL', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'CK_Product_Class'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [DaysToManufacture] >= (0)', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'CK_Product_DaysToManufacture'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [ListPrice] >= (0.00)', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'CK_Product_ListPrice'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [ProductLine]=''r'' OR [ProductLine]=''m'' OR [ProductLine]=''t'' OR [ProductLine]=''s'' OR [ProductLine]=''R'' OR [ProductLine]=''M'' OR [ProductLine]=''T'' OR [ProductLine]=''S'' OR [ProductLine] IS NULL', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'CK_Product_ProductLine'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [ReorderPoint] > (0)', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'CK_Product_ReorderPoint'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [SafetyStockLevel] > (0)', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'CK_Product_SafetyStockLevel'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [SellEndDate] >= [SellStartDate] OR [SellEndDate] IS NULL', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'CK_Product_SellEndDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [SafetyStockLevel] > (0)', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'CK_Product_StandardCost'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [Style]=''u'' OR [Style]=''m'' OR [Style]=''w'' OR [Style]=''U'' OR [Style]=''M'' OR [Style]=''W'' OR [Style] IS NULL', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'CK_Product_Style'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [Weight] > (0.00)', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'CK_Product_Weight'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of  1', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'DF_Product_FinishedGoodsFlag'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of  1', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'DF_Product_MakeFlag'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'DF_Product_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'DF_Product_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing ProductModel.ProductModelID.', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'FK_Product_ProductModel_ProductModelID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing ProductSubcategory.ProductSubcategoryID.', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'FK_Product_ProductSubcategory_ProductSubcategoryID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing UnitMeasure.UnitMeasureCode.', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'FK_Product_UnitMeasure_SizeUnitMeasureCode'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing UnitMeasure.UnitMeasureCode.', 'SCHEMA', N'Production', 'TABLE', N'Product', 'CONSTRAINT', N'FK_Product_UnitMeasure_WeightUnitMeasureCode'
GO






















































