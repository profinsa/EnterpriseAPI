CREATE PROCEDURE Payment_CreateFromRMA (v_CompanyID NATIONAL VARCHAR(36)
	,v_DivisionID NATIONAL VARCHAR(36)
	,v_DepartmentID NATIONAL VARCHAR(36)
	,v_PurchaseNumber NATIONAL VARCHAR(36)
	,INOUT v_NewPaymentID NATIONAL VARCHAR(36) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN


   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_PaymentTotal DECIMAL(19,4);
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_DocumentDate DATETIME;
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   IFNULL(Total,0) -IFNULL(AmountPaid,0), VendorID, IFNULL(PaymentDate,CURRENT_TIMESTAMP), IFNULL(PaymentDate,CURRENT_TIMESTAMP) INTO v_PaymentTotal,v_CustomerID,v_PaymentDate,v_DocumentDate FROM PurchaseHeader WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   START TRANSACTION;


   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextVoucherNumber',v_PaymentID, v_ReturnStatus);

   IF @SWV_Error <> 0
   OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromRMA',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

   select   BankAccounts.GLBankAccount INTO v_GLBankAccount FROM Companies
   INNER JOIN BankAccounts ON Companies.CompanyID = BankAccounts.CompanyID
   AND Companies.DivisionID = BankAccounts.DivisionID
   AND Companies.DepartmentID = BankAccounts.DepartmentID WHERE Companies.CompanyID = v_CompanyID
   AND Companies.DivisionID = v_DivisionID
   AND Companies.DepartmentID = v_DepartmentID;


   SET @SWV_Error = 0;
   INSERT INTO PaymentsHeader(CompanyID
	,DivisionID
	,DepartmentID
	,PaymentID
	,PaymentTypeID
	,CheckNumber
	,VendorID
	,PaymentDate
	,Amount
	,UnAppliedAmount
	,PaymentStatus
	,CurrencyID
	,CurrencyExchangeRate
	,CreditAmount
	,Posted
	,Cleared
	,GLBankAccount
	,InvoiceNumber
	,DueToDate
	,PurchaseDate)
   SELECT v_CompanyID
	,v_DivisionID
	,v_DepartmentID
	,v_PaymentID
	,'Check'
	,CheckNumber
	,VendorID
	,now()
	,v_PaymentTotal
	,0
	,'Posted'
	,CurrencyID
	,CurrencyExchangeRate
	,v_PaymentTotal
	,1
	,0
	,v_GLBankAccount
	,v_PurchaseNumber
	,PurchaseDueDate
	,PurchaseDate
   FROM PurchaseHeader
   WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into PaymentsHeader failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   INSERT INTO PaymentsDetail(CompanyID
	,DivisionID
	,DepartmentID
	,PaymentID
	,PayedID
	,DocumentNumber
	,DocumentDate
	,DiscountTaken
	,WriteOffAmount
	,AppliedAmount
	,Cleared
	,GLExpenseAccount)
   SELECT CompanyID
	,DivisionID
	,DepartmentID
	,v_PaymentID
	,v_CustomerID
	,v_PurchaseNumber
	,v_PaymentDate
	,DiscountPerc
	,0
	,Total
	,NULL
	,GLPurchaseAccount
   FROM PurchaseDetail
   WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into PaymentsDetail failed';
      ROLLBACK;


      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_NewPaymentID = v_PaymentID;


   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END