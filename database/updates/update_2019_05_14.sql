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

DELIMITER //
DROP PROCEDURE IF EXISTS DebitMemo_ApplyToPayment;
//
CREATE               PROCEDURE DebitMemo_ApplyToPayment(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),
	v_Amount DECIMAL(19,4),
	INOUT v_Result SMALLINT ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN
























/*
Name of stored procedure: DebitMemo_ApplyToPayment
Method: 
	performs all the necessary actions to cash a Payment from debit memo

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36)	 - the ID of debit memo
	@PaymentID NVARCHAR(36)		 - the ID of payment
	@Amount MONEY			 - the money amout that should be applied to payment

Output Parameters:

	@Result SMALLINT 

Called From:

	DebitMemo_ApplyToPayment.vb

Calls:

	Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_DebitMemoPost BOOLEAN;
   DECLARE v_DebitMemoTotal DECIMAL(19,4);
   DECLARE v_DebitMemoAmountPaid DECIMAL(19,4);
   DECLARE v_DebitMemoBalance DECIMAL(19,4);
   DECLARE v_DebitMemoCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_DebitMemoDate DATETIME;

   DECLARE v_PaymentPost BOOLEAN;
   DECLARE v_PaymentPaid BOOLEAN;
   DECLARE v_PaymentAmount DECIMAL(19,4);
   DECLARE v_PaymentCreditAmount DECIMAL(19,4);
   DECLARE v_PaymentBalance DECIMAL(19,4);
   DECLARE v_PaymentCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_PaymentCheckNumber NATIONAL VARCHAR(20);
   DECLARE v_PaymentCheckDate DATETIME;
   DECLARE v_BankTransNumber NATIONAL VARCHAR(36);
   DECLARE v_CreditMemoNumber NATIONAL VARCHAR(36);
   DECLARE v_CurrencyExchangeRate FLOAT;

   DECLARE v_PayDebitMemo DECIMAL(19,4);
   DECLARE v_DebitMemoRest DECIMAL(19,4);

-- Vendor info
   DECLARE v_VendorID NATIONAL VARCHAR(50);
   DECLARE v_TermsID NATIONAL VARCHAR(36);
   DECLARE v_VendorShipToID NATIONAL VARCHAR(36);
   DECLARE v_VendorShipForID NATIONAL VARCHAR(36);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_TaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_ShipMethodID NATIONAL VARCHAR(36);
   DECLARE v_EmployeeID NATIONAL VARCHAR(36);
   DECLARE v_ShippingName NATIONAL VARCHAR(50);
   DECLARE v_ShippingAddress1 NATIONAL VARCHAR(50);
   DECLARE v_ShippingAddress2 NATIONAL VARCHAR(50);
   DECLARE v_ShippingAddress3 NATIONAL VARCHAR(50);
   DECLARE v_ShippingCity NATIONAL VARCHAR(50);
   DECLARE v_ShippingState NATIONAL VARCHAR(50);
   DECLARE v_ShippingZip NATIONAL VARCHAR(50);
   DECLARE v_ShippingCountry NATIONAL VARCHAR(50);
   DECLARE v_GLPurchaseAccount NATIONAL VARCHAR(36);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_PayDebitMemo = 0;

-- get information about the DebitMemo
   select   VendorID, IFNULL(Posted,0), IFNULL(Total,0), IFNULL(AmountPaid,0), IFNULL(BalanceDue,0), IFNULL(CurrencyID,N''), IFNULL(PurchaseDate,CURRENT_TIMESTAMP) INTO v_VendorID,v_DebitMemoPost,v_DebitMemoTotal,v_DebitMemoAmountPaid,v_DebitMemoBalance,
   v_DebitMemoCurrencyID,v_DebitMemoDate FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

-- verify if the DebitMemo can be used
-- only posted opened debit memo can be applied to payment
   IF ROW_COUNT() = 0 OR v_DebitMemoPost <> 1 OR ABS(v_DebitMemoTotal -v_DebitMemoAmountPaid) < 0.005 OR ABS(v_DebitMemoTotal) < 0.005 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

	-- get the information about the payment
   select   IFNULL(Paid,0), IFNULL(Posted,0), IFNULL(Amount,0), IFNULL(CreditAmount,IFNULL(Amount,0)), IFNULL(CurrencyID,N''), CurrencyExchangeRate, CheckNumber, PaymentDate INTO v_PaymentPaid,v_PaymentPost,v_PaymentAmount,v_PaymentCreditAmount,v_PaymentCurrencyID,
   v_CurrencyExchangeRate,v_PaymentCheckNumber,v_PaymentCheckDate FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;

   SET v_PaymentCreditAmount = v_PaymentCreditAmount;
-- verify if the Payment can be used
   IF v_PaymentPost <> 1 OR  ABS(v_PaymentCreditAmount) < 0.005  OR v_PaymentPaid = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

-- verify if the DebitMemo and the Payment are in the same currency
   IF v_DebitMemoCurrencyID <> v_PaymentCurrencyID then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   SET v_PayDebitMemo = v_Amount;
-- get the total amount of money the Payments has to transfer
   IF v_PayDebitMemo > v_PaymentCreditAmount then
      SET v_PayDebitMemo = v_PaymentCreditAmount;
   end if;
-- if the amount is greater that the DebitMemo needs to be totally paid get only
-- the amount needed to pay the DebitMemo
   IF v_PayDebitMemo > v_DebitMemoTotal -v_DebitMemoAmountPaid then

      SET v_PayDebitMemo = v_DebitMemoTotal -v_DebitMemoAmountPaid;
      SET v_Result = 1;
   ELSE
      SET v_Result = 0;
   end if;


   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL DebitMemoApplyToPayment_CreateGLTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentID,v_PayDebitMemo, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'DebitMemoApplyToPayment_CreateGLTransaction call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_ApplyToPayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;

-- Payment is not fully offset
-- we should create new payment for the rest of amount
   if v_PaymentCreditAmount > v_PayDebitMemo then

      UPDATE
      PaymentsHeader
      SET
      CreditAmount = v_PaymentCreditAmount -v_PayDebitMemo,PaymentDate = CURRENT_TIMESTAMP
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PaymentID = v_PaymentID;
   ELSE
	-- Update Payment
      UPDATE
      PaymentsHeader
      SET
      CreditAmount = 0,PaymentDate = CURRENT_TIMESTAMP,Paid = 1
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PaymentID = v_PaymentID;
   end if;

   SET v_DebitMemoRest = v_DebitMemoTotal -v_PayDebitMemo -v_DebitMemoAmountPaid;

   SET @SWV_Error = 0;
   UPDATE
   PurchaseHeader
   SET
   AmountPaid = v_PayDebitMemo+v_DebitMemoAmountPaid,BalanceDue = v_DebitMemoRest,
   CheckNumber = v_PaymentCheckNumber,CheckDate = v_PaymentCheckDate,
   PaymentID = v_PaymentID
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;


   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update PurchaseHeader failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_ApplyToPayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;	
-- insert into receipts detail getting data from the orer details
   SET @SWV_Error = 0;
   INSERT INTO PaymentsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	PaymentID,
	PayedID,
	DocumentNumber,
	DocumentDate,
	DiscountTaken,
	WriteOffAmount,
	AppliedAmount,
	Cleared,
	GLExpenseAccount)
   SELECT
   CompanyID,
		DivisionID,
		DepartmentID,
		v_PaymentID,
		v_VendorID,
		CONCAT('DM#',v_PurchaseNumber),
		v_DebitMemoDate,
		0,
		0,
		v_PayDebitMemo,
		NULL,
		GLPurchaseAccount
   FROM
   PurchaseDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber  = v_PurchaseNumber;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into PaymentsDetail failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_ApplyToPayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_ApplyToPayment',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);

   SET SWP_Ret_Value = -1;
END;































//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS DebitMemoApplyToPayment_CreateGLTransaction2;
//
CREATE                      PROCEDURE DebitMemoApplyToPayment_CreateGLTransaction2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),
	v_DebitMemoAmount DECIMAL(19,4),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

















/*
Name of stored procedure: DebitMemoApplyToPayment_CreateGLTransaction
Method: 
	Makes all needed records in the General Ledger related with applying debit memo to Payment

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36)	 - the ID of the debit memo

Output Parameters:

	NONE

Called From:

	DebitMemo_ApplyToPayment

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
   DECLARE v_ConvertedDebitMemoAmount DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_ConvertedTotal DECIMAL(19,4);
   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_GLCashAccount NATIONAL VARCHAR(36);
   DECLARE v_GLAPAccount NATIONAL VARCHAR(36);
   DECLARE v_GLARAccount NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(36);
   DECLARE v_PostCOA BOOLEAN;
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_Posted BOOLEAN;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;




-- get the information about the Vendor, Currency and the ammount of money
   select   IFNULL(Posted,0), IFNULL(CreditAmount,0), VendorID, CurrencyID, IFNULL(PaymentDate,CURRENT_TIMESTAMP), CurrencyExchangeRate INTO v_Posted,v_Amount,v_VendorID,v_CurrencyID,v_PaymentDate,v_CurrencyExchangeRate FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;


   IF v_Amount = 0 or v_DebitMemoAmount = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF v_Amount < v_DebitMemoAmount then

      SET v_ErrorMessage = 'Debit memo amount can''t be greater then payment amount';
      ROLLBACK;
-- the error handler


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemoApplyToPayment_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;

-- get the GL Account Information from the Companies Table
   select   GLARAccount, GLAPAccount, IFNULL(DefaultGLPostingDate,'1') INTO v_GLARAccount,v_GLAPAccount,v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


-- Get currency exhange rate for the debit memo
   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
-- the error handler


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemoApplyToPayment_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;


   SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
   SET v_ConvertedDebitMemoAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DebitMemoAmount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);


   select   ProjectID INTO v_ProjectID FROM
   PaymentsDetail WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID AND
   Not ProjectID IS NULL;


-- get the transaction number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
-- the error handler


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemoApplyToPayment_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PaymentID);
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
		'DM Check',
		CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE v_PaymentDate END,
		v_VendorID,
		v_PaymentID,
		v_CurrencyID,
		v_CurrencyExchangeRate,
		v_ConvertedDebitMemoAmount,
		0,
		1,
		0,
		CONCAT('DM Check ', cast(v_PaymentID as char(10))),
		1,
		1);


   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
      ROLLBACK;
-- the error handler


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemoApplyToPayment_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;



-- Credit @ConvertedDebitMemoAmount to  Account Receivable
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
		v_GLARAccount,
		0,
		v_ConvertedDebitMemoAmount,
		v_ProjectID);

-- Debit	@ConvertedDebitMemoAmount to Account Payable

   SET @SWV_Error = 0;
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
	v_ConvertedDebitMemoAmount,
	0,
	v_ProjectID);




   IF @SWV_Error <> 0 then
-- An error occured , drop the temporary table and 
-- go to the error handler

      SET v_ErrorMessage = 'Error Processing Data';
      ROLLBACK;
-- the error handler


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemoApplyToPayment_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PaymentID);
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


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemoApplyToPayment_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PaymentID);
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


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemoApplyToPayment_CreateGLTransaction',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PaymentID);

   SET SWP_Ret_Value = -1;
END;
















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS DebitMemo_CopyToHistory2;
//
CREATE              PROCEDURE DebitMemo_CopyToHistory2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


























/*
Name of stored procedure: DebitMemo_CopyToHistory
Method: 
	Copies specified debit memo record to History table

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36)	 - the ID of debit memo that should be copied to history table

Output Parameters:

	NONE

Called From:

	DebitMemo_CopyAllToHistory, DebitMemo_CopyToHistory.vb

Calls:

	Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);




   DECLARE v_Memorize BOOLEAN;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
        GET DIAGNOSTICS CONDITION 1
         @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
         SELECT @p1, @p2;
       SET @SWV_Error = 1;
   END;
   select   Memorize INTO v_Memorize FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber
   AND ABS(IFNULL(BalanceDue,0)) < 0.005
   AND ABS(IFNULL(PurchaseHeader.Total,0)) >= 0.005
   AND LOWER(IFNULL(PurchaseHeader.TransactionTypeID,N'')) = 'debit memo';
   IF ROW_COUNT() = 0 then

      SET SWP_Ret_Value = -2;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   IF NOT Exists(SELECT PurchaseNumber
   FROM PurchaseHeaderHistory
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber) then

      SET @SWV_Error = 0;
      INSERT INTO
      PurchaseDetailHistory(CompanyID,
		DivisionID,
		DepartmentID,
		PurchaseNumber, 
		-- [PurchaseLineNumber], 
		ItemID,
		VendorItemID,
		Description,
		WarehouseID,
		WarehouseBinID,
		SerialNumber,
		OrderQty,
		ItemUOM,
		ItemWeight,
		DiscountPerc,
		Taxable,
		ItemCost,
		CurrencyID,
		CurrencyExchangeRate,
		ItemUnitPrice,
		Total,
		TotalWeight,
		GLPurchaseAccount,
		ProjectID,
		Received,
		ReceivedDate,
		ReceivedQty,
		RecivingNumber,
		TrackingNumber,
		DetailMemo1,
		DetailMemo2,
		DetailMemo3,
		DetailMemo4,
		DetailMemo5,
		TaxGroupID,
		TaxAmount,
		TaxPercent,
		SubTotal)
      SELECT
      CompanyID,
		DivisionID,
		DepartmentID,
		PurchaseNumber, 
		-- [PurchaseLineNumber], 
		ItemID,
		VendorItemID,
		Description,
		WarehouseID,
		WarehouseBinID,
		SerialNumber,
		OrderQty,
		ItemUOM,
		ItemWeight,
		DiscountPerc,
		Taxable,
		ItemCost,
		CurrencyID,
		CurrencyExchangeRate,
		ItemUnitPrice,
		Total,
		TotalWeight,
		GLPurchaseAccount,
		ProjectID,
		Received,
		ReceivedDate,
		ReceivedQty,
		RecivingNumber,
		TrackingNumber,
		DetailMemo1,
		DetailMemo2,
		DetailMemo3,
		DetailMemo4,
		DetailMemo5,
		TaxGroupID,
		TaxAmount,
		TaxPercent,
		SubTotal
      FROM
      PurchaseDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber = v_PurchaseNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into PurchaseDetailHistory failed';
         ROLLBACK;
-- the error handler


         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      INSERT INTO
      PurchaseHeaderHistory
      SELECT * FROM
      PurchaseHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber = v_PurchaseNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into PurchaselHistory failed';
         ROLLBACK;
-- the error handler


         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF IFNULL(v_Memorize,0) <> 1 then
	
      SET @SWV_Error = 0;
      DELETE
      FROM
      PurchaseDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber = v_PurchaseNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from PurchaseDetail failed';
         ROLLBACK;
-- the error handler


         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      DELETE
      FROM
      PurchaseHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber = v_PurchaseNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from PurchaseHeader failed';
         ROLLBACK;
-- the error handler


         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
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


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CopyToHistory',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');

   SET SWP_Ret_Value = -1;
END;


































//

DELIMITER ;

update databaseinfo set value='2019_05_14',lastupdate=now() WHERE id='Version';
