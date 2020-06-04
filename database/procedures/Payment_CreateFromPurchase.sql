CREATE PROCEDURE Payment_CreateFromPurchase (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN





















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
   DECLARE v_PurchasePaid INT; 



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


   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextVoucherNumber',v_PaymentID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;

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

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_PurchasePaid = 0 OR v_PurchasePaid = 2 then

	
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

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF v_PurchasePaid = 1 then 


      SET @SWV_Error = 0;
      CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextVoucherNumber',v_PaymentID, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

         SET v_ErrorMessage = 'GetNextEntityID call failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;


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

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;









   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateFromPurchase',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END