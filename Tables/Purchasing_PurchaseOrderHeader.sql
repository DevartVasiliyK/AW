SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Purchasing].[PurchaseOrderHeader] (
  [added] [int] NULL,
  [EmployeeID] [int] NOT NULL,
  [Freight] [money] NOT NULL CONSTRAINT [DF_PurchaseOrderHeader_Freight] DEFAULT (0.00),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_PurchaseOrderHeader_ModifiedDate] DEFAULT (getdate()),
  [OrderDate] [datetime] NOT NULL CONSTRAINT [DF_PurchaseOrderHeader_OrderDate] DEFAULT (getdate()),
  [PurchaseOrderID] [int] IDENTITY,
  [RevisionNumber] [tinyint] NOT NULL CONSTRAINT [DF_PurchaseOrderHeader_RevisionNumber] DEFAULT (0),
  [ShipDate] [datetime] NULL,
  [ShipMethodID] [int] NOT NULL,
  [Status] [tinyint] NOT NULL CONSTRAINT [DF_PurchaseOrderHeader_Status] DEFAULT (1),
  [SubTotal] [money] NOT NULL CONSTRAINT [DF_PurchaseOrderHeader_SubTotal] DEFAULT (0.00),
  [TaxAmt] [money] NOT NULL CONSTRAINT [DF_PurchaseOrderHeader_TaxAmt] DEFAULT (0.00),
  [TotalDue] AS (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))) PERSISTED NOT NULL,
  [VendorID] [int] NOT NULL,
  CONSTRAINT [PK_PurchaseOrderHeader_PurchaseOrderID] PRIMARY KEY CLUSTERED ([PurchaseOrderID]),
  CONSTRAINT [CK_PurchaseOrderHeader_Freight] CHECK ([Freight]>=(0.00)),
  CONSTRAINT [CK_PurchaseOrderHeader_ShipDate] CHECK ([ShipDate]>=[OrderDate] OR [ShipDate] IS NULL),
  CONSTRAINT [CK_PurchaseOrderHeader_Status] CHECK ([Status]>=(1) AND [Status]<=(4)),
  CONSTRAINT [CK_PurchaseOrderHeader_SubTotal] CHECK ([SubTotal]>=(0.00)),
  CONSTRAINT [CK_PurchaseOrderHeader_TaxAmt] CHECK ([TaxAmt]>=(0.00)),
  CONSTRAINT [FK_PurchaseOrderHeader_Employee_EmployeeID] FOREIGN KEY ([employeeid]) REFERENCES [HumanResources].[Employee] ([employeeid]),
  CONSTRAINT [FK_PurchaseOrderHeader_ShipMethod_ShipMethodID] FOREIGN KEY ([shipmethodid]) REFERENCES [Purchasing].[ShipMethod] ([shipmethodid]),
  CONSTRAINT [FK_PurchaseOrderHeader_Vendor_VendorID] FOREIGN KEY ([vendorid]) REFERENCES [Purchasing].[Vendor] ([vendorid])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_PurchaseOrderHeader_EmployeeID]
  ON [Purchasing].[PurchaseOrderHeader] ([EmployeeID])
  ON [PRIMARY]
GO

CREATE INDEX [IX_PurchaseOrderHeader_VendorID]
  ON [Purchasing].[PurchaseOrderHeader] ([VendorID])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE TRIGGER [uPurchaseOrderHeader] ON [Purchasing].[PurchaseOrderHeader] 
AFTER UPDATE AS 
BEGIN
DECLARE @Count int;
SET @Count = @@ROWCOUNT;
IF @Count = 0 
RETURN;
SET NOCOUNT ON;
BEGIN TRY
IF NOT UPDATE([Status])
BEGIN
UPDATE [Purchasing].[PurchaseOrderHeader]
SET [Purchasing].[PurchaseOrderHeader].[RevisionNumber] = 
[Purchasing].[PurchaseOrderHeader].[RevisionNumber] + 1
WHERE [Purchasing].[PurchaseOrderHeader].[PurchaseOrderID] IN 
(SELECT inserted.[PurchaseOrderID] FROM inserted);
END;
END TRY
BEGIN CATCH
EXECUTE [dbo].[uspPrintError];
IF @@TRANCOUNT > 0
BEGIN
ROLLBACK TRANSACTION;
END
EXECUTE [dbo].[uspLogError];
END CATCH;
END;
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'AFTER UPDATE trigger that updates the RevisionNumber and ModifiedDate columns in the PurchaseOrderHeader table.', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'TRIGGER', N'uPurchaseOrderHeader'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'General purchase order information. See PurchaseOrderDetail.', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'INDEX', N'IX_PurchaseOrderHeader_EmployeeID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'INDEX', N'IX_PurchaseOrderHeader_VendorID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'INDEX', N'PK_PurchaseOrderHeader_PurchaseOrderID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'PK_PurchaseOrderHeader_PurchaseOrderID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [Freight] >= (0.00)', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'CK_PurchaseOrderHeader_Freight'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [ShipDate] >= [OrderDate] OR [ShipDate] IS NULL', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'CK_PurchaseOrderHeader_ShipDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [Status] BETWEEN (1) AND (4)', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'CK_PurchaseOrderHeader_Status'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [SubTotal] >= (0.00)', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'CK_PurchaseOrderHeader_SubTotal'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [TaxAmt] >= (0.00)', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'CK_PurchaseOrderHeader_TaxAmt'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'DF_PurchaseOrderHeader_Freight'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'DF_PurchaseOrderHeader_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'DF_PurchaseOrderHeader_OrderDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'DF_PurchaseOrderHeader_RevisionNumber'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 1', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'DF_PurchaseOrderHeader_Status'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'DF_PurchaseOrderHeader_SubTotal'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'DF_PurchaseOrderHeader_TaxAmt'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Employee.EmployeeID.', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'FK_PurchaseOrderHeader_Employee_EmployeeID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing ShipMethod.ShipMethodID.', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'FK_PurchaseOrderHeader_ShipMethod_ShipMethodID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Vendor.VendorID.', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'CONSTRAINT', N'FK_PurchaseOrderHeader_Vendor_VendorID'
GO
















































