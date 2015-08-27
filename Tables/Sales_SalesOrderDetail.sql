CREATE TABLE [Sales].[SalesOrderDetail] (
  [SalesOrderID] [int] NOT NULL,
  [SalesOrderDetailID] [int] IDENTITY,
  [CarrierTrackingNumber] [nvarchar](25) NULL,
  [OrderQty] [smallint] NOT NULL,
  [ProductID] [int] NOT NULL,
  [SpecialOfferID] [int] NOT NULL,
  [UnitPrice] [money] NOT NULL,
  [UnitPriceDiscount] [money] NOT NULL CONSTRAINT [DF_SalesOrderDetail_UnitPriceDiscount] DEFAULT (0.0),
  [LineTotal] AS (isnull(([UnitPrice]*((1.0)-[UnitPriceDiscount]))*[OrderQty],(0.0))),
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesOrderDetail_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderDetail_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] PRIMARY KEY CLUSTERED ([SalesOrderID], [SalesOrderDetailID]),
  CONSTRAINT [CK_SalesOrderDetail_OrderQty] CHECK ([OrderQty]>(0)),
  CONSTRAINT [CK_SalesOrderDetail_UnitPrice] CHECK ([UnitPrice]>=(0.00)),
  CONSTRAINT [CK_SalesOrderDetail_UnitPriceDiscount] CHECK ([UnitPriceDiscount]>=(0.00)),
  CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID] FOREIGN KEY ([salesorderid]) REFERENCES [Sales].[SalesOrderHeader] ([salesorderid]) ON DELETE CASCADE,
  CONSTRAINT [FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID] FOREIGN KEY ([specialofferid], [productid]) REFERENCES [Sales].[SpecialOfferProduct] ([specialofferid], [productid])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_SalesOrderDetail_rowguid]
  ON [Sales].[SalesOrderDetail] ([rowguid])
  ON [PRIMARY]
GO

CREATE INDEX [IX_SalesOrderDetail_ProductID]
  ON [Sales].[SalesOrderDetail] ([ProductID])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE TRIGGER [iduSalesOrderDetail] ON [Sales].[SalesOrderDetail] 
AFTER INSERT, DELETE, UPDATE AS 
BEGIN
DECLARE @Count int;
SET @Count = @@ROWCOUNT;
IF @Count = 0 
RETURN;
SET NOCOUNT ON;
BEGIN TRY
IF UPDATE([ProductID]) OR UPDATE([OrderQty]) OR UPDATE([UnitPrice]) OR UPDATE([UnitPriceDiscount]) 
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
,inserted.[SalesOrderID]
,inserted.[SalesOrderDetailID]
,'S'
,GETDATE()
,inserted.[OrderQty]
,inserted.[UnitPrice]
FROM inserted 
INNER JOIN [Sales].[SalesOrderHeader] 
ON inserted.[SalesOrderID] = [Sales].[SalesOrderHeader].[SalesOrderID];
UPDATE [Sales].[Individual] 
SET [Demographics].modify('declare default element namespace 
"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
replace value of (/IndividualSurvey/TotalPurchaseYTD)[1] 
with data(/IndividualSurvey/TotalPurchaseYTD)[1] + sql:column ("inserted.LineTotal")') 
FROM inserted 
INNER JOIN [Sales].[SalesOrderHeader] 
ON inserted.[SalesOrderID] = [Sales].[SalesOrderHeader].[SalesOrderID] 
WHERE [Sales].[SalesOrderHeader].[CustomerID] = [Sales].[Individual].[CustomerID];
END;
UPDATE [Sales].[SalesOrderHeader]
SET [Sales].[SalesOrderHeader].[SubTotal] = 
(SELECT SUM([Sales].[SalesOrderDetail].[LineTotal])
FROM [Sales].[SalesOrderDetail]
WHERE [Sales].[SalesOrderHeader].[SalesOrderID] = [Sales].[SalesOrderDetail].[SalesOrderID])
WHERE [Sales].[SalesOrderHeader].[SalesOrderID] IN (SELECT inserted.[SalesOrderID] FROM inserted);
UPDATE [Sales].[Individual] 
SET [Demographics].modify('declare default element namespace 
"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
replace value of (/IndividualSurvey/TotalPurchaseYTD)[1] 
with data(/IndividualSurvey/TotalPurchaseYTD)[1] - sql:column("deleted.LineTotal")') 
FROM deleted 
INNER JOIN [Sales].[SalesOrderHeader] 
ON deleted.[SalesOrderID] = [Sales].[SalesOrderHeader].[SalesOrderID] 
WHERE [Sales].[SalesOrderHeader].[CustomerID] = [Sales].[Individual].[CustomerID];
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

EXEC sys.sp_addextendedproperty N'MS_Description', N'AFTER INSERT, DELETE, UPDATE trigger that inserts a row in the TransactionHistory table, updates ModifiedDate in SalesOrderDetail and updates the SalesOrderHeader.SubTotal column.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'TRIGGER', N'iduSalesOrderDetail'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Individual products associated with a specific sales order. See SalesOrderHeader.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'INDEX', N'AK_SalesOrderDetail_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'INDEX', N'IX_SalesOrderDetail_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'INDEX', N'PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [OrderQty] > (0)', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'CK_SalesOrderDetail_OrderQty'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [UnitPrice] >= (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'CK_SalesOrderDetail_UnitPrice'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [UnitPriceDiscount] >= (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'CK_SalesOrderDetail_UnitPriceDiscount'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'DF_SalesOrderDetail_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'DF_SalesOrderDetail_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'DF_SalesOrderDetail_UnitPriceDiscount'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SalesOrderHeader.PurchaseOrderID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SpecialOfferProduct.SpecialOfferIDProductID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID'
GO