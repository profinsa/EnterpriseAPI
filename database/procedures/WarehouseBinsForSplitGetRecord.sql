CREATE PROCEDURE WarehouseBinsForSplitGetRecord (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36),
	v_Qty FLOAT,
	Counter INT,
	
      	INOUT outIdent INT,
      	INOUT outWarehouseID NATIONAL VARCHAR(36),
      	INOUT outWarehouseBinID NATIONAL VARCHAR(36),
	INOUT outQty FLOAT,
	INOUT outAvlblQty FLOAT,
	INOUT outBackQty FLOAT
	) SWL_return:
BEGIN

   DECLARE v_Ident INT;
   DECLARE v_QtyOnHand FLOAT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cBins CURSOR
   FOR SELECT 
   WarehouseID, WarehouseBinID, QtyOnHand
   FROM 
   tt_fnWarehouseBinsRet;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN

      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;

   DROP TEMPORARY TABLE IF EXISTS tt_Ret;
   CREATE TEMPORARY TABLE IF NOT EXISTS tt_Ret
   (
      Ident INT,
      WarehouseID NATIONAL VARCHAR(36),
      WarehouseBinID NATIONAL VARCHAR(36),
      Qty FLOAT,
      AvlblQty FLOAT,
      BackQty FLOAT
   );
   CALL fnWarehouseBins(v_CompanyID, v_DivisionID, v_DepartmentID, v_WarehouseID, v_WarehouseBinID, v_InventoryItemID, 1);
   SET v_Ident = 1;

   OPEN cBins;
   SET NO_DATA = 0;
   FETCH cBins INTO v_WarehouseID,v_WarehouseBinID,v_QtyOnHand;
   WHILE NO_DATA = 0 DO
      IF v_Qty > 0 then
				
         IF v_Qty <= v_QtyOnHand then
						
            INSERT INTO tt_Ret(Ident,
								WarehouseID,
								WarehouseBinID,
								Qty,
								AvlblQty,
								BackQty)
							VALUES(v_Ident,
								v_WarehouseID,
								v_WarehouseBinID,
								v_Qty,
								v_Qty,
								0);
						
            SET v_Qty = 0;
         ELSE 
            IF v_QtyOnHand > 0 then
						
               INSERT INTO tt_Ret(Ident,
								WarehouseID,
								WarehouseBinID,
								Qty,
								AvlblQty,
								BackQty)
							VALUES(v_Ident,
								v_WarehouseID,
								v_WarehouseBinID,
								v_QtyOnHand,
								v_QtyOnHand,
								0);
						
               SET v_Qty = v_Qty -v_QtyOnHand;
            end if;
         end if;
      end if;
      SET v_Ident = v_Ident+1;
      SET NO_DATA = 0;
      FETCH cBins INTO v_WarehouseID,v_WarehouseBinID,v_QtyOnHand;
   END WHILE;
	
   CLOSE cBins;
	

   IF v_Qty > 0 then
		
      INSERT INTO tt_Ret(Ident,
				WarehouseID,
				WarehouseBinID,
				Qty,
				AvlblQty,
				BackQty)
			VALUES(v_Ident,
				v_WarehouseID,
				v_WarehouseBinID,
				v_Qty,
				0,
				v_Qty);
   end if;

   select * into outIdent, outWarehouseID, outWarehouseBinID, outQty, outAvlblQty, outBackQty from tt_Ret limit Counter, 1;
   LEAVE SWL_return;

END