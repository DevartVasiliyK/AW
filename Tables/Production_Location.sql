﻿CREATE TABLE [Production].[Location] (
  [added] [int] NULL,
  [Availability] [decimal](8, 2) NOT NULL CONSTRAINT [DF_Location_Availability] DEFAULT (0.00),
  [CostRate] [smallmoney] NOT NULL CONSTRAINT [DF_Location_CostRate] DEFAULT (0.00),
  [LocationID] [smallint] IDENTITY,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Location_ModifiedDate] DEFAULT (getdate()),
  [Name] [dbo].[Name] NOT NULL,
  CONSTRAINT [PK_Location_LocationID] PRIMARY KEY CLUSTERED ([LocationID]),
  CONSTRAINT [CK_Location_Availability] CHECK ([Availability]>=(0.00)),
  CONSTRAINT [CK_Location_CostRate] CHECK ([CostRate]>=(0.00))
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [AK_Location_Name]
  ON [Production].[Location] ([Name])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Product inventory and manufacturing locations.', 'SCHEMA', N'Production', 'TABLE', N'Location'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'Location', 'INDEX', N'AK_Location_Name'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'Location', 'INDEX', N'PK_Location_LocationID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'Location', 'CONSTRAINT', N'PK_Location_LocationID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [Availability] >= (0.00)', 'SCHEMA', N'Production', 'TABLE', N'Location', 'CONSTRAINT', N'CK_Location_Availability'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [CostRate] >= (0.00)', 'SCHEMA', N'Production', 'TABLE', N'Location', 'CONSTRAINT', N'CK_Location_CostRate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.00', 'SCHEMA', N'Production', 'TABLE', N'Location', 'CONSTRAINT', N'DF_Location_Availability'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'Production', 'TABLE', N'Location', 'CONSTRAINT', N'DF_Location_CostRate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'Location', 'CONSTRAINT', N'DF_Location_ModifiedDate'
GO




















