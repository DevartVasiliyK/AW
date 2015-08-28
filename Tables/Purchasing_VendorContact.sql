CREATE TABLE [Purchasing].[VendorContact] (
  [added] [int] NULL,
  [ContactID] [int] NOT NULL,
  [ContactTypeID] [int] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_VendorContact_ModifiedDate] DEFAULT (getdate()),
  [VendorID] [int] NOT NULL,
  CONSTRAINT [PK_VendorContact_VendorID_ContactID] PRIMARY KEY CLUSTERED ([VendorID], [ContactID]),
  CONSTRAINT [FK_VendorContact_Contact_ContactID] FOREIGN KEY ([contactid]) REFERENCES [Person].[Contact] ([contactid]),
  CONSTRAINT [FK_VendorContact_ContactType_ContactTypeID] FOREIGN KEY ([contacttypeid]) REFERENCES [Person].[ContactType] ([contacttypeid]),
  CONSTRAINT [FK_VendorContact_Vendor_VendorID] FOREIGN KEY ([vendorid]) REFERENCES [Purchasing].[Vendor] ([vendorid])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_VendorContact_ContactID]
  ON [Purchasing].[VendorContact] ([ContactID])
  ON [PRIMARY]
GO

CREATE INDEX [IX_VendorContact_ContactTypeID]
  ON [Purchasing].[VendorContact] ([ContactTypeID])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping vendors and their employees.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'INDEX', N'IX_VendorContact_ContactID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'INDEX', N'IX_VendorContact_ContactTypeID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'INDEX', N'PK_VendorContact_VendorID_ContactID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'CONSTRAINT', N'PK_VendorContact_VendorID_ContactID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'CONSTRAINT', N'DF_VendorContact_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Contact.ContactID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'CONSTRAINT', N'FK_VendorContact_Contact_ContactID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing ContactType.ContactTypeID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'CONSTRAINT', N'FK_VendorContact_ContactType_ContactTypeID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Vendor.VendorID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorContact', 'CONSTRAINT', N'FK_VendorContact_Vendor_VendorID'
GO






















