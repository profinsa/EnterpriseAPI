CREATE PROCEDURE RptListDivisions (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN






   SELECT
	
   DivisionID,
	DivisionName,
	DivisionDescription,
	DivisionAddress1,
	
	DivisionCity,
	DivisionState,
	DivisionZip, 
	
	
	
	
	
	DivisionNotes
   FROM Divisions
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID And DepartmentID = v_DepartmentID;
END