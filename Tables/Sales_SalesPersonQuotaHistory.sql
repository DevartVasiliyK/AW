CREATE TABLE [Sales].[SalesPersonQuotaHistory] (
  [added] [int] NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesPersonQuotaHistory_ModifiedDate] DEFAULT (getdate()),
  [QuotaDate] [datetime] NOT NULL,
  [rowguid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesPersonQuotaHistory_rowguid] DEFAULT (newid()) ROWGUIDCOL,
  [SalesPersonID] [int] NOT NULL,
  [SalesQuota] [money] NOT NULL,
  CONSTRAINT [PK_SalesPersonQuotaHistory_SalesPersonID_QuotaDate] PRIMARY KEY CLUSTERED ([SalesPersonID], [QuotaDate]),
  CONSTRAINT [CK_SalesPersonQuotaHistory_SalesQuota] CHECK ([SalesQuota]>(0.00)),
  CONSTRAINT [FK_SalesPersonQuotaHistory_SalesPerson_SalesPersonID] FOREIGN KEY ([salespersonid]) REFERENCES [Sales].[SalesPerson] ([salespersonid])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_SalesPersonQuotaHistory_rowguid]
  ON [Sales].[SalesPersonQuotaHistory] ([rowguid])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Sales performance tracking.', 'SCHEMA', N'Sales', 'TABLE', N'SalesPersonQuotaHistory'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'Sales', 'TABLE', N'SalesPersonQuotaHistory', 'INDEX', N'AK_SalesPersonQuotaHistory_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'SalesPersonQuotaHistory', 'INDEX', N'PK_SalesPersonQuotaHistory_SalesPersonID_QuotaDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'SalesPersonQuotaHistory', 'CONSTRAINT', N'PK_SalesPersonQuotaHistory_SalesPersonID_QuotaDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [SalesQuota] > (0.00)', 'SCHEMA', N'Sales', 'TABLE', N'SalesPersonQuotaHistory', 'CONSTRAINT', N'CK_SalesPersonQuotaHistory_SalesQuota'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'SalesPersonQuotaHistory', 'CONSTRAINT', N'DF_SalesPersonQuotaHistory_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Sales', 'TABLE', N'SalesPersonQuotaHistory', 'CONSTRAINT', N'DF_SalesPersonQuotaHistory_rowguid'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SalesPerson.SalesPersonID.', 'SCHEMA', N'Sales', 'TABLE', N'SalesPersonQuotaHistory', 'CONSTRAINT', N'FK_SalesPersonQuotaHistory_SalesPerson_SalesPersonID'
GO


















