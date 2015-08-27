CREATE TABLE [Production].[ProductDocument] (
  [ProductID] [int] NOT NULL,
  [DocumentID] [int] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductDocument_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_ProductDocument_ProductID_DocumentID] PRIMARY KEY CLUSTERED ([ProductID], [DocumentID]),
  CONSTRAINT [FK_ProductDocument_Document_DocumentID] FOREIGN KEY ([documentid]) REFERENCES [Production].[Document] ([documentid]),
  CONSTRAINT [FK_ProductDocument_Product_ProductID] FOREIGN KEY ([productid]) REFERENCES [Production].[Product] ([productid])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping products to related product documents.', 'SCHEMA', N'Production', 'TABLE', N'ProductDocument'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'ProductDocument', 'INDEX', N'PK_ProductDocument_ProductID_DocumentID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'ProductDocument', 'CONSTRAINT', N'PK_ProductDocument_ProductID_DocumentID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'ProductDocument', 'CONSTRAINT', N'DF_ProductDocument_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Document.DocumentID.', 'SCHEMA', N'Production', 'TABLE', N'ProductDocument', 'CONSTRAINT', N'FK_ProductDocument_Document_DocumentID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', 'SCHEMA', N'Production', 'TABLE', N'ProductDocument', 'CONSTRAINT', N'FK_ProductDocument_Product_ProductID'
GO