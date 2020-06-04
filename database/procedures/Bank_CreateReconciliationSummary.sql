CREATE PROCEDURE Bank_CreateReconciliationSummary (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLBankAccount NATIONAL VARCHAR(36),
	v_CurrencyID NATIONAL VARCHAR(3),
	v_CurrencyExchangeRate FLOAT,
	v_BankRecCutoffDate DATETIME,
	v_BankRecEndingBalance DECIMAL(19,4),
	v_BankRecServiceCharge DECIMAL(19,4),
	v_GLServiceChargeAccount NATIONAL VARCHAR(36),
	v_BankRecIntrest DECIMAL(19,4),
	v_GLInterestAccount NATIONAL VARCHAR(36),
	v_BankRecAdjustment DECIMAL(19,4),
	v_GLAdjustmentAccount NATIONAL VARCHAR(36),
	v_BankRecOtherCharges DECIMAL(19,4),
	v_GLOtherChargesAccount NATIONAL VARCHAR(36),
	v_BankRecCreditTotal DECIMAL(19,4),
	v_BankRecDebitTotal DECIMAL(19,4),
	v_BankRecCreditOS DECIMAL(19,4),
	v_BankRecDebitOS DECIMAL(19,4),
	v_BankRecStartingBalance DECIMAL(19,4),
	v_BankRecBookBalance DECIMAL(19,4),
	v_BankRecDifference DECIMAL(19,4),
	v_BankRecEndingBookBalance DECIMAL(19,4),
	v_BankRecStartingBookBalance DECIMAL(19,4),
	v_Notes NATIONAL VARCHAR(1),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN



   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_BankRecID NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextReconNumber',v_BankRecID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_CreateReconciliationSummary',
         v_ErrorMessage,v_ErrorID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   INSERT INTO BankReconciliationSummary(CompanyID
           ,DivisionID
           ,DepartmentID
           ,BankRecID
           ,GLBankAccount
           ,CurrencyID
           ,CurrencyExchangeRate
           ,BankRecCutoffDate
           ,BankRecEndingBalance
           ,BankRecServiceCharge
           ,GLServiceChargeAccount
           ,BankRecIntrest
           ,GLInterestAccount
           ,BankRecAdjustment
           ,GLAdjustmentAccount
           ,BankRecOtherCharges
           ,GLOtherChargesAccount
           ,BankRecCreditTotal
           ,BankRecDebitTotal
           ,BankRecCreditOS
           ,BankRecDebitOS
           ,BankRecStartingBalance
           ,BankRecBookBalance
           ,BankRecDifference
           ,BankRecEndingBookBalance
           ,BankRecStartingBookBalance
           ,Notes)
     VALUES(v_CompanyID
           ,v_DivisionID
           ,v_DepartmentID
           ,v_BankRecID
           ,v_GLBankAccount
           ,v_CurrencyID
           ,v_CurrencyExchangeRate
           ,v_BankRecCutoffDate
           ,v_BankRecEndingBalance
           ,v_BankRecServiceCharge
           ,v_GLServiceChargeAccount
           ,v_BankRecIntrest
           ,v_GLInterestAccount
           ,v_BankRecAdjustment
           ,v_GLAdjustmentAccount
           ,v_BankRecOtherCharges
           ,v_GLOtherChargesAccount
           ,v_BankRecCreditTotal
           ,v_BankRecDebitTotal
           ,v_BankRecCreditOS
           ,v_BankRecDebitOS
           ,v_BankRecStartingBalance
           ,v_BankRecBookBalance
           ,v_BankRecDifference
           ,v_BankRecEndingBookBalance
           ,v_BankRecStartingBookBalance
           ,v_Notes);

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into BankReconciliationSummary failed';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_CreateReconciliationSummary',
         v_ErrorMessage,v_ErrorID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_CreateReconciliationSummary',
      v_ErrorMessage,v_ErrorID);
   end if;
   SET SWP_Ret_Value = -1;
END