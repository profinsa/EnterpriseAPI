CREATE PROCEDURE PayrollEmployeesTaskPrioritySelectAll (v_CompanyID NATIONAL VARCHAR(36), v_DivisionID NATIONAL VARCHAR(36), v_DepartmentID NATIONAL VARCHAR(36)) begin
   SELECT
   PriorityID,
	PriorityDescription,
	LockedBy,
	LockTS
   FROM
   PayrollEmployeesTaskPriority
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
end