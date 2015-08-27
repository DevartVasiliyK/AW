CREATE TABLE [Production].[ProductReview] (
  [ProductReviewID] [int] IDENTITY,
  [ProductID] [int] NOT NULL,
  [ReviewerName] [dbo].[Name] NOT NULL,
  [ReviewDate] [datetime] NOT NULL CONSTRAINT [DF_ProductReview_ReviewDate] DEFAULT (getdate()),
  [EmailAddress] [nvarchar](50) NOT NULL,
  [Rating] [int] NOT NULL,
  [Comments] [nvarchar](3850) NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductReview_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_ProductReview_ProductReviewID] PRIMARY KEY CLUSTERED ([ProductReviewID]),
  CONSTRAINT [CK_ProductReview_Rating] CHECK ([Rating]>=(1) AND [Rating]<=(5)),
  CONSTRAINT [FK_ProductReview_Product_ProductID] FOREIGN KEY ([productid]) REFERENCES [Production].[Product] ([productid])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_ProductReview_ProductID_Name]
  ON [Production].[ProductReview] ([ProductID], [ReviewerName])
  INCLUDE ([Comments])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Customer reviews of products they have purchased.', 'SCHEMA', N'Production', 'TABLE', N'ProductReview'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'ProductReview', 'INDEX', N'IX_ProductReview_ProductID_Name'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'ProductReview', 'INDEX', N'PK_ProductReview_ProductReviewID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'ProductReview', 'CONSTRAINT', N'PK_ProductReview_ProductReviewID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [Rating] BETWEEN (1) AND (5)', 'SCHEMA', N'Production', 'TABLE', N'ProductReview', 'CONSTRAINT', N'CK_ProductReview_Rating'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'ProductReview', 'CONSTRAINT', N'DF_ProductReview_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'ProductReview', 'CONSTRAINT', N'DF_ProductReview_ReviewDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', 'SCHEMA', N'Production', 'TABLE', N'ProductReview', 'CONSTRAINT', N'FK_ProductReview_Product_ProductID'
GO