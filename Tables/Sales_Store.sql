CREATE TABLE [Sales].[Store] (
  [added] [int] NULL,
  [CustomerID] [int] NOT NULL,
  [Demographics] [xml] (CONTENT Sales.StoreSurveySchemaCollection) NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Store_ModifiedDate] DEFAULT (getdate()),
  [Name] [dbo].[Name] NOT NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Store_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [SalesPersonID] [int] NULL,
  CONSTRAINT [PK_Store_CustomerID] PRIMARY KEY CLUSTERED ([CustomerID]),
  CONSTRAINT [FK_Store_Customer_CustomerID] FOREIGN KEY ([customerid]) REFERENCES [Sales].[Customer] ([customerid]),
  CONSTRAINT [FK_Store_SalesPerson_SalesPersonID] FOREIGN KEY ([salespersonid]) REFERENCES [Sales].[SalesPerson] ([salespersonid])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PRIMARY XML INDEX [PXML_Store_Demographics]
  ON [Sales].[Store] ([Demographics])
GO

CREATE UNIQUE INDEX [AK_Store_rowguid]
  ON [Sales].[Store] ([rowguid])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Store_SalesPersonID]
  ON [Sales].[Store] ([SalesPersonID])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE TRIGGER [iStore] ON [Sales].[Store] 
AFTER INSERT AS 
BEGIN
DECLARE @Count int;
SET @Count = @@ROWCOUNT;
IF @Count = 0 
RETURN;
SET NOCOUNT ON;
BEGIN TRY
IF EXISTS (SELECT * FROM inserted INNER JOIN [Sales].[Individual] 
ON inserted.[CustomerID] = [Sales].[Individual].[CustomerID]) 
BEGIN
IF @@TRANCOUNT > 0
BEGIN
ROLLBACK TRANSACTION;
END
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

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary XML index.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'INDEX', N'PXML_Store_Demographics'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'AFTER INSERT trigger inserting Store only if the Customer does not exist in the Individual table.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'TRIGGER', N'iStore'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Customers (resellers) of Adventure Works products.', 'SCHEMA', N'Sales', 'TABLE', N'Store'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'INDEX', N'AK_Store_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'INDEX', N'IX_Store_SalesPersonID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'INDEX', N'PK_Store_CustomerID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'CONSTRAINT', N'PK_Store_CustomerID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'CONSTRAINT', N'DF_Store_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'CONSTRAINT', N'DF_Store_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Customer.CustomerID.', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'CONSTRAINT', N'FK_Store_Customer_CustomerID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SalesPerson.SalesPersonID', 'SCHEMA', N'Sales', 'TABLE', N'Store', 'CONSTRAINT', N'FK_Store_SalesPerson_SalesPersonID'
GO






























