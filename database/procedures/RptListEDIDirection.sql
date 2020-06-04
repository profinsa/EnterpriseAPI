CREATE PROCEDURE RptListEDIDirection (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   DirectionTypeID,
	DirectionTypeDescription
   FROM EDIDirection
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END