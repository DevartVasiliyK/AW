CREATE TABLE [Sales].[SalesOrderHeaderSalesReason] (
  [added] [int] NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderHeaderSalesReason_ModifiedDate] DEFAULT (getdate()),
  [SalesOrderID] [int] NOT NULL,
  [SalesReasonID] [int] NOT NULL,
  CONSTRAINT [PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID] PRIMARY KEY CLUSTERED ([SalesOrderID], [SalesReasonID]),
  CONSTRAINT [FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID] FOREIGN KEY ([salesorderid]) REFERENCES [Sales].[SalesOrderHeader] ([salesorderid]) ON DELETE CASCADE,
  CONSTRAINT [FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID] FOREIGN KEY ([salesreasonid]) REFERENCES [Sales].[SalesReason] ([salesreasonid])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Cross-reference table mapping sales orders to sales reason codes.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeaderSalesReason'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeaderSalesReason', 'INDEX', N'PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeaderSalesReason', 'CONSTRAINT', N'PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeaderSalesReason', 'CONSTRAINT', N'DF_SalesOrderHeaderSalesReason_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SalesOrderHeader.SalesOrderID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeaderSalesReason', 'CONSTRAINT', N'FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SalesReason.SalesReasonID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeaderSalesReason', 'CONSTRAINT', N'FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID'
GO












