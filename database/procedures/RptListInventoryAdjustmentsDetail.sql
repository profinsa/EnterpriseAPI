CREATE PROCEDURE RptListInventoryAdjustmentsDetail (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   AdjustmentID,
	AdjustmentLineID,
	ItemID,
	WarehouseID,
	AdjustmentDescription,
	OriginalQuantity,
	AdjustedQuantity
	
	
	
	
	
   FROM InventoryAdjustmentsDetail
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END