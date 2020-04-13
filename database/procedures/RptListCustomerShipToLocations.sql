CREATE PROCEDURE RptListCustomerShipToLocations (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   CustomerID,
	ShipToID,
	ShipToName,
	ShipToAddress1, 
	
	
	ShipToCity,
	ShipToState,
	ShipToZip
	
	
	
	
   FROM CustomerShipToLocations
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END