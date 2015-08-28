CREATE TABLE [Person].[ContactType] (
  [added] [int] NULL,
  [ContactTypeID] [int] IDENTITY,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ContactType_ModifiedDate] DEFAULT (getdate()),
  [Name] [dbo].[Name] NOT NULL,
  CONSTRAINT [PK_ContactType_ContactTypeID] PRIMARY KEY CLUSTERED ([ContactTypeID])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_ContactType_Name]
  ON [Person].[ContactType] ([Name])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Lookup table containing the types of contacts stored in Contact.', 'SCHEMA', N'Person', 'TABLE', N'ContactType'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Person', 'TABLE', N'ContactType', 'INDEX', N'AK_ContactType_Name'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Person', 'TABLE', N'ContactType', 'INDEX', N'PK_ContactType_ContactTypeID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Person', 'TABLE', N'ContactType', 'CONSTRAINT', N'PK_ContactType_ContactTypeID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Person', 'TABLE', N'ContactType', 'CONSTRAINT', N'DF_ContactType_ModifiedDate'
GO












