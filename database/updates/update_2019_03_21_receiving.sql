DELIMITER //
DROP PROCEDURE IF EXISTS Receiving_Post2;
//
CREATE               PROCEDURE Receiving_Post2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	INOUT v_Success INT  ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: Receiving_Post
Method:
	Posts a receiving into the system
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36) - the puchase order
Output Parameters:
	@Success INT  			 - RETURN VALUES for the @Success output parameter:
							   1 succes
							   0 error while processin data
							   2 error on geting time Period
Called From:
	Receiving_Post.vb
Calls:
	Receiving_AdjustVendorFinancials, Receiving_UpdateInventoryCosting, Payment_CreateFromPurchase, Purchase_Recalc, Error_InsertError, LedgerMain_VerifyPeriod, Error_InsertErrorDetail, Receiving_AdjustInventory, Receiving_CreateGLTransaction
Last Modified:
Last Modified By:
Revision History:
*/

-- variables declarations
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_TranDate DATETIME;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_VendorID NATIONAL VARCHAR(50);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
GET DIAGNOSTICS CONDITION 1
         @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
 SELECT @p1, @p2;
      SET @SWV_Error = 1;
   END;
-- initialize the success flag of this procedure to 1 (which signifies succes)
-- If an error will occurre in the procedure this flag will be set to 0 or 2 (which signifies an error)
   SET @SWV_Error = 0;
   SET v_Success =  1;
   SET v_ErrorMessage = '';
-- get the current rule for post date for the company from the companies table
   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
-- begin the posting process
   IF v_PostDate = '1' then
	-- if the post Period is set to true
	-- the transaction date is the current date
      SET v_TranDate = CURRENT_TIMESTAMP;
   ELSE
	-- if the post Period is set to false
	-- the transaction date is the purchase date
      select   PurchaseDate INTO v_TranDate FROM
      PurchaseHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PurchaseNumber = v_PurchaseNumber;
   end if;
-- verify the Period of time the posting will take place
-- call a procedure (LedgerMain_VerifyPeriod) which will verify if the Period to post is closed or not
   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);
-- if the Period to post is closed the posted cannot be done and the procedure will return an error
   IF v_PeriodClosed <> 0 OR v_ReturnStatus = -1 then
	
-- We can come to this point only if the Period to post is closed the posted cannot be done
-- the goto operator is placed before BEGIN TRAN so we should not commit or rollback transaction here
      SET v_Success = 2;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   end if;
   START TRANSACTION;
-- recalc the purchase order
   SET v_ReturnStatus = Purchase_Recalc(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Purchase_Recalc call failed';
      ROLLBACK;
-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- get the information about the Vendor, Currency and the ammount of money from the purchase order
   select   IFNULL(AmountPaid,0), IFNULL(Total,0), VendorID INTO v_AmountPaid,v_Total,v_VendorID FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;
   UPDATE
   PurchaseDetail
   SET
   ReceivedQty = IFNULL(OrderQty,0),ReceivedDate = IFNULL(ReceivedDate,CURRENT_TIMESTAMP)
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;
-- debit the inventory from the OnOrder field, and credit OnHand field
   SET @SWV_Error = 0;
   CALL Receiving_AdjustInventory(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Receiving_AdjustInventory call failed';
      ROLLBACK;
-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- update inventory costing
   SET @SWV_Error = 0;
   CALL Receiving_UpdateInventoryCosting2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Receiving_UpdateInventoryCosting call failed';
      ROLLBACK;
-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- Adjust Vendor Finacials information
   SET @SWV_Error = 0;
   CALL Receiving_AdjustVendorFinancials(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Receiving_AdjustVendorFinancials call failed';
      ROLLBACK;
-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- if a payment was made for the order that is received this payment must be returned
-- and the vendor financials must be updated
   SET @SWV_Error = 0;
   CALL Payment_CreateFromPurchase(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;	
   UPDATE
   PurchaseHeader
   SET
   Received = 1,ReceivedDate = CURRENT_TIMESTAMP
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;
   UPDATE
   PurchaseDetail
   SET
   Received = 1
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;
-- get the transaction number
   SET @SWV_Error = 0;
   CALL Receiving_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_PostDate, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;

-- We can come to this point only if the Period to post is closed the posted cannot be done
-- the goto operator is placed before BEGIN TRAN so we should not commit or rollback transaction here
   SET v_Success = 2;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;
-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   ROLLBACK;
-- Change return status if it was not changed iside error checking procedure
   IF v_Success = 1 then

      SET v_Success = 0;
   end if;
-- Process error only if @ErrorMessage was set during error checking
   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
      v_PurchaseNumber);
   end if;
   SET SWP_Ret_Value = -1;
END;


//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Receiving_Post2;
//
CREATE               PROCEDURE Receiving_Post2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	INOUT v_Success INT  ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: Receiving_Post
Method:
	Posts a receiving into the system
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36) - the puchase order
Output Parameters:
	@Success INT  			 - RETURN VALUES for the @Success output parameter:
							   1 succes
							   0 error while processin data
							   2 error on geting time Period
Called From:
	Receiving_Post.vb
Calls:
	Receiving_AdjustVendorFinancials, Receiving_UpdateInventoryCosting, Payment_CreateFromPurchase, Purchase_Recalc, Error_InsertError, LedgerMain_VerifyPeriod, Error_InsertErrorDetail, Receiving_AdjustInventory, Receiving_CreateGLTransaction
Last Modified:
Last Modified By:
Revision History:
*/

-- variables declarations
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_TranDate DATETIME;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_VendorID NATIONAL VARCHAR(50);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
-- initialize the success flag of this procedure to 1 (which signifies succes)
-- If an error will occurre in the procedure this flag will be set to 0 or 2 (which signifies an error)
   SET @SWV_Error = 0;
   SET v_Success =  1;
   SET v_ErrorMessage = '';
-- get the current rule for post date for the company from the companies table
   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
-- begin the posting process
   IF v_PostDate = '1' then
	-- if the post Period is set to true
	-- the transaction date is the current date
      SET v_TranDate = CURRENT_TIMESTAMP;
   ELSE
	-- if the post Period is set to false
	-- the transaction date is the purchase date
      select   PurchaseDate INTO v_TranDate FROM
      PurchaseHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PurchaseNumber = v_PurchaseNumber;
   end if;
-- verify the Period of time the posting will take place
-- call a procedure (LedgerMain_VerifyPeriod) which will verify if the Period to post is closed or not
   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);
-- if the Period to post is closed the posted cannot be done and the procedure will return an error
   IF v_PeriodClosed <> 0 OR v_ReturnStatus = -1 then
	
-- We can come to this point only if the Period to post is closed the posted cannot be done
-- the goto operator is placed before BEGIN TRAN so we should not commit or rollback transaction here
      SET v_Success = 2;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   end if;
   START TRANSACTION;
-- recalc the purchase order
   SET v_ReturnStatus = Purchase_Recalc(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Purchase_Recalc call failed';
      ROLLBACK;
-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- get the information about the Vendor, Currency and the ammount of money from the purchase order
   select   IFNULL(AmountPaid,0), IFNULL(Total,0), VendorID INTO v_AmountPaid,v_Total,v_VendorID FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;
   UPDATE
   PurchaseDetail
   SET
   ReceivedQty = IFNULL(OrderQty,0),ReceivedDate = IFNULL(ReceivedDate,CURRENT_TIMESTAMP)
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;
-- debit the inventory from the OnOrder field, and credit OnHand field
   SET @SWV_Error = 0;
   CALL Receiving_AdjustInventory(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Receiving_AdjustInventory call failed';
      ROLLBACK;
-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- update inventory costing
   SET @SWV_Error = 0;
   CALL Receiving_UpdateInventoryCosting2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Receiving_UpdateInventoryCosting call failed';
      ROLLBACK;
-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- Adjust Vendor Finacials information
   SET @SWV_Error = 0;
   CALL Receiving_AdjustVendorFinancials(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'Receiving_AdjustVendorFinancials call failed';
      ROLLBACK;
-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- if a payment was made for the order that is received this payment must be returned
-- and the vendor financials must be updated
   SET @SWV_Error = 0;
   CALL Payment_CreateFromPurchase(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;	
   UPDATE
   PurchaseHeader
   SET
   Received = 1,ReceivedDate = CURRENT_TIMESTAMP
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;
   UPDATE
   PurchaseDetail
   SET
   Received = 1
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;
-- get the transaction number
   SET @SWV_Error = 0;
   CALL Receiving_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_PostDate, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
-- Change return status if it was not changed iside error checking procedure
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;
-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;

-- We can come to this point only if the Period to post is closed the posted cannot be done
-- the goto operator is placed before BEGIN TRAN so we should not commit or rollback transaction here
   SET v_Success = 2;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;
-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   ROLLBACK;
-- Change return status if it was not changed iside error checking procedure
   IF v_Success = 1 then

      SET v_Success = 0;
   end if;
-- Process error only if @ErrorMessage was set during error checking
   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
      v_PurchaseNumber);
   end if;
   SET SWP_Ret_Value = -1;
END;


//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Receiving_CreateGLTransaction;
//
CREATE                     PROCEDURE Receiving_CreateGLTransaction(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseOrderNumber NATIONAL VARCHAR(36),
	v_PostDate  NATIONAL VARCHAR(1),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN




















/*
Name of stored procedure: Receiving_CreateGLTransaction
Method: 
	Creates a new GL transaction from an receiving

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseOrderNumber NVARCHAR(36) - the purchase number
	@PostDate NVARCHAR(1)			 - defines the date of GL transaction

							   1 - current date id used

							   0 - purchase date is used

Output Parameters:

	NONE

Called From:

	Receiving_Post

Calls:

	VerifyCurrency, GetNextEntityID, TaxGroup_GetTotalPercent, LedgerTransactions_PostCOA_AllRecords, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_GLAPAccount NATIONAL VARCHAR(36);
   DECLARE v_InventoryAccount NATIONAL VARCHAR(36);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_Freight DECIMAL(19,4);
   DECLARE v_Handling DECIMAL(19,4);
   DECLARE v_DiscountAmount DECIMAL(19,4);
   DECLARE v_ConvertedTotal DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PurchaseDate DATETIME;

   DECLARE v_TranDate DATETIME;
   DECLARE v_HeaderTaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_HeaderTaxAmount DECIMAL(19,4);
   DECLARE v_HeaderTaxPercent FLOAT;
   DECLARE v_GLAPCOGSAccount NATIONAL VARCHAR(36);
   DECLARE v_GLAPInventoryAccount NATIONAL VARCHAR(36);
   DECLARE v_ItemTaxAmount DECIMAL(19,4);
-- get the information about the Vendor, Currency and the ammount of money from the purchase order

   DECLARE v_TaxAccount NATIONAL VARCHAR(36);
   DECLARE v_TaxAmount DECIMAL(19,4);
   DECLARE v_TaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_TotalTaxPercent FLOAT;
   DECLARE v_ItemProjectID NATIONAL VARCHAR(36);
   DECLARE v_GLTaxAccount NATIONAL VARCHAR(36);
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_ErrorID INT;
   DECLARE v_TaxPercent FLOAT;
   DECLARE cPurchaseDetail CURSOR FOR
   SELECT
   SUM(IFNULL(TaxAmount,0)),
		TaxGroupID,
		TaxPercent,
		ProjectID
		
   FROM
   PurchaseDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseOrderNumber AND 
   IFNULL(Total,0) > 0
   GROUP BY
   TaxGroupID,TaxPercent,ProjectID;

   DECLARE cTax CURSOR FOR
   SELECT 
   IFNULL(Taxes.TaxPercent,0), 
		IFNULL(Taxes.GLTaxAccount,(SELECT GLARMiscAccount
      FROM Companies
      WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID))
   FROM 
   TaxGroups
   INNER JOIN  TaxGroupDetail ON
   TaxGroupDetail.CompanyID = TaxGroups.CompanyID
   AND TaxGroupDetail.DivisionID = TaxGroups.DivisionID
   AND TaxGroupDetail.DepartmentID = TaxGroups.DepartmentID
   AND TaxGroupDetail.TaxGroupDetailID = TaxGroups.TaxGroupDetailID
   INNER JOIN  Taxes ON
   TaxGroupDetail.CompanyID = Taxes.CompanyID
   AND TaxGroupDetail.DivisionID = Taxes.DivisionID
   AND TaxGroupDetail.DepartmentID = Taxes.DepartmentID
   AND TaxGroupDetail.TaxID = Taxes.TaxID

   WHERE 
   TaxGroups.CompanyID = v_CompanyID
   AND TaxGroups.DivisionID = v_DivisionID
   AND TaxGroups.DepartmentID = v_DepartmentID
   AND TaxGroups.TaxGroupID = v_TaxGroupID;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   select   CurrencyID, CurrencyExchangeRate, PurchaseDate, IFNULL(AmountPaid,0), IFNULL(Total,0), IFNULL(Freight,0), IFNULL(Handling,0), IFNULL(DiscountAmount,0), GLPurchaseAccount, TaxGroupID, IFNULL(TaxAmount,0), IFNULL(TaxPercent,0), CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE PurchaseDate END INTO v_CurrencyID,v_CurrencyExchangeRate,v_PurchaseDate,v_AmountPaid,v_Total,
   v_Freight,v_Handling,v_DiscountAmount,v_InventoryAccount,v_HeaderTaxGroupID,
   v_HeaderTaxAmount,v_HeaderTaxPercent,v_TranDate FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseOrderNumber;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   select   ProjectID INTO v_ProjectID FROM  PurchaseDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseOrderNumber
   AND NOT ProjectID IS NULL   LIMIT 1;



-- get the transaction number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);

-- insert the necessary entries into LedgerTransactions table
-- set the transaction type to Receiving and the date to the current
-- date or to purchase date depending on the value of @PostDate
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
	GLTransactionBalance,
	GLTransactionPostedYN,
	GLTransactionSource,
	GLTransactionSystemGenerated)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_GLTransNumber,
		'Receiving',
		CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE PurchaseDate END ,
		VendorID,
		PurchaseNumber,
		v_CompanyCurrencyID,
		1,
		v_ConvertedTotal,
		0,
		0,
		1,
		CONCAT('REC ',cast(PurchaseNumber as char(10))),
		1
   FROM
   PurchaseHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseOrderNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert Header into LedgerTransactions failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

	
-- create temporary table to retain information about transaction details
-- This informations will be written into the LedgerTransactionDetail after some processing.
-- The temporary table definition contains the column's definitions and the informations
-- about primary key of the temporary table.
   CREATE TEMPORARY TABLE tt_LedgerDetailTmp  
   (
      GLTransactionNumberDetail BIGINT NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
      GLTransactionAccount NATIONAL VARCHAR(36),
      GLDebitAmount DECIMAL(19,4),
      GLCreditAmount DECIMAL(19,4),
      ProjectID NATIONAL VARCHAR(36)
   )  AUTO_INCREMENT = 1;

-- Get default company Accounts
   select   GLAPAccount, GLAPInventoryAccount, GLARCOGSAccount INTO v_GLAPAccount,v_GLAPInventoryAccount,v_GLAPCOGSAccount FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
	
   SET v_InventoryAccount = IFNULL(v_InventoryAccount,v_GLAPInventoryAccount);

-- Debit Freight to GLAPFreightAccount
   SET @SWV_Error = 0;
   IF v_Freight > 0 then

      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
      SELECT
      Companies.GLAPFreightAccount,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Freight*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID),
	0,
	v_ProjectID
      FROM
      Companies
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
   end if;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing Freight Data';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Debit Handling to GLAPHandlingAccount
   IF v_Handling > 0 then

      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
      SELECT
      GLAPHandlingAccount,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Handling*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID),
		0,
		v_ProjectID
      FROM
      Companies
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Error Processing Handling Data';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;

-- insert the record for @TaxAmount
-- we will redistribute @TaxAmount between different GLTaxAccounts included to Invoice tax group
   OPEN cPurchaseDetail;
   SET NO_DATA = 0;
   FETCH cPurchaseDetail INTO v_TaxAmount,v_TaxGroupID,v_TotalTaxPercent,v_ItemProjectID;
   WHILE NO_DATA = 0 DO
      IF v_TaxAmount > 0 then

         IF v_TaxGroupID = N'' then
		
            SET v_TaxGroupID = v_HeaderTaxGroupID;
            SET v_TotalTaxPercent = v_HeaderTaxPercent;
         end if;
         SET @SWV_Error = 0;
         CALL TaxGroup_GetTotalPercent(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxGroupID,v_TotalTaxPercent);
         IF @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'Procedure call TaxGroup_GetTotalPercent failed';
            ROLLBACK;
            DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
            IF v_ErrorMessage <> '' then

	-- the error handler
	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
            end if;
            SET SWP_Ret_Value = -1;
         end if;
         OPEN cTax;
         SET NO_DATA = 0;
         FETCH cTax INTO v_TaxPercent,v_GLTaxAccount;
         WHILE NO_DATA = 0 DO
            IF v_TotalTaxPercent <> 0 then
               SET v_ItemTaxAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxAmount*v_CurrencyExchangeRate*v_TaxPercent/v_TotalTaxPercent, 
               v_CompanyCurrencyID);
            ELSE
               SET v_ItemTaxAmount = 0;
            end if;

	-- Debit Tax to Tax Account
            SET @SWV_Error = 0;
            INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(v_GLTaxAccount,
		v_ItemTaxAmount,
		0,
		v_ProjectID);
	
            IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	-- and drop the temporary table
	
               SET v_ErrorMessage = 'Error Processing Tax Data';
               CLOSE cTax;
		
               ROLLBACK;
               DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
               IF v_ErrorMessage <> '' then

	-- the error handler
	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_CreateGLTransaction',
                  v_ErrorMessage,v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
               end if;
               SET SWP_Ret_Value = -1;
            end if;
            SET NO_DATA = 0;
            FETCH cTax INTO v_TaxPercent,v_GLTaxAccount;
         END WHILE;
         CLOSE cTax;
      end if;
      SET NO_DATA = 0;
      FETCH cPurchaseDetail INTO v_TaxAmount,v_TaxGroupID,v_TotalTaxPercent,v_ItemProjectID;
   END WHILE;
   CLOSE cPurchaseDetail;
   SET @SWV_Error = 0;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing Tax Update';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- Credit DiscountAmount to GLAPDiscountAccount
   IF v_DiscountAmount > 0 then

      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
      SELECT
      GLAPDiscountAccount,
		0,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DiscountAmount*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID),
		v_ProjectID
      FROM
      Companies
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Error Processing GL Discount Data';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;

-- Credit Total to Account Payable
   IF v_Total > 0 then

      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(v_GLAPAccount,
		0,
		v_ConvertedTotal,
		v_ProjectID);
	
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Error Processing AP Data';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;


-- Debit SubTotal To Inventory Account
-- Detail item can have different Inventroy Accounts,
-- so we post it as sum of detail Totals grouped by Account and ProjectID
   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   IFNULL(GLPurchaseAccount,v_InventoryAccount),
	SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SubTotal*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID)),
	0,
	ProjectID
   FROM
   PurchaseDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseOrderNumber AND
   IFNULL(SubTotal,0) > 0
   GROUP BY
   IFNULL(GLPurchaseAccount,v_InventoryAccount),ProjectID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Processing Inventory Data';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


-- insert the data into the LedgerTransactionsDetail table; 
-- the records are grouped by GLTransactionAccount and ProjectID
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
		SUM(GLDebitAmount),
		SUM(GLCreditAmount),
		ProjectID
   FROM
   tt_LedgerDetailTmp
   GROUP BY
   GLTransactionAccount,ProjectID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into LedgerTransactionsDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;

/*
update the information in the Ledger Chart of Accounts fro the accounts of the newly inserted transaction

parameters	@CompanyID NVARCHAR(36),
		@DivisionID NVARCHAR(36),
		@DepartmentID NVARCHAR(36),
		@GLTransNumber NVARCHAR (36)
		used to identify the TRANSACTION
		@PostCOA BIT - used in the process of creation of the transaction
*/
   SET @SWV_Error = 0;
   SET v_ReturnStatus = LedgerTransactions_PostCOA_AllRecords(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransNumber);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- Everything is  OK
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

   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;

   IF v_ErrorMessage <> '' then

	-- the error handler
	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseOrderNumber);
   end if;
   SET SWP_Ret_Value = -1;
END;



















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Payment_CreateFromPurchase;
//
CREATE              PROCEDURE Payment_CreateFromPurchase(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN



















/*
Name of stored procedure: Payment_CreateFromPurchase
Method: 
	Creates payment from purchase order

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36)	 - the number of purchase order

Output Parameters:

	NONE

Called From:

	Receiving_Post

Calls:

	GetNextEntityID, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_VendorID NATIONAL VARCHAR(36);
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_DocumentDate DATETIME;
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);
   DECLARE v_PaymentMethod NATIONAL VARCHAR(36);
   DECLARE v_PurchasePaid INT; -- 0 - not paid, 1- partially paid, 2 - full paid



   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   IFNULL(Total,0), IFNULL(AmountPaid,0), VendorID, IFNULL(PaymentDate,CURRENT_TIMESTAMP), IFNULL(PaymentDate,CURRENT_TIMESTAMP), PaymentMethodID, CASE WHEN ABS(IFNULL(AmountPaid,0)) <= 0.005 THEN 0 WHEN ABS(IFNULL(Total,0) -IFNULL(AmountPaid,0)) <= 0.005 THEN 2 ELSE 1 END INTO v_Total,v_AmountPaid,v_VendorID,v_PaymentDate,v_DocumentDate,v_PaymentMethod,
   v_PurchasePaid FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   START TRANSACTION;

-- get the payment number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextVoucherNumber',v_PaymentID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

   select   BankAccounts.GLBankAccount INTO v_GLBankAccount FROM
   Companies
   INNER JOIN
   BankAccounts
   ON
   Companies.CompanyID = BankAccounts.CompanyID AND
   Companies.DivisionID = BankAccounts.DivisionID AND
   Companies.DepartmentID = BankAccounts.DepartmentID AND
   Companies.BankAccount = BankAccounts.BankAccountNumber WHERE
   Companies.CompanyID = v_CompanyID AND
   Companies.DivisionID = v_DivisionID AND
   Companies.DepartmentID = v_DepartmentID;

-- Insert into Payment Header getting the information from the purchase order
-- First payment transaction is created for purchase total if purchase is not paid or for AmountPaid in other case
   SET @SWV_Error = 0;
   INSERT INTO PaymentsHeader(CompanyID,
	DivisionID,
	DepartmentID,
	PaymentID,
	PaymentTypeID,
	CheckNumber,
	VendorID,
	PaymentDate,
	Amount,
	UnAppliedAmount,
	PaymentStatus,
	CurrencyID,
	CurrencyExchangeRate,
	CreditAmount,
	Posted,
	Cleared,
	GLBankAccount,
	InvoiceNumber,
	DueToDate,
	PurchaseDate)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_PaymentID,
		CASE v_PurchasePaid WHEN 0 THEN 'Check' ELSE IFNULL(v_PaymentMethod,'Cash') END,
		CheckNumber,
		VendorID,
		CURRENT_TIMESTAMP,
		CASE v_PurchasePaid WHEN 0 THEN v_Total ELSE v_AmountPaid END,
		0,
		'Posted',
		CurrencyID,
		CurrencyExchangeRate,
		CASE v_PurchasePaid WHEN 0 THEN v_Total ELSE v_AmountPaid END,
		1,
		0,
		v_GLBankAccount,
		v_PurchaseNumber,
		PurchaseDueDate,
		PurchaseDate
   FROM
   PurchaseHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into PaymentsHeader failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_PurchasePaid = 0 OR v_PurchasePaid = 2 then

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
			v_PurchaseNumber,
			v_PaymentDate,
			DiscountPerc,
			0,
			Total,
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
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
   ELSE
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
			v_PurchaseNumber,
			v_PaymentDate,
			0,
			0,
			v_AmountPaid,
			NULL,
			GLPurchaseAccount
      FROM
      PurchaseHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber  = v_PurchaseNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into PaymentsDetail failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF v_PurchasePaid = 1 then -- partially paid purchase, we create 2nd payment for unpaid part here

-- get the payment number
      SET @SWV_Error = 0;
      CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextVoucherNumber',v_PaymentID, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'GetNextEntityID call failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;

-- Insert into Payment Header getting the information from the purchase order
      SET @SWV_Error = 0;
      INSERT INTO PaymentsHeader(CompanyID,
	DivisionID,
	DepartmentID,
	PaymentID,
	PaymentTypeID,
	CheckNumber,
	VendorID,
	PaymentDate,
	Amount,
	UnAppliedAmount,
	PaymentStatus,
	CurrencyID,
	CurrencyExchangeRate,
	CreditAmount,
	Posted,
	Cleared,
	GLBankAccount,
	InvoiceNumber,
	DueToDate,
	PurchaseDate)
      SELECT
      v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_PaymentID,
		'Check',
		CheckNumber,
		VendorID,
		CURRENT_TIMESTAMP,
		v_Total -v_AmountPaid,
		0,
		'Posted',
		CurrencyID,
		CurrencyExchangeRate,
		v_Total -v_AmountPaid,
		1,
		0,
		v_GLBankAccount,
		v_PurchaseNumber,
		PurchaseDueDate,
		PurchaseDate
      FROM
      PurchaseHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber = v_PurchaseNumber;
      IF @SWV_Error <> 0 then

         SET v_ErrorMessage = 'Insert into PaymentsHeader failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
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
			v_PurchaseNumber,
			v_PaymentDate,
			0,
			0,
			v_Total -v_AmountPaid,
			NULL,
			GLPurchaseAccount
      FROM
      PurchaseHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber  = v_PurchaseNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into PaymentsDetail failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END;








//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Receiving_AdjustVendorFinancials;
//
CREATE        PROCEDURE Receiving_AdjustVendorFinancials(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN











/*
Name of stored procedure: Receiving_AdjustVendorFinancials
Method: 
	We need to un-do the purchase order postings, 
	First, minus the order total from the booked purchase orders, 
	and add the amount back onto the available credit. 
	Also, check, if available credit > credit limit set in Vendor Information table, then available credit = credit limit.

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR (36)	 - the purchase numeber

Output Parameters:

	NONE

Called From:

	Receiving_Post

Calls:

	VerifyCurrency, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_VendorID NATIONAL VARCHAR(50);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PurchaseDate DATETIME;
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_ConvertedTotal DECIMAL(19,4);
   DECLARE v_CreditLimit DECIMAL(19,4);
   DECLARE v_AvailableCredit DECIMAL(19,4);

-- select informations about the customer,
-- the total value of the order
-- the currency of the order and the exchange rate
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   VendorID, Total, CurrencyID, CurrencyExchangeRate, PurchaseDate INTO v_VendorID,v_Total,v_CurrencyID,v_CurrencyExchangeRate,v_PurchaseDate FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   START TRANSACTION;

-- adjust the system to for the multicurrency 
   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_AdjustVendorFinancials',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);



-- Upfate Available Credit

   select   IFNULL(CreditLimit,0) INTO v_CreditLimit FROM
   VendorInformation WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID;


   select   IFNULL(AvailableCredit,0) INTO v_AvailableCredit FROM
   VendorFinancials WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID;

-- check, if available credit > credit limit set in Vendor Information table, then available credit = credit limit.
   SET v_AvailableCredit = v_AvailableCredit+v_ConvertedTotal;

   IF v_AvailableCredit > v_CreditLimit then
      SET v_AvailableCredit = v_CreditLimit;
   end if;


   SET @SWV_Error = 0;
   UPDATE
   VendorFinancials
   SET
   AvailableCredit = v_AvailableCredit,BookedPurchaseOrders = IFNULL(BookedPurchaseOrders,0) -v_ConvertedTotal,PurchaseYTD = IFNULL(PurchaseYTD,0)+v_ConvertedTotal,
   PurchaseLifetime = IFNULL(PurchaseLifetime,0)+v_ConvertedTotal,
   LastPurchaseDate = v_PurchaseDate
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'vendor financials updating failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_AdjustVendorFinancials',
      v_ErrorMessage,v_ErrorID);
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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_AdjustVendorFinancials',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END;



















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Receiving_UpdateInventoryCosting2;
//
CREATE         PROCEDURE Receiving_UpdateInventoryCosting2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: Receiving_UpdateInventoryCosting
Method: 
	updates the inventory item cost after extracting items from warehouse

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36)	 - the purchase number

Output Parameters:

	NONE

Called From:

	Receiving_Post, RMAReceiving_Post

Calls:

	VerifyCurrency, Inventory_CreateILTransaction, Inventory_Costing, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_ReceivedQty FLOAT;
   DECLARE v_OrderQty FLOAT;
   DECLARE v_ItemUnitPrice DECIMAL(19,4);
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_ConvertedItemUnitPrice DECIMAL(19,4);
   DECLARE v_LastCost DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PurchaseDate DATETIME;
   DECLARE v_PurchaseLineNumber NUMERIC(18,0);
   DECLARE v_Result INT;

   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_ErrorID INT;
   DECLARE C CURSOR FOR 
   SELECT  
   PurchaseLineNumber,
		ItemID, 
		IFNULL(ReceivedQty,0),
		IFNULL(OrderQty,0),
		IFNULL(ItemUnitPrice,0), 
		IFNULL(WarehouseID,N'')
   FROM  
   PurchaseDetail
   WHERE 
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber AND
   IFNULL(Received,0) = 0;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   select   CurrencyID, CurrencyExchangeRate, PurchaseDate INTO v_CurrencyID,v_CurrencyExchangeRate,v_PurchaseDate FROM
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
-- Process error only if @ErrorMessage was set during error checking
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_UpdateInventoryCosting',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

-- declare a cursor for puchase details
   OPEN C;

-- looping through the PurchaseDetail

   SET NO_DATA = 0;
   FETCH C INTO v_PurchaseLineNumber,v_ItemID,v_ReceivedQty,v_OrderQty,v_ItemUnitPrice, 
   v_WarehouseID;
   WHILE NO_DATA = 0 DO
	-- get the currency for the item unit price
      SET v_ConvertedItemUnitPrice = v_ItemUnitPrice*v_CurrencyExchangeRate;
      SET @SWV_Error = 0;
      CALL Inventory_CreateILTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,v_ItemID,'Purchase',
      v_PurchaseNumber,v_PurchaseLineNumber,v_ReceivedQty,v_ConvertedItemUnitPrice, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         CLOSE C;
		
         SET v_ErrorMessage = 'Inventory_CreateILTransaction call failed';
         ROLLBACK;
-- Process error only if @ErrorMessage was set during error checking
         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_UpdateInventoryCosting',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
	
	-- update the cost of the items
      SET @SWV_Error = 0;
      CALL Inventory_Costing2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_WarehouseID,v_ReceivedQty,
      v_ConvertedItemUnitPrice,1,v_Result, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_Result <> 1 OR v_ReturnStatus = -1 then
	-- An error occured, go to the error handler
	
         CLOSE C;
		
         SET v_ErrorMessage = 'Inventory_Costing call failed';
         ROLLBACK;
-- Process error only if @ErrorMessage was set during error checking
         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_UpdateInventoryCosting',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH C INTO v_PurchaseLineNumber,v_ItemID,v_ReceivedQty,v_OrderQty,v_ItemUnitPrice, 
      v_WarehouseID;
   END WHILE;
   CLOSE C;


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
-- Process error only if @ErrorMessage was set during error checking
   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_UpdateInventoryCosting',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
   end if;
   SET SWP_Ret_Value = -1;
END;



//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Receiving_AdjustInventory;
//
CREATE         PROCEDURE Receiving_AdjustInventory(v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN







/*
Name of stored procedure: Receiving_AdjustInventory
Method: 
	this procedure we adjusts the inventory to show that the goods are received and in inventory. 
	We already credited the On Order amount when the purchase order was processed, 
	now we are going to debit the inventory from the On Order field and credit the On Hand field. 
	Remember this is done by item by warehouse

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PurchaseNumber NVARCHAR(36)	 - the purchase number

Output Parameters:

	NONE

Called From:

	Receiving_Post, RMAReceiving_Post

Calls:

	Inventory_GetWarehouseForPurchase, WarehouseBinPutGoods, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_ReturnStatus INT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(250);
   DECLARE v_InvoiceLineNumber INT; 
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty INT;
   DECLARE v_BackOrderQty INT;
   DECLARE v_IsOverflow BOOLEAN;
   DECLARE v_PurchaseLineNumber NUMERIC(18,0);
   DECLARE v_SerialNumber NATIONAL VARCHAR(50);
   DECLARE v_ReceivedDate DATETIME;

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE C CURSOR FOR 
   SELECT  
   ItemID, 
		IFNULL(OrderQty,0),
		IFNULL(WarehouseID,v_PurchaseWarehouseID),
		WarehouseBinID,
		PurchaseLineNumber,
		SerialNumber,
		ReceivedDate
   FROM  
   PurchaseDetail
   WHERE 
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber AND
   IFNULL(Received,0) = 0;	
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;


-- get the @WarehouseID for the purchase order
   SET @SWV_Error = 0;
   CALL Inventory_GetWarehouseForPurchase2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_PurchaseWarehouseID, v_ReturnStatus); 
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Getting the WarehouseID failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PurchaseAdjustInventory',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

-- declare a cursor for puchase details
   OPEN C;

-- looping through the PurchaseDetail

   SET NO_DATA = 0;
   FETCH C INTO v_ItemID,v_OrderQty,v_WarehouseID,v_WarehouseBinID,v_PurchaseLineNumber, 
   v_SerialNumber,v_ReceivedDate;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL WarehouseBinPutGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
      v_ItemID,v_PurchaseNumber,v_PurchaseLineNumber,v_SerialNumber,v_ReceivedDate,
      v_OrderQty,2,v_IsOverflow, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE C;
		
         SET v_ErrorMessage = 'WarehouseBinPutGoods failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PurchaseAdjustInventory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH C INTO v_ItemID,v_OrderQty,v_WarehouseID,v_WarehouseBinID,v_PurchaseLineNumber, 
      v_SerialNumber,v_ReceivedDate;
   END WHILE;
   CLOSE C;


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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PurchaseAdjustInventory',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END;

















//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS Inventory_Costing2;
//
CREATE     PROCEDURE Inventory_Costing2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_ReceivedQty INT,
	v_ItemUnitPrice DECIMAL(19,4),
	v_Mode INT,
	INOUT v_Result INT  ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


/*
Name of stored procedure: Inventory_Costing
Method: 
	calculeates inventory item costing (FIFOValue, AvarageValue, LIFOValue) 
	when the items are received from the vendor

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@ItemID NVARCHAR(36)		 - the ID of the item
	@WarehouseID NVARCHAR(36)	 - warehause ID
	@ReceivedQty INT		 - quantity received in inventory
	@ItemUnitPrice MONEY		 - unit cost for received items

Output Parameters:

	@Result INT  			 - Return values (@Result)

							   1	the operation completed successfuly

							   0	there was a database error in processing the request

Called From:

	Inventory_Assemblies, Receiving_UpdateInventoryCosting

Calls:

	VerifyCurrency, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_FIFOValue DECIMAL(19,4);
   DECLARE v_LIFOValue DECIMAL(19,4);
   DECLARE v_AverageValue DECIMAL(19,4);
   DECLARE v_ConvertedItemUnitPrice DECIMAL(19,4);
   DECLARE v_TotalItemQuantity INT;
   DECLARE v_QtyOnHand INT;
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_InventoryCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_InventoryExchangeRate FLOAT;

   DECLARE v_ExchangeRateDate DATETIME;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_Result = 1;


-- the items are added to the inventory
-- according to the costing  method

   START TRANSACTION;

   SET v_ExchangeRateDate = CURRENT_TIMESTAMP;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ExchangeRateDate,0,v_CompanyCurrencyID,
   v_InventoryCurrencyID,v_InventoryExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
-- the error handler
      SET v_Result = 0;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Costing',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyReceived',v_ReceivedQty);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemUnitCost',v_ItemUnitPrice);
      SET SWP_Ret_Value = -1;
   end if;
   SET v_ConvertedItemUnitPrice = v_ItemUnitPrice; -- -- * @InventoryExchangeRate--(1 / @InventoryExchangeRate)

   select   IFNULL(SUM(IFNULL(QtyOnHand,0)),0) INTO v_QtyOnHand FROM
   InventoryByWarehouse WHERE
   InventoryByWarehouse.CompanyID = v_CompanyID AND
   InventoryByWarehouse.DivisionID = v_DivisionID AND
   InventoryByWarehouse.DepartmentID = v_DepartmentID AND
   InventoryByWarehouse.ItemID = v_ItemID AND
   InventoryByWarehouse.WarehouseID = v_WarehouseID;

   select   IFNULL(AverageValue,0), IFNULL(LIFOValue,0) INTO v_AverageValue,v_LIFOValue FROM
   InventoryItems WHERE
   InventoryItems.CompanyID = v_CompanyID AND
   InventoryItems.DivisionID = v_DivisionID AND
   InventoryItems.DepartmentID = v_DepartmentID AND
   InventoryItems.ItemID = v_ItemID;

   IF ROW_COUNT() > 0 then

	-- if the ItemUnitPrice from the purchase is > 0 then some changes will be made in the 
	-- ItemInventory and InventoryByWarehouse tables 
      IF v_ConvertedItemUnitPrice > 0 then
	
         IF v_Mode = 1 then
			
            SET v_QtyOnHand = v_QtyOnHand -v_ReceivedQty;
         end if;
         IF v_QtyOnHand < 0 then
		
            SET v_QtyOnHand = 0;
         end if;
         IF v_QtyOnHand+v_ReceivedQty > 0 then
		
            SET v_AverageValue = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_AverageValue*v_QtyOnHand+v_ConvertedItemUnitPrice*v_ReceivedQty)/(v_QtyOnHand+v_ReceivedQty), 
            v_CompanyCurrencyID);
         ELSE
            SET v_AverageValue = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ConvertedItemUnitPrice,v_CompanyCurrencyID);
         end if;
         SET v_ConvertedItemUnitPrice = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ConvertedItemUnitPrice,v_CompanyCurrencyID);
         IF v_QtyOnHand = 0 OR v_LIFOValue = 0 then
		
            SET v_LIFOValue = v_ConvertedItemUnitPrice;
         end if;

		-- update the LIFOValue, FIFOValue and the average Value
         SET @SWV_Error = 0;
         UPDATE
         InventoryItems
         SET
         LIFOValue = v_LIFOValue,AverageValue = v_AverageValue,FIFOValue = v_ConvertedItemUnitPrice
         WHERE
         InventoryItems.CompanyID = v_CompanyID AND
         InventoryItems.DivisionID = v_DivisionID AND
         InventoryItems.DepartmentID = v_DepartmentID AND
         InventoryItems.ItemID = v_ItemID;
         IF @SWV_Error <> 0 then
		
            SET v_ErrorMessage = 'Update InventoryItems failed';
            ROLLBACK;
-- the error handler
            SET v_Result = 0;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Costing',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyReceived',v_ReceivedQty);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemUnitCost',v_ItemUnitPrice);
            SET SWP_Ret_Value = -1;
         end if;
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
   SET v_Result = 0;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Inventory_Costing',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemID',v_ItemID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'QtyReceived',v_ReceivedQty);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ItemUnitCost',v_ItemUnitPrice);

   SET SWP_Ret_Value = -1;
END;



//

DELIMITER ;
