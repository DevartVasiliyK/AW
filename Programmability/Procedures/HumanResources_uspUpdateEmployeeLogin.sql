SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [HumanResources].[uspUpdateEmployeeLogin]
@EmployeeID [int], 
@ManagerID [int],
@LoginID [nvarchar](256),
@Title [nvarchar](50),
@HireDate [datetime],
@CurrentFlag [dbo].[Flag]
WITH EXECUTE AS CALLER
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
UPDATE [HumanResources].[Employee] 
SET [ManagerID] = @ManagerID 
,[LoginID] = @LoginID 
,[Title] = @Title 
,[HireDate] = @HireDate 
,[CurrentFlag] = @CurrentFlag 
WHERE [EmployeeID] = @EmployeeID;
END TRY
BEGIN CATCH
EXECUTE [dbo].[uspLogError];
END CATCH;
END;
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Updates the Employee table with the values specified in the input parameters for the given EmployeeID.', 'SCHEMA', N'HumanResources', 'PROCEDURE', N'uspUpdateEmployeeLogin'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeLogin. Enter a valid EmployeeID from the Employee table.', 'SCHEMA', N'HumanResources', 'PROCEDURE', N'uspUpdateEmployeeLogin', 'PARAMETER', N'@EmployeeID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a valid ManagerID for the employee.', 'SCHEMA', N'HumanResources', 'PROCEDURE', N'uspUpdateEmployeeLogin', 'PARAMETER', N'@ManagerID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a valid login for the employee.', 'SCHEMA', N'HumanResources', 'PROCEDURE', N'uspUpdateEmployeeLogin', 'PARAMETER', N'@LoginID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a title for the employee.', 'SCHEMA', N'HumanResources', 'PROCEDURE', N'uspUpdateEmployeeLogin', 'PARAMETER', N'@Title'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a hire date for the employee.', 'SCHEMA', N'HumanResources', 'PROCEDURE', N'uspUpdateEmployeeLogin', 'PARAMETER', N'@HireDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter the current flag for the employee.', 'SCHEMA', N'HumanResources', 'PROCEDURE', N'uspUpdateEmployeeLogin', 'PARAMETER', N'@CurrentFlag'
GO