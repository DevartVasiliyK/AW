SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE VIEW [dbo].[view1] (name, number, type, low, high, status)
AS
 SELECT *
  FROM master.dbo.spt_values sv
GO