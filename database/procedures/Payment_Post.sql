CREATE PROCEDURE Payment_Post (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),
	INOUT v_Succes INT  ,
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN


















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Posted BOOLEAN;
   DECLARE v_Void BOOLEAN;
   DECLARE v_Paid BOOLEAN;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_TranDate DATETIME;
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);
   DECLARE v_VendorID NATIONAL VARCHAR(36);
   DECLARE v_PaymentTypeID NATIONAL VARCHAR(36);
   DECLARE v_CheckNumber NATIONAL VARCHAR(20);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
       SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_Succes =  1;


   IF NOT EXISTS(SELECT
   PaymentID
   FROM
   PaymentsDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID) then

      SET v_PostingResult = 'Payment was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;


   IF EXISTS(SELECT
   PaymentID
   FROM
   PaymentsDetail
   WHERE
   IFNULL(AppliedAmount,0) = 0 AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID) then

      SET v_PostingResult = 'Payment was not posted: there is the detail item with undefined AppliedAmount value';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Posted,0), IFNULL(Void,0), IFNULL(Paid,0), IFNULL(PaymentDate,CURRENT_TIMESTAMP), VendorID, IFNULL(PaymentTypeID,''), IFNULL(CheckNumber,'') INTO v_Posted,v_Void,v_Paid,v_PaymentDate,v_VendorID,v_PaymentTypeID,v_CheckNumber FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;



   IF v_PaymentTypeID <> 'Check' AND RTrim(v_CheckNumber) = '' then
	
      START TRANSACTION;
      SET v_ErrorMessage = 'You must enter a Check Number for this payment type.';
      ROLLBACK;

      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   IF v_Paid = 1 AND v_Void = 1 then

      START TRANSACTION;
	
      select   GLTransactionNumber INTO v_GLTransactionNumber FROM
      LedgerTransactions WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      GLTransactionTypeID = 'Check' AND
      GLTransactionReference = v_PaymentID AND
      IFNULL(Reversal,0) = 0;
      IF @SWV_Error <> 0 OR ROW_COUNT() <> 1 then
	
         SET v_ErrorMessage = 'Get GLTransactionNumber failed';
         ROLLBACK;

         IF v_Succes = 1 then

            SET v_Succes = 0;
         end if;
         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;

	
      SET v_ReturnStatus = LedgerTransactions_Reverse(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionNumber);
      IF v_ReturnStatus = -1 then
	
         SET v_ErrorMessage = 'LedgerTransactions_Reverse call failed';
         ROLLBACK;

         IF v_Succes = 1 then

            SET v_Succes = 0;
         end if;
         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;

	
      SET @SWV_Error = 0;
      UPDATE
      PaymentsHeader
      SET
      Void = 0,CheckPrinted = 0,Paid = 0
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PaymentID = v_PaymentID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Update PaymentsHeader failed';
         ROLLBACK;

         IF v_Succes = 1 then

            SET v_Succes = 0;
         end if;
         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;



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
	
	
      select   IFNULL(PaymentDate,CURRENT_TIMESTAMP) INTO v_TranDate FROM
      PaymentsHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PaymentID = v_PaymentID;
   end if;


   START TRANSACTION;


   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_VerifyPeriod call failed';
      ROLLBACK;

      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   IF v_PeriodClosed <> 0 then

      SET v_Succes = 2;
      SET v_ErrorMessage = 'UNABLE_TO_POST_HERE';
      ROLLBACK;

      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   CALL Payment_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	
      SET v_ErrorMessage = 'Payment_Recalc call failed';
      ROLLBACK;

      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   CALL Payment_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Payment_CreateGLTransaction call failed';
      ROLLBACK;

      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   UPDATE
   PaymentsHeader
   SET
   Posted = 1
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update PaymentsHeader failed';
      ROLLBACK;

      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   SET v_ReturnStatus = VendorFinancials_ReCalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_VendorID);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	
      SET v_ErrorMessage = 'VendorFinancials_Recalc call failed';
      ROLLBACK;

      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   select   ProjectID INTO v_ProjectID FROM PaymentsDetail WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID AND
   NOT ProjectID IS NULL   LIMIT 1;


   SET @SWV_Error = 0;
   CALL Project_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ProjectID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	
      SET v_ErrorMessage = 'Project_ReCalc call failed';
      ROLLBACK;

      IF v_Succes = 1 then

         SET v_Succes = 0;
      end if;
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   IF v_Succes = 1 then

      SET v_Succes = 0;
   end if;

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
   end if;
   SET SWP_Ret_Value = -1;
END