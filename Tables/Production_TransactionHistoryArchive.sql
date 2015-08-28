CREATE TABLE [Production].[TransactionHistoryArchive] (
  [ActualCost] [money] NOT NULL,
  [added] [int] NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TransactionHistoryArchive_ModifiedDate] DEFAULT (getdate()),
  [ProductID] [int] NOT NULL,
  [Quantity] [int] NOT NULL,
  [ReferenceOrderID] [int] NOT NULL,
  [ReferenceOrderLineID] [int] NOT NULL CONSTRAINT [DF_TransactionHistoryArchive_ReferenceOrderLineID] DEFAULT (0),
  [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_TransactionHistoryArchive_TransactionDate] DEFAULT (getdate()),
  [TransactionID] [int] NOT NULL,
  [TransactionType] [nchar](1) NOT NULL,
  CONSTRAINT [PK_TransactionHistoryArchive_TransactionID] PRIMARY KEY CLUSTERED ([TransactionID]),
  CONSTRAINT [CK_TransactionHistoryArchive_TransactionType] CHECK (upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W')
)
ON [PRIMARY]
GO

CREATE INDEX [IX_TransactionHistoryArchive_ProductID]
  ON [Production].[TransactionHistoryArchive] ([ProductID])
  ON [PRIMARY]
GO

CREATE INDEX [IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID]
  ON [Production].[TransactionHistoryArchive] ([ReferenceOrderID], [ReferenceOrderLineID])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Transactions for previous years.', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'INDEX', N'IX_TransactionHistoryArchive_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'INDEX', N'IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'INDEX', N'PK_TransactionHistoryArchive_TransactionID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'CONSTRAINT', N'PK_TransactionHistoryArchive_TransactionID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [TransactionType]=''p'' OR [TransactionType]=''s'' OR [TransactionType]=''w'' OR [TransactionType]=''P'' OR [TransactionType]=''S'' OR [TransactionType]=''W''', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'CONSTRAINT', N'CK_TransactionHistoryArchive_TransactionType'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'CONSTRAINT', N'DF_TransactionHistoryArchive_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'CONSTRAINT', N'DF_TransactionHistoryArchive_ReferenceOrderLineID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'CONSTRAINT', N'DF_TransactionHistoryArchive_TransactionDate'
GO






















