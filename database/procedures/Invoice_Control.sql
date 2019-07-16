CREATE PROCEDURE Invoice_Control (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN
















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_DocumentTypeID NATIONAL VARCHAR(36);


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   TransactionTypeID INTO v_DocumentTypeID FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber;


   IF LOWER(v_DocumentTypeID) = LOWER('Credit Memo') then

      SET @SWV_Error = 0;
      SET v_ReturnStatus = CreditMemo_Post2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_PostingResult);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
	
         IF IFNULL(v_PostingResult,N'') <> N'' then
            SET v_ErrorMessage = v_PostingResult;
         ELSE
            SET v_ErrorMessage = 'CreditMemo_Post call failed';
         end if;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Control',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DocumentNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF LOWER(v_DocumentTypeID) = LOWER('Invoice') then

      SET @SWV_Error = 0;
      CALL Invoice_Post2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,0,v_PostingResult, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
	
         IF IFNULL(v_PostingResult,N'') <> N'' then
            SET v_ErrorMessage = v_PostingResult;
         ELSE
            SET v_ErrorMessage = 'Invoice_Post call failed';
         end if;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Control',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DocumentNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF LOWER(v_DocumentTypeID) = LOWER('Return') then

      SET @SWV_Error = 0;
      SET v_ReturnStatus = ReturnInvoice_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_PostingResult);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
	
         IF IFNULL(v_PostingResult,N'') <> N'' then
            SET v_ErrorMessage = v_PostingResult;
         ELSE
            SET v_ErrorMessage = 'ReturnInvoice_Post call failed';
         end if;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Control',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DocumentNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF LOWER(v_DocumentTypeID) = LOWER('Service Invoice') then

      SET @SWV_Error = 0;
      SET v_ReturnStatus = ServiceInvoice_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber,v_PostingResult);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
	
         IF IFNULL(v_PostingResult,N'') <> N'' then
            SET v_ErrorMessage = v_PostingResult;
         ELSE
            SET v_ErrorMessage = 'ServiceInvoice_Post call failed';
         end if;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Control',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DocumentNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;










   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_Control',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DocumentNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END