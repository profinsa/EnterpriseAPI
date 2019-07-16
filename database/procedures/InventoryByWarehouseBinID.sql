CREATE PROCEDURE InventoryByWarehouseBinID (v_CompanyID NATIONAL VARCHAR(50),
	v_DivisionID NATIONAL VARCHAR(50),
	v_DepartmentID NATIONAL VARCHAR(50),
	v_WarehouseID NATIONAL VARCHAR(50)) BEGIN
   SELECT
   WarehouseBinID
   FROM
   WarehouseBins
   WHERE
   CompanyID = v_CompanyID
   AND
   DivisionID = v_DivisionID
   AND
   DepartmentID = v_DepartmentID
   AND
   WarehouseID = v_WarehouseID;
END