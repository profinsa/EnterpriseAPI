CREATE PROCEDURE RptListInventoryByWarehouse (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN










 

   SELECT
	
	
	
   ItemID,
	WarehouseID,
	WarehouseBinID,
	QtyOnHand,
	QtyCommitted,
	QtyOnOrder,
	QtyOnBackorder
   FROM InventoryByWarehouse
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID and
   QtyOnHand <> 0;
END