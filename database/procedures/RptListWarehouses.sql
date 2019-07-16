CREATE PROCEDURE RptListWarehouses (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   WarehouseID,
	WarehouseName,
	WarehouseAddress1, 
	
	
	WarehouseCity,
	WarehouseState,
	WarehouseZip,
	WarehousePhone
	
	
	
	
	
	
	
	
	
   FROM Warehouses
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END