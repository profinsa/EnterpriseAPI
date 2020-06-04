CREATE PROCEDURE ServiceInvoice_Post2 (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36) ,
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN





   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Rest DECIMAL(19,4);
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_TranDate DATETIME;
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_InvoiceType NATIONAL VARCHAR(36);
   DECLARE v_BankKey NATIONAL VARCHAR(36);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_TotalAmount DECIMAL(19,4);
   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_ConvertedTotalAmount DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_CustomerSalesAcct NATIONAL VARCHAR(36);
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_DefaultInventoryCostingMethod CHAR(1);
   DECLARE v_InventoryCost DECIMAL(19,4);

   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty NATIONAL VARCHAR(36);
   DECLARE v_ItemUnitPrice DECIMAL(19,4);
   DECLARE v_ItemCost DECIMAL(19,4);
   DECLARE v_ItemCurrencyID NATIONAL VARCHAR(3); 
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ItemCurrencyExchangeRate FLOAT;
   DECLARE v_InvoiceDate DATETIME;
   DECLARE v_ID CHAR(180);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_PaymentMethodID NATIONAL VARCHAR(36);
   DECLARE v_ReceiptID NATIONAL VARCHAR(36);
   DECLARE v_Cleared BOOLEAN;
   DECLARE v_Success BOOLEAN;
   DECLARE v_ErrorID INT;
   DECLARE v_CreditMemoNumber NATIONAL VARCHAR(36);
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT * FROM
   InvoiceDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber) then

      SET v_PostingResult = 'Service Invoice was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT * FROM
   InvoiceDetail
   WHERE
   IFNULL(OrderQty,0) = 0 AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber) then

      SET v_PostingResult = 'Service Invoice was not posted: there is the detail item with undefined Order Qty value';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   select   Posted INTO v_Posted FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;
	

   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;




   select   IFNULL(TransactionTypeID,N''), IFNULL(AmountPaid,0), IFNULL(Total,0), CurrencyID, CurrencyExchangeRate, InvoiceDate, IFNULL(GLSalesAccount,N''), IFNULL(GLSalesAccount,N''), CustomerID, IFNULL(PaymentMethodID,N''), CASE CreditCardApprovalNumber
   WHEN NULL THEN 0
   ELSE 1
   END INTO v_InvoiceType,v_Amount,v_TotalAmount,v_CurrencyID,v_CurrencyExchangeRate,
   v_InvoiceDate,v_CustomerSalesAcct,v_BankKey,v_CustomerID,v_PaymentMethodID,
   v_Cleared FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   select   ProjectID INTO v_ProjectID FROM InvoiceDetail WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber AND
   NOT ProjectID IS NULL   LIMIT 1;


   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;




   IF v_PostDate = '1' then
      SET v_TranDate = CURRENT_TIMESTAMP;
   ELSE
      select   IFNULL(InvoiceDate,CURRENT_TIMESTAMP) INTO v_TranDate FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND InvoiceNumber = v_InvoiceNumber;
   end if;


   SET @SWV_Error = 0;
   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


      SET v_ErrorMessage = 'LedgerMain_VerifyPeriod call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_PeriodClosed <> 0 then



      SET v_ErrorMessage = 'Period is closed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   CALL Invoice_AdjustCustomerFinancials(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


      SET v_ErrorMessage = 'Invoice_AdjustCustomerFinancials call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   CALL Invoice_CustomerFinancialsUpdateAging(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


      SET v_ErrorMessage = 'Invoice_CustomerFinancialsUpdateAging call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


   select   IFNULL(Total,0) -IFNULL(AmountPaid,0) INTO v_Rest FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   IF ABS(v_Rest) > 0.005 then

      IF v_Rest < 0 then
	
		
	
		
         SET v_Rest = -v_Rest; 
         SET @SWV_Error = 0;
         SET v_ReturnStatus = CreditMemo_CreateFromInvoice2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_Rest,v_CreditMemoNumber);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
		
            SET v_ErrorMessage = 'CreditMemo_CreateFromInvoice call failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
         SET @SWV_Error = 0;
         SET v_ReturnStatus = CreditMemo_Post2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CreditMemoNumber,v_PostingResult);
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
		
            SET v_ErrorMessage = 'CreditMemo_Post call failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
   end if;


	


   SET @SWV_Error = 0;
   CALL ServiceInvoice_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


      SET v_ErrorMessage = 'Invoice_Recalc call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;




   SET @SWV_Error = 0;
   CALL ServiceInvoice_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_PostDate, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


      SET v_ErrorMessage = 'Invoice_CreateGLTransaction call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   UPDATE
   InvoiceHeader
   SET
   Posted = 1,PostedDate = CURRENT_TIMESTAMP
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;
   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'InvoiceHeader update failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;	



   SET @SWV_Error = 0;
   CALL ServiceReceipt_CreateFromInvoice2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_ReceiptID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Creating receipt from invoice failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   IF IFNULL(v_ReceiptID,N'') <> N'' then

	
	
      SET @SWV_Error = 0;
      SET v_ReturnStatus = ServiceReceipt_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptID,v_Success,v_PostingResult);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 OR  v_Success = 0 then
	
         SET v_ErrorMessage = 'Posting the receipt failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Post',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END