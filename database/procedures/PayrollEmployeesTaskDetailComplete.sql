CREATE PROCEDURE PayrollEmployeesTaskDetailComplete (v_CompanyID NATIONAL VARCHAR(36),
v_DivisionID NATIONAL VARCHAR(36),
v_DepartmentID NATIONAL VARCHAR(36),
v_EmployeeID NATIONAL VARCHAR(36),
v_EmployeeTaskID NATIONAL VARCHAR(36),
v_EmployeeTaskDetailID NATIONAL VARCHAR(36)) begin
   UPDATE
   PayrollEmployeesTaskDetail
   SET
   TaskDetailComplete = 1,TaskDetailCompleteDate = CURRENT_TIMESTAMP
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND EmployeeID = v_EmployeeID
   AND EmployeeTaskID = v_EmployeeTaskID
   AND EmployeeTaskDetailID = v_EmployeeTaskDetailID;
end