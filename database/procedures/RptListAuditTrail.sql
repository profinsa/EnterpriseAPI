CREATE PROCEDURE RptListAuditTrail (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   EmployeeID,
	AuditID,
	EntryDate,
	EntryTime,
	DocumentType,
	TransactionNumber,
	TableAffected,
	FieldChanged,
	OldValue,
	NewValue
   FROM AuditTrail
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END