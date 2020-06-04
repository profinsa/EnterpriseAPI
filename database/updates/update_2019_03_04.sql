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
