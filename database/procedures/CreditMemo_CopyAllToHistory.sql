CREATE PROCEDURE CreditMemo_CopyAllToHistory (v_CompanyID 	NATIONAL VARCHAR(36),
	v_DivisionID 	NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




























   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_InvoiceNumber NATIONAL VARCHAR(36);


   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cInvoice CURSOR 
   FOR SELECT
   InvoiceNumber
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ABS(IFNULL(Total,0) -IFNULL(AmountPaid,0)) < 0.005 
   AND ABS(IFNULL(Total,0)) >= 0.005
   AND LOWER(IFNULL(TransactionTypeID,N'')) = 'credit memo';

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;



   OPEN cInvoice;

   SET @SWV_Error = 0;
   SET NO_DATA = 0;
   FETCH cInvoice INTO v_InvoiceNumber;

   IF @SWV_Error <> 0 then
	
      CLOSE cInvoice;
		
      SET v_ErrorMessage = 'Fetching from the Invoice cursor failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CopyAllToHistory',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
      SET SWP_Ret_Value = -1;
   end if;


   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      SET v_ReturnStatus = CreditMemo_CopyToHistory(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
		
         CLOSE cInvoice;
			
         SET v_ErrorMessage = 'CreditMemo_CopyToHistory call failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CopyAllToHistory',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      SET NO_DATA = 0;
      FETCH cInvoice INTO v_InvoiceNumber;
      IF @SWV_Error <> 0 then
		
         CLOSE cInvoice;
			
         SET v_ErrorMessage = 'Fetching from the Invoice cursor failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CopyAllToHistory',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   END WHILE;

   CLOSE cInvoice;





   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_CopyAllToHistory',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');

   SET SWP_Ret_Value = -1;
END