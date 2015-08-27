CREATE TABLE [Sales].[SalesOrderHeader] (
  [SalesOrderID] [int] IDENTITY NOT FOR REPLICATION,
  [RevisionNumber] [tinyint] NOT NULL CONSTRAINT [DF_SalesOrderHeader_RevisionNumber] DEFAULT (0),
  [OrderDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderHeader_OrderDate] DEFAULT (getdate()),
  [DueDate] [datetime] NOT NULL,
  [ShipDate] [datetime] NULL,
  [Status] [tinyint] NOT NULL CONSTRAINT [DF_SalesOrderHeader_Status] DEFAULT (1),
  [OnlineOrderFlag] [dbo].[Flag] NOT NULL CONSTRAINT [DF_SalesOrderHeader_OnlineOrderFlag] DEFAULT (1),
  [SalesOrderNumber] AS (isnull(N'SO'+CONVERT([nvarchar](23),[SalesOrderID],0),N'*** ERROR ***')),
  [PurchaseOrderNumber] [dbo].[OrderNumber] NULL,
  [AccountNumber] [dbo].[AccountNumber] NULL,
  [CustomerID] [int] NOT NULL,
  [ContactID] [int] NOT NULL,
  [SalesPersonID] [int] NULL,
  [TerritoryID] [int] NULL,
  [BillToAddressID] [int] NOT NULL,
  [ShipToAddressID] [int] NOT NULL,
  [ShipMethodID] [int] NOT NULL,
  [CreditCardID] [int] NULL,
  [CreditCardApprovalCode] [varchar](15) NULL,
  [CurrencyRateID] [int] NULL,
  [SubTotal] [money] NOT NULL CONSTRAINT [DF_SalesOrderHeader_SubTotal] DEFAULT (0.00),
  [TaxAmt] [money] NOT NULL CONSTRAINT [DF_SalesOrderHeader_TaxAmt] DEFAULT (0.00),
  [Freight] [money] NOT NULL CONSTRAINT [DF_SalesOrderHeader_Freight] DEFAULT (0.00),
  [TotalDue] AS (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))),
  [Comment] [nvarchar](128) NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesOrderHeader_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderHeader_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_SalesOrderHeader_SalesOrderID] PRIMARY KEY CLUSTERED ([SalesOrderID]),
  CONSTRAINT [CK_SalesOrderHeader_DueDate] CHECK ([DueDate]>=[OrderDate]),
  CONSTRAINT [CK_SalesOrderHeader_Freight] CHECK ([Freight]>=(0.00)),
  CONSTRAINT [CK_SalesOrderHeader_ShipDate] CHECK ([ShipDate]>=[OrderDate] OR [ShipDate] IS NULL),
  CONSTRAINT [CK_SalesOrderHeader_Status] CHECK ([Status]>=(0) AND [Status]<=(8)),
  CONSTRAINT [CK_SalesOrderHeader_SubTotal] CHECK ([SubTotal]>=(0.00)),
  CONSTRAINT [CK_SalesOrderHeader_TaxAmt] CHECK ([TaxAmt]>=(0.00)),
  CONSTRAINT [FK_SalesOrderHeader_Address_BillToAddressID] FOREIGN KEY ([billtoaddressid]) REFERENCES [Person].[Address] ([addressid]),
  CONSTRAINT [FK_SalesOrderHeader_Address_ShipToAddressID] FOREIGN KEY ([shiptoaddressid]) REFERENCES [Person].[Address] ([addressid]),
  CONSTRAINT [FK_SalesOrderHeader_Contact_ContactID] FOREIGN KEY ([contactid]) REFERENCES [Person].[Contact] ([contactid]),
  CONSTRAINT [FK_SalesOrderHeader_CreditCard_CreditCardID] FOREIGN KEY ([creditcardid]) REFERENCES [Sales].[CreditCard] ([creditcardid]),
  CONSTRAINT [FK_SalesOrderHeader_CurrencyRate_CurrencyRateID] FOREIGN KEY ([currencyrateid]) REFERENCES [Sales].[CurrencyRate] ([currencyrateid]),
  CONSTRAINT [FK_SalesOrderHeader_Customer_CustomerID] FOREIGN KEY ([customerid]) REFERENCES [Sales].[Customer] ([customerid]),
  CONSTRAINT [FK_SalesOrderHeader_SalesPerson_SalesPersonID] FOREIGN KEY ([salespersonid]) REFERENCES [Sales].[SalesPerson] ([salespersonid]),
  CONSTRAINT [FK_SalesOrderHeader_SalesTerritory_TerritoryID] FOREIGN KEY ([territoryid]) REFERENCES [Sales].[SalesTerritory] ([territoryid]),
  CONSTRAINT [FK_SalesOrderHeader_ShipMethod_ShipMethodID] FOREIGN KEY ([shipmethodid]) REFERENCES [Purchasing].[ShipMethod] ([shipmethodid])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_SalesOrderHeader_rowguid]
  ON [Sales].[SalesOrderHeader] ([rowguid])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_SalesOrderHeader_SalesOrderNumber]
  ON [Sales].[SalesOrderHeader] ([SalesOrderNumber])
  ON [PRIMARY]
GO

CREATE INDEX [IX_SalesOrderHeader_CustomerID]
  ON [Sales].[SalesOrderHeader] ([CustomerID])
  ON [PRIMARY]
GO

CREATE INDEX [IX_SalesOrderHeader_SalesPersonID]
  ON [Sales].[SalesOrderHeader] ([SalesPersonID])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE TRIGGER [uSalesOrderHeader] ON [Sales].[SalesOrderHeader] 
AFTER UPDATE NOT FOR REPLICATION AS 
BEGIN
DECLARE @Count int;
SET @Count = @@ROWCOUNT;
IF @Count = 0 
RETURN;
SET NOCOUNT ON;
BEGIN TRY
IF NOT UPDATE([Status])
BEGIN
UPDATE [Sales].[SalesOrderHeader]
SET [Sales].[SalesOrderHeader].[RevisionNumber] = 
[Sales].[SalesOrderHeader].[RevisionNumber] + 1
WHERE [Sales].[SalesOrderHeader].[SalesOrderID] IN 
(SELECT inserted.[SalesOrderID] FROM inserted);
END;
IF UPDATE([SubTotal])
BEGIN
DECLARE @StartDate datetime,
@EndDate datetime
SET @StartDate = [dbo].[ufnGetAccountingStartDate]();
SET @EndDate = [dbo].[ufnGetAccountingEndDate]();
UPDATE [Sales].[SalesPerson]
SET [Sales].[SalesPerson].[SalesYTD] = 
(SELECT SUM([Sales].[SalesOrderHeader].[SubTotal])
FROM [Sales].[SalesOrderHeader] 
WHERE [Sales].[SalesPerson].[SalesPersonID] = [Sales].[SalesOrderHeader].[SalesPersonID]
AND ([Sales].[SalesOrderHeader].[Status] = 5) -- Shipped
AND [Sales].[SalesOrderHeader].[OrderDate] BETWEEN @StartDate AND @EndDate)
WHERE [Sales].[SalesPerson].[SalesPersonID] 
IN (SELECT DISTINCT inserted.[SalesPersonID] FROM inserted 
WHERE inserted.[OrderDate] BETWEEN @StartDate AND @EndDate);
UPDATE [Sales].[SalesTerritory]
SET [Sales].[SalesTerritory].[SalesYTD] = 
(SELECT SUM([Sales].[SalesOrderHeader].[SubTotal])
FROM [Sales].[SalesOrderHeader] 
WHERE [Sales].[SalesTerritory].[TerritoryID] = [Sales].[SalesOrderHeader].[TerritoryID]
AND ([Sales].[SalesOrderHeader].[Status] = 5) -- Shipped
AND [Sales].[SalesOrderHeader].[OrderDate] BETWEEN @StartDate AND @EndDate)
WHERE [Sales].[SalesTerritory].[TerritoryID] 
IN (SELECT DISTINCT inserted.[TerritoryID] FROM inserted 
WHERE inserted.[OrderDate] BETWEEN @StartDate AND @EndDate);
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

EXEC sys.sp_addextendedproperty N'MS_Description', N'AFTER UPDATE trigger that updates the RevisionNumber and ModifiedDate columns in the SalesOrderHeader table.Updates the SalesYTD column in the SalesPerson and SalesTerritory tables.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'TRIGGER', N'uSalesOrderHeader'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'General sales order information.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'INDEX', N'AK_SalesOrderHeader_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'INDEX', N'AK_SalesOrderHeader_SalesOrderNumber'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'INDEX', N'IX_SalesOrderHeader_CustomerID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'INDEX', N'IX_SalesOrderHeader_SalesPersonID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'INDEX', N'PK_SalesOrderHeader_SalesOrderID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'PK_SalesOrderHeader_SalesOrderID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [DueDate] >= [OrderDate]', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'CK_SalesOrderHeader_DueDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [Freight] >= (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'CK_SalesOrderHeader_Freight'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [ShipDate] >= [OrderDate] OR [ShipDate] IS NULL', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'CK_SalesOrderHeader_ShipDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [Status] BETWEEN (0) AND (8)', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'CK_SalesOrderHeader_Status'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [SubTotal] >= (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'CK_SalesOrderHeader_SubTotal'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [TaxAmt] >= (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'CK_SalesOrderHeader_TaxAmt'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'DF_SalesOrderHeader_Freight'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'DF_SalesOrderHeader_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 1 (TRUE)', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'DF_SalesOrderHeader_OnlineOrderFlag'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'DF_SalesOrderHeader_OrderDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'DF_SalesOrderHeader_RevisionNumber'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'DF_SalesOrderHeader_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 1', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'DF_SalesOrderHeader_Status'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'DF_SalesOrderHeader_SubTotal'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'DF_SalesOrderHeader_TaxAmt'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Address.AddressID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'FK_SalesOrderHeader_Address_BillToAddressID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Address.AddressID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'FK_SalesOrderHeader_Address_ShipToAddressID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Contact.ContactID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'FK_SalesOrderHeader_Contact_ContactID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing CreditCard.CreditCardID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'FK_SalesOrderHeader_CreditCard_CreditCardID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing CurrencyRate.CurrencyRateID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'FK_SalesOrderHeader_CurrencyRate_CurrencyRateID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Customer.CustomerID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'FK_SalesOrderHeader_Customer_CustomerID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SalesPerson.SalesPersonID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'FK_SalesOrderHeader_SalesPerson_SalesPersonID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SalesTerritory.TerritoryID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'FK_SalesOrderHeader_SalesTerritory_TerritoryID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing ShipMethod.ShipMethodID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'CONSTRAINT', N'FK_SalesOrderHeader_ShipMethod_ShipMethodID'
GO