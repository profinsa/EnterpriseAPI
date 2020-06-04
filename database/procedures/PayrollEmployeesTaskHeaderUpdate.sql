CREATE PROCEDURE PayrollEmployeesTaskHeaderUpdate (v_CompanyID NATIONAL VARCHAR(36), v_DivisionID NATIONAL VARCHAR(36), v_DepartmentID NATIONAL VARCHAR(36), v_EmployeeID NATIONAL VARCHAR(36), v_EmployeeTaskID NATIONAL VARCHAR(36), v_TaskTypeID NATIONAL VARCHAR(36), v_StartDate DATETIME, v_DueDate DATETIME, v_Completed BOOLEAN, v_CompletedDate DATETIME, v_PriorityID NATIONAL VARCHAR(36), v_RelatedDocumentType NATIONAL VARCHAR(36), v_RelatedDocumentNumber NATIONAL VARCHAR(36), v_LeadID NATIONAL VARCHAR(36), v_CustomerID NATIONAL VARCHAR(36), v_VendorID NATIONAL VARCHAR(36), v_Description NATIONAL VARCHAR(200), v_DelegatedTo NATIONAL VARCHAR(36),
v_DelegatedDate DATETIME, v_LockedBy NATIONAL VARCHAR(36), v_LockTS DATETIME) begin
   UPDATE
   PayrollEmployeesTaskHeader
   SET
   TaskTypeID = v_TaskTypeID,StartDate = v_StartDate,DueDate = v_DueDate,Completed = v_Completed,
   CompletedDate = v_CompletedDate,PriorityID = v_PriorityID,
   RelatedDocumentType = v_RelatedDocumentType,RelatedDocumentNumber = v_RelatedDocumentNumber,
   LeadID = v_LeadID,CustomerID = v_CustomerID,VendorID = v_VendorID,
   Description = v_Description,DelegatedTo = v_DelegatedTo,DelegatedDate = v_DelegatedDate,
   LockedBy = v_LockedBy,LockTS = v_LockTS
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND EmployeeID = v_EmployeeID
   AND EmployeeTaskID = v_EmployeeTaskID;
end