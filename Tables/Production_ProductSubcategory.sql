CREATE TABLE [Production].[ProductSubcategory] (
  [added] [int] NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductSubcategory_ModifiedDate] DEFAULT (getdate()),
  [Name] [dbo].[Name] NOT NULL,
  [ProductCategoryID] [int] NOT NULL,
  [ProductSubcategoryID] [int] IDENTITY,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ProductSubcategory_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  CONSTRAINT [PK_ProductSubcategory_ProductSubcategoryID] PRIMARY KEY CLUSTERED ([ProductSubcategoryID]),
  CONSTRAINT [FK_ProductSubcategory_ProductCategory_ProductCategoryID] FOREIGN KEY ([productcategoryid]) REFERENCES [Production].[ProductCategory] ([productcategoryid])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_ProductSubcategory_Name]
  ON [Production].[ProductSubcategory] ([Name])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_ProductSubcategory_rowguid]
  ON [Production].[ProductSubcategory] ([rowguid])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Product subcategories. See ProductCategory table.', 'SCHEMA', N'Production', 'TABLE', N'ProductSubcategory'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'ProductSubcategory', 'INDEX', N'AK_ProductSubcategory_Name'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Production', 'TABLE', N'ProductSubcategory', 'INDEX', N'AK_ProductSubcategory_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'ProductSubcategory', 'INDEX', N'PK_ProductSubcategory_ProductSubcategoryID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'ProductSubcategory', 'CONSTRAINT', N'PK_ProductSubcategory_ProductSubcategoryID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'ProductSubcategory', 'CONSTRAINT', N'DF_ProductSubcategory_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Production', 'TABLE', N'ProductSubcategory', 'CONSTRAINT', N'DF_ProductSubcategory_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing ProductCategory.ProductCategoryID.', 'SCHEMA', N'Production', 'TABLE', N'ProductSubcategory', 'CONSTRAINT', N'FK_ProductSubcategory_ProductCategory_ProductCategoryID'
GO




















