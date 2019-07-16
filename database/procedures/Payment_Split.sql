CREATE PROCEDURE Payment_Split (v_CompanyID 		NATIONAL VARCHAR(36),
	v_DivisionID 		NATIONAL VARCHAR(36),
	v_DepartmentID 		NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),
	v_NewAmount DECIMAL(19,4),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_NewPaymentID NATIONAL VARCHAR(36);
   DECLARE v_SplittedAmount DECIMAL(19,4);
   DECLARE v_VendorID NATIONAL VARCHAR(36);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_GLExpenseAccount NATIONAL VARCHAR(36);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_DocumentNumber NATIONAL VARCHAR(36);
   DECLARE v_DocumentDate DATETIME;


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   Amount -v_NewAmount, VendorID, InvoiceNumber, IFNULL(PurchaseDate,CURRENT_TIMESTAMP) INTO v_SplittedAmount,v_VendorID,v_DocumentNumber,v_DocumentDate FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PaymentID	= v_PaymentID;

   IF v_SplittedAmount <= 0 then
	
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   select   CONCAT(LEFT(v_PaymentID,IFNULL(NULLIF(LOCATE('-',v_PaymentID),0) -1,LENGTH(v_PaymentID))),'-',CAST(MAX(cast(IFNULL(NULLIF(SUBSTRING(PaymentID,IFNULL(NULLIF(LOCATE('-',PaymentID),0),LENGTH(PaymentID))+1, 
   LENGTH(PaymentID)),''),'0') as SIGNED INTEGER))+1 AS CHAR(8))) INTO v_NewPaymentID FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND LEFT(PaymentID,IFNULL(NULLIF(LOCATE('-',PaymentID),0) -1,LENGTH(PaymentID)))
   = LEFT(v_PaymentID,IFNULL(NULLIF(LOCATE('-',v_PaymentID),0) -1,LENGTH(v_PaymentID)));

   select   Amount -v_NewAmount, VendorID INTO v_SplittedAmount,v_VendorID FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PaymentID	= v_PaymentID;

   select   CurrencyID, CurrencyExchangeRate, GLExpenseAccount, ProjectID INTO v_CurrencyID,v_CurrencyExchangeRate,v_GLExpenseAccount,v_ProjectID FROM
   PaymentsDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PaymentID	= v_PaymentID   LIMIT 1;




   SET @SWV_Error = 0;
   UPDATE
   PaymentsHeader
   SET
   Amount = v_NewAmount,CreditAmount = v_NewAmount
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PaymentID	= v_PaymentID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update PaymentsHeader failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Split',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   DELETE FROM
   PaymentsDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PaymentID	= v_PaymentID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Delete PaymentsDetail failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Split',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   INSERT INTO
   PaymentsDetail(CompanyID,
		DivisionID,
		DepartmentID,
		PaymentID,
		PayedID,
		DocumentNumber,
		DocumentDate,
		CurrencyID,
		CurrencyExchangeRate,
		DiscountTaken,
		WriteOffAmount,
		AppliedAmount,
		Cleared,
		GLExpenseAccount,
		ProjectID)
   SELECT
   v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_PaymentID,
	v_VendorID,
	v_DocumentNumber,
	v_DocumentDate,
	v_CurrencyID,
	v_CurrencyExchangeRate,
	0,
	0,
	v_NewAmount,
	0,
	v_GLExpenseAccount,
	v_ProjectID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert PaymentsDetail 1 failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Split',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;





   SET @SWV_Error = 0;
   INSERT INTO
   PaymentsHeader(CompanyID
   ,DivisionID
   ,DepartmentID
   ,PaymentID
   ,PaymentTypeID
   ,CheckNumber
   ,CheckPrinted
   ,CheckDate
   ,Paid
   ,PaymentDate
   ,Memorize
   ,PaymentClassID
   ,VendorID
   ,SystemDate
   ,DueToDate
   ,PurchaseDate
   ,Amount
   ,UnAppliedAmount
   ,GLBankAccount
   ,PaymentStatus
   ,Void
   ,Notes
   ,CurrencyID
   ,CurrencyExchangeRate
   ,CreditAmount
   ,SelectedForPayment
   ,SelectedForPaymentDate
   ,ApprovedForPayment
   ,ApprovedForPaymentDate
   ,Cleared
   ,InvoiceNumber
   ,Posted
   ,Reconciled
   ,Credit
   ,ApprovedBy
   ,EnteredBy
   ,BatchControlNumber
   ,BatchControlTotal
   ,Signature
   ,SignaturePassword
   ,SupervisorSignature
   ,SupervisorPassword
   ,ManagerSignature
   ,ManagerPassword)
   SELECT
   CompanyID
   ,DivisionID
   ,DepartmentID
   ,v_NewPaymentID
   ,PaymentTypeID
   ,null
   ,null
   ,null
   ,Paid
   ,PaymentDate
   ,Memorize
   ,PaymentClassID
   ,VendorID
   ,SystemDate
   ,DueToDate
   ,PurchaseDate
   ,v_SplittedAmount
   ,UnAppliedAmount
   ,GLBankAccount
   ,PaymentStatus
   ,Void
   ,Notes
   ,CurrencyID
   ,CurrencyExchangeRate
   ,0
   ,SelectedForPayment
   ,SelectedForPaymentDate
   ,0
   ,null
   ,Cleared
   ,InvoiceNumber
   ,Posted
   ,Reconciled
   ,Credit
   ,null
   ,EnteredBy
   ,BatchControlNumber
   ,BatchControlTotal
   ,Signature
   ,SignaturePassword
   ,SupervisorSignature
   ,SupervisorPassword
   ,ManagerSignature
   ,ManagerPassword
   FROM
   PaymentsHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PaymentID	= v_PaymentID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert PaymentsHeader failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Split',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   INSERT INTO
   PaymentsDetail(CompanyID,
		DivisionID,
		DepartmentID,
		PaymentID,
		PayedID,
		DocumentNumber,
		DocumentDate,
		CurrencyID,
		CurrencyExchangeRate,
		DiscountTaken,
		WriteOffAmount,
		AppliedAmount,
		Cleared,
		GLExpenseAccount,
		ProjectID)
   SELECT
   v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_NewPaymentID,
	v_VendorID,
	v_DocumentNumber,
	v_DocumentDate,
	v_CurrencyID,
	v_CurrencyExchangeRate,
	0,
	0,
	v_SplittedAmount,
	0,
	v_GLExpenseAccount,
	v_ProjectID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert PaymentsDetail 2 failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Split',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Split',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);

   SET SWP_Ret_Value = -1;
END