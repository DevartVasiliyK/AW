CREATE TABLE [Production].[WorkOrderRouting] (
  [ActualCost] [money] NULL,
  [ActualEndDate] [datetime] NULL,
  [ActualResourceHrs] [decimal](9, 4) NULL,
  [ActualStartDate] [datetime] NULL,
  [added] [int] NULL,
  [LocationID] [smallint] NOT NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_WorkOrderRouting_ModifiedDate] DEFAULT (getdate()),
  [OperationSequence] [smallint] NOT NULL,
  [PlannedCost] [money] NOT NULL,
  [ProductID] [int] NOT NULL,
  [ScheduledEndDate] [datetime] NOT NULL,
  [ScheduledStartDate] [datetime] NOT NULL,
  [WorkOrderID] [int] NOT NULL,
  CONSTRAINT [PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence] PRIMARY KEY CLUSTERED ([WorkOrderID], [ProductID], [OperationSequence]),
  CONSTRAINT [CK_WorkOrderRouting_ActualCost] CHECK ([ActualCost]>(0.00)),
  CONSTRAINT [CK_WorkOrderRouting_ActualEndDate] CHECK ([ActualEndDate]>=[ActualStartDate] OR [ActualEndDate] IS NULL OR [ActualStartDate] IS NULL),
  CONSTRAINT [CK_WorkOrderRouting_ActualResourceHrs] CHECK ([ActualResourceHrs]>=(0.0000)),
  CONSTRAINT [CK_WorkOrderRouting_PlannedCost] CHECK ([PlannedCost]>(0.00)),
  CONSTRAINT [CK_WorkOrderRouting_ScheduledEndDate] CHECK ([ScheduledEndDate]>=[ScheduledStartDate]),
  CONSTRAINT [FK_WorkOrderRouting_Location_LocationID] FOREIGN KEY ([locationid]) REFERENCES [Production].[Location] ([locationid]),
  CONSTRAINT [FK_WorkOrderRouting_WorkOrder_WorkOrderID] FOREIGN KEY ([workorderid]) REFERENCES [Production].[WorkOrder] ([workorderid])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_WorkOrderRouting_ProductID]
  ON [Production].[WorkOrderRouting] ([ProductID])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Work order details.', 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'INDEX', N'IX_WorkOrderRouting_ProductID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'INDEX', N'PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'CONSTRAINT', N'PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [ActualCost] > (0.00)', 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'CONSTRAINT', N'CK_WorkOrderRouting_ActualCost'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [ActualEndDate] >= [ActualStartDate] OR [ActualEndDate] IS NULL OR [ActualStartDate] IS NULL', 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'CONSTRAINT', N'CK_WorkOrderRouting_ActualEndDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [ActualResourceHrs] >= (0.0000)', 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'CONSTRAINT', N'CK_WorkOrderRouting_ActualResourceHrs'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [PlannedCost] > (0.00)', 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'CONSTRAINT', N'CK_WorkOrderRouting_PlannedCost'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [ScheduledEndDate] >= [ScheduledStartDate]', 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'CONSTRAINT', N'CK_WorkOrderRouting_ScheduledEndDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'CONSTRAINT', N'DF_WorkOrderRouting_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Location.LocationID.', 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'CONSTRAINT', N'FK_WorkOrderRouting_Location_LocationID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing WorkOrder.WorkOrderID.', 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'CONSTRAINT', N'FK_WorkOrderRouting_WorkOrder_WorkOrderID'
GO


























