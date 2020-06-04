CREATE PROCEDURE Receipt_CreateFromInvoice2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber  NATIONAL VARCHAR(36),
	INOUT v_ReceiptID NATIONAL VARCHAR(36)  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN












   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_GLARCashAccount NATIONAL VARCHAR(36);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   IFNULL(AmountPaid,0) INTO v_Amount FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   IF ROW_COUNT() = 0 OR v_Amount = 0 then
      SET SWP_Ret_Value = 1;
      LEAVE SWL_return;
   end if;

   select   ProjectID INTO v_ProjectID FROM InvoiceDetail WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber AND
   NOT ProjectID IS NULL   LIMIT 1;

   START TRANSACTION;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextReceiptNumber',v_ReceiptID);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;
      SET v_ReceiptID = N'';

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateFromInvoice',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;

   select   GLARCashAccount INTO v_GLARCashAccount FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;


   SET @SWV_Error = 0;
   INSERT INTO ReceiptsHeader(CompanyID,
	DivisionID,
	DepartmentID,
	ReceiptID,
	ReceiptTypeID,
	CheckNumber,
	CustomerID,
	SystemDate,
	CurrencyID,
	CurrencyExchangeRate,
	Amount,
	CreditAmount,
	UnAppliedAmount,
	GLBankAccount,
	DueToDate,
	OrderDate,
        ReceiptClassID,
	HeaderMemo1,
	HeaderMemo2,
	HeaderMemo3,
	HeaderMemo4,
	HeaderMemo5,
	HeaderMemo6,
	HeaderMemo7,
	HeaderMemo8,
	HeaderMemo9)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_ReceiptID,
		CASE IFNULL(PaymentMethodID,N'') WHEN N'' THEN N'Cash' ELSE PaymentMethodID END,
		CheckNumber,
		CustomerID,
		SystemDate,
		CurrencyID,
		CurrencyExchangeRate,
		AmountPaid,
		0,
		UndistributedAmount,
		v_GLARCashAccount,
		InvoiceDueDate,
		IFNULL(InvoiceDate,CURRENT_TIMESTAMP),
                'Customer',
		HeaderMemo1,
		HeaderMemo2,
		HeaderMemo3,
		HeaderMemo4,
		HeaderMemo5,
		HeaderMemo6,
		HeaderMemo7,
		HeaderMemo8,
		HeaderMemo9
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber  = v_InvoiceNumber;
   IF @SWV_Error <> 0 then

      SET v_ReceiptID = N'';
      SET v_ErrorMessage = 'Insert into ReceiptsHeader failed';
      ROLLBACK;
      SET v_ReceiptID = N'';

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateFromInvoice',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   INSERT INTO ReceiptsDetail(CompanyID,
	DivisionID,
	DepartmentID,
	ReceiptID,
	DocumentNumber,
	DocumentDate,
	DiscountTaken,
	WriteOffAmount,
	AppliedAmount,
	Cleared,
	DetailMemo1,
	DetailMemo2,
	DetailMemo3,
	DetailMemo4,
	DetailMemo5,
	ProjectID)
   SELECT
   CompanyID,
		DivisionID,
		DepartmentID,
		v_ReceiptID,
		v_InvoiceNumber,
		IFNULL(InvoiceDate,CURRENT_TIMESTAMP),
		0,
		0,
		AmountPaid,
		0,
		HeaderMemo1,
		HeaderMemo2,
		HeaderMemo3,
		HeaderMemo4,
		HeaderMemo5,
		v_ProjectID
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber  = v_InvoiceNumber;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into ReceiptsDetail failed';
      ROLLBACK;
      SET v_ReceiptID = N'';

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateFromInvoice',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;
   SET v_ReceiptID = N'';

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_CreateFromInvoice',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);

   SET SWP_Ret_Value = -1;
END