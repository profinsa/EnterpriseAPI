CREATE PROCEDURE InventoryByWarehouseAlternate (v_CompanyID NATIONAL VARCHAR(50),
	v_DivisionID NATIONAL VARCHAR(50),
	v_DepartmentID NATIONAL VARCHAR(50),
	v_ItemID NATIONAL VARCHAR(50)) BEGIN
   SELECT
   CompanyID,
			DivisionID,
			DepartmentID,
			ItemID,
			WarehouseID,
			WarehouseBinID,
			QtyOnHand,
			QtyCommitted,
			QtyOnOrder,
			QtyOnBackorder
   FROM
   InventoryByWarehouse
   WHERE
   CompanyID = v_CompanyID
   AND
   DivisionID = v_DivisionID
   AND
   DepartmentID = v_DepartmentID
   AND
   ItemID = v_ItemID;
END