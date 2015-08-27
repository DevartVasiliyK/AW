CREATE TABLE [Sales].[StoreContact] (
  [CustomerID] [int] NOT NULL,
  [ContactID] [int] NOT NULL,
  [ContactTypeID] [int] NOT NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_StoreContact_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_StoreContact_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_StoreContact_CustomerID_ContactID] PRIMARY KEY CLUSTERED ([CustomerID], [ContactID]),
  CONSTRAINT [FK_StoreContact_Contact_ContactID] FOREIGN KEY ([contactid]) REFERENCES [Person].[Contact] ([contactid]),
  CONSTRAINT [FK_StoreContact_ContactType_ContactTypeID] FOREIGN KEY ([contacttypeid]) REFERENCES [Person].[ContactType] ([contacttypeid]),
  CONSTRAINT [FK_StoreContact_Store_CustomerID] FOREIGN KEY ([customerid]) REFERENCES [Sales].[Store] ([customerid])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_StoreContact_rowguid]
  ON [Sales].[StoreContact] ([rowguid])
  ON [PRIMARY]
GO

CREATE INDEX [IX_StoreContact_ContactID]
  ON [Sales].[StoreContact] ([ContactID])
  ON [PRIMARY]
GO

CREATE INDEX [IX_StoreContact_ContactTypeID]
  ON [Sales].[StoreContact] ([ContactTypeID])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping stores and their employees.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'INDEX', N'AK_StoreContact_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'INDEX', N'IX_StoreContact_ContactID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'INDEX', N'IX_StoreContact_ContactTypeID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'INDEX', N'PK_StoreContact_CustomerID_ContactID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'CONSTRAINT', N'PK_StoreContact_CustomerID_ContactID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'CONSTRAINT', N'DF_StoreContact_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'CONSTRAINT', N'DF_StoreContact_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Contact.ContactID.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'CONSTRAINT', N'FK_StoreContact_Contact_ContactID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing ContactType.ContactTypeID.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'CONSTRAINT', N'FK_StoreContact_ContactType_ContactTypeID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Store.CustomerID.', 'SCHEMA', N'Sales', 'TABLE', N'StoreContact', 'CONSTRAINT', N'FK_StoreContact_Store_CustomerID'
GO