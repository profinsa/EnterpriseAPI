DELIMITER //
DROP PROCEDURE IF EXISTS Bank_CreateReconciliationSummary;
//
CREATE         PROCEDURE Bank_CreateReconciliationSummary(v_CompanyID NATIONAL VARCHAR(36),
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
	v_Notes NATIONAL VARCHAR(1),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN

/*
Name of stored procedure: Bank_CreateReconciliationSummary
Method: 
	Stored procedure used to create a bank reconciliation summary

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@BankID NVARCHAR(36)		 - the ID of the bank

Output Parameters:


Called From:


Calls:

Last Modified: 

Last Modified By: 

Revision History: 

*/

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
-- get the transaction number
   SET @SWV_Error = 0;
   CALL GetNextEntityID2(v_CompanyID,v_DivisionID,v_DepartmentID,'NextReconNumber',v_BankRecID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;

-- Error handler
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

-- Error handler
      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_CreateReconciliationSummary',
         v_ErrorMessage,v_ErrorID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   ROLLBACK;

-- Error handler
   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'Bank_CreateReconciliationSummary',
      v_ErrorMessage,v_ErrorID);
   end if;
   SET SWP_Ret_Value = -1;
END;
























//

DELIMITER ;
