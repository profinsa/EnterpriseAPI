CREATE PROCEDURE PayrollEmployeesTaskDetailUpdate (v_CompanyID NATIONAL VARCHAR(36),
v_DivisionID NATIONAL VARCHAR(36),
v_DepartmentID NATIONAL VARCHAR(36),
v_EmployeeID NATIONAL VARCHAR(36),
v_EmployeeTaskID NATIONAL VARCHAR(36),
v_EmployeeTaskDetailID NATIONAL VARCHAR(36),
v_TaskDetailDate DATETIME,
v_TaskDetailComplete BOOLEAN,
v_TaskDetailCompleteDate DATETIME,
v_TaskDetailRelatedDocumentType NATIONAL VARCHAR(36),
v_TaskDetailRelatedDocumentNumber NATIONAL VARCHAR(36),
v_TaskDetailDescription NATIONAL VARCHAR(200),
v_LockedBy NATIONAL VARCHAR(36),
v_LockTS DATETIME) begin
   UPDATE
   PayrollEmployeesTaskDetail
   SET
   TaskDetailRelatedDocumentType = v_TaskDetailRelatedDocumentType,TaskDetailRelatedDocumentNumber = v_TaskDetailRelatedDocumentNumber,
   TaskDetailDescription = v_TaskDetailDescription,
   TaskDetailDate = v_TaskDetailDate,TaskDetailComplete = v_TaskDetailComplete,
   TaskDetailCompleteDate = v_TaskDetailCompleteDate,
   LockedBy = v_LockedBy,LockTS = v_LockTS
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND EmployeeID = v_EmployeeID
   AND EmployeeTaskID = v_EmployeeTaskID
   AND EmployeeTaskDetailID = v_EmployeeTaskDetailID;
end