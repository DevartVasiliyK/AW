CREATE TABLE [Purchasing].[Vendor] (
  [AccountNumber] [dbo].[AccountNumber] NOT NULL,
  [ActiveFlag] [dbo].[Flag] NOT NULL CONSTRAINT [DF_Vendor_ActiveFlag] DEFAULT (1),
  [added] [int] NULL,
  [CreditRating] [tinyint] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Vendor_ModifiedDate] DEFAULT (getdate()),
  [Name] [dbo].[Name] NOT NULL,
  [PreferredVendorStatus] [dbo].[Flag] NOT NULL CONSTRAINT [DF_Vendor_PreferredVendorStatus] DEFAULT (1),
  [PurchasingWebServiceURL] [nvarchar](1024) NULL,
  [VendorID] [int] IDENTITY,
  CONSTRAINT [PK_Vendor_VendorID] PRIMARY KEY CLUSTERED ([VendorID]),
  CONSTRAINT [CK_Vendor_CreditRating] CHECK ([CreditRating]>=(1) AND [CreditRating]<=(5))
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_Vendor_AccountNumber]
  ON [Purchasing].[Vendor] ([AccountNumber])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE TRIGGER [dVendor] ON [Purchasing].[Vendor] 
INSTEAD OF DELETE NOT FOR REPLICATION AS 
BEGIN
DECLARE @Count int;
SET @Count = @@ROWCOUNT;
IF @Count = 0 
RETURN;
SET NOCOUNT ON;
BEGIN TRY
DECLARE @DeleteCount int;
SELECT @DeleteCount = COUNT(*) FROM deleted;
IF @DeleteCount > 0 
BEGIN
RAISERROR
(N'Vendors cannot be deleted. They can only be marked as not active.', -- Message
10, -- Severity.
1); -- State.
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

EXEC sys.sp_addextendedproperty N'MS_Description', N'INSTEAD OF DELETE trigger which keeps Vendors from being deleted.', 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'TRIGGER', N'dVendor'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Companies from whom Adventure Works Cycles purchases parts or other goods.', 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'INDEX', N'AK_Vendor_AccountNumber'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'INDEX', N'PK_Vendor_VendorID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'CONSTRAINT', N'PK_Vendor_VendorID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [CreditRating] BETWEEN (1) AND (5)', 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'CONSTRAINT', N'CK_Vendor_CreditRating'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 1 (TRUE)', 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'CONSTRAINT', N'DF_Vendor_ActiveFlag'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'CONSTRAINT', N'DF_Vendor_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 1 (TRUE)', 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'CONSTRAINT', N'DF_Vendor_PreferredVendorStatus'
GO






















