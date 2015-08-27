CREATE TABLE [Person].[Contact] (
  [ContactID] [int] IDENTITY NOT FOR REPLICATION,
  [NameStyle] [dbo].[NameStyle] NOT NULL CONSTRAINT [DF_Contact_NameStyle] DEFAULT (0),
  [Title] [nvarchar](8) NULL,
  [FirstName] [dbo].[Name] NOT NULL,
  [MiddleName] [dbo].[Name] NULL,
  [LastName] [dbo].[Name] NOT NULL,
  [Suffix] [nvarchar](10) NULL,
  [EmailAddress] [nvarchar](50) NULL,
  [EmailPromotion] [int] NOT NULL CONSTRAINT [DF_Contact_EmailPromotion] DEFAULT (0),
  [Phone] [dbo].[Phone] NULL,
  [PasswordHash] [varchar](128) NOT NULL,
  [PasswordSalt] [varchar](10) NOT NULL,
  [AdditionalContactInfo] [xml] (CONTENT Person.AdditionalContactInfoSchemaCollection) NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Contact_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Contact_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_Contact_ContactID] PRIMARY KEY CLUSTERED ([ContactID]),
  CONSTRAINT [CK_Contact_EmailPromotion] CHECK ([EmailPromotion]>=(0) AND [EmailPromotion]<=(2))
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PRIMARY XML INDEX [PXML_Contact_AddContact]
  ON [Person].[Contact] ([AdditionalContactInfo])
GO

CREATE UNIQUE INDEX [AK_Contact_rowguid]
  ON [Person].[Contact] ([rowguid])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Contact_EmailAddress]
  ON [Person].[Contact] ([EmailAddress])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary XML index.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'INDEX', N'PXML_Contact_AddContact'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Names of each employee, customer contact, and vendor contact.', 'SCHEMA', N'Person', 'TABLE', N'Contact'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'INDEX', N'AK_Contact_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'INDEX', N'IX_Contact_EmailAddress'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'INDEX', N'PK_Contact_ContactID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'CONSTRAINT', N'PK_Contact_ContactID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [EmailPromotion] >= (0) AND [EmailPromotion] <= (2)', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'CONSTRAINT', N'CK_Contact_EmailPromotion'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'CONSTRAINT', N'DF_Contact_EmailPromotion'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'CONSTRAINT', N'DF_Contact_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'CONSTRAINT', N'DF_Contact_NameStyle'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Person', 'TABLE', N'Contact', 'CONSTRAINT', N'DF_Contact_rowguid'
GO