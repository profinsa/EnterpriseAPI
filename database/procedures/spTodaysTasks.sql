CREATE PROCEDURE spTodaysTasks (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36), 
 v_EmployeeID NATIONAL VARCHAR(36)) BEGIN






   SELECT
   DueDate,
	TaskTypeID as Task
   FROM PayrollEmployeesTaskHeader
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID and EmployeeID = v_EmployeeID
   and DueDate <= CURRENT_TIMESTAMP
   and	IFNULL(Completed,0) = 0
   and LOWER(EmployeeTaskID) <> 'default';
END