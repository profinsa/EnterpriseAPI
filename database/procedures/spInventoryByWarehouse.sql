CREATE PROCEDURE spInventoryByWarehouse (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN











   SELECT
   ItemID as Item,
	WarehouseID as WH,
	WarehouseBinID as Bin,
	QtyOnHand as Qty
   FROM
   InventoryByWarehouse
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID
   ORDER BY WH ASC,Bin ASC;

   SET SWP_Ret_Value = 0;
END