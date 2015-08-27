CREATE TABLE [Sales].[CustomerAddress] (
  [CustomerID] [int] NOT NULL,
  [AddressID] [int] NOT NULL,
  [AddressTypeID] [int] NOT NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_CustomerAddress_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_CustomerAddress_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_CustomerAddress_CustomerID_AddressID] PRIMARY KEY CLUSTERED ([CustomerID], [AddressID]),
  CONSTRAINT [FK_CustomerAddress_Address_AddressID] FOREIGN KEY ([addressid]) REFERENCES [Person].[Address] ([addressid]),
  CONSTRAINT [FK_CustomerAddress_AddressType_AddressTypeID] FOREIGN KEY ([addresstypeid]) REFERENCES [Person].[AddressType] ([addresstypeid]),
  CONSTRAINT [FK_CustomerAddress_Customer_CustomerID] FOREIGN KEY ([customerid]) REFERENCES [Sales].[Customer] ([customerid])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_CustomerAddress_rowguid]
  ON [Sales].[CustomerAddress] ([rowguid])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping customers to their address(es).', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'INDEX', N'AK_CustomerAddress_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'INDEX', N'PK_CustomerAddress_CustomerID_AddressID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'CONSTRAINT', N'PK_CustomerAddress_CustomerID_AddressID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'CONSTRAINT', N'DF_CustomerAddress_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'CONSTRAINT', N'DF_CustomerAddress_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Address.AddressID.', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'CONSTRAINT', N'FK_CustomerAddress_Address_AddressID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing AddressType.AddressTypeID.', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'CONSTRAINT', N'FK_CustomerAddress_AddressType_AddressTypeID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Customer.CustomerID.', 'SCHEMA', N'Sales', 'TABLE', N'CustomerAddress', 'CONSTRAINT', N'FK_CustomerAddress_Customer_CustomerID'
GO