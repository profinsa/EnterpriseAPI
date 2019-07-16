CREATE PROCEDURE Invoice_Cancel (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN



















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_TranDate DATETIME;
   DECLARE v_PeriodToPost INT;
   DECLARE v_InvoiceType NATIONAL VARCHAR(36);
   DECLARE v_BankKey NATIONAL VARCHAR(36);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_TotalAmount DECIMAL(19,4);
   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_ConvertedTotalAmount DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_InvoiceDate DATETIME;
   DECLARE v_CustomerSalesAcct NATIONAL VARCHAR(36);
   DECLARE v_CurrentBalance DECIMAL(19,4);
   DECLARE v_ConvertedCurrentBalance DECIMAL(19,4);
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_DefaultInventoryCostingMethod CHAR(1);
   DECLARE v_InventoryCost DECIMAL(19,4);
   DECLARE v_ReceiptForInvoice NATIONAL VARCHAR(36);

   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_ItemUnitPrice DECIMAL(19,4);
   DECLARE v_ItemCost DECIMAL(19,4);
   DECLARE v_ItemCurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ItemCurrencyExchangeRate FLOAT;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_TransactionTypeID NATIONAL VARCHAR(36);
   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   Posted INTO v_Posted FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;
	

   IF v_Posted = 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;




   select   IFNULL(InvoiceHeader.TransactionTypeID,N''), IFNULL(InvoiceHeader.AmountPaid,0), IFNULL(InvoiceHeader.Total,0), InvoiceHeader.CurrencyID, InvoiceHeader.CurrencyExchangeRate, InvoiceHeader.InvoiceDate, IFNULL(InvoiceHeader.GLSalesAccount,N''), IFNULL(InvoiceHeader.GLSalesAccount,N''), InvoiceHeader.CustomerID, InvoiceDetail.ProjectID, IFNULL(InvoiceHeader.TransactionTypeID,N'') INTO v_InvoiceType,v_Amount,v_TotalAmount,v_CurrencyID,v_CurrencyExchangeRate,
   v_InvoiceDate,v_CustomerSalesAcct,v_BankKey,v_CustomerID,v_ProjectID,
   v_TransactionTypeID FROM
   InvoiceHeader
   InvoiceHeader Inner Join InvoiceDetail
   ON
   InvoiceHeader.CompanyID = InvoiceDetail.CompanyID
   AND InvoiceHeader.DivisionID =  InvoiceDetail.DivisionID
   AND InvoiceHeader.DepartmentID =  InvoiceDetail.DepartmentID
   AND InvoiceHeader.InvoiceNumber = InvoiceDetail.InvoiceNumber WHERE
   InvoiceHeader.CompanyID = v_CompanyID
   AND InvoiceHeader.DivisionID = v_DivisionID
   AND InvoiceHeader.DepartmentID = v_DepartmentID
   AND InvoiceHeader.InvoiceNumber = v_InvoiceNumber;


   IF v_Amount = v_TotalAmount then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Cancel',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;



   SET v_ConvertedAmount = v_Amount*v_CurrencyExchangeRate;
   SET v_ConvertedTotalAmount = v_TotalAmount*v_CurrencyExchangeRate;



   select   GLTransactionNumber INTO v_GLTransactionNumber FROM
   LedgerTransactions WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   GLTransactionReference = v_InvoiceNumber AND
   IFNULL(Reversal,0) = 0;

   IF ROW_COUNT() > 0 then

      SET @SWV_Error = 0;
      SET v_ReturnStatus = LedgerTransactions_Reverse(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionNumber);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
	
         SET v_ErrorMessage = 'LedgerTransactions_Reverse call failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Cancel',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = Invoice_UndoAdjustInventory(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


      SET v_ErrorMessage = 'Invoice_UndoAdjustInventory call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Cancel',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   UPDATE
   InvoiceHeader
   SET
   Posted = 0,PostedDate = NULL
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;
   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'InvoiceHeader update failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Cancel',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;	

   SET @SWV_Error = 0;
   SET v_ReturnStatus = Invoice_UndoAdjustCustomerFinancials(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


      SET v_ErrorMessage = 'Invoice_UndoAdjustCustomerFinancials call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Cancel',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   IF UPPER(v_TransactionTypeID) <> 'RETURN' then

      SET @SWV_Error = 0;
      SET v_ReturnStatus = CustomerFinancials_ReCalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
	
         SET v_ErrorMessage = 'CustomerFinancials_Recalc call failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Cancel',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Cancel',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END