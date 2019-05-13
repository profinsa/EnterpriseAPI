DELIMITER //
DROP PROCEDURE IF EXISTS DebitMemo_Post;
//
CREATE                    PROCEDURE DebitMemo_Post(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	INOUT v_Succes INT  ,
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


/*
Name of stored procedure: DebitMemo_Post
Method: 
	Stored procedure used to post a debit memo

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36)	 - the ID of the debit memo

Output Parameters:

	@Succes INT  			 - RETURN VALUES for the @Succes output parameter:

							   1 succes

							   0 error while processin data

							   2 error on geting time Period
	@PostingResult NVARCHAR(200)	 - returns error message that should be displayed for end user

Called From:

	Purchase_Control, DebitMemo_Post.vb

Calls:

	LedgerMain_VerifyPeriod, DebitMemo_CreateGLTransaction, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_TranDate DATETIME;
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_PostDate NATIONAL VARCHAR(1);






   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_Succes =  1;
   IF NOT EXISTS(SELECT * FROM
   PurchaseDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber) then

      SET v_PostingResult = 'Debit Memo was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT * FROM
   PurchaseDetail
   WHERE
   IFNULL(Total,0) = 0 AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber) then

      SET v_PostingResult = 'Debit Memo was not posted: there is the detail item with undefined Total value';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

-- begin the posting process

   select   CASE v_PostDate WHEN '1'
   THEN
      CURRENT_TIMESTAMP
   ELSE
      PurchaseDate
   END, Posted INTO v_TranDate,v_Posted FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;


   IF v_Posted = 1 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;
   SET @SWV_Error = 0;
   CALL DebitMemo_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);
-- EXEC @ReturnStatus = DebitMemo_RecalcCLR @CompanyID, @DivisionID, @DepartmentID, @PurchaseNumber
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Recalculating the debit memo failed';
	
      SET v_Succes = 0;
      ROLLBACK;
-- the error handler


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_DebitMemoPost',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- get the current Period
   SET @SWV_Error = 0;
   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'LedgerMain_VerifyPeriod call failed';
	
      SET v_Succes = 0;
      ROLLBACK;
-- the error handler


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_DebitMemoPost',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_PeriodClosed <> 0 then
-- the Period is closed, go to the error handler
-- and set the apropriate error message

      SET v_Succes = 2;
      SET v_ErrorMessage = 'Period is closed';
	
      SET v_Succes = 0;
      ROLLBACK;
-- the error handler


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_DebitMemoPost',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   CALL DebitMemo_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'CreditMemo_CreateGLTransaction call failed';
	
      SET v_Succes = 0;
      ROLLBACK;
-- the error handler


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_DebitMemoPost',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- Update purchase header to prevent furter posting
   UPDATE
   PurchaseHeader
   SET
   Approved = 1,ApprovedDate = CURRENT_TIMESTAMP,Posted = 1,PostedDate = CURRENT_TIMESTAMP
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;


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

   SET v_Succes = 0;

   ROLLBACK;
-- the error handler


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_DebitMemoPost',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END;






//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS DebitMemo_Cancel;
//
CREATE   PROCEDURE DebitMemo_Cancel(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN









/*
Name of stored procedure: DebitMemo_Cancel
Method: 
	Cancels a debit memo that was not affected to General Ledger

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36)	 - the ID of debit memo

Output Parameters:

	NONE

Called From:

	DebitMemo_Cancel.vb

Calls:

	VerifyCurrency, Inventory_GetWarehouseForPurchase, WarehouseBinPutGoods, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_OrderWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_DetailWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseDetailID CHAR(144);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty FLOAT;

   DECLARE v_Received BOOLEAN;
   DECLARE v_PurchasePosted BOOLEAN;
   DECLARE v_PurchasePaid BOOLEAN;
   DECLARE v_PurchaseShipped BOOLEAN;
   DECLARE v_PurchaseCancelDate DATETIME;
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);

   DECLARE v_VendorID NATIONAL VARCHAR(50);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PurchaseDate DATETIME;

   DECLARE v_IsOverflow BOOLEAN;

-- if purchase is posted return
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cPurchaseDetail CURSOR FOR
   SELECT
   PurchaseNumber, 
		ItemID, WarehouseID, WarehouseBinID, IFNULL(OrderQty,0)
   FROM
   PurchaseDetail
   WHERE
   PurchaseNumber = v_PurchaseNumber AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   select   IFNULL(Received,0), IFNULL(Posted,0), PurchaseCancelDate, IFNULL(Paid,0), IFNULL(AmountPaid,0), IFNULL(Total,0), CurrencyID, CurrencyExchangeRate, PurchaseDate, VendorID INTO v_Received,v_PurchasePosted,v_PurchaseCancelDate,v_PurchasePaid,v_AmountPaid,
   v_Total,v_CurrencyID,v_CurrencyExchangeRate,v_PurchaseDate,v_VendorID FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;



-- if order is canceled
-- or order is not posted exit the procedure
   IF 	v_PurchasePosted = 0
   OR v_PurchasePaid <> 0
   OR v_AmountPaid <> 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
-- the error handler

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_Cancel',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


-- transform if necessary (different currencies)
   SET v_AmountPaid = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_AmountPaid*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
   SET v_Total = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);

   UPDATE
   VendorFinancials
   SET
   AvailableCredit = IFNULL(AvailableCredit,0)+v_Total,BookedPurchaseOrders = IFNULL(BookedPurchaseOrders,0) -v_Total,
   PurchaseYTD = IFNULL(PurchaseYTD,0) -v_Total
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID;

-- get the warehouse for the order
   SET @SWV_Error = 0;
   CALL Inventory_GetWarehouseForPurchase2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_OrderWarehouseID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Inventory_GetWarehouseForPurchase call failed';
      ROLLBACK;
-- the error handler

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_Cancel',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;	

-- create cursor for iteration of purchase details	
   OPEN cPurchaseDetail;
   SET NO_DATA = 0;
   FETCH cPurchaseDetail INTO v_PurchaseDetailID,v_ItemID,v_DetailWarehouseID,v_WarehouseBinID,v_OrderQty;

   WHILE NO_DATA = 0 DO
	-- update the quantity in inventory
	-- use the warehouse of the purchase detail or of purchase order
      IF v_Received = 0 then
		
         SET @SWV_Error = 0;
         CALL WarehouseBinPutGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_DetailWarehouseID,v_WarehouseBinID,
         v_ItemID,NULL,NULL,NULL,NULL,v_OrderQty,3,v_IsOverflow, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
            CLOSE cPurchaseDetail;
				
            SET v_ErrorMessage = 'WarehouseBinPutGoods failed';
            ROLLBACK;
-- the error handler

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_Cancel',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
            SET SWP_Ret_Value = -1;
         end if;
      ELSE
         SET @SWV_Error = 0;
         CALL WarehouseBinPutGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_DetailWarehouseID,v_WarehouseBinID,
         v_ItemID,NULL,NULL,NULL,NULL,v_OrderQty,4,v_IsOverflow, v_ReturnStatus);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
            CLOSE cPurchaseDetail;
				
            SET v_ErrorMessage = 'WarehouseBinPutGoods failed';
            ROLLBACK;
-- the error handler

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_Cancel',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH cPurchaseDetail INTO v_PurchaseDetailID,v_ItemID,v_DetailWarehouseID,v_WarehouseBinID,v_OrderQty;
   END WHILE;


   CLOSE cPurchaseDetail;



-- cancel the purchase
   SET @SWV_Error = 0;
   UPDATE
   PurchaseHeader
   SET
   Posted = 0
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update PurchaseHeader failed';
      ROLLBACK;
-- the error handler

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_Cancel',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_Cancel',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END;





//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Inventory_GetWarehouseForPurchase2;
//
CREATE PROCEDURE Inventory_GetWarehouseForPurchase2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	INOUT v_WarehouseID NATIONAL VARCHAR(36)  ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN










/*
Name of stored procedure: Inventory_GetWarehouseForPurchase
Method: 
	this procedure decides what warehouse will be used when a purchase (PO) is posted; 
	the items from purchase detalis will be credited to that warehouses Quantity on hand.

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36)	 - the ID of the purchase

Output Parameters:

	@WarehouseID NVARCHAR(36)	 - the Warehouse for puchase

Called From:

	DebitMemo_Cancel, Purchase_Cancel, RMA_Post, Purchase_Post, Receiving_AdjustInventory, RMA_Cancel

Calls:

	NONE

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_VendorID NATIONAL VARCHAR(50);


-- get the warehouse id from the purchase order
   select   IFNULL(WarehouseID,N''), VendorID INTO v_WarehouseID,v_VendorID FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;


   IF v_WarehouseID <> N'' then

	-- we got the warehouseID, exit
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


-- if warehouse id is null in purchase order header, get it form vendor default warehous
   select   IFNULL(WarehouseID,N'') INTO v_WarehouseID FROM
   VendorInformation WHERE
   VendorID = v_VendorID AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   IF v_WarehouseID <> N'' then

	-- we got the warehouseID, exit
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

-- if vendor default warehouse is null, get the default warehouse from the company
   select   IFNULL(WarehouseID,N'') INTO v_WarehouseID FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;

   IF v_WarehouseID <> N'' then

	-- we got the warehouseID, exit
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

-- if vendor default warehouse is null, get the default warehouse from the company
   select   IFNULL(WarehouseID,N'DEFAULT') INTO v_WarehouseID FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   SET SWP_Ret_Value = 0;
END;









//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS DebitMemo_Recalc2;
//
CREATE           PROCEDURE DebitMemo_Recalc2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


/*
Name of stored procedure: DebitMemo_Recalc
Method: 
	Calculates the ammunts of money for a specified debit memo

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR (36)	 - the ID of the debit memo

Output Parameters:

	NONE

Called From:

	DebitMemo_Recalc.vb

Calls:

	VerifyCurrency, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PurchaseDate DATETIME;
   DECLARE v_Subtotal DECIMAL(19,4);
   DECLARE v_SubtotalMinusDetailDiscount DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_TotalTaxable DECIMAL(19,4);
   DECLARE v_DiscountPers FLOAT;
   DECLARE v_DiscountAmount DECIMAL(19,4);
   DECLARE v_TaxAmount DECIMAL(19,4);
   DECLARE v_Freight DECIMAL(19,4);
   DECLARE v_Handling DECIMAL(19,4);
   DECLARE v_TaxFreight BOOLEAN;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_Paid BOOLEAN;

   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_TaxPercent FLOAT;

   DECLARE v_ItemOrderQty FLOAT;
   DECLARE v_ItemUnitPrice FLOAT;
   DECLARE v_ItemTotal DECIMAL(19,4);
   DECLARE v_ItemDiscountPerc FLOAT;
   DECLARE v_ItemTaxable BOOLEAN;

   DECLARE v_TaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_tmp NATIONAL VARCHAR(100);
-- get the information about the order status
   DECLARE v_BalananceDue DECIMAL(19,4);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_TaxPercent = 0;
   select   IFNULL(Posted,0) INTO v_Posted FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;	

   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

-- get the currency id for the order header

   select   CurrencyID, CurrencyExchangeRate, PurchaseDate, IFNULL(DiscountPers,0), IFNULL(TaxFreight,0), IFNULL(Freight,0), IFNULL(Handling,0), IFNULL(AmountPaid,0), TaxGroupID INTO v_CurrencyID,v_CurrencyExchangeRate,v_PurchaseDate,v_DiscountPers,v_TaxFreight,
   v_Freight,v_Handling,v_AmountPaid,v_TaxGroupID FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;
   SET v_Subtotal = 0;
   SET v_TotalTaxable = 0;


-- get the details Totals
   select   IFNULL(SUM(Total),0) INTO v_Subtotal FROM
   PurchaseDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;


   SET v_Subtotal = v_Subtotal;
   SET v_Total = v_Subtotal; 
   SET v_BalananceDue = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total -v_AmountPaid,v_CompanyCurrencyID);

   SET @SWV_Error = 0;
   UPDATE
   PurchaseHeader
   SET
   Subtotal = v_Subtotal,DiscountAmount = 0,TaxableSubTotal = v_Total,TaxPercent = 0,
   TaxAmount = 0,Total = v_Total,BalanceDue = v_BalananceDue
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Recalculating order header totals failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_Recalc',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_Recalc',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END;


















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS DebitMemo_CreateGLTransaction;
//
CREATE                       PROCEDURE DebitMemo_CreateGLTransaction(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


















/*
Name of stored procedure: DebitMemo_CreateGLTransaction
Method: 
	Makes all needed records in the General Ledger related with specific debit memo

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36)	 - the ID of the debit memo

Output Parameters:

	NONE

Called From:

	DebitMemo_Post

Calls:

	VerifyCurrency, GetNextEntityID, LedgerTransactions_PostCOA_AllRecords, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_TranDate DATETIME;
   DECLARE v_PeriodToPost INT;
   DECLARE v_ConvertedAmountPaid DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PurchaseDate DATETIME;
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_ConvertedTotal DECIMAL(19,4);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_GLAPAccount NATIONAL VARCHAR(36);
   DECLARE v_GLAPInventoryAccount NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(36);
   DECLARE v_PostCOA BOOLEAN;
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_PostDate NATIONAL VARCHAR(1);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;




-- get the information about the Vendor, Currency and the ammount of money
   select   VendorID, CurrencyID, CurrencyExchangeRate, PurchaseDate, Total, AmountPaid, VendorID INTO v_VendorID,v_CurrencyID,v_CurrencyExchangeRate,v_PurchaseDate,v_Total,
   v_AmountPaid,v_VendorID FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;


-- get the GL Account Information from the Companies Table
   select   GLAPInventoryAccount, GLAPAccount, IFNULL(DefaultGLPostingDate,'1') INTO v_GLAPInventoryAccount,v_GLAPAccount,v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

-- Get currency exhange rate for the debit memo
   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
-- the error handler


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


   SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);

   select   ProjectID INTO v_ProjectID FROM
   PurchaseDetail WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber AND
   Not ProjectID IS NULL;


-- get the transaction number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
-- the error handler


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

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
	GLTransactionAmountUndistributed,
	GLTransactionPostedYN,
	GLTransactionBalance,
	GLTransactionSource,
	GLTransactionSystemGenerated,
	GLTransactionRecurringYN)
	Values(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		'Debit Memo',
		CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE v_PurchaseDate END,
		v_VendorID,
		v_PurchaseNumber,
		v_CurrencyID,
		v_CurrencyExchangeRate,
		v_ConvertedTotal,
		0,
		1,
		0,
		CONCAT('DEBIT MEMO ', cast(v_PurchaseNumber as char(10))),
		1,
		1);


   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
      ROLLBACK;
-- the error handler


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;



-- Debit @Total from  Account Payable
   INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
VALUES(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		v_GLAPAccount,
		v_ConvertedTotal,
		0,
		v_ProjectID);

-- Credit @Total to detail item account

   SET @SWV_Error = 0;
   INSERT INTO LedgerTransactionsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	GLTransactionNumber,
	GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   Select
   v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_GLTransNumber,
	IFNULL(GLPurchaseAccount,v_GLAPInventoryAccount),
	0,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Total*v_CurrencyExchangeRate,v_CompanyCurrencyID),
	ProjectID
   FROM
   PurchaseDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber
   AND IFNULL(Total,0) <> 0;




   IF @SWV_Error <> 0 then
-- An error occured , drop the temporary table and 
-- go to the error handler

      SET v_ErrorMessage = 'Error Processing Data';
      ROLLBACK;
-- the error handler


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
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


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
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


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CreateGLTransaction',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END;

















//

DELIMITER ;
