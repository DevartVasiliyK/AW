CREATE TABLE [Purchasing].[VendorAddress] (
  [added] [int] NULL,
  [AddressID] [int] NOT NULL,
  [AddressTypeID] [int] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_VendorAddress_ModifiedDate] DEFAULT (getdate()),
  [VendorID] [int] NOT NULL,
  CONSTRAINT [PK_VendorAddress_VendorID_AddressID] PRIMARY KEY CLUSTERED ([VendorID], [AddressID]),
  CONSTRAINT [FK_VendorAddress_Address_AddressID] FOREIGN KEY ([addressid]) REFERENCES [Person].[Address] ([addressid]),
  CONSTRAINT [FK_VendorAddress_AddressType_AddressTypeID] FOREIGN KEY ([addresstypeid]) REFERENCES [Person].[AddressType] ([addresstypeid]),
  CONSTRAINT [FK_VendorAddress_Vendor_VendorID] FOREIGN KEY ([vendorid]) REFERENCES [Purchasing].[Vendor] ([vendorid])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_VendorAddress_AddressID]
  ON [Purchasing].[VendorAddress] ([AddressID])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Cross-reference mapping vendors and addresses.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'INDEX', N'IX_VendorAddress_AddressID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'INDEX', N'PK_VendorAddress_VendorID_AddressID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'CONSTRAINT', N'PK_VendorAddress_VendorID_AddressID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'CONSTRAINT', N'DF_VendorAddress_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Address.AddressID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'CONSTRAINT', N'FK_VendorAddress_Address_AddressID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing AddressType.AddressTypeID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'CONSTRAINT', N'FK_VendorAddress_AddressType_AddressTypeID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Vendor.VendorID.', 'SCHEMA', N'Purchasing', 'TABLE', N'VendorAddress', 'CONSTRAINT', N'FK_VendorAddress_Vendor_VendorID'
GO


















