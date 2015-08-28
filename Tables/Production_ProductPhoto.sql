CREATE TABLE [Production].[ProductPhoto] (
  [added] [int] NULL,
  [LargePhoto] [varbinary](max) NULL,
  [LargePhotoFileName] [nvarchar](50) NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductPhoto_ModifiedDate] DEFAULT (getdate()),
  [ProductPhotoID] [int] IDENTITY,
  [ThumbNailPhoto] [varbinary](max) NULL,
  [ThumbnailPhotoFileName] [nvarchar](50) NULL,
  CONSTRAINT [PK_ProductPhoto_ProductPhotoID] PRIMARY KEY CLUSTERED ([ProductPhotoID])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Product images.', 'SCHEMA', N'Production', 'TABLE', N'ProductPhoto'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'ProductPhoto', 'INDEX', N'PK_ProductPhoto_ProductPhotoID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'ProductPhoto', 'CONSTRAINT', N'PK_ProductPhoto_ProductPhotoID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'ProductPhoto', 'CONSTRAINT', N'DF_ProductPhoto_ModifiedDate'
GO








