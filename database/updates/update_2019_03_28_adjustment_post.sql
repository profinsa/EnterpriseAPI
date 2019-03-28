DELIMITER //
DROP PROCEDURE IF EXISTS InventoryAdjustments_Post;
//
CREATE             PROCEDURE InventoryAdjustments_Post(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AdjustmentID NATIONAL VARCHAR(36),
	INOUT v_Success INT ,
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN
/*
Name of stored procedure: InventoryAdjustments_Post
Method:
	Performs all preliminary checks and operations with inventory adjustment and
	posts it to General Ledger
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@AdjustmentID NVARCHAR(36)	 - the ID of the inventory adjustment
Output Parameters:
	@Success INT 			 - returns the operation result
							   0 - some error in the stored procedure occurs
							   1 - success
							   2 - posting period is closed already
	@PostingResult NVARCHAR(200)	 - the error message that should be displayed for end user
Called From:
	InventoryAdjustments_Post.vb
Calls:
	LedgerMain_VerifyPeriod, Inventory_CreateILTransaction, WarehouseBinShipGoods, InventoryAdjustments_CreateGLTransaction, Error_InsertError, Error_InsertErrorDetail
Last Modified:
Last Modified By:
Revision History:
*/
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_AdjustmentDate DATETIME;
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_DefaultInventoryCostingMethod NATIONAL VARCHAR(1);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
-- get @DefaultInventoryCostingMethod
   DECLARE v_AdjustmentLineID INT;
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_AdjustedQuantity INT;
   DECLARE v_ItemCost DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_Context VARBINARY(128);
   DECLARE v_EmployeeID NATIONAL VARCHAR(36);
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_ErrorID INT;
   DECLARE v_QtyOnHand INT;
	-- Get the current item quantity in the Warehouse bin
   DECLARE v_Cost DECIMAL(19,4);
   DECLARE v_IsOverflow BOOLEAN;
   DECLARE cAdjustmentDetail CURSOR 
   FOR SELECT
   InventoryAdjustmentsDetail.AdjustmentLineID,
		InventoryAdjustmentsDetail.WarehouseID,
		InventoryAdjustmentsDetail.WarehouseBinID,
		InventoryAdjustmentsDetail.ItemID,
		IFNULL(InventoryAdjustmentsDetail.AdjustedQuantity,0),
		(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN InventoryItems.FIFOValue
   WHEN 'L' THEN InventoryItems.LIFOValue
   WHEN 'A' THEN InventoryItems.AverageValue
   END)
   FROM
   InventoryAdjustmentsDetail
   INNER JOIN InventoryItems ON
   InventoryAdjustmentsDetail.CompanyID = InventoryItems.CompanyID
   AND InventoryAdjustmentsDetail.DivisionID = InventoryItems.DivisionID
   AND InventoryAdjustmentsDetail.DepartmentID = InventoryItems.DepartmentID
   AND InventoryAdjustmentsDetail.ItemID = InventoryItems.ItemID
   WHERE	
   InventoryAdjustmentsDetail.CompanyID = v_CompanyID
   AND InventoryAdjustmentsDetail.DivisionID = v_DivisionID
   AND InventoryAdjustmentsDetail.DepartmentID = v_DepartmentID
   AND InventoryAdjustmentsDetail.AdjustmentID = v_AdjustmentID
   AND IFNULL(InventoryAdjustmentsDetail.AdjustedQuantity,0) <> 0;
-- open the cursor and get the first row
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   SET v_Success =  1;
-- Prevent default record posting
   IF IFNULL(v_AdjustmentID,N'') = N'DEFAULT' then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
-- If there is no detail with positive cost for the inventory adjustment then exit
   IF NOT EXISTS(SELECT
   AdjustmentID
   FROM
   InventoryAdjustmentsDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID AND
   IFNULL(AdjustedQuantity,0) <> 0) then

      SET v_PostingResult = 'Adjustment was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;
   select   IFNULL(CurrencyID,N''), IFNULL(DefaultInventoryCostingMethod,'F') INTO v_CompanyCurrencyID,v_DefaultInventoryCostingMethod FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
   IF EXISTS(SELECT(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN InventoryItems.FIFOValue
   WHEN 'L' THEN InventoryItems.LIFOValue
   WHEN 'A' THEN InventoryItems.AverageValue
   END) As ItemCost
   FROM
   InventoryAdjustmentsDetail
   INNER JOIN InventoryItems ON
   InventoryAdjustmentsDetail.CompanyID = InventoryItems.CompanyID
   AND InventoryAdjustmentsDetail.DivisionID = InventoryItems.DivisionID
   AND InventoryAdjustmentsDetail.DepartmentID = InventoryItems.DepartmentID
   AND InventoryAdjustmentsDetail.ItemID = InventoryItems.ItemID
   WHERE
   InventoryAdjustmentsDetail.CompanyID = v_CompanyID
   AND InventoryAdjustmentsDetail.DivisionID = v_DivisionID
   AND InventoryAdjustmentsDetail.DepartmentID = v_DepartmentID
   AND InventoryAdjustmentsDetail.AdjustmentID = v_AdjustmentID
   AND(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN IFNULL(InventoryItems.FIFOValue,0)
   WHEN 'L' THEN IFNULL(InventoryItems.LIFOValue,0)
   WHEN 'A' THEN IFNULL(InventoryItems.AverageValue,0)
   END) = 0) then

      SET v_PostingResult = 'Adjustment was not posted: the cost of some detail items is not defined';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;
   select   IFNULL(AdjustmentPosted,0), IFNULL(v_AdjustmentDate,CURRENT_TIMESTAMP) INTO v_Posted,v_AdjustmentDate FROM
   InventoryAdjustments WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID;
-- if the payment is allready posted do not post it again
   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
-- get the post date flag from
-- the companies table
   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
-- begin the posting process
   IF v_PostDate = '1' then
      SET v_AdjustmentDate = CURRENT_TIMESTAMP;
   end if;
   START TRANSACTION;
-- verify the period of time
   SET v_ReturnStatus = LedgerMain_VerifyPeriod(v_CompanyID,v_DivisionID,v_DepartmentID,v_AdjustmentDate,v_PeriodToPost,
   v_PeriodClosed);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_VerifyPeriod call failed';
      ROLLBACK;
-- the error handler
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
   IF v_PeriodClosed <> 0 then

      SET v_Success = 2;
      SET v_ErrorMessage = 'UNABLE_TO_POST_HERE';
      ROLLBACK;
-- the error handler
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
   Set v_Total = 0;
   OPEN cAdjustmentDetail;
   SET NO_DATA = 0;
   FETCH cAdjustmentDetail INTO v_AdjustmentLineID,v_WarehouseID,v_WarehouseBinID,v_ItemID,v_AdjustedQuantity, 
   v_ItemCost;
   WHILE NO_DATA = 0 DO
      SET v_ItemCost = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemCost,v_CompanyCurrencyID);
      select   IFNULL(QtyOnHand,0) INTO v_QtyOnHand FROM 	InventoryByWarehouse WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND WarehouseID = v_WarehouseID
      AND WarehouseBinID = v_WarehouseBinID
      AND ItemID = v_ItemID;
	-- check AdjustedQuantity
      IF v_AdjustedQuantity < 0 AND v_QtyOnHand < -v_AdjustedQuantity then
		
         CLOSE cAdjustmentDetail;
			
         SET v_ErrorMessage = 'Qty On Hand < Adjusted Quantity';
         ROLLBACK;
-- the error handler
         IF v_Success = 1 then

            SET v_Success = 0;
         end if;
         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      CALL Inventory_CreateILTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_AdjustmentDate,v_ItemID,'Adjustment',
      v_AdjustmentID,v_AdjustmentLineID,v_AdjustedQuantity,v_ItemCost, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         CLOSE cAdjustmentDetail;
		
         SET v_ErrorMessage = 'Inventory_CreateILTransaction call failed';
         ROLLBACK;
-- the error handler
         IF v_Success = 1 then

            SET v_Success = 0;
         end if;
         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
      SET v_Cost = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,ABS(v_AdjustedQuantity*v_ItemCost), 
      v_CompanyCurrencyID);
      SET v_Total = v_Total+v_Cost;
	-- Write adjustment real values back to the InventoryAdjustmentsDetail
      UPDATE	InventoryAdjustmentsDetail
      SET
      AdjustedQuantity = v_AdjustedQuantity,OriginalQuantity = v_QtyOnHand,Cost = v_Cost,
      CurrencyID = v_CompanyCurrencyID,CurrencyExchangeRate = 1
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND AdjustmentID = v_AdjustmentID
      AND AdjustmentLineID = v_AdjustmentLineID;
      IF v_AdjustedQuantity > 0 then
	
		
         SET @SWV_Error = 0;
         CALL WarehouseBinPutGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
         v_ItemID,v_AdjustmentID,v_AdjustmentLineID,NULL,v_AdjustmentDate,v_AdjustedQuantity,
         6,v_IsOverflow, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
            -- CLOSE C;
			
            SET v_ErrorMessage = 'WarehouseBinPutGoods failed';
            ROLLBACK;
-- the error handler
            IF v_Success = 1 then

               SET v_Success = 0;
            end if;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
      ELSE
         SET v_AdjustedQuantity = -v_AdjustedQuantity;
         CALL WarehouseBinShipGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
         v_ItemID,v_AdjustedQuantity,0,3, v_ReturnStatus);
         IF v_ReturnStatus = -1 then
		
            CLOSE cAdjustmentDetail;
			
            SET v_ErrorMessage = 'WarehouseBinShipGoods call failed';
            ROLLBACK;
-- the error handler
            IF v_Success = 1 then

               SET v_Success = 0;
            end if;
            IF v_ErrorMessage <> '' then

	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH cAdjustmentDetail INTO  v_AdjustmentLineID,v_WarehouseID,v_WarehouseBinID,v_ItemID,v_AdjustedQuantity, 
      v_ItemCost;
   END WHILE;
   CLOSE cAdjustmentDetail;

   select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
   SET v_EmployeeID = CAST(v_Context AS CHAR(36));
-- set posted flag for payment
   SET @SWV_Error = 0;
   UPDATE
   InventoryAdjustments
   SET
   AdjustmentPosted = 1,EnteredBy = v_EmployeeID,Total = v_Total,AdjustmentDate = CASE WHEN IFNULL(AdjustmentDate,'1980/01/01') = '1980/01/01' THEN CURRENT_TIMESTAMP ELSE AdjustmentDate END
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update InventoryAdjustments failed';
      ROLLBACK;
-- the error handler
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
   SET @SWV_Error = 0;
   CALL InventoryAdjustments_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_AdjustmentID, v_ReturnStatus);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Payment_CreateGLTransaction call failed';
      ROLLBACK;
-- the error handler
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- Everything is OK
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;
-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   ROLLBACK;
-- the error handler
   IF v_Success = 1 then

      SET v_Success = 0;
   end if;
   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
   end if;
   SET SWP_Ret_Value = -1;
END;

//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS InventoryAdjustments_CreateGLTransaction;
//
CREATE        PROCEDURE InventoryAdjustments_CreateGLTransaction(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AdjustmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN














/*
Name of stored procedure: InventoryAdjustments_CreateGLTransaction
Method: 
	Posts inventory adjustment to the General Ledger

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@AdjustmentID NVARCHAR(36)	 - the  ID of the inventory adjustment

Output Parameters:

	NONE

Called From:

	InventoryAdjustments_Post

Calls:

	GetNextEntityID, LedgerTransactions_PostCOA_AllRecords, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Posted BOOLEAN;
   DECLARE v_PostedToGL BOOLEAN;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(50);
   DECLARE v_Cost DECIMAL(19,4);
   DECLARE v_ConvertedCost DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PostCOA BOOLEAN;
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);
   DECLARE v_GLInventoryAccount NATIONAL VARCHAR(36);
   DECLARE v_AdjustmentDate DATETIME;
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT
   AdjustmentID
   FROM
   InventoryAdjustmentsDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID AND
   IFNULL(Cost,0) > 0) then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(AdjustmentPosted,0), IFNULL(AdjustmentPostToGL,0), IFNULL(AdjustmentDate,CURRENT_TIMESTAMP) INTO v_Posted,v_PostedToGL,v_AdjustmentDate FROM
   InventoryAdjustments WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID;
-- We can't post adjustment to GL, 
-- if inventory was not adjusted yet
   IF v_Posted = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
-- Do nothing if adjustment was posted already
   IF v_PostedToGL = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;


-- get the post date flag, Inventory Account and Company Currency
-- from the companies table
   select   IFNULL(DefaultGLPostingDate,'1'), GLAPInventoryAccount, IFNULL(CurrencyID,N'') INTO v_PostDate,v_GLInventoryAccount,v_CompanyCurrencyID FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   IF v_PostDate = '1' then
      SET v_AdjustmentDate = CURRENT_TIMESTAMP;
   end if;

   select   ProjectID INTO v_ProjectID FROM InventoryAdjustmentsDetail WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID AND
   NOT ProjectID IS NULL   LIMIT 1;


   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


-- create temporary table for payment information
   CREATE TEMPORARY TABLE tt_LedgerDetailTmp  
   (
      GLTransactionNumberDetail BIGINT NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
      GLTransactionAccount NATIONAL VARCHAR(36),
      GLDebitAmount DECIMAL(19,4),
      GLCreditAmount DECIMAL(19,4),
      ProjectID NATIONAL VARCHAR(36)
   )  AUTO_INCREMENT = 1;

-- get the transaction number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InventoryAdjustments_CreateGLTransaction',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Get adjustment amount
   select   SUM(IFNULL(Cost,0)) INTO v_Cost FROM
   InventoryAdjustmentsDetail WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID AND
   IFNULL(Cost,0) > 0;	

-- insert into ledger transactions informations about the payment
-- Inventory stores all money amounts in the company currency already,
-- so we should not convert @Cost to company currency
   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactions(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionTypeID,
	GLTransactionDate,
	GLTransactionDescription,
	GLTransactionReference,
	CurrencyID,
	CurrencyExchangeRate,
	GLTransactionAmount,
	GLTransactionPostedYN,
	GLTransactionSystemGenerated,
	GLTransactionBalance,
	GLTransactionAmountUndistributed)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransNumber,
	N'Inventory Adjustment',
	v_AdjustmentDate,
	CONCAT(N'ADJ', v_AdjustmentID),
	N'',
	v_CompanyCurrencyID,
	1,
	v_Cost,
	1,
	1,
	0,
	0);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
      ROLLBACK;
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- ---------------------------------------------
-- Post detail items with negative AdjustedQuantity
-- that decrease inventory
-- ---------------------------------------------
-- Credit  ItemCost to company Inventory Account
   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)(SELECT
      v_GLInventoryAccount,
	0,
	SUM(IFNULL(Cost,0)),
	ProjectID
      FROM
      InventoryAdjustmentsDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND AdjustmentID = v_AdjustmentID
      AND IFNULL(Cost,0) > 0
      AND IFNULL(AdjustedQuantity,0) < 0
      GROUP BY
      ProjectID);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing AP Data';
      ROLLBACK;
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- Debit ItemCost to Adjustment Posting Account
   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   IFNULL(GLAdjustmentPostingAccount,(SELECT GLAPMiscAccount
      FROM Companies
      WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID)),
	SUM(IFNULL(Cost,0)),
	0,
	ProjectID
   FROM
   InventoryAdjustmentsDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND AdjustmentID = v_AdjustmentID
   AND IFNULL(Cost,0) > 0
   AND IFNULL(AdjustedQuantity,0) < 0
   GROUP BY
   GLAdjustmentPostingAccount,ProjectID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing Expense Data';
      ROLLBACK;
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- ---------------------------------------------
-- Post detail items with positive AdjustedQuantity
-- that increase inventory
-- ---------------------------------------------
-- Debit  ItemCost to company Inventory Account
   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)(SELECT
      v_GLInventoryAccount,
	SUM(IFNULL(Cost,0)),
	0,
	ProjectID
      FROM
      InventoryAdjustmentsDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND AdjustmentID = v_AdjustmentID
      AND IFNULL(Cost,0) > 0
      AND IFNULL(AdjustedQuantity,0) > 0
      GROUP BY
      ProjectID);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing AP Data';
      ROLLBACK;
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- Credit ItemCost to Adjustment Posting Account
   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount ,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   IFNULL(GLAdjustmentPostingAccount,(SELECT GLAPMiscAccount
      FROM Companies
      WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID)),
	0,
	SUM(IFNULL(Cost,0)),
	ProjectID
   FROM
   InventoryAdjustmentsDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND AdjustmentID = v_AdjustmentID
   AND IFNULL(Cost,0) > 0
   AND IFNULL(AdjustedQuantity,0) > 0
   GROUP BY
   GLAdjustmentPostingAccount,ProjectID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing Expense Data';
      ROLLBACK;
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- insert the information in the LedgerTransactionsDetail group by GLTransactionAccount, CurrencyID, CurrencyExchangeRate
   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		GLTransactionAccount,
		SUM(IFNULL(GLDebitAmount,0)),
		SUM(IFNULL(GLCreditAmount,0)),
		ProjectID
   FROM
   tt_LedgerDetailTmp
   GROUP BY
   GLTransactionAccount,ProjectID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
/*
update the information in the Ledger Chart of Accounts for the accounts of the newly inserted transaction

parameters	@CompanyID NVARCHAR(36),
		@DivisionID NVARCHAR(36),
		@DepartmentID NVARCHAR(36),
		@GLTransNumber NVARCHAR (36)
		used to identify the TRANSACTION
		@PostCOA BIT - used in the process of creation of the transaction
*/
   SET @SWV_Error = 0;
   CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;
-- the error handler

      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;




-- drop temporary table used for ledger details
   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;


-- updated GL Posting flag for InventoryAdjustments
   UPDATE
   InventoryAdjustments
   SET
   AdjustmentPostToGL = 1
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID;

-- Everything is OK
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   ROLLBACK;
-- the error handler

   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'AdjustmentID',v_AdjustmentID);
   end if;
   SET SWP_Ret_Value = -1;
END;








//

DELIMITER ;
