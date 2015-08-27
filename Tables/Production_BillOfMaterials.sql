CREATE TABLE [Production].[BillOfMaterials] (
  [BillOfMaterialsID] [int] IDENTITY,
  [ProductAssemblyID] [int] NULL,
  [ComponentID] [int] NOT NULL,
  [StartDate] [datetime] NOT NULL CONSTRAINT [DF_BillOfMaterials_StartDate] DEFAULT (getdate()),
  [EndDate] [datetime] NULL,
  [UnitMeasureCode] [nchar](3) NOT NULL,
  [BOMLevel] [smallint] NOT NULL,
  [PerAssemblyQty] [decimal](8, 2) NOT NULL CONSTRAINT [DF_BillOfMaterials_PerAssemblyQty] DEFAULT (1.00),
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_BillOfMaterials_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_BillOfMaterials_BillOfMaterialsID] PRIMARY KEY NONCLUSTERED ([BillOfMaterialsID]),
  CONSTRAINT [CK_BillOfMaterials_BOMLevel] CHECK ([ProductAssemblyID] IS NULL AND [BOMLevel]=(0) AND [PerAssemblyQty]=(1.00) OR [ProductAssemblyID] IS NOT NULL AND [BOMLevel]>=(1)),
  CONSTRAINT [CK_BillOfMaterials_EndDate] CHECK ([EndDate]>[StartDate] OR [EndDate] IS NULL),
  CONSTRAINT [CK_BillOfMaterials_PerAssemblyQty] CHECK ([PerAssemblyQty]>=(1.00)),
  CONSTRAINT [CK_BillOfMaterials_ProductAssemblyID] CHECK ([ProductAssemblyID]<>[ComponentID]),
  CONSTRAINT [FK_BillOfMaterials_Product_ComponentID] FOREIGN KEY ([componentid]) REFERENCES [Production].[Product] ([productid]),
  CONSTRAINT [FK_BillOfMaterials_Product_ProductAssemblyID] FOREIGN KEY ([productassemblyid]) REFERENCES [Production].[Product] ([productid]),
  CONSTRAINT [FK_BillOfMaterials_UnitMeasure_UnitMeasureCode] FOREIGN KEY ([unitmeasurecode]) REFERENCES [Production].[UnitMeasure] ([unitmeasurecode])
)
ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [AK_BillOfMaterials_ProductAssemblyID_ComponentID_StartDate]
  ON [Production].[BillOfMaterials] ([ProductAssemblyID], [ComponentID], [StartDate])
  ON [PRIMARY]
GO

CREATE INDEX [IX_BillOfMaterials_UnitMeasureCode]
  ON [Production].[BillOfMaterials] ([UnitMeasureCode])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Items required to make bicycles and bicycle subassemblies. It identifies the heirarchical relationship between a parent product and its components.', 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index.', 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'INDEX', N'AK_BillOfMaterials_ProductAssemblyID_ComponentID_StartDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'INDEX', N'IX_BillOfMaterials_UnitMeasureCode'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index created by a primary key constraint.', 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'INDEX', N'PK_BillOfMaterials_BillOfMaterialsID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'CONSTRAINT', N'PK_BillOfMaterials_BillOfMaterialsID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [ProductAssemblyID] IS NULL AND [BOMLevel] = (0) AND [PerAssemblyQty] = (1) OR [ProductAssemblyID] IS NOT NULL AND [BOMLevel] >= (1)', 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'CONSTRAINT', N'CK_BillOfMaterials_BOMLevel'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint EndDate] > [StartDate] OR [EndDate] IS NULL', 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'CONSTRAINT', N'CK_BillOfMaterials_EndDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [PerAssemblyQty] >= (1.00)', 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'CONSTRAINT', N'CK_BillOfMaterials_PerAssemblyQty'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Check constraint [ProductAssemblyID] <> [ComponentID]', 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'CONSTRAINT', N'CK_BillOfMaterials_ProductAssemblyID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'CONSTRAINT', N'DF_BillOfMaterials_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of 1.0', 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'CONSTRAINT', N'DF_BillOfMaterials_PerAssemblyQty'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'CONSTRAINT', N'DF_BillOfMaterials_StartDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Product.ComponentID.', 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'CONSTRAINT', N'FK_BillOfMaterials_Product_ComponentID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Product.ProductAssemblyID.', 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'CONSTRAINT', N'FK_BillOfMaterials_Product_ProductAssemblyID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing UnitMeasure.UnitMeasureCode.', 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'CONSTRAINT', N'FK_BillOfMaterials_UnitMeasure_UnitMeasureCode'
GO