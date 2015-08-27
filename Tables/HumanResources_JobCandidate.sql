CREATE TABLE [HumanResources].[JobCandidate] (
  [JobCandidateID] [int] IDENTITY,
  [EmployeeID] [int] NULL,
  [Resume] [xml] (CONTENT HumanResources.HRResumeSchemaCollection) NULL,
  [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_JobCandidate_ModifiedDate] DEFAULT (getdate()),
  CONSTRAINT [PK_JobCandidate_JobCandidateID] PRIMARY KEY CLUSTERED ([JobCandidateID]),
  CONSTRAINT [FK_JobCandidate_Employee_EmployeeID] FOREIGN KEY ([employeeid]) REFERENCES [HumanResources].[Employee] ([employeeid])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

CREATE INDEX [IX_JobCandidate_EmployeeID]
  ON [HumanResources].[JobCandidate] ([EmployeeID])
  ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Résumés submitted to Human Resources by job applicants.', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'INDEX', N'IX_JobCandidate_EmployeeID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'INDEX', N'PK_JobCandidate_JobCandidateID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'CONSTRAINT', N'PK_JobCandidate_JobCandidateID'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'CONSTRAINT', N'DF_JobCandidate_ModifiedDate'
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Employee.EmployeeID.', 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'CONSTRAINT', N'FK_JobCandidate_Employee_EmployeeID'
GO