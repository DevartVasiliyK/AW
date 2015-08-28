CREATE TABLE [Production].[WorkOrder] (
  [added] [int] NULL,
  [DueDate] [datetime] NOT NULL,
  [EndDate] [datetime] NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_WorkOrder_ModifiedDate] DEFAULT (getdate()),
  [OrderQty] [int] NOT NULL,
  [ProductID] [int] NOT NULL,
  [ScrappedQty] [smallint] NOT NULL,
  [ScrapReasonID] [smallint] NULL,
  [StartDate] [datetime] NOT NULL,
  [StockedQty] AS (isnull([OrderQty]-[ScrappedQty],(0))),
  [WorkOrderID] [int] IDENTITY,
  CONSTRAINT [PK_WorkOrder_WorkOrderID] PRIMARY KEY CLUSTERED ([WorkOrderID]),
  CONSTRAINT [CK_WorkOrder_EndDate] CHECK ([EndDate]>=[StartDate] OR [EndDate] IS NULL),
  CONSTRAINT [CK_WorkOrder_OrderQty] CHECK ([OrderQty]>(0)),
  CONSTRAINT [CK_WorkOrder_ScrappedQty] CHECK ([ScrappedQty]>=(0)),
  CONSTRAINT [FK_WorkOrder_Product_ProductID] FOREIGN KEY ([productid]) REFERENCES [Production].[Product] ([productid]),
  CONSTRAINT [FK_WorkOrder_ScrapReason_ScrapReasonID] FOREIGN KEY ([scrapreasonid]) REFERENCES [Production].[ScrapReason] ([scrapreasonid])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_WorkOrder_ProductID]
  ON [Production].[WorkOrder] ([ProductID])
  ON [PRIMARY]
GO

CREATE INDEX [IX_WorkOrder_ScrapReasonID]
  ON [Production].[WorkOrder] ([ScrapReasonID])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE TRIGGER [iWorkOrder] ON [Production].[WorkOrder] 
AFTER INSERT AS 
BEGIN
DECLARE @Count int;
SET @Count = @@ROWCOUNT;
IF @Count = 0 
RETURN;
SET NOCOUNT ON;
BEGIN TRY
INSERT INTO [Production].[TransactionHistory](
[ProductID]
,[ReferenceOrderID]
,[TransactionType]
,[TransactionDate]
,[Quantity]
,[ActualCost])
SELECT 
inserted.[ProductID]
,inserted.[WorkOrderID]
,'W'
,GETDATE()
,inserted.[OrderQty]
,0
FROM inserted;
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

CREATE TRIGGER [uWorkOrder] ON [Production].[WorkOrder] 
AFTER UPDATE AS 
BEGIN
DECLARE @Count int;
SET @Count = @@ROWCOUNT;
IF @Count = 0 
RETURN;
SET NOCOUNT ON;
BEGIN TRY
IF UPDATE([ProductID]) OR UPDATE([OrderQty])
BEGIN
INSERT INTO [Production].[TransactionHistory](
[ProductID]
,[ReferenceOrderID]
,[TransactionType]
,[TransactionDate]
,[Quantity])
SELECT 
inserted.[ProductID]
,inserted.[WorkOrderID]
,'W'
,GETDATE()
,inserted.[OrderQty]
FROM inserted;
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

EXEC sys.sp_addextendedproperty N'MS_Description', N'AFTER INSERT trigger that inserts a row in the TransactionHistory table.', 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'TRIGGER', N'iWorkOrder'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'AFTER UPDATE trigger that inserts a row in the TransactionHistory table, updates ModifiedDate in the WorkOrder table.', 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'TRIGGER', N'uWorkOrder'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Manufacturing work orders.', 'SCHEMA', N'Production', 'TABLE', N'WorkOrder'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'INDEX', N'IX_WorkOrder_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'INDEX', N'IX_WorkOrder_ScrapReasonID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'INDEX', N'PK_WorkOrder_WorkOrderID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'CONSTRAINT', N'PK_WorkOrder_WorkOrderID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [EndDate] >= [StartDate] OR [EndDate] IS NULL', 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'CONSTRAINT', N'CK_WorkOrder_EndDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [OrderQty] > (0)', 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'CONSTRAINT', N'CK_WorkOrder_OrderQty'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [ScrappedQty] >= (0)', 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'CONSTRAINT', N'CK_WorkOrder_ScrappedQty'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'CONSTRAINT', N'DF_WorkOrder_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'CONSTRAINT', N'FK_WorkOrder_Product_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing ScrapReason.ScrapReasonID.', 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'CONSTRAINT', N'FK_WorkOrder_ScrapReason_ScrapReasonID'
GO


































