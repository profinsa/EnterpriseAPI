CREATE PROCEDURE Bank_PostReconciliation (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_BankID NATIONAL VARCHAR(36),
	INOUT v_Success INT  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




























   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_BankRecEndDate DATETIME;
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodToClose INT;
   DECLARE v_BankRecDocumentNumber NATIONAL VARCHAR(36);
   DECLARE v_BankRecType NATIONAL VARCHAR(50);
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);
   DECLARE v_GLInterestAccount NATIONAL VARCHAR(36);
   DECLARE v_GLAdjustmentAccount NATIONAL VARCHAR(36);
   DECLARE v_GLServiceChargeAccount NATIONAL VARCHAR(36);
   DECLARE v_GLOtherChargesAccount NATIONAL VARCHAR(35);
   DECLARE v_BankRecIntrest DECIMAL(19,4);
   DECLARE v_BankRecAdjustment DECIMAL(19,4);
   DECLARE v_BankRecServiceCharge DECIMAL(19,4);
   DECLARE v_BankRecOtherCharges DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_ConvertedBankRecIntrest DECIMAL(19,4);
   DECLARE v_ConvertedBankRecServiceCharge DECIMAL(19,4);
   DECLARE v_ConvertedBankRecOtherCharges DECIMAL(19,4);
   DECLARE v_ConvertedBankRecAdjustment DECIMAL(19,4);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_Success = 1;

   IF NOT Exists(SELECT BankID FROM BankReconciliation
   WHERE CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND BankID = v_BankID) then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   IF v_PostDate = '1' then
      SET v_BankRecEndDate = CURRENT_TIMESTAMP;
   ELSE
      select   BankRecEndDate INTO v_BankRecEndDate FROM BankReconciliation WHERE CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND BankID = v_BankID;
   end if;
   START TRANSACTION;


   SET v_ReturnStatus = LedgerMain_VerifyPeriod(v_CompanyID,v_DivisionID,v_DepartmentID,v_BankRecEndDate,v_PeriodToPost,
   v_PeriodToClose);
   IF v_PeriodToClose <> 0 then
	
	

      SET v_Success = 2;
      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;








   end if;

   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_VerifyPeriod procedure call failed';
      ROLLBACK;
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_PostReconciliation',v_ErrorMessage,
         v_ErrorID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;




   UPDATE
   BankTransactions
   SET
   Cleared = 1
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND BankTransactionID in(Select BankTransactionID From BankReconciliationDetailCredits
   Where (BankRecType not in('Cash Receipt','Payment'))
   AND	CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND BankID = v_BankID
   AND BankRecCleared = 1);

   UPDATE
   BankTransactions
   SET
   Cleared = 1
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND BankTransactionID in(Select BankTransactionID From BankReconciliationDetailDebits
   Where (BankRecType not in('Cash Receipt','Payment'))
   AND	CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND BankID = v_BankID
   AND BankRecCleared = 1);


   UPDATE
   PaymentsHeader
   SET
   Cleared = 1,Reconciled = 1
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PaymentID in(Select BankTransactionID From BankReconciliationDetailDebits
   Where BankRecType = 'Payment'
   AND	CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND BankID = v_BankID
   AND BankRecCleared = 1);


   UPDATE
   ReceiptsHeader
   SET
   Cleared = 1,Reconciled = 1
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ReceiptID in(Select BankTransactionID From BankReconciliationDetailCredits
   Where BankRecType = 'Cash Receipt'
   AND	CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND BankID = v_BankID
   AND BankRecCleared = 1);



   select   IFNULL(BankRecIntrest,0), GLBankAccount, GLInterestAccount, IFNULL(BankRecServiceCharge,0), GLServiceChargeAccount, IFNULL(BankRecOtherCharges,0), GLOtherChargesAccount INTO v_BankRecIntrest,v_GLBankAccount,v_GLInterestAccount,v_BankRecServiceCharge,
   v_GLServiceChargeAccount,v_BankRecOtherCharges,v_GLOtherChargesAccount FROM
   BankReconciliation WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND BankID = v_BankID;


   select   CurrencyID, CurrencyExchangeRate INTO v_CurrencyID,v_CurrencyExchangeRate FROM
   BankReconciliation WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND BankID = v_BankID;

   SET @SWV_Error = 0;
   CALL VerifyCurrency(v_CompanyID,v_DivisionID,v_DepartmentID,v_BankRecEndDate,0,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_PostReconciliation',v_ErrorMessage,
         v_ErrorID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   SET v_ConvertedBankRecIntrest = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_BankRecIntrest*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
   SET v_ConvertedBankRecServiceCharge = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_BankRecServiceCharge*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
   SET v_ConvertedBankRecOtherCharges = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_BankRecOtherCharges*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
   SET v_ConvertedBankRecAdjustment = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_BankRecAdjustment*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);



   SET @SWV_Error = 0;
   SET v_ReturnStatus = Bank_CreateGLTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,'BANK',v_BankRecEndDate,'Interest Earned',
   v_GLBankAccount,'Bank Reconciliation',v_ConvertedBankRecIntrest,
   v_GLInterestAccount,v_GLInterestAccount,1,v_CurrencyID,v_CurrencyExchangeRate);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Unable to post BankRecIntrest to LedgerTransactions';
      ROLLBACK;
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_PostReconciliation',v_ErrorMessage,
         v_ErrorID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = Bank_CreateGLTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,'BANK',v_BankRecEndDate,'Service Charge',
   v_GLBankAccount,'Bank Reconciliation',v_ConvertedBankRecServiceCharge,
   v_GLServiceChargeAccount,v_GLServiceChargeAccount,1,v_CurrencyID,
   v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Unable to post BankRecServiceCharge to LedgerTransactions';
      ROLLBACK;
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_PostReconciliation',v_ErrorMessage,
         v_ErrorID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = Bank_CreateGLTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,'BANK',v_BankRecEndDate,'Other Charges',
   v_GLBankAccount,'Bank Reconciliation',v_ConvertedBankRecOtherCharges,
   v_GLOtherChargesAccount,v_GLOtherChargesAccount,1,v_CurrencyID,
   v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Unable to post BankRecOtherCharges to LedgerTransactions';
      ROLLBACK;
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_PostReconciliation',v_ErrorMessage,
         v_ErrorID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = Bank_CreateGLTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,'BANK',v_BankRecEndDate,'Other Charges',
   v_GLBankAccount,'Bank Reconciliation',v_ConvertedBankRecAdjustment,
   v_GLAdjustmentAccount,v_GLAdjustmentAccount,1,v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Unable to post BankRecAdjustment to LedgerTransactions';
      ROLLBACK;
      IF v_Success = 1 then

         SET v_Success = 0;
      end if;

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_PostReconciliation',v_ErrorMessage,
         v_ErrorID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;



   SET v_Success = 2;
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   IF v_Success = 1 then

      SET v_Success = 0;
   end if;

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_PostReconciliation',v_ErrorMessage,
      v_ErrorID);
   end if;
   SET SWP_Ret_Value = -1;
END