DELIMITER //
DROP PROCEDURE IF EXISTS Invoice_DebitInventory;
//
CREATE  PROCEDURE Invoice_DebitInventory(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: Invoice_DebitInventory
Method:
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the ID of the Invoice
Output Parameters:
	NONE
Called From:
	Invoice_Post
Calls:
Last Modified:
Last Modified By:
Revision History:
*/
   DECLARE v_ReturnStatus INT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(250);
   DECLARE v_FlipBackInvoiceFlag BOOLEAN;
   DECLARE v_InvoiceLineNumber NUMERIC(18,0);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_QtyOnHand INT;
   DECLARE v_InvoiceQty FLOAT;
   DECLARE v_AvailableQty INT;
   DECLARE v_DifferenceQty INT;
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_SerialNumber NATIONAL VARCHAR(50);
   DECLARE v_Result INT;
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cInvoiceDetail CURSOR 
   FOR SELECT
   InvoiceLineNumber,
		ItemID,
		IFNULL(OrderQty,0),
		WarehouseID,
		WarehouseBinID,
		SerialNumber
   FROM
   InvoiceDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;
-- open the cursor and get the first row
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;
-- debit the inventory
-- set the flag for back Invoices to 0
   SET v_FlipBackInvoiceFlag = 0;
-- declare a cursor to iterate through the Invoice's items
   OPEN cInvoiceDetail;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_InvoiceQty,v_WarehouseID,v_WarehouseBinID, 
   v_SerialNumber;
   WHILE NO_DATA = 0 DO
      SET v_FlipBackInvoiceFlag = 0;
      SET v_DifferenceQty = 0;
      SET v_QtyOnHand = 0;
      SET v_AvailableQty = 0;
-- get the @WarehouseID for the Invoice
      SET @SWV_Error = 0;
      CALL Inventory_GetWarehouseForInvoiceItem(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_InvoiceLineNumber,
      v_WarehouseID,v_WarehouseBinID, v_ReturnStatus);
      IF @SWV_Error <> 0 OR  v_ReturnStatus = -1 then
	
         CLOSE cInvoiceDetail;
		
         SET v_ErrorMessage = 'Getting the WarehouseID failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      select   IFNULL(SUM(IFNULL(QtyOnHand,0)),0) INTO v_QtyOnHand FROM
      InventoryByWarehouse WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND WarehouseID = v_WarehouseID
      AND ItemID = v_ItemID;
      IF v_InvoiceQty > v_QtyOnHand then -- there is enough quantity in the warehouse
		
         SET v_AvailableQty = v_QtyOnHand;
         SET v_DifferenceQty = v_InvoiceQty -v_QtyOnHand;
		
			-- verify if the item is an assembly and if the assembly can be created
			-- from items existing in the warehouses
         SET @SWV_Error = 0;
         CALL Invoice_CreateAssembly(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_WarehouseID,v_DifferenceQty,
         v_Result, v_ReturnStatus);
			-- check for errors
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
            CLOSE cInvoiceDetail;
				
            -- NOT SUPPORTED Print CONCAT('ItemID: ',convert(CHAR(20),@ItemID),' InvoiceQty: ', convert(CHAR(20),@InvoiceQty))
SET v_ErrorMessage = 'Invoice_CreateAssembly call failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_InvoiceQty,v_WarehouseID,v_WarehouseBinID, 
      v_SerialNumber;
   END WHILE;
   CLOSE cInvoiceDetail;
   SET @SWV_Error = 0;
   CALL  InvoiceDetail_SplitToWarehouseBin2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,0,v_FlipBackInvoiceFlag, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'InvoiceDetail_SplitToWarehouseBin failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;
   IF v_FlipBackInvoiceFlag = 1 then

	
      SET v_ErrorMessage = 'The Invoice did not post: there is not enough staff in Inventory to cover the invoice';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;
-- open the cursor and get the first row
   OPEN cInvoiceDetail;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_InvoiceQty,v_WarehouseID,v_WarehouseBinID, 
   v_SerialNumber;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL SerialNumber_Get2(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
      v_SerialNumber,v_ItemID,NULL,NULL,v_InvoiceNumber,v_InvoiceLineNumber,
      v_InvoiceQty, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE cInvoiceDetail;
		
         SET v_ErrorMessage = 'SerialNumber_Get failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_InvoiceLineNumber,v_ItemID,v_InvoiceQty,v_WarehouseID,v_WarehouseBinID, 
      v_SerialNumber;
   END WHILE;
   CLOSE cInvoiceDetail;

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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_DebitInventory',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoceNumber',v_InvoiceNumber);
   SET SWP_Ret_Value = -1;
END;

//
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS LedgerTransactions_PostCOA_AllRecords2;
//
CREATE     PROCEDURE LedgerTransactions_PostCOA_AllRecords2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLTransNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN
/*
Name of stored procedure: LedgerTransactions_PostCOA_AllRecords
Method:
	Stored procedure used to update the LegderChart of Accounts after the insert of a tansaction;
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@GLTransNumber NVARCHAR(36)	 - used to identify the transaction
Output Parameters:
	NONE
Called From:
	Payment_CreateGLTransaction, PaymentCheck_CreateGLTransaction, Receiving_CreateGLTransaction, ReceiptCash_CreateGLTransaction, CreditMemo_CreateGLTransaction, Bank_CreateGLTransaction, ReturnInvoice_CreateGLTransaction, ReturnReceipt_CreateGLTransaction, Receipt_CreateGLTransaction, ReceiptCash_Return_CreateGLTransaction, Purchase_DebitMemoPost, ServiceReceipt_CreateGLTransaction, InventoryAdjustments_CreateGLTransaction, ServiceInvoice_CreateGLTransaction, RMAReceiving_CreateGLTransaction, Invoice_CreateGLTransaction, FixedAssetDepreciation_CreateGLTransaction, FixedAssetDisposal_CreateGLTransaction, DebitMemo_CreateGLTransaction
Calls:
	LedgerMain_PostCOA, Error_InsertError, Error_InsertErrorDetail
Last Modified:
Last Modified By:
Revision History:
*/
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_GLTransactionAccount NATIONAL VARCHAR(36);
   DECLARE v_GLTransactionDate DATETIME;
   DECLARE v_GLDebitAmount DECIMAL(19,4);
   DECLARE v_GLCreditAmount DECIMAL(19,4);
   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);
   DECLARE v_PostCOA BOOLEAN;
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE C CURSOR FOR
   SELECT
   LedgerTransactionsDetail.GLTransactionAccount,
		LedgerTransactions.GLTransactionDate,
		LedgerTransactionsDetail.GLDebitAmount,
		LedgerTransactionsDetail.GLCreditAmount,
		LedgerTransactions.GLTransactionNumber
   FROM
   LedgerTransactions
   INNER JOIN LedgerTransactionsDetail ON
   LedgerTransactions.CompanyID = LedgerTransactionsDetail.CompanyID AND
   LedgerTransactions.DivisionID = LedgerTransactionsDetail.DivisionID AND
   LedgerTransactions.DepartmentID = LedgerTransactionsDetail.DepartmentID AND
   LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
   WHERE
   LedgerTransactions.CompanyID = v_CompanyID AND
   LedgerTransactions.DivisionID = v_DivisionID AND
   LedgerTransactions.DepartmentID = v_DepartmentID AND
   LedgerTransactions.GLTransactionNumber = v_GLTransNumber;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   START TRANSACTION;
   OPEN C;
-- looping through the recordset
   SET NO_DATA = 0;
   FETCH C INTO v_GLTransactionAccount,v_GLTransactionDate,v_GLDebitAmount,v_GLCreditAmount, 
   v_GLTransactionNumber;
   WHILE NO_DATA = 0 DO
	-- ledger post COA
      CALL LedgerMain_PostCOA(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionAccount,v_GLTransactionDate,
      v_GLDebitAmount,v_GLCreditAmount,v_PostCOA, v_ReturnStatus);
      IF v_PostCOA = 0 OR v_ReturnStatus = -1 then
	
		-- An error occured, go to the error handler
         CLOSE C;
		
         SET v_ErrorMessage = 'LedgerMain_PostCOA call failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_PostCOA_AllRecords',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
         v_GLTransactionNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH C INTO v_GLTransactionAccount,v_GLTransactionDate,v_GLDebitAmount,v_GLCreditAmount, 
      v_GLTransactionNumber;
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
-- the error handler
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_PostCOA_AllRecords',
   v_ErrorMessage,v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
   v_GLTransactionNumber);
   SET SWP_Ret_Value = -1;
END;

//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS LedgerMain_PostCOA;
//
CREATE   PROCEDURE LedgerMain_PostCOA(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLAccountNumber NATIONAL VARCHAR(36),
	v_TranDate DATETIME,
	v_DebitAmount DECIMAL(19,4),
	v_CreditAmount DECIMAL(19,4),
	INOUT v_PostCOA BOOLEAN  ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN










/*
Name of stored procedure: LedgerMain_PostCOA
Method: 
	This stored procedure is used to make a post into the ledger charts of acounts
	updates the ammounts from LedgerChartOfAccounts after the insert of a transaction that involves the account @GLAccountNumber

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@GLAccountNumber NVARCHAR(36)	 - the parameters above are used to identify the Account
	@TranDate datetime		 - the date of GL transaction
	@DebitAmount money		 - the debit money amount
	@CreditAmount money		 - the credit money

Output Parameters:

	@PostCOA BIT  			 - returns the posting status

							   1 - success

							   0 - an error occured in the stored procedure

Called From:

	LedgerTransactions_PostCOA_AllRecords, LedgerTransactions_PostPayment, LedgerTransactions_PostManual, LedgerTransactions_PostCOA, LedgerMain_PostCOA.vb

Calls:

	LedgerMain_VerifyPeriod, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/


/*
The output parameter = @PostCOA
updates the ammounts from LedgerChartOfAccounts after the insert of a transaction that involves the account @GLAccountNumber
*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_TransactionAmount DECIMAL(19,4);
   DECLARE v_GLBalanceType NATIONAL VARCHAR(36);
   DECLARE v_SQLString NATIONAL VARCHAR(2000);


/* Get the GL Balance Type from the chart of accounts so we know how to post to the ledger */
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   UPPER(GLBalanceType) INTO v_GLBalanceType FROM
   LedgerChartOfAccounts WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLAccountNumber = v_GLAccountNumber;


   SET v_PostCOA = 1;

   START TRANSACTION;
/*  Set the Proper Balance in the system,
All accounts in the system are coded with a balance type, so the system knows how to properly apply the balances to the accounts.
Here is how this is done:
*/

   Set v_TransactionAmount = CASE

	/* ASSET */
	-- When Applying a CREDIT to an ASSET account, the amount DECREASES
   When IFNULL(v_CreditAmount,0) <> 0  AND v_GLBalanceType = 'ASSET'  THEN 0 -v_CreditAmount
	-- When Applying a DEBIT to an ASSET account, the amount INCREASE
   When IFNULL(v_DebitAmount,0) <> 0  AND v_GLBalanceType = 'ASSET'  THEN v_DebitAmount

	/* LIABILITY */
	-- When Applying a CREDIT to a LIABILITY account, the amount INCREASES
   When IFNULL(v_CreditAmount,0) <> 0  AND v_GLBalanceType = 'LIABILITY'  THEN v_CreditAmount
	-- When Applying a DEBIT to a LIABILITY account, the amount DECREASES
   When IFNULL(v_DebitAmount,0) <> 0  AND v_GLBalanceType = 'LIABILITY'  THEN 0 -v_DebitAmount

	/* EQUITY */
	-- When Applying a CREDIT to an EQUITY account, the amount INCREASES
   When IFNULL(v_CreditAmount,0) <> 0  AND v_GLBalanceType = 'EQUITY'  THEN v_CreditAmount
	-- When Applying a DEBIT to an EQUITY account, the amount DECREASES
   When IFNULL(v_DebitAmount,0) <> 0  AND v_GLBalanceType = 'EQUITY'  THEN 0 -v_DebitAmount

	/* INCOME */
	-- When Applying a CREDIT to an INCOME account, the amount INCREASES
   When IFNULL(v_CreditAmount,0) <> 0  AND v_GLBalanceType = 'INCOME'  THEN v_CreditAmount
	-- When Applying a DEBIT to an INCOME account, the amount DECREASES
   When IFNULL(v_DebitAmount,0) <> 0  AND v_GLBalanceType = 'INCOME'  THEN 0 -v_DebitAmount

	/* EXPENSE */
	-- When Applying a CREDIT to an EXPENSE account, the amount DECREASES
   When IFNULL(v_CreditAmount,0) <> 0  AND v_GLBalanceType = 'EXPENSE'  THEN 0 -v_CreditAmount
	-- When Applying a DEBIT to an EXPENSE account, the amount INCREASES
   When IFNULL(v_DebitAmount,0) <> 0  AND v_GLBalanceType = 'EXPENSE'  THEN v_DebitAmount

	/* ERROR CONDITION */
	-- This is just a catch all, you can replace this with error code or whatever other controls you wish , this condition should never fire
   ELSE v_DebitAmount
   END;

-- get the Period
   SET @SWV_Error = 0;
   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'LedgerMain_VerifyPeriod call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_PeriodClosed <> 0 then
-- the Period is closed, go to the error handler
-- and set the apropriate error message

      SET v_ErrorMessage = 'Period is closed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
      SET SWP_Ret_Value = -1;
   end if;

-- ok, we know what to do now, so post the amount to the proper account
   IF v_PeriodToPost >= 0 AND v_ReturnStatus = 0 then

      SET @SWV_Error = 0;
      UPDATE
      LedgerChartOfAccounts
      SET
      GLAccountBalance = IFNULL(GLAccountBalance,0)+IFNULL(v_TransactionAmount,0)
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND GLAccountNumber = v_GLAccountNumber;
      IF @SWV_Error <> 0 then
	-- An errror occured, go to error handler
	
         SET v_PostCOA = 0;
         SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
         SET SWP_Ret_Value = -1;
      end if;
      IF v_PeriodToPost = 0 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod1 = IFNULL(GLCurrentYearPeriod1,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then
		-- An errror occured, go to error handler
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 1 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod2 = IFNULL(GLCurrentYearPeriod2,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		-- An errror occured, go to error handler
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 2 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod3 = IFNULL(GLCurrentYearPeriod3,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		-- An errror occured, go to error handler
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 3 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod4 = IFNULL(GLCurrentYearPeriod4,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		-- An errror occured, go to error handler
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 4 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod5 = IFNULL(GLCurrentYearPeriod5,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		-- An errror occured, go to error handler
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 5 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod6 = IFNULL(GLCurrentYearPeriod6,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		-- An errror occured, go to error handler
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 6 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod7 = IFNULL(GLCurrentYearPeriod7,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		-- An errror occured, go to error handler
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 7 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod8 = IFNULL(GLCurrentYearPeriod8,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		-- An errror occured, go to error handler
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 8 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod9 = IFNULL(GLCurrentYearPeriod9,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		-- An errror occured, go to error handler
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 9 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod10 = IFNULL(GLCurrentYearPeriod10,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		-- An errror occured, go to error handler
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 10 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod11 = IFNULL(GLCurrentYearPeriod11,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		-- An errror occured, go to error handler
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 11 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod12 = IFNULL(GLCurrentYearPeriod12,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		-- An errror occured, go to error handler
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 12 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod13 = IFNULL(GLCurrentYearPeriod13,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		-- An errror occured, go to error handler
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 13 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod14 = IFNULL(GLCurrentYearPeriod14,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		-- An errror occured, go to error handler
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
   ELSE
      SET @SWV_Error = 0;
      UPDATE
      LedgerChartOfAccounts
      SET
      GLAccountBalance = IFNULL(GLAccountBalance,0)+IFNULL(v_TransactionAmount,0),GLAccountBeginningBalance =  IFNULL(GLAccountBeginningBalance,0)+IFNULL(v_TransactionAmount,0)
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND GLAccountNumber = v_GLAccountNumber;
      IF @SWV_Error <> 0 then 
		-- An errror occured, go to error handler
		
         SET v_PostCOA = 0;
         SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

-- everything is OK
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
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);

   SET SWP_Ret_Value = -1;
END;


//

DELIMITER ;


DELIMITER //
DROP PROCEDURE IF EXISTS Invoice_CreateGLTransaction;
//
CREATE                PROCEDURE Invoice_CreateGLTransaction(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	v_PostDate  NATIONAL VARCHAR(1),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: Invoice_CreateGLTransaction
Method:
	Creates a new GL transaction for the invoice
Date Created: EDE - 07/28/2015
Input Parameters:
	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the ID of the invoice
	@PostDate NVARCHAR(1)			 - indicates what date should be used as GL transaction date
							   0 - invoice date
							   1 - current date
Output Parameters:
	NONE
Called From:
	Invoice_Post
Calls:
	VerifyCurrency, GetNextEntityID, TaxGroup_GetTotalPercent, LedgerTransactions_PostCOA_AllRecords, Error_InsertError, Error_InsertErrorDetail
Last Modified:
Last Modified By:
Revision History:
*/
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_OrderNumber NATIONAL VARCHAR(36);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_ConvertedTotal DECIMAL(19,4);
   DECLARE v_DiscountAmount DECIMAL(19,4);
   DECLARE v_SalesAcctDefault BOOLEAN;
   DECLARE v_GLSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_GLInvoiceSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_SubTotal DECIMAL(19,4);
   DECLARE v_HeaderTaxAmount DECIMAL(19,4);
   DECLARE v_Freight DECIMAL(19,4);
   DECLARE v_Handling DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_InvoiceDate DATETIME;
   DECLARE v_GLARAccount NATIONAL VARCHAR(36);
   DECLARE v_TranDate DATETIME;
   DECLARE v_PostCoa BOOLEAN;
   DECLARE v_ItemTaxAmount DECIMAL(19,4);
   DECLARE v_GLARDiscountAccount NATIONAL VARCHAR(36);
   DECLARE v_GLItemSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_GLTaxAccount NATIONAL VARCHAR(36);
   DECLARE v_GLARFreightAccount NATIONAL VARCHAR(36);
   DECLARE v_GLARHandlingAccount NATIONAL VARCHAR(36);
   DECLARE v_GLItemInventoryAccount NATIONAL VARCHAR(36);
   DECLARE v_GLItemCOGSAccount NATIONAL VARCHAR(36);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_HeaderTaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_HeaderTaxPercent FLOAT;
-- get the ammount of money from the Invoice
   DECLARE v_ItemGLSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_ItemUnitPrice DECIMAL(19,4);
   DECLARE v_ItemProjectID NATIONAL VARCHAR(36);
   DECLARE v_ConvertedDiscountAmount DECIMAL(19,4);
   DECLARE v_TaxAccount NATIONAL VARCHAR(36);
   DECLARE v_TaxAmount DECIMAL(19,4);
   DECLARE v_TaxGroupID NATIONAL VARCHAR(36);
   DECLARE v_TotalTaxPercent FLOAT;
   DECLARE v_DefaultInventoryCostingMethod NATIONAL VARCHAR(1);
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_ErrorID INT;
   DECLARE v_TaxPercent FLOAT;
   DECLARE SWV_CurNum INT DEFAULT 0;
   DECLARE cInvoiceDetail CURSOR FOR
   SELECT
   GLSalesAccount,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(IFNULL(ItemUnitPrice,0)*IFNULL(OrderQty,0)), 
   v_CompanyCurrencyID),
		ProjectID
   FROM
   InvoiceDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber AND
   IFNULL(SubTotal,0) > 0
   GROUP BY
   GLSalesAccount,ProjectID;
   DECLARE cInvoiceDetail2 CURSOR  FOR SELECT
   SUM(IFNULL(TaxAmount,0)),
		TaxGroupID,
		TaxPercent,
		ProjectID
		
   FROM
   InvoiceDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber AND
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
   select   OrderNumber, IFNULL(AmountPaid,0), IFNULL(Total,0), IFNULL(DiscountAmount,0), IFNULL(TaxPercent,0), IFNULL(TaxAmount,0), IFNULL(Freight,0), IFNULL(Subtotal,0), IFNULL(Handling,0), GLSalesAccount, TaxGroupID INTO v_OrderNumber,v_AmountPaid,v_Total,v_DiscountAmount,v_HeaderTaxPercent,
   v_HeaderTaxAmount,v_Freight,v_SubTotal,v_Handling,v_GLInvoiceSalesAccount,
   v_HeaderTaxGroupID FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;
   SET v_GLInvoiceSalesAccount = IFNULL(v_GLInvoiceSalesAccount,(SELECT GLARSalesAccount
   FROM Companies
   WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID));
   START TRANSACTION;
/*
a temporary table used to collect information about the details of the Transaction;
at the end, the record from this table will be grouped by the GLTransactionAccount and inserted into the LedgerTransactionsDetail
*/
   CREATE TEMPORARY TABLE tt_LedgerDetailTmp  
   (
      GLTransactionNumberDetail BIGINT NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
      GLTransactionAccount NATIONAL VARCHAR(36),
      GLDebitAmount DECIMAL(19,4),
      GLCreditAmount DECIMAL(19,4),
      ProjectID NATIONAL VARCHAR(36)
   )  AUTO_INCREMENT = 1;
   select   CurrencyID, CurrencyExchangeRate, InvoiceDate INTO v_CurrencyID,v_CurrencyExchangeRate,v_InvoiceDate FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;
   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
   SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
   select   ProjectID INTO v_ProjectID FROM  InvoiceDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber
   AND NOT ProjectID IS NULL   LIMIT 1;
-- get the transaction number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- Insert into LedgerTransactions
-- first calculate the Transaction date
   select   CASE v_PostDate WHEN '1' THEN CURRENT_TIMESTAMP ELSE InvoiceDate END INTO v_TranDate FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;
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
		CASE TransactionTypeID WHEN 'Service Invoice' THEN 'SERINV' ELSE 'Invoice' END ,
		v_TranDate,
		CustomerID,
		InvoiceNumber,
		v_CompanyCurrencyID,
		1,
		v_ConvertedTotal,
		0,
		0,
		1,
		CONCAT('INV ',cast(v_InvoiceNumber as char(10))),
		1
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'Insert into LedgerTransactions failed2';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- Get Company Account Receivable
   select   GLARAccount INTO v_GLARAccount FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
-- Debit @Total to Account Receivable
   IF v_Total > 0 then

      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(v_GLARAccount,
		v_ConvertedTotal,
		0,
		v_ProjectID);
	
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	-- and drop the temporary table
	
         SET v_ErrorMessage = 'Error Processing AR Data';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;
-- Define default AR Sales Account,
-- it will be used if detail Sales Account is undefined
   IF v_GLInvoiceSalesAccount IS NULL then

      select   GLARSalesAccount INTO v_GLInvoiceSalesAccount FROM
      Companies WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID;
   end if;
-- Credit Subtotal to AR Sales Account
-- Different detail items can have different Sales Account
-- So we will collect this information scanning all invoice detail items
   IF SWV_CurNum = 0 THEN
      OPEN cInvoiceDetail;
   ELSE
      OPEN cInvoiceDetail2;
   END IF;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_ItemGLSalesAccount,v_ItemUnitPrice,v_ItemProjectID;
   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(IFNULL(v_ItemGLSalesAccount,v_GLInvoiceSalesAccount),
		0,
		fnRound(v_CompanyID, v_DivisionID, v_DepartmentID, v_ItemUnitPrice*v_CurrencyExchangeRate, v_CompanyCurrencyID),
		v_ItemProjectID);
	
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	
         IF SWV_CurNum = 0 THEN
            CLOSE cInvoiceDetail;
         ELSE
            CLOSE cInvoiceDetail2;
         END IF;
		
         SET v_ErrorMessage = 'Update InvoiceDetail failed';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_ItemGLSalesAccount,v_ItemUnitPrice,v_ItemProjectID;
   END WHILE;
   IF SWV_CurNum = 0 THEN
      CLOSE cInvoiceDetail;
   ELSE
      CLOSE cInvoiceDetail2;
   END IF;

   SET v_ConvertedDiscountAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_DiscountAmount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
   SET @SWV_Error = 0;
   IF v_DiscountAmount > 0 then

      select   GLARDiscountAccount INTO v_GLARDiscountAccount FROM
      Companies WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
	-- Debit DiscountAmount From GLARDiscountAccount
      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(v_GLARDiscountAccount,
		v_ConvertedDiscountAmount,
		0,
		v_ProjectID);
	
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	-- and drop the temporary table
	
         SET v_ErrorMessage = 'Error Processing Discount GL Data';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'Error Processing Discount Data';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- insert the record for @TaxAmount
-- we will redistribute @TaxAmount between different GLTaxAccounts included to Invoice tax group
   IF SWV_CurNum = 0 THEN
      OPEN cInvoiceDetail;
   ELSE
      OPEN cInvoiceDetail2;
   END IF;
   SET NO_DATA = 0;
   FETCH cInvoiceDetail INTO v_TaxAmount,v_TaxGroupID,v_TotalTaxPercent,v_ItemProjectID;
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
	
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
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

		-- Credit Tax to Tax Account
            SET @SWV_Error = 0;
            INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(v_GLTaxAccount,
		0,
		v_ItemTaxAmount,
		v_ItemProjectID);
	
            IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	-- and drop the temporary table
	
               SET v_ErrorMessage = 'Error Processing Tax Data';
               CLOSE cTax;
		
               ROLLBACK;
               DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
               IF v_ErrorMessage <> '' then

	-- the error handler
	
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
                  v_ErrorMessage,v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
               end if;
               SET SWP_Ret_Value = -1;
            end if;
            SET NO_DATA = 0;
            FETCH cTax INTO v_TaxPercent,v_GLTaxAccount;
         END WHILE;
         CLOSE cTax;
      end if;
      SET NO_DATA = 0;
      FETCH cInvoiceDetail INTO v_TaxAmount,v_TaxGroupID,v_TotalTaxPercent,v_ItemProjectID;
   END WHILE;
   IF SWV_CurNum = 0 THEN
      CLOSE cInvoiceDetail;
   ELSE
      CLOSE cInvoiceDetail2;
   END IF;

-- insert the record for @Freight
   IF v_Freight > 0 then

	-- Get AR Freight Account
      select   GLARFreightAccount INTO v_GLARFreightAccount FROM
      Companies WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
	-- Credit Freight to AR Freight Account
      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(v_GLARFreightAccount,
		0,
		fnRound(v_CompanyID, v_DivisionID , v_DepartmentID,v_Freight*v_CurrencyExchangeRate, v_CompanyCurrencyID),
		v_ProjectID);
	
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	-- and drop the temporary table
	
         SET v_ErrorMessage = 'Error Processing Freight Data';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;
-- insert the record for @Handling
   IF v_Handling > 0 then

	-- Get AR Handling Account
      select   GLARHandlingAccount INTO v_GLARHandlingAccount FROM
      Companies WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET v_Handling = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Handling*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID);
	-- Credit Handling from AR Handling Account
      SET @SWV_Error = 0;
      INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
		GLDebitAmount,
		GLCreditAmount,
		ProjectID)
	VALUES(v_GLARHandlingAccount,
		0,
		v_Handling,
		v_ProjectID);
	
      IF @SWV_Error <> 0 then
	-- An error occured, go to the error handler
	-- and drop the temporary table
	
         SET v_ErrorMessage = 'Error Processing Handling Data';
         ROLLBACK;
         DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
         IF v_ErrorMessage <> '' then

	-- the error handler
	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;
   select   IFNULL(DefaultInventoryCostingMethod,'F') INTO v_DefaultInventoryCostingMethod FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
-- Credit invetory cost to GLItemInventoryAccount
   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   IFNULL(GLItemInventoryAccount,(SELECT GLARInventoryAccount
      FROM Companies
      WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID)),
	0,
	SUM(OrderQty*CASE(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN IFNULL(FIFOCost,0)
   WHEN 'L' THEN IFNULL(LIFOCost,0)
   WHEN 'A' THEN IFNULL(AverageCost,0)
   ELSE 0 END)
   WHEN 0 THEN IFNULL(ItemCost,0)
   ELSE(CASE(v_DefaultInventoryCostingMethod)
      WHEN 'F' THEN IFNULL(FIFOCost,0)
      WHEN 'L' THEN IFNULL(LIFOCost,0)
      WHEN 'A' THEN IFNULL(AverageCost,0)
      ELSE 0 END) END),
	InvoiceDetail.ProjectID
   FROM
   InvoiceDetail, InventoryItems
   WHERE
   InvoiceDetail.CompanyID = InventoryItems.CompanyID
   AND InvoiceDetail.DivisionID = InventoryItems.DivisionID
   AND InvoiceDetail.DepartmentID = InventoryItems.DepartmentID
   AND InventoryItems.ItemID =  InvoiceDetail.ItemID
   AND InvoiceDetail.CompanyID = v_CompanyID
   AND InvoiceDetail.DivisionID = v_DivisionID
   AND InvoiceDetail.DepartmentID = v_DepartmentID
   AND InvoiceDetail.InvoiceNumber = v_InvoiceNumber
   AND(CASE(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN IFNULL(FIFOCost,0)
   WHEN 'L' THEN IFNULL(LIFOCost,0)
   WHEN 'A' THEN IFNULL(AverageCost,0)
   ELSE 0 END)
   WHEN 0 THEN IFNULL(ItemCost,0)
   ELSE(CASE(v_DefaultInventoryCostingMethod)
      WHEN 'F' THEN IFNULL(FIFOCost,0)
      WHEN 'L' THEN IFNULL(LIFOCost,0)
      WHEN 'A' THEN IFNULL(AverageCost,0)
      ELSE 0 END) END) > 0
   GROUP BY
   GLItemInventoryAccount,InvoiceDetail.ProjectID;
	
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler
-- and drop the temporary table	

      SET v_ErrorMessage = 'Error Processing Inventory Data';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;
-- Debit inventory cost to COGS Accout
   SET @SWV_Error = 0;
   INSERT INTO tt_LedgerDetailTmp(GLTransactionAccount,
	GLDebitAmount,
	GLCreditAmount,
	ProjectID)
   SELECT
   IFNULL(GLItemCOGSAccount,(SELECT GLARCOGSAccount
      FROM Companies
      WHERE CompanyID = v_CompanyID AND DivisionID  = v_DivisionID AND  DepartmentID = v_DepartmentID)),
	SUM(OrderQty*CASE(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN IFNULL(FIFOCost,0)
   WHEN 'L' THEN IFNULL(LIFOCost,0)
   WHEN 'A' THEN IFNULL(AverageCost,0)
   ELSE 0 END)
   WHEN 0 THEN IFNULL(ItemCost,0)
   ELSE(CASE(v_DefaultInventoryCostingMethod)
      WHEN 'F' THEN IFNULL(FIFOCost,0)
      WHEN 'L' THEN IFNULL(LIFOCost,0)
      WHEN 'A' THEN IFNULL(AverageCost,0)
      ELSE 0 END) END),
	0,
	InvoiceDetail.ProjectID
   FROM
   InvoiceDetail, InventoryItems
   WHERE
   InvoiceDetail.CompanyID = InventoryItems.CompanyID
   AND InvoiceDetail.DivisionID = InventoryItems.DivisionID
   AND InvoiceDetail.DepartmentID = InventoryItems.DepartmentID
   AND InventoryItems.ItemID =  InvoiceDetail.ItemID
   AND InvoiceDetail.CompanyID = v_CompanyID
   AND InvoiceDetail.DivisionID = v_DivisionID
   AND InvoiceDetail.DepartmentID = v_DepartmentID
   AND InvoiceDetail.InvoiceNumber = v_InvoiceNumber
   AND(CASE(CASE(v_DefaultInventoryCostingMethod)
   WHEN 'F' THEN IFNULL(FIFOCost,0)
   WHEN 'L' THEN IFNULL(LIFOCost,0)
   WHEN 'A' THEN IFNULL(AverageCost,0)
   ELSE 0 END)
   WHEN 0 THEN IFNULL(ItemCost,0)
   ELSE(CASE(v_DefaultInventoryCostingMethod)
      WHEN 'F' THEN IFNULL(FIFOCost,0)
      WHEN 'L' THEN IFNULL(LIFOCost,0)
      WHEN 'A' THEN IFNULL(AverageCost,0)
      ELSE 0 END) END) > 0
   GROUP BY
   GLItemCOGSAccount,InvoiceDetail.ProjectID;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'Error Processing COGS Data';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
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
	SUM(IFNULL(GLDebitAmount,0)),
	SUM(IFNULL(GLCreditAmount,0)) ,
	ProjectID
   FROM
   tt_LedgerDetailTmp
   GROUP BY
   ProjectID,GLTransactionAccount;
   IF @SWV_Error <> 0 then
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'Insert into LedgerTransactionDetail failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
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
   CALL LedgerTransactions_PostCOA_AllRecords2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
-- An error occured, go to the error handler
-- and drop the temporary table

      SET v_ErrorMessage = 'LedgerTransactions_PostCOA_AllRecords call failed';
      ROLLBACK;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	-- the error handler
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
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
	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CreateGLTransaction',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
   end if;
   SET SWP_Ret_Value = -1;
END;




//

DELIMITER ;
