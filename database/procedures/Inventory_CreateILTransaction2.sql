CREATE PROCEDURE Inventory_CreateILTransaction2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_TransDate DATETIME,
	v_ItemID NATIONAL VARCHAR(36),
	v_TransactionType NATIONAL VARCHAR(36),
	v_TransactionNumber NATIONAL VARCHAR(36),
	v_TransactionLineNumber DECIMAL,
	v_Quantity BIGINT,
	v_CostPerUnit DECIMAL(19,4),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN






   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_DefaultInventoryCostingMethod CHAR(1);
   DECLARE v_NewCostPerUnit DECIMAL(19,4);

   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_ErrorID INT;
   DECLARE v_PrevQuantity BIGINT;
   DECLARE v_CurQuantity BIGINT;
   DECLARE v_CalcQuantity BIGINT;
   DECLARE v_InsQuantity BIGINT;
   DECLARE v_CurCostPerUnit DECIMAL(19,4);
   DECLARE SWV_CurNum INT DEFAULT 0;
   DECLARE cInventoryLedger CURSOR FOR
   SELECT Quantity, CostPerUnit FROM InventoryLedger
   WHERE 
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID AND
   Quantity > 0
   ORDER BY  
   TransDate ASC;
   DECLARE cInventoryLedger2 CURSOR  FOR SELECT Quantity, CostPerUnit FROM InventoryLedger
   WHERE 
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID AND
   Quantity > 0
   ORDER BY  
   TransDate DESC;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   IF IFNULL(v_Quantity,0) = 0 OR IFNULL(v_CostPerUnit,0) = 0 then

      SET SWP_Ret_Value = 1;
      LEAVE SWL_return;
   end if;
   IF(IFNULL(v_ItemID,N'') = N'' OR IFNULL(v_TransactionType,N'') = N'' OR IFNULL(v_TransactionNumber,N'') = N'') then

      SET v_ErrorMessage = 'Invalid input parameters for Inventory_CreateILTransaction';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateILTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;



   select   IFNULL(DefaultInventoryCostingMethod,'F') INTO v_DefaultInventoryCostingMethod FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   START TRANSACTION;

   SET v_TransDate = IFNULL(v_TransDate,CURRENT_TIMESTAMP);

   IF v_Quantity > 0 then

      SET @SWV_Error = 0;
      INSERT INTO InventoryLedger(CompanyID,
		DivisionID,
		DepartmentID,
		TransDate,
		ItemID,
		TransactionType,
		TransNumber,
		ILLineNumber,
		Quantity,
		CostPerUnit,
		TotalCost)
	VALUES(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_TransDate,
		v_ItemID,
		v_TransactionType,
		v_TransactionNumber,
		v_TransactionLineNumber,
		v_Quantity,
		v_CostPerUnit,
		fnRound(v_CompanyID, v_DivisionID, v_DepartmentID, Abs(v_Quantity)*v_CostPerUnit, v_CompanyCurrencyID));
	
      IF @SWV_Error <> 0 then
	
	
         SET v_ErrorMessage = 'Insert in InventoryTransaction failed';
         ROLLBACK;


         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateILTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;

	
      SET @SWV_Error = 0;
      CALL Inventory_RecalcItemCost2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_Quantity,v_CostPerUnit,
      v_NewCostPerUnit, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
	
         SET v_ErrorMessage = 'Inventory_RecalcItemCost call failed';
         ROLLBACK;


         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateILTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;


   IF v_Quantity < 0 then

	
      select   SUM(-Quantity) INTO v_PrevQuantity FROM
      InventoryLedger WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      ItemID = v_ItemID AND
      Quantity < 0;
      SET v_PrevQuantity = IFNULL(v_PrevQuantity,0);
      SET v_CalcQuantity = -v_Quantity;
      IF v_DefaultInventoryCostingMethod = 'F' OR v_DefaultInventoryCostingMethod = 'L' then
		
         IF v_DefaultInventoryCostingMethod = 'F' then
				
					
            SET SWV_CurNum = 0;
         ELSE 
            IF v_DefaultInventoryCostingMethod = 'L' then
				
					
               SET SWV_CurNum = 1;
            end if;
         end if;
         IF SWV_CurNum = 0 THEN
            OPEN cInventoryLedger;
         ELSE
            OPEN cInventoryLedger2;
         END IF;
         SET NO_DATA = 0;
         IF SWV_CurNum = 0 THEN
            FETCH cInventoryLedger INTO v_CurQuantity,v_CurCostPerUnit;
         ELSE
            FETCH cInventoryLedger2 INTO v_CurQuantity,v_CurCostPerUnit;
         END IF;
         WHILE NO_DATA = 0 DO
            IF v_CalcQuantity > 0 then
				
               SET v_PrevQuantity = v_PrevQuantity -v_CurQuantity;
               IF v_PrevQuantity < 0 then
					
                  SET v_PrevQuantity = -v_PrevQuantity;
                  IF v_PrevQuantity >= v_CalcQuantity then
						
                     SET v_InsQuantity = v_CalcQuantity;
                     SET v_CalcQuantity = 0;
                  ELSE
                     SET v_InsQuantity = v_PrevQuantity;
                     SET v_CalcQuantity = v_CalcQuantity -v_PrevQuantity;
                  end if;
                  SET v_PrevQuantity = 0;
                  SET v_TransDate = TIMESTAMPADD(SECOND,1,v_TransDate);
                  SET @SWV_Error = 0;
                  INSERT INTO InventoryLedger(CompanyID,
							DivisionID,
							DepartmentID,
							TransDate,
							ItemID,
							TransactionType,
							TransNumber,
							ILLineNumber,
							Quantity,
							CostPerUnit,
							TotalCost)
						VALUES(v_CompanyID,
							v_DivisionID,
							v_DepartmentID,
							v_TransDate,
							v_ItemID,
							v_TransactionType,
							v_TransactionNumber,
							v_TransactionLineNumber,
							-v_InsQuantity,
							v_CurCostPerUnit,
							fnRound(v_CompanyID, v_DivisionID, v_DepartmentID, Abs(v_InsQuantity)*v_CurCostPerUnit, v_CompanyCurrencyID));
						
                  IF @SWV_Error <> 0 then
						
						
                     IF SWV_CurNum = 0 THEN
                        CLOSE cInventoryLedger;
                     ELSE
                        CLOSE cInventoryLedger2;
                     END IF;
							
                     SET v_ErrorMessage = 'Insert in InventoryTransaction failed';
                     ROLLBACK;


                     IF v_ErrorMessage <> '' then

	
                        CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateILTransaction',
                        v_ErrorMessage,v_ErrorID);
                        CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
                     end if;
                     SET SWP_Ret_Value = -1;
                  end if;
               end if;
            end if;
            SET NO_DATA = 0;
            IF SWV_CurNum = 0 THEN
               FETCH cInventoryLedger INTO v_CurQuantity,v_CurCostPerUnit;
            ELSE
               FETCH cInventoryLedger2 INTO v_CurQuantity,v_CurCostPerUnit;
            END IF;
         END WHILE;
         IF SWV_CurNum = 0 THEN
            CLOSE cInventoryLedger;
         ELSE
            CLOSE cInventoryLedger2;
         END IF;
			

			
         SET @SWV_Error = 0;
         CALL Inventory_RecalcItemCost2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_Quantity,v_CostPerUnit,
         v_NewCostPerUnit, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
			
            SET v_ErrorMessage = 'Inventory_RecalcItemCost call failed';
            ROLLBACK;


            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateILTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
		
      ELSE
         SET @SWV_Error = 0;
         INSERT INTO InventoryLedger(CompanyID,
					DivisionID,
					DepartmentID,
					TransDate,
					ItemID,
					TransactionType,
					TransNumber,
					ILLineNumber,
					Quantity,
					CostPerUnit,
					TotalCost)
				VALUES(v_CompanyID,
					v_DivisionID,
					v_DepartmentID,
					v_TransDate,
					v_ItemID,
					v_TransactionType,
					v_TransactionNumber,
					v_TransactionLineNumber,
					v_Quantity,
					v_CostPerUnit,
					fnRound(v_CompanyID, v_DivisionID, v_DepartmentID, Abs(v_Quantity)*v_CostPerUnit, v_CompanyCurrencyID));
				
         IF @SWV_Error <> 0 then
				
				
            SET v_ErrorMessage = 'Insert in InventoryTransaction failed';
            ROLLBACK;


            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateILTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
      end if;
   end if;




   COMMIT;
	
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_CreateILTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
   end if;
   SET SWP_Ret_Value = -1;
END