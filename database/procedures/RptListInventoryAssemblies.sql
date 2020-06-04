CREATE PROCEDURE RptListInventoryAssemblies (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN















   SELECT
	
	
	
   AssemblyID,
	ItemID,
	NumberOfItemsInAssembly, 
	
	
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,LaborCost,N'') AS LaborCost,
	WarehouseID
   FROM InventoryAssemblies
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END