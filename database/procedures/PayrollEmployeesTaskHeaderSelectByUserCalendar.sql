CREATE PROCEDURE PayrollEmployeesTaskHeaderSelectByUserCalendar (v_CompanyID NATIONAL VARCHAR(36), v_DivisionID NATIONAL VARCHAR(36), v_DepartmentID NATIONAL VARCHAR(36), v_EmployeeID NATIONAL VARCHAR(36), v_StartDate DATETIME, v_EndDate DATETIME) begin
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
	LockTS,
	0 AS SourceType
   FROM
   PayrollEmployeesTaskHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND EmployeeID = v_EmployeeID
   AND StartDate BETWEEN v_StartDate AND v_EndDate
   UNION
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
	LockTS,
	1 AS SourceType
   FROM
   PayrollEmployeesTaskHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_EmployeeID
   AND StartDate BETWEEN v_StartDate AND v_EndDate;
end