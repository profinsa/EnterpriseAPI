CREATE PROCEDURE RptListCustomerShipForLocations (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   CustomerID,
	ShipToID,
	ShipForID,
	ShipForName,
	ShipForAddress1, 
	
	
	ShipForCity,
	ShipForState,
	ShipForZip
	
	
	
	
   FROM CustomerShipForLocations
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END