DELIMITER //
DROP PROCEDURE IF EXISTS Invoice_AdjustCustomerFinancials;
//
CREATE       PROCEDURE Invoice_AdjustCustomerFinancials(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN











/*
Name of stored procedure: Invoice_AdjustCustomerFinancials
Method: 
	We need to un-do the order postings, 
	First, minus the order total from the booked orders, and add the amount back onto the available credit.
	Also, check, if available credit > credit limit set in Customer Information table, then available credit = credit limit.
	Update the Invoices YTD Field, set InvoicesYTD = InvoicesYTD + This Invoice.

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR (36)	 - the Id of the invoice

Output Parameters:

	NONE

Called From:

	ServiceInvoice_Post, Invoice_Post

Calls:

	VerifyCurrency, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_CustomerID NATIONAL VARCHAR(50);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_InvoiceDate DATETIME;
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_ConvertedTotal DECIMAL(19,4);
   DECLARE v_CreditLimit DECIMAL(19,4);
   DECLARE v_AvailibleCredit DECIMAL(19,4);

-- select informations about the customer,
-- the total value of the order
-- the currency of the order and the exchange rate
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   CustomerID, Total, CurrencyID, CurrencyExchangeRate, InvoiceDate INTO v_CustomerID,v_Total,v_CurrencyID,v_CurrencyExchangeRate,v_InvoiceDate FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   START TRANSACTION;

-- adjust the system to for the multicurrency 
   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_AdjustCustomerFinancials',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'Number',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);



-- Update Available Credit
   select   IFNULL(CreditLimit,0) INTO v_CreditLimit FROM
   CustomerInformation WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;


   select   IFNULL(AvailibleCredit,0) INTO v_AvailibleCredit FROM
   CustomerFinancials WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;

-- check, if available credit > credit limit set in Customer Information table, then available credit = credit limit.
   SET v_AvailibleCredit = v_AvailibleCredit+v_ConvertedTotal;

   IF v_AvailibleCredit > v_CreditLimit then
      SET v_AvailibleCredit = v_CreditLimit;
   end if;


   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   AvailibleCredit = v_AvailibleCredit
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'customer financials updating failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_AdjustCustomerFinancials',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'Number',v_InvoiceNumber);
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

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_AdjustCustomerFinancials',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'Number',v_InvoiceNumber);

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

      SET v_ErrorMessage = 'Insert into LedgerTransactions failed';
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

DELIMITER //
DROP PROCEDURE IF EXISTS InvoiceDetail_SplitToWarehouseBin2;
//
CREATE   PROCEDURE InvoiceDetail_SplitToWarehouseBin2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	v_BackOrdered BOOLEAN,
	INOUT v_BackOrder BOOLEAN ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN











/*
Name of stored procedure: InvoiceDetail_SplitToWarehouseBin
Method: 
	this procedure split Invoice items to warehouse bins

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@InvoiceNumber NVARCHAR(36)	 - the Invoice numeber
	@BackInvoiceed BIT		 - backInvoiceed status of the Invoice

Output Parameters:

	@BackInvoice BIT 			 - backInvoiceed status of the Invoice

Called From:

	Return_Post, Invoice_Allocate, Invoice_Post

Calls:

	WarehouseBinLockGoods, Invoice_Recalc, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/



   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_InvoiceLineNumber NUMERIC(18,0);
   DECLARE v_PrevWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_PrevWarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_PrevQty FLOAT;
   DECLARE v_PrevBackInvoiceQty FLOAT;
   DECLARE v_Qty FLOAT;
   DECLARE v_AvlblQty FLOAT;
   DECLARE v_BackQty FLOAT;
   DECLARE v_First BOOLEAN;
   DECLARE SWV_cOD_CompanyID NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_DivisionID NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_DepartmentID NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_InvoiceNumber NATIONAL VARCHAR(36);
   DECLARE SWV_cOD_InvoiceLineNumber NUMERIC(18,0);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE Counter INT;
   DECLARE Records INT DEFAULT 0;
   DECLARE cOD CURSOR
   FOR SELECT 
   WarehouseID, WarehouseBinID, 
			InvoiceLineNumber, ItemID, IFNULL(OrderQty,0), IFNULL(BackOrderQty,0), CompanyID,DivisionID,DepartmentID,InvoiceNumber,InvoiceLineNumber
   FROM 
   InvoiceDetail
   WHERE	
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber
   AND IFNULL(BackOrdered,0) = IFNULL(v_BackOrdered,0);
	
	-- open the cursor and get the first row
/*   DECLARE cBins CURSOR
   FOR SELECT 
   WarehouseID, WarehouseBinID, Qty, AvlblQty, BackQty
   FROM 
   WarehouseBinsForSplit(v_CompanyID,v_DivisionID,v_DepartmentID,v_PrevWarehouseID,v_PrevWarehouseBinID, 
   v_ItemID,v_PrevQty);*/
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;

   SET @SWV_Error = 0;
   SET v_BackOrder = 0;

   START TRANSACTION;

   OPEN cOD;
   SET NO_DATA = 0;
   FETCH cOD INTO v_PrevWarehouseID,v_PrevWarehouseBinID,v_InvoiceLineNumber,v_ItemID,v_PrevQty, 
   v_PrevBackInvoiceQty,SWV_cOD_CompanyID,SWV_cOD_DivisionID,SWV_cOD_DepartmentID,
   SWV_cOD_InvoiceNumber,SWV_cOD_InvoiceLineNumber;
   WHILE NO_DATA = 0 DO
      SET v_First = 1;
      IF v_BackOrdered = 1 then
				
         SET @SWV_Error = 0;
         SET v_ReturnStatus = WarehouseBinLockGoods(v_CompanyID,v_DivisionID,v_DepartmentID,v_PrevWarehouseID,v_PrevWarehouseBinID,
         v_ItemID,0,v_PrevBackInvoiceQty,3);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
					
            CLOSE cOD;
						
            SET v_ErrorMessage = 'WarehouseBinLockGoods failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InvoiceDetail_SplitToWarehouseBin',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;

      
      -- OPEN cBins;
      SET NO_DATA = 0;
      -- FETCH cBins INTO v_WarehouseID,v_WarehouseBinID,v_Qty,v_AvlblQty,v_BackQty;
      SET Counter = WarehouseBinsForSplitCount(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty, 5);      
      WHILE NO_DATA = 0 DO
         IF v_BackQty > 0 then
						
            SET v_BackOrder = 1;
         end if;
         IF v_First = 1 then
						
            SET @SWV_Error = 0;
            UPDATE InvoiceDetail
            SET
            WarehouseID = v_WarehouseID,WarehouseBinID = v_WarehouseBinID,OrderQty = v_Qty,
            BackOrdered =
            CASE WHEN v_BackQty > 0 THEN 1
            ELSE 0 END,BackOrderQty = v_BackQty
            WHERE InvoiceDetail.CompanyID = SWV_cOD_CompanyID AND InvoiceDetail.DivisionID = SWV_cOD_DivisionID AND InvoiceDetail.DepartmentID = SWV_cOD_DepartmentID AND InvoiceDetail.InvoiceNumber = SWV_cOD_InvoiceNumber AND InvoiceDetail.InvoiceLineNumber = SWV_cOD_InvoiceLineNumber;
            IF @SWV_Error <> 0 then
							
               -- CLOSE cBins;
								
               CLOSE cOD;
								
               SET v_ErrorMessage = 'Updating Invoice detail failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InvoiceDetail_SplitToWarehouseBin',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
               SET SWP_Ret_Value = -1;
            end if;
            SET v_First = 0;
         ELSE
            SET @SWV_Error = 0;
            INSERT INTO InvoiceDetail(CompanyID,
								DivisionID,
								DepartmentID,
								InvoiceNumber,
								ItemID,
								WarehouseID,
								WarehouseBinID,
								SerialNumber,
								Description,
								OrderQty,
								BackOrdered,
								BackOrderQty,
								ItemUOM,
								ItemWeight,
								DiscountPerc,
								Taxable,
								ItemCost,
								ItemUnitPrice,
								Total,
								TotalWeight,
								GLSalesAccount,
								ProjectID,
								TrackingNumber,
								WarehouseBinZone,
								PalletLevel,
								CartonLevel,
								PackLevelA,
								PackLevelB,
								PackLevelC,
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
									InvoiceNumber,
									ItemID,
									v_WarehouseID,
									v_WarehouseBinID,
									SerialNumber,
									Description,
									v_Qty,
									CASE WHEN v_BackQty > 0 THEN 1
            ELSE 0 END,
									v_BackQty,
									ItemUOM,
									ItemWeight,
									DiscountPerc,
									Taxable,
									ItemCost,
									ItemUnitPrice,
									Total,
									TotalWeight,
									GLSalesAccount,
									ProjectID,
									TrackingNumber,
									WarehouseBinZone,
									PalletLevel,
									CartonLevel,
									PackLevelA,
									PackLevelB,
									PackLevelC,
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
            InvoiceDetail
            WHERE
            CompanyID = v_CompanyID
            AND DivisionID = v_DivisionID
            AND DepartmentID = v_DepartmentID
            AND InvoiceNumber = v_InvoiceNumber
            AND InvoiceLineNumber = v_InvoiceLineNumber;
            IF @SWV_Error <> 0 then
							-- An error occured, go to the error handler
							
               -- CLOSE cBins;
								
               CLOSE cOD;
								
               SET v_ErrorMessage = 'Insert into InvoiceDetail failed';
               ROLLBACK;
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InvoiceDetail_SplitToWarehouseBin',
               v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
         SET @SWV_Error = 0;
         SET v_ReturnStatus = WarehouseBinLockGoods(v_CompanyID,v_DivisionID,v_DepartmentID,v_WarehouseID,v_WarehouseBinID,
         v_ItemID,v_AvlblQty,v_BackQty,1);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
					
            CLOSE cOD;
						
            SET v_ErrorMessage = 'WarehouseBinLockGoods failed';
            ROLLBACK;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InvoiceDetail_SplitToWarehouseBin',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
	 
         SET Records = Records + 1;
	 CALL WarehouseBinsForSplitGetRecord(v_CompanyID, v_DivisionID, v_DepartmentID, v_PrevWarehouseID, v_PrevWarehouseBinID, v_ItemID, v_PrevQty, Records, @outIdent, v_WarehouseID, v_WarehouseBinID, v_Qty, v_AvlblQty, v_BackQty );
         IF Records = Counter then
						
            SET NO_DATA = 1;
         end if;
     	 -- FETCH cBins INTO v_WarehouseID,v_WarehouseBinID,v_Qty,v_AvlblQty,v_BackQty;
      END WHILE;
      -- CLOSE cBins;
			
      SET NO_DATA = 0;
      FETCH cOD INTO v_PrevWarehouseID,v_PrevWarehouseBinID,v_InvoiceLineNumber,v_ItemID,v_PrevQty, 
      v_PrevBackInvoiceQty,SWV_cOD_CompanyID,SWV_cOD_DivisionID,SWV_cOD_DepartmentID,
      SWV_cOD_InvoiceNumber,SWV_cOD_InvoiceLineNumber;
   END WHILE;
	
   CLOSE cOD;
	


   SET @SWV_Error = 0;
   CALL Invoice_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
      SET v_ErrorMessage = 'Recalculating the Invoice failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InvoiceDetail_SplitToWarehouseBin',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'InvoiceDetail_SplitToWarehouseBin',
   v_ErrorMessage,v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
	
   SET SWP_Ret_Value = -1;

END;

//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS WarehouseBinsForSplitCount;
DROP FUNCTION IF EXISTS WarehouseBinsForSplitCount;
//
CREATE FUNCTION WarehouseBinsForSplitCount(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WarehouseID NATIONAL VARCHAR(36),
	v_WarehouseBinID NATIONAL VARCHAR(36),
	v_InventoryItemID NATIONAL VARCHAR(36),
	v_Qty FLOAT) 
   RETURNS INT
BEGIN

   DECLARE Counter INT;
   DECLARE v_Ident INT;
   DECLARE v_QtyOnHand FLOAT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cBins CURSOR
   FOR SELECT 
   WarehouseID, WarehouseBinID, QtyOnHand
   FROM 
   tt_Ret;
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

   SELECT COUNT(*) Into Counter FROM tt_Ret;
   RETURN Counter;
END;


//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS WarehouseBinsForSplitGetRecord;
//
CREATE PROCEDURE WarehouseBinsForSplitGetRecord(v_CompanyID NATIONAL VARCHAR(36),
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
	) 
   SWL_return:
BEGIN

   DECLARE v_Ident INT;
   DECLARE v_QtyOnHand FLOAT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cBins CURSOR
   FOR SELECT 
   WarehouseID, WarehouseBinID, QtyOnHand
   FROM 
   tt_Ret;
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

END;


//

DELIMITER ;
