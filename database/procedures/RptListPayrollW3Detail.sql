CREATE PROCEDURE RptListPayrollW3Detail (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   ControlNumber,
	TotalNoStatements,
	EstablishmentNo,
	EmployerIdentifyicationNumber,
	OtherEmployerIdentifyicationNumber
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
   FROM PayrollW3Detail
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END