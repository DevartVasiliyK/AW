CREATE TABLE [Production].[ProductProductPhoto] (
  [ProductID] [int] NOT NULL,
  [ProductPhotoID] [int] NOT NULL,
  [Primary] [dbo].[Flag] NOT NULL CONSTRAINT [DF_ProductProductPhoto_Primary] DEFAULT (0),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductProductPhoto_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_ProductProductPhoto_ProductID_ProductPhotoID] PRIMARY KEY NONCLUSTERED ([ProductID], [ProductPhotoID]),
  CONSTRAINT [FK_ProductProductPhoto_Product_ProductID] FOREIGN KEY ([productid]) REFERENCES [Production].[Product] ([productid]),
  CONSTRAINT [FK_ProductProductPhoto_ProductPhoto_ProductPhotoID] FOREIGN KEY ([productphotoid]) REFERENCES [Production].[ProductPhoto] ([productphotoid])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping products and product photos.', 'SCHEMA', N'Production', 'TABLE', N'ProductProductPhoto'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'ProductProductPhoto', 'INDEX', N'PK_ProductProductPhoto_ProductID_ProductPhotoID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'ProductProductPhoto', 'CONSTRAINT', N'PK_ProductProductPhoto_ProductID_ProductPhotoID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'ProductProductPhoto', 'CONSTRAINT', N'DF_ProductProductPhoto_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0 (FALSE)', 'SCHEMA', N'Production', 'TABLE', N'ProductProductPhoto', 'CONSTRAINT', N'DF_ProductProductPhoto_Primary'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', 'SCHEMA', N'Production', 'TABLE', N'ProductProductPhoto', 'CONSTRAINT', N'FK_ProductProductPhoto_Product_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing ProductPhoto.ProductPhotoID.', 'SCHEMA', N'Production', 'TABLE', N'ProductProductPhoto', 'CONSTRAINT', N'FK_ProductProductPhoto_ProductPhoto_ProductPhotoID'
GO