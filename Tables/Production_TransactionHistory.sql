CREATE TABLE [Production].[TransactionHistory] (
  [ActualCost] [money] NOT NULL,
  [added] [int] NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TransactionHistory_ModifiedDate] DEFAULT (getdate()),
  [ProductID] [int] NOT NULL,
  [Quantity] [int] NOT NULL,
  [ReferenceOrderID] [int] NOT NULL,
  [ReferenceOrderLineID] [int] NOT NULL CONSTRAINT [DF_TransactionHistory_ReferenceOrderLineID] DEFAULT (0),
  [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_TransactionHistory_TransactionDate] DEFAULT (getdate()),
  [TransactionID] [int] IDENTITY (100000, 1),
  [TransactionType] [nchar](1) NOT NULL,
  CONSTRAINT [PK_TransactionHistory_TransactionID] PRIMARY KEY CLUSTERED ([TransactionID]),
  CONSTRAINT [CK_TransactionHistory_TransactionType] CHECK (upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W'),
  CONSTRAINT [FK_TransactionHistory_Product_ProductID] FOREIGN KEY ([productid]) REFERENCES [Production].[Product] ([productid])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_TransactionHistory_ProductID]
  ON [Production].[TransactionHistory] ([ProductID])
  ON [PRIMARY]
GO

CREATE INDEX [IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID]
  ON [Production].[TransactionHistory] ([ReferenceOrderID], [ReferenceOrderLineID])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Record of each purchase order, sales order, or work order transaction year to date.', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'INDEX', N'IX_TransactionHistory_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'INDEX', N'IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'INDEX', N'PK_TransactionHistory_TransactionID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'CONSTRAINT', N'PK_TransactionHistory_TransactionID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [TransactionType]=''p'' OR [TransactionType]=''s'' OR [TransactionType]=''w'' OR [TransactionType]=''P'' OR [TransactionType]=''S'' OR [TransactionType]=''W'')', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'CONSTRAINT', N'CK_TransactionHistory_TransactionType'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'CONSTRAINT', N'DF_TransactionHistory_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'CONSTRAINT', N'DF_TransactionHistory_ReferenceOrderLineID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'CONSTRAINT', N'DF_TransactionHistory_TransactionDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'CONSTRAINT', N'FK_TransactionHistory_Product_ProductID'
GO
























