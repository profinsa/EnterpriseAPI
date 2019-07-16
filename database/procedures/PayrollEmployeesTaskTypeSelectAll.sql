CREATE PROCEDURE PayrollEmployeesTaskTypeSelectAll (v_CompanyID NATIONAL VARCHAR(36), v_DivisionID NATIONAL VARCHAR(36), v_DepartmentID NATIONAL VARCHAR(36)) begin
   SELECT
   TaskTypeID,
WorkFlowTypeID,
TaskTypeDescription,
TaskTypeRule,
TaskTypeManager,
LockedBy,
LockTS
   FROM
   PayrollEmployeesTaskType
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
end