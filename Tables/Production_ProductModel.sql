CREATE TABLE [Production].[ProductModel] (
  [added] [int] NULL,
  [CatalogDescription] [xml] (CONTENT Production.ProductDescriptionSchemaCollection) NULL,
  [Instructions] [xml] (CONTENT Production.ManuInstructionsSchemaCollection) NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductModel_ModifiedDate] DEFAULT (getdate()),
  [Name] [dbo].[Name] NOT NULL,
  [ProductModelID] [int] IDENTITY,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ProductModel_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  CONSTRAINT [PK_ProductModel_ProductModelID] PRIMARY KEY CLUSTERED ([ProductModelID])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PRIMARY XML INDEX [PXML_ProductModel_Instructions]
  ON [Production].[ProductModel] ([Instructions])
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PRIMARY XML INDEX [PXML_ProductModel_CatalogDescription]
  ON [Production].[ProductModel] ([CatalogDescription])
GO

CREATE UNIQUE INDEX [AK_ProductModel_Name]
  ON [Production].[ProductModel] ([Name])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_ProductModel_rowguid]
  ON [Production].[ProductModel] ([rowguid])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary XML index.', 'SCHEMA', N'Production', 'TABLE', N'ProductModel', 'INDEX', N'PXML_ProductModel_Instructions'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary XML index.', 'SCHEMA', N'Production', 'TABLE', N'ProductModel', 'INDEX', N'PXML_ProductModel_CatalogDescription'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Product model classification.', 'SCHEMA', N'Production', 'TABLE', N'ProductModel'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'ProductModel', 'INDEX', N'AK_ProductModel_Name'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Production', 'TABLE', N'ProductModel', 'INDEX', N'AK_ProductModel_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'ProductModel', 'INDEX', N'PK_ProductModel_ProductModelID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'ProductModel', 'CONSTRAINT', N'PK_ProductModel_ProductModelID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'ProductModel', 'CONSTRAINT', N'DF_ProductModel_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Production', 'TABLE', N'ProductModel', 'CONSTRAINT', N'DF_ProductModel_rowguid'
GO


























