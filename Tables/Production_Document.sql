CREATE TABLE [Production].[Document] (
  [DocumentID] [int] IDENTITY,
  [Title] [nvarchar](50) NOT NULL,
  [FileName] [nvarchar](400) NOT NULL,
  [FileExtension] [nvarchar](8) NOT NULL,
  [Revision] [nchar](5) NOT NULL,
  [ChangeNumber] [int] NOT NULL CONSTRAINT [DF_Document_ChangeNumber] DEFAULT (0),
  [Status] [tinyint] NOT NULL,
  [DocumentSummary] [nvarchar](max) NULL,
  [Document] [varbinary](max) NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Document_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_Document_DocumentID] PRIMARY KEY CLUSTERED ([DocumentID]),
  CONSTRAINT [CK_Document_Status] CHECK ([Status]>=(1) AND [Status]<=(3))
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_Document_FileName_Revision]
  ON [Production].[Document] ([FileName], [Revision])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Product maintenance documents.', 'SCHEMA', N'Production', 'TABLE', N'Document'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'Document', 'INDEX', N'AK_Document_FileName_Revision'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'Document', 'INDEX', N'PK_Document_DocumentID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'Document', 'CONSTRAINT', N'PK_Document_DocumentID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [Status] BETWEEN (1) AND (3)', 'SCHEMA', N'Production', 'TABLE', N'Document', 'CONSTRAINT', N'CK_Document_Status'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0', 'SCHEMA', N'Production', 'TABLE', N'Document', 'CONSTRAINT', N'DF_Document_ChangeNumber'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'Document', 'CONSTRAINT', N'DF_Document_ModifiedDate'
GO