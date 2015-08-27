CREATE TABLE [Purchasing].[PurchaseOrderDetail] (
  [PurchaseOrderID] [int] NOT NULL,
  [PurchaseOrderDetailID] [int] IDENTITY,
  [DueDate] [datetime] NOT NULL,
  [OrderQty] [smallint] NOT NULL,
  [ProductID] [int] NOT NULL,
  [UnitPrice] [money] NOT NULL,
  [LineTotal] AS (isnull([OrderQty]*[UnitPrice],(0.00))),
  [ReceivedQty] [decimal](8, 2) NOT NULL,
  [RejectedQty] [decimal](8, 2) NOT NULL,
  [StockedQty] AS (isnull([ReceivedQty]-[RejectedQty],(0.00))),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_PurchaseOrderDetail_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID] PRIMARY KEY CLUSTERED ([PurchaseOrderID], [PurchaseOrderDetailID]),
  CONSTRAINT [CK_PurchaseOrderDetail_OrderQty] CHECK ([OrderQty]>(0)),
  CONSTRAINT [CK_PurchaseOrderDetail_ReceivedQty] CHECK ([ReceivedQty]>=(0.00)),
  CONSTRAINT [CK_PurchaseOrderDetail_RejectedQty] CHECK ([RejectedQty]>=(0.00)),
  CONSTRAINT [CK_PurchaseOrderDetail_UnitPrice] CHECK ([UnitPrice]>=(0.00)),
  CONSTRAINT [FK_PurchaseOrderDetail_Product_ProductID] FOREIGN KEY ([productid]) REFERENCES [Production].[Product] ([productid]),
  CONSTRAINT [FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID] FOREIGN KEY ([purchaseorderid]) REFERENCES [Purchasing].[PurchaseOrderHeader] ([purchaseorderid])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_PurchaseOrderDetail_ProductID]
  ON [Purchasing].[PurchaseOrderDetail] ([ProductID])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE TRIGGER [iPurchaseOrderDetail] ON [Purchasing].[PurchaseOrderDetail] 
AFTER INSERT AS
BEGIN
DECLARE @Count int;
SET @Count = @@ROWCOUNT;
IF @Count = 0 
RETURN;
SET NOCOUNT ON;
BEGIN TRY
INSERT INTO [Production].[TransactionHistory]
([ProductID]
,[ReferenceOrderID]
,[ReferenceOrderLineID]
,[TransactionType]
,[TransactionDate]
,[Quantity]
,[ActualCost])
SELECT 
inserted.[ProductID]
,inserted.[PurchaseOrderID]
,inserted.[PurchaseOrderDetailID]
,'P'
,GETDATE()
,inserted.[OrderQty]
,inserted.[UnitPrice]
FROM inserted 
INNER JOIN [Purchasing].[PurchaseOrderHeader] 
ON inserted.[PurchaseOrderID] = [Purchasing].[PurchaseOrderHeader].[PurchaseOrderID];
UPDATE [Purchasing].[PurchaseOrderHeader]
SET [Purchasing].[PurchaseOrderHeader].[SubTotal] = 
(SELECT SUM([Purchasing].[PurchaseOrderDetail].[LineTotal])
FROM [Purchasing].[PurchaseOrderDetail]
WHERE [Purchasing].[PurchaseOrderHeader].[PurchaseOrderID] = [Purchasing].[PurchaseOrderDetail].[PurchaseOrderID])
WHERE [Purchasing].[PurchaseOrderHeader].[PurchaseOrderID] IN (SELECT inserted.[PurchaseOrderID] FROM inserted);
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

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE TRIGGER [uPurchaseOrderDetail] ON [Purchasing].[PurchaseOrderDetail] 
AFTER UPDATE AS 
BEGIN
DECLARE @Count int;
SET @Count = @@ROWCOUNT;
IF @Count = 0 
RETURN;
SET NOCOUNT ON;
BEGIN TRY
IF UPDATE([ProductID]) OR UPDATE([OrderQty]) OR UPDATE([UnitPrice])
BEGIN
INSERT INTO [Production].[TransactionHistory]
([ProductID]
,[ReferenceOrderID]
,[ReferenceOrderLineID]
,[TransactionType]
,[TransactionDate]
,[Quantity]
,[ActualCost])
SELECT 
inserted.[ProductID]
,inserted.[PurchaseOrderID]
,inserted.[PurchaseOrderDetailID]
,'P'
,GETDATE()
,inserted.[OrderQty]
,inserted.[UnitPrice]
FROM inserted 
INNER JOIN [Purchasing].[PurchaseOrderDetail] 
ON inserted.[PurchaseOrderID] = [Purchasing].[PurchaseOrderDetail].[PurchaseOrderID];
UPDATE [Purchasing].[PurchaseOrderHeader]
SET [Purchasing].[PurchaseOrderHeader].[SubTotal] = 
(SELECT SUM([Purchasing].[PurchaseOrderDetail].[LineTotal])
FROM [Purchasing].[PurchaseOrderDetail]
WHERE [Purchasing].[PurchaseOrderHeader].[PurchaseOrderID] 
= [Purchasing].[PurchaseOrderDetail].[PurchaseOrderID])
WHERE [Purchasing].[PurchaseOrderHeader].[PurchaseOrderID] 
IN (SELECT inserted.[PurchaseOrderID] FROM inserted);
UPDATE [Purchasing].[PurchaseOrderDetail]
SET [Purchasing].[PurchaseOrderDetail].[ModifiedDate] = GETDATE()
FROM inserted
WHERE inserted.[PurchaseOrderID] = [Purchasing].[PurchaseOrderDetail].[PurchaseOrderID]
AND inserted.[PurchaseOrderDetailID] = [Purchasing].[PurchaseOrderDetail].[PurchaseOrderDetailID];
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

EXEC sys.sp_addextendedproperty N'MS_Description', N'AFTER INSERT trigger that inserts a row in the TransactionHistory table and updates the PurchaseOrderHeader.SubTotal column.', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'TRIGGER', N'iPurchaseOrderDetail'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'AFTER UPDATE trigger that inserts a row in the TransactionHistory table, updates ModifiedDate in PurchaseOrderDetail and updates the PurchaseOrderHeader.SubTotal column.', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'TRIGGER', N'uPurchaseOrderDetail'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Individual products associated with a specific purchase order. See PurchaseOrderHeader.', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'INDEX', N'IX_PurchaseOrderDetail_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'INDEX', N'PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'CONSTRAINT', N'PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [OrderQty] > (0)', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'CONSTRAINT', N'CK_PurchaseOrderDetail_OrderQty'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [ReceivedQty] >= (0.00)', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'CONSTRAINT', N'CK_PurchaseOrderDetail_ReceivedQty'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [RejectedQty] >= (0.00)', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'CONSTRAINT', N'CK_PurchaseOrderDetail_RejectedQty'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [UnitPrice] >= (0.00)', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'CONSTRAINT', N'CK_PurchaseOrderDetail_UnitPrice'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'CONSTRAINT', N'DF_PurchaseOrderDetail_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'CONSTRAINT', N'FK_PurchaseOrderDetail_Product_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing PurchaseOrderHeader.PurchaseOrderID.', 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'CONSTRAINT', N'FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID'
GO