CREATE PROCEDURE PayrollEmployeesTaskHeaderSelectByUser (v_CompanyID NATIONAL VARCHAR(36), v_DivisionID NATIONAL VARCHAR(36), v_DepartmentID NATIONAL VARCHAR(36), v_EmployeeID NATIONAL VARCHAR(36)) begin
   SELECT
   EmployeeID,
	EmployeeTaskID,
	TaskTypeID,
	StartDate,
	DueDate,
	IFNULL(Completed,0) as Completed,
	CompletedDate,
	PriorityID,
	RelatedDocumentType,
	RelatedDocumentNumber,
	LeadID,
	CustomerID,
	VendorID,
	Description,
	DelegatedTo,
	DelegatedDate,
	LockedBy,
	LockTS
   FROM
   PayrollEmployeesTaskHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND EmployeeID = v_EmployeeID;
end