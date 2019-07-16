CREATE PROCEDURE PayrollEmployeesTaskDetailSelectByTask (v_CompanyID NATIONAL VARCHAR(36), v_DivisionID NATIONAL VARCHAR(36), v_DepartmentID NATIONAL VARCHAR(36), v_EmployeeID NATIONAL VARCHAR(36), v_EmployeeTaskID NATIONAL VARCHAR(36)) begin
   SELECT
   EmployeeTaskID,
	EmployeeTaskDetailID,
	TaskDetailRelatedDocumentType,
	TaskDetailRelatedDocumentNumber,
	TaskDetailDescription,
	TaskDetailDate,
IFNULL(TaskDetailComplete,0) as TaskDetailComplete,
	TaskDetailCompleteDate,
	LockedBy,
	LockTS
   FROM
   PayrollEmployeesTaskDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND EmployeeID = v_EmployeeID
   AND EmployeeTaskID = v_EmployeeTaskID;
end