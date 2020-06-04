CREATE PROCEDURE InventoryByWarehouse_Update (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_WareHouseID NATIONAL VARCHAR(36),
	v_WareHouseBinID NATIONAL VARCHAR(36),
	v_QtyOnHand INT,
	v_QtyCommitted INT,
	v_QtyOnOrder INT) BEGIN
   UPDATE
   InventoryByWarehouse
   SET
   QtyOnHand = v_QtyOnHand,QtyCommitted = v_QtyCommitted,QtyOnOrder = v_QtyOnOrder
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ItemID = v_ItemID
   AND WarehouseID = v_WareHouseID;
END