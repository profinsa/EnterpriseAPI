CREATE PROCEDURE CreditMemo_CreatePayment (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN














   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);
   DECLARE v_GLSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_BalanceDue DECIMAL(19,4);
   DECLARE v_Posted BOOLEAN;


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   CustomerID, InvoiceDate, IFNULL(Total,0) -IFNULL(AmountPaid,0), IFNULL(Posted,0) INTO v_CustomerID,v_PaymentDate,v_BalanceDue,v_Posted FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   IF v_BalanceDue <= 0 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF v_Posted = 0 then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   GLSalesAccount INTO v_GLSalesAccount FROM
   InvoiceDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber   LIMIT 1;
   START TRANSACTION;


   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextVoucherNumber',v_PaymentID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   CALL Vendor_CreateFromCustomer2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID, v_ReturnStatus);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Vendor_CreateFromCustomer call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;



   select   BankAccounts.GLBankAccount INTO v_GLBankAccount FROM
   Companies
   INNER JOIN
   BankAccounts
   ON
   Companies.CompanyID = BankAccounts.CompanyID AND
   Companies.DivisionID = BankAccounts.DivisionID AND
   Companies.DepartmentID = BankAccounts.DepartmentID WHERE
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
	CreditAmount,
	UnAppliedAmount,
	PaymentStatus,
	CurrencyID,
	CurrencyExchangeRate,
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
	NULL,
	CustomerID,
	InvoiceDate,
	v_BalanceDue,
        v_BalanceDue,
	0,
	NULL,
	CurrencyID,
	CurrencyExchangeRate,
	0,
	0,
	v_GLBankAccount,
	NULL,
	InvoiceDueDate,
	now()
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into PaymentsHeader failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
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
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_PaymentID,
	v_CustomerID,
	v_InvoiceNumber,
	v_PaymentDate,
	0,
	0,
	v_BalanceDue,
	0,
	v_GLSalesAccount);


   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into PaymentsDetail failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   CALL CreditMemoIssuePayment_CreateGLTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'CreditMemoIssuePayment_CreateGLTransaction';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;



   UPDATE
   InvoiceHeader
   SET
   AmountPaid = Total,BalanceDue = 0
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;









   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CreatePayment',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END