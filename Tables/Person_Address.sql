CREATE TABLE [Person].[Address] (
  [added] [int] NULL,
  [AddressID] [int] IDENTITY NOT FOR REPLICATION,
  [AddressLine1] [nvarchar](60) NOT NULL,
  [AddressLine2] [nvarchar](60) NULL,
  [City] [nvarchar](30) NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Address_ModifiedDate] DEFAULT (getdate()),
  [PostalCode] [nvarchar](15) NOT NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Address_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [StateProvinceID] [int] NOT NULL,
  CONSTRAINT [PK_Address_AddressID] PRIMARY KEY CLUSTERED ([AddressID]),
  CONSTRAINT [FK_Address_StateProvince_StateProvinceID] FOREIGN KEY ([stateprovinceid]) REFERENCES [Person].[StateProvince] ([stateprovinceid])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_Address_rowguid]
  ON [Person].[Address] ([rowguid])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode]
  ON [Person].[Address] ([AddressLine1], [AddressLine2], [City], [StateProvinceID], [PostalCode])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Address_StateProvinceID]
  ON [Person].[Address] ([StateProvinceID])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Street address information for customers, employees, and vendors.', 'SCHEMA', N'Person', 'TABLE', N'Address'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Person', 'TABLE', N'Address', 'INDEX', N'AK_Address_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Person', 'TABLE', N'Address', 'INDEX', N'IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Person', 'TABLE', N'Address', 'INDEX', N'IX_Address_StateProvinceID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Person', 'TABLE', N'Address', 'INDEX', N'PK_Address_AddressID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Person', 'TABLE', N'Address', 'CONSTRAINT', N'PK_Address_AddressID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Person', 'TABLE', N'Address', 'CONSTRAINT', N'DF_Address_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Person', 'TABLE', N'Address', 'CONSTRAINT', N'DF_Address_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing StateProvince.StateProvinceID.', 'SCHEMA', N'Person', 'TABLE', N'Address', 'CONSTRAINT', N'FK_Address_StateProvince_StateProvinceID'
GO
























