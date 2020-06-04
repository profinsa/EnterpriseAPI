CREATE PROCEDURE CreditMemo_Post (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN





   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GLSalesAccount NATIONAL VARCHAR(36);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_PeriodClosed INT;
   DECLARE v_PeriodToPost INT;
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_TranDate DATETIME;
   DECLARE v_ErrorID INT;
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

      SET v_PostingResult = 'Credit Memo was not posted: there are no detail items';
      
SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT * FROM
   InvoiceDetail
   WHERE
   IFNULL(Total,0) = 0 AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_InvoiceNumber) then

      SET v_PostingResult = 'Credit Memo was not posted: there is the detail item with undefined Total value';
      
SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Posted,0) INTO v_Posted FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;


   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;



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

   START TRANSACTION;
   SET @SWV_Error = 0;
   CALL CreditMemo_Recalc(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Recalculating the credit memo failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


      SET v_ErrorMessage = 'LedgerMain_VerifyPeriod call failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   IF v_PeriodClosed <> 0 then



      SET v_ErrorMessage = 'Period is closed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   CALL CreditMemo_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceNumber, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'CreditMemo_CreateGLTransaction call failed';
      ROLLBACK;
      IF v_ErrorMessage <> '' then

	
	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   UPDATE
   InvoiceHeader
   SET
   Posted = 1,PostedDate = CURRENT_TIMESTAMP
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   IF v_ErrorMessage <> '' then

	
	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CreditMemo_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
   end if;
   SET SWP_Ret_Value = -1;
END