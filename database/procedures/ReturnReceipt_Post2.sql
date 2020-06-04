CREATE PROCEDURE ReturnReceipt_Post2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ReceiptID NATIONAL VARCHAR(36),
	INOUT v_Success INT   ,
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN











   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_TranDate DATETIME;
   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_GLARCashAccount NATIONAL VARCHAR(36);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_ReceiptDate DATETIME;
   DECLARE v_CustomerID NATIONAL VARCHAR(50);
   DECLARE v_PostCOA BOOLEAN;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_TotalAppliedAmount DECIMAL(19,4);
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;




   SET @SWV_Error = 0;
   SET v_Success = 1;
   SET v_ErrorMessage = '';



   IF NOT EXISTS(SELECT
   ReceiptID
   FROM
   ReceiptsDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID) then

      SET v_PostingResult = 'Return Receipt was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT
   ReceiptID
   FROM
   ReceiptsDetail
   WHERE
   AppliedAmount IS NULL AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID) then

      SET v_PostingResult = 'Return Receipt was not posted: there is the detail item with undefined AppliedAmount value';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;


   select   Posted INTO v_Posted FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID;



   IF v_Posted = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   START TRANSACTION;
   SET @SWV_Error = 0;
   CALL ReturnReceipt_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	
      SET v_ErrorMessage = 'Receipt_Recalc call failed';
      ROLLBACK;
      IF v_Success <> 1 then

         SET v_Success = 0;
      end if;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   select   IFNULL(Amount,0) INTO v_Amount FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID;

   IF v_Amount = 0 then 

      SET v_PostingResult = 'Return Receipt was not posted:  Receipt Amount=0';
	

      SET v_Success = 2;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;






   end if;

   SET @SWV_Error = 0;
   CALL ReturnReceipt_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	
      SET v_ErrorMessage = 'ReturnReceipt_CreateGLTransaction call failed';
      ROLLBACK;
      IF v_Success <> 1 then

         SET v_Success = 0;
      end if;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   IF v_ReturnStatus = 1 then

      SET v_PostingResult = 'Return Receipt was not posted: Period to post is closed already';
	

      SET v_Success = 2;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;






   end if;


   SET @SWV_Error = 0;
   CALL Project_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ProjectID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	
      SET v_ErrorMessage = 'Project_ReCalc call failed';
      ROLLBACK;
      IF v_Success <> 1 then

         SET v_Success = 0;
      end if;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   UPDATE
   ReceiptsHeader
   SET
   Posted = 1,Status = 'Posted'
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update ReceiptsHeader failed';
      ROLLBACK;
      IF v_Success <> 1 then

         SET v_Success = 0;
      end if;
      DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;




   SET v_Success = 2;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;


   IF v_Success <> 1 then

      SET v_Success = 0;
   end if;
   DROP TEMPORARY TABLE IF EXISTS tt_LedgerDetailTmp;

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ReturnReceipt_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
   end if;

   SET SWP_Ret_Value = -1;
END