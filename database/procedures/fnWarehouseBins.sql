CREATE PROCEDURE fnWarehouseBins (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36),
	v_Direction BOOLEAN) SWL_return:
BEGIN
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_Available FLOAT;
   DECLARE v_QtyBin FLOAT;
   DECLARE v_OverFlowBin NATIONAL VARCHAR(36);
   DECLARE v_Ident INT;
	
   DROP TEMPORARY TABLE IF EXISTS tt_fnWarehouseBinsRet;
   CREATE TEMPORARY TABLE IF NOT EXISTS tt_fnWarehouseBinsRet
   (
      WarehouseID NATIONAL VARCHAR(36),
      WarehouseBinID NATIONAL VARCHAR(36),
      MaximumQuantity FLOAT,
      QtyOnHand FLOAT
   );
   SET v_WarehouseID = WarehouseRoot2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_InventoryItemID);
   SET v_WarehouseBinID = WarehouseBinRoot2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
   v_InventoryItemID);
   DROP TEMPORARY TABLE IF EXISTS tt_Tbl;
   CREATE TEMPORARY TABLE tt_Tbl
   (
      Ident INT,
      WarehouseID NATIONAL VARCHAR(36),
      WarehouseBinID NATIONAL VARCHAR(36),
      MaximumQuantity FLOAT,
      QtyOnHand FLOAT
   );
   SET v_Ident = 1;
   WHILE NOT (v_WarehouseBinID IS NULL OR RTRIM(v_WarehouseBinID) = '' OR v_WarehouseBinID = 'Overflow') DO
			
      select   IFNULL(SUM(IFNULL(QtyOnHand,0)),0) INTO v_QtyBin FROM InventoryByWarehouse WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      WarehouseID = v_WarehouseID AND
      WarehouseBinID = v_WarehouseBinID AND
      ItemID = v_InventoryItemID;
      select   IFNULL(MaximumQuantity,0) -IFNULL(LockerStockQty,0), OverFlowBin INTO v_Available,v_OverFlowBin FROM WarehouseBins WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      WarehouseID = v_WarehouseID AND
      WarehouseBinID = v_WarehouseBinID;
      IF NOT EXISTS(SELECT * FROM WarehouseBins
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      WarehouseID = v_WarehouseID AND
      WarehouseBinID = v_OverFlowBin) then
				
         SET v_OverFlowBin = '';
      end if;
      INSERT INTO tt_Tbl(Ident,
				WarehouseID,
				WarehouseBinID,
				MaximumQuantity,
				QtyOnHand)
			VALUES(v_Ident,
				v_WarehouseID,
				v_WarehouseBinID,
				v_Available,
				v_QtyBin);
			
      SET v_WarehouseBinID = v_OverFlowBin;
      SET v_Ident = v_Ident+1;
   END WHILE;
   select   IFNULL(SUM(QtyOnHand),0) INTO v_QtyBin FROM InventoryByWarehouse WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   WarehouseID = v_WarehouseID AND
   WarehouseBinID = 'Overflow' AND
   ItemID = v_InventoryItemID;
   INSERT INTO tt_Tbl(Ident,
		WarehouseID,
		WarehouseBinID,
		MaximumQuantity,
		QtyOnHand)
	VALUES(v_Ident,
		v_WarehouseID,
		'Overflow',
		-1,
		v_QtyBin);
	
   IF v_Direction = 0 then
		
      INSERT INTO tt_fnWarehouseBinsRet
      SELECT
      WarehouseID,
				WarehouseBinID,
				MaximumQuantity,
				QtyOnHand
      FROM
      tt_Tbl
      ORDER BY Ident ASC;
   ELSE
      INSERT INTO tt_fnWarehouseBinsRet
      SELECT
      WarehouseID,
				WarehouseBinID,
				MaximumQuantity,
				QtyOnHand
      FROM
      tt_Tbl
      ORDER BY Ident DESC;
   end if;
   LEAVE SWL_return;
END