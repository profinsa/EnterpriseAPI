CREATE PROCEDURE DebitMemo_ApplyToPayment (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),
	v_Amount DECIMAL(19,4),
	INOUT v_Result SMALLINT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN


























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


   select   VendorID, IFNULL(Posted,0), IFNULL(Total,0), IFNULL(AmountPaid,0), IFNULL(BalanceDue,0), IFNULL(CurrencyID,N''), IFNULL(PurchaseDate,CURRENT_TIMESTAMP) INTO v_VendorID,v_DebitMemoPost,v_DebitMemoTotal,v_DebitMemoAmountPaid,v_DebitMemoBalance,
   v_DebitMemoCurrencyID,v_DebitMemoDate FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;



   IF ROW_COUNT() = 0 OR v_DebitMemoPost <> 1 OR ABS(v_DebitMemoTotal -v_DebitMemoAmountPaid) < 0.005 OR ABS(v_DebitMemoTotal) < 0.005 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

	
   select   IFNULL(Paid,0), IFNULL(Posted,0), IFNULL(Amount,0), IFNULL(CreditAmount,IFNULL(Amount,0)), IFNULL(CurrencyID,N''), CurrencyExchangeRate, CheckNumber, PaymentDate INTO v_PaymentPaid,v_PaymentPost,v_PaymentAmount,v_PaymentCreditAmount,v_PaymentCurrencyID,
   v_CurrencyExchangeRate,v_PaymentCheckNumber,v_PaymentCheckDate FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;

   SET v_PaymentCreditAmount = v_PaymentCreditAmount;

   IF v_PaymentPost <> 1 OR  ABS(v_PaymentCreditAmount) < 0.005  OR v_PaymentPaid = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF v_DebitMemoCurrencyID <> v_PaymentCurrencyID then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   SET v_PayDebitMemo = v_Amount;

   IF v_PayDebitMemo > v_PaymentCreditAmount then
      SET v_PayDebitMemo = v_PaymentCreditAmount;
   end if;


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

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_ApplyToPayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;



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

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_ApplyToPayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
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

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_ApplyToPayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_ApplyToPayment',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);

   SET SWP_Ret_Value = -1;
END