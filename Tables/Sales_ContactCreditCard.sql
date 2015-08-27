CREATE TABLE [Sales].[ContactCreditCard] (
  [ContactID] [int] NOT NULL,
  [CreditCardID] [int] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ContactCreditCard_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_ContactCreditCard_ContactID_CreditCardID] PRIMARY KEY CLUSTERED ([ContactID], [CreditCardID]),
  CONSTRAINT [FK_ContactCreditCard_Contact_ContactID] FOREIGN KEY ([contactid]) REFERENCES [Person].[Contact] ([contactid]),
  CONSTRAINT [FK_ContactCreditCard_CreditCard_CreditCardID] FOREIGN KEY ([creditcardid]) REFERENCES [Sales].[CreditCard] ([creditcardid])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping customers in the Contact table to their credit card information in the CreditCard table. ', 'SCHEMA', N'Sales', 'TABLE', N'ContactCreditCard'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'ContactCreditCard', 'INDEX', N'PK_ContactCreditCard_ContactID_CreditCardID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'ContactCreditCard', 'CONSTRAINT', N'PK_ContactCreditCard_ContactID_CreditCardID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'ContactCreditCard', 'CONSTRAINT', N'DF_ContactCreditCard_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Contact.ContactID.', 'SCHEMA', N'Sales', 'TABLE', N'ContactCreditCard', 'CONSTRAINT', N'FK_ContactCreditCard_Contact_ContactID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing CreditCard.CreditCardID.', 'SCHEMA', N'Sales', 'TABLE', N'ContactCreditCard', 'CONSTRAINT', N'FK_ContactCreditCard_CreditCard_CreditCardID'
GO