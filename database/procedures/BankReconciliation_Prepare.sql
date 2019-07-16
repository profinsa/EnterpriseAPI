CREATE PROCEDURE BankReconciliation_Prepare (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_BankID NATIONAL VARCHAR(36),
	v_RefreshData BOOLEAN, 
	v_GLBankAccount NATIONAL VARCHAR(36),
	v_GLInterestAccount NATIONAL VARCHAR(36),
	v_GLServiceChargeAccount NATIONAL VARCHAR(36),
	v_GLOtherChargeAccount NATIONAL VARCHAR(36),
	v_GLAdjustmentAccount NATIONAL VARCHAR(36),
	v_BankRecStartDate DATETIME,
	v_BankRecEndDate DATETIME,
	INOUT v_StartingBalance DECIMAL(19,4) ,
	INOUT v_BookBalance DECIMAL(19,4) ,
	INOUT v_PeriodBalance DECIMAL(19,4) ,
	INOUT v_PeriodCredit DECIMAL(19,4) ,
	INOUT v_PeriodDebit DECIMAL(19,4) ,
	INOUT v_Result INT ,
	INOUT v_CreditBalanceSign INT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN






   DECLARE v_ErrorMessage NATIONAL VARCHAR(250);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   Set v_Result = 1;


   If IFNULL(v_GLInterestAccount,N'') = N'' then
      select   GLBankInterestEarnedAccount INTO v_GLInterestAccount From Companies Where CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
   end if;

   If IFNULL(v_GLServiceChargeAccount,N'') = N'' then
      select   GLBankServiceChargesAccount INTO v_GLServiceChargeAccount From Companies Where CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
   end if;

   If IFNULL(v_GLBankAccount,N'') = N'' then
      select   GLBankAccount INTO v_GLBankAccount from BankAccounts Where CompanyID = v_CompanyID And DivisionID = v_DivisionID And DepartmentID = v_DepartmentID And BankID = v_BankID;
   end if;
   If IFNULL(v_GLOtherChargeAccount,N'') = N'' then
      select   GLBankOtherChargesAccount INTO v_GLOtherChargeAccount From Companies Where CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
   end if;

   If IFNULL(v_GLAdjustmentAccount,N'') = N'' then
      select   GLBankServiceChargesAccount INTO v_GLAdjustmentAccount From Companies Where CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
   end if;







   DROP TEMPORARY TABLE IF EXISTS `#tmpBankTransactions`;
   CREATE TEMPORARY TABLE `#tmpBankTransactions` 
   (
      CompanyID NATIONAL VARCHAR(36),
      DivisionID NATIONAL VARCHAR(36),
      DepartmentID NATIONAL VARCHAR(36),
      BankTransactionID NATIONAL VARCHAR(36),
      BankRecType NATIONAL VARCHAR(50),
      BankRecLineNumber INT NOT NULL  AUTO_INCREMENT,
      BankRecDocumentNumber NATIONAL VARCHAR(36),
      BankRecCleared BOOLEAN,
      `Date` DATETIME,
      BankRecDescription NATIONAL VARCHAR(50),
      BankRecAmount DECIMAL(19,4),
      CurrencyID NATIONAL VARCHAR(3),
      CurrencyExchangeRate FLOAT,
      GLBankAccount NATIONAL VARCHAR(36),
      CONSTRAINT constrain_10 PRIMARY KEY(CompanyID,DivisionID,DepartmentID,BankTransactionID,BankRecType,BankRecLineNumber)
   )   AUTO_INCREMENT = 1;

   SET @SWV_Error = 0;
   INSERT INTO `#tmpBankTransactions`(CompanyID,
	DivisionID,
	DepartmentID,
	BankTransactionID,
	BankRecDocumentNumber,
	`Date`,
	BankRecDescription,
	BankRecType,
	BankRecAmount,
	CurrencyID,
	CurrencyExchangeRate,
	GLBankAccount,
	BankRecCleared)
   SELECT
   CompanyID,
	DivisionID,
	DepartmentID,
	BankTransactionID,
	IFNULL(BankDocumentNumber,N''),
	TransactionDate,
	Reference,
	IFNULL(TransactionType,N''),
	TransactionAmount,
	CurrencyID,
	CurrencyExchangeRate,
	GLBankAccount1,
	Cleared
   FROM
   BankTransactions
   WHERE
   CompanyID = v_CompanyID And
   DivisionID = v_DivisionID And
   DepartmentID = v_DepartmentID And
   Posted = 1; 


   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Temporary reconciliation table creation failed';
	


      DROP TEMPORARY TABLE IF EXISTS tt_tmpBankTransactions;


      IF v_Result <> 1 then
         SET v_Result = 0;
      end if;
      IF v_ErrorMessage <> '' then

         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'BankReconciliation_Prepare',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankID',v_BankID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;




   SET @SWV_Error = 0;
   INSERT INTO `#tmpBankTransactions`(CompanyID,
	DivisionID,
	DepartmentID,
	BankTransactionID,
	BankRecDocumentNumber,
	`Date`,
	BankRecDescription,
	BankRecType,
	BankRecAmount,
	CurrencyID,
	CurrencyExchangeRate,
	GLBankAccount,
	BankRecCleared)
   SELECT
   CompanyID,
	DivisionID,
	DepartmentID,
	ReceiptID,
	IFNULL(CheckNumber,N''),
	TransactionDate,
	CustomerID,
	'Cash Receipt',
	Amount,
	CurrencyID,
	CurrencyExchangeRate,
	GLBankAccount,
	Cleared
   FROM
   ReceiptsHeader
   WHERE
   CompanyID = v_CompanyID And
   DivisionID = v_DivisionID And
   DepartmentID = v_DepartmentID And
   Posted = 1  And 
   IFNULL(Reconciled,0) <> 1;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Temporary reconciliation table insert from ReceiptsHeader failed';
	
      DROP TEMPORARY TABLE IF EXISTS tt_tmpBankTransactions;


      IF v_Result <> 1 then
         SET v_Result = 0;
      end if;
      IF v_ErrorMessage <> '' then

         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'BankReconciliation_Prepare',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankID',v_BankID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   INSERT INTO `#tmpBankTransactions`(CompanyID,
	DivisionID,
	DepartmentID,
	BankTransactionID,
	BankRecDocumentNumber,
	`Date`,
	BankRecDescription,
	BankRecType,
	BankRecAmount,
	CurrencyID,
	CurrencyExchangeRate,
	GLBankAccount,
	BankRecCleared)
   SELECT
   CompanyID,
	DivisionID,
	DepartmentID,
	PaymentID,
	IFNULL(CheckNumber,N''),
	PaymentDate,
	VendorID,
	'Payment',
	Amount,
	CurrencyID,
	CurrencyExchangeRate,
	GLBankAccount,
	Cleared
   FROM
   PaymentsHeader
   WHERE
   CompanyID = v_CompanyID And
   DivisionID = v_DivisionID And
   DepartmentID = v_DepartmentID And
   Posted = 1 And  
   Paid = 1 AND
   Reconciled <> 1;


   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Temporary reconciliation table insert from PaymentsHeader failed';
	
      DROP TEMPORARY TABLE IF EXISTS tt_tmpBankTransactions;


      IF v_Result <> 1 then
         SET v_Result = 0;
      end if;
      IF v_ErrorMessage <> '' then

         CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'BankReconciliation_Prepare',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankID',v_BankID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;






   IF IFNULL(v_RefreshData,0) = 1 then

      DELETE FROM
      BankReconciliation
      Where
      CompanyID = v_CompanyID
      And DivisionID = v_DivisionID
      And DepartmentID = v_DepartmentID
      And BankID = v_BankID;
	
	
      IF v_BankRecEndDate IS NULL then
	
         Set v_BankRecEndDate = CURRENT_TIMESTAMP;
      end if;
	
	
      IF v_BankRecStartDate Is NULL then
	
         Set v_BankRecStartDate = TIMESTAMPADD(day,-30,v_BankRecEndDate);
      end if;
      IF v_BankRecEndDate < v_BankRecStartDate then
	
         Set v_BankRecStartDate = TIMESTAMPADD(day,-30,v_BankRecEndDate);
      end if;
	
	
	
      SET @SWV_Error = 0;
      Insert Into BankReconciliation(CompanyID,
		DivisionID,
		DepartmentID,
		BankID,
		GLBankAccount,
		GLServiceChargeAccount,
		GLInterestAccount,
		GLOtherChargesAccount,
		GLAdjustmentAccount,
		BankRecStartDate,
		BankRecEndDate)
	Values(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_BankID,
		v_GLBankAccount,
		v_GLServiceChargeAccount,
		v_GLInterestAccount,
		v_GLOtherChargeAccount,
		v_GLAdjustmentAccount,
		v_BankRecStartDate,
		v_BankRecEndDate);
	
	
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'BankReconciliation table insert failed';
		
         DROP TEMPORARY TABLE IF EXISTS tt_tmpBankTransactions;


         IF v_Result <> 1 then
            SET v_Result = 0;
         end if;
         IF v_ErrorMessage <> '' then

            CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'BankReconciliation_Prepare',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankID',v_BankID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   ELSE
      select   GLBankAccount, GLServiceChargeAccount, GLInterestAccount, GLOtherChargesAccount, GLAdjustmentAccount, BankRecStartDate, BankRecEndDate INTO v_GLBankAccount,v_GLServiceChargeAccount,v_GLInterestAccount,v_GLOtherChargeAccount,
      v_GLAdjustmentAccount,v_BankRecStartDate,v_BankRecEndDate FROM
      BankReconciliation Where
      CompanyID = v_CompanyID
      And DivisionID = v_DivisionID
      And DepartmentID = v_DepartmentID
      And BankID = v_BankID;
   end if;
	
	
   Set v_PeriodBalance = 0;
   Set v_PeriodCredit = 0;

   Set v_PeriodDebit = 0;

   select   GLAccountBalance INTO v_StartingBalance From
   LedgerChartOfAccounts Where  CompanyID = v_CompanyID And DivisionID = v_DivisionID And DepartmentID = v_DepartmentID And GLAccountNumber = v_GLBankAccount;

   Set v_BookBalance = v_StartingBalance;



	



   IF IFNULL(v_RefreshData,0) = 1 then

      SET @SWV_Error = 0;
      DELETE FROM
      BankReconciliationDetailCredits
      WHERE
      CompanyID = v_CompanyID
      And DivisionID = v_DivisionID
      And DepartmentID = v_DepartmentID
      And BankID = v_BankID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from BankReconciliationDetailCredits table failed';
		
         DROP TEMPORARY TABLE IF EXISTS tt_tmpBankTransactions;


         IF v_Result <> 1 then
            SET v_Result = 0;
         end if;
         IF v_ErrorMessage <> '' then

            CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'BankReconciliation_Prepare',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankID',v_BankID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      Insert Into BankReconciliationDetailCredits(CompanyID,
		DivisionID,
		DepartmentID,
		BankID,
		BankTransactionID,
		BankRecDocumentNumber,
		BankRecClearedDate,
		BankRecDescription,
		BankRecType,
		BankRecAmount,
		CurrencyID,
		CurrencyExchangeRate,
		BankRecCleared)
      SELECT
      v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_BankID,
		BankTransactionID,
		BankRecDocumentNumber,
		`Date`,
		BankRecDescription,
		BankRecType,
		BankRecAmount,
		CurrencyID,
		CurrencyExchangeRate,
		0
      FROM
      `#tmpBankTransactions`
      WHERE
      GLBankAccount = v_GLBankAccount AND
		(BankRecType in('Deposit','Earned Interest','Outbound Wire','Cash Receipt') OR
		(BankRecType = 'Adjustment' AND BankRecAmount < 0)) AND
      IFNULL(BankRecCleared,0) = 0;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'BankReconciliationDetailCredits table insert failed';
		
         DROP TEMPORARY TABLE IF EXISTS tt_tmpBankTransactions;


         IF v_Result <> 1 then
            SET v_Result = 0;
         end if;
         IF v_ErrorMessage <> '' then

            CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'BankReconciliation_Prepare',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankID',v_BankID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;	

   select   fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Sum(IFNULL(BankRecAmount,0)*IFNULL(CurrencyExchangeRate,1)),0),MAX(CurrencyID)) INTO v_Amount from
   BankReconciliationDetailCredits Where
   CompanyID = v_CompanyID
   And DivisionID = v_DivisionID
   And DepartmentID = v_DepartmentID
   And BankID = v_BankID;

   Set v_StartingBalance = v_StartingBalance -v_Amount;
   Set v_PeriodCredit = v_PeriodCredit+v_Amount;
   Set v_PeriodBalance = v_PeriodBalance+v_Amount;



   select   fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Sum(IFNULL(BankRecAmount,0)*IFNULL(CurrencyExchangeRate,1)),0),MAX(CurrencyID)) INTO v_Amount FROM
   `#tmpBankTransactions` Where
   GLBankAccount = v_GLBankAccount AND
	(BankRecType in('Deposit','Earned Interest','Outbound Wire','Cash Receipt') OR
	(BankRecType = 'Adjustment' AND BankRecAmount < 0));

   Set v_StartingBalance = v_StartingBalance -v_Amount;
	

   IF IFNULL(v_RefreshData,0) = 1 then

      SET @SWV_Error = 0;
      DELETE FROM
      BankReconciliationDetailDebits
      WHERE
      CompanyID = v_CompanyID
      And DivisionID = v_DivisionID
      And DepartmentID = v_DepartmentID
      And BankID = v_BankID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from BankReconciliationDetailDebits table failed';
		
         DROP TEMPORARY TABLE IF EXISTS tt_tmpBankTransactions;


         IF v_Result <> 1 then
            SET v_Result = 0;
         end if;
         IF v_ErrorMessage <> '' then

            CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'BankReconciliation_Prepare',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankID',v_BankID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      Insert Into BankReconciliationDetailDebits(CompanyID,
		DivisionID,
		DepartmentID,
		BankID,
		BankTransactionID,
		BankRecDocumentNumber,
		BankRecClearedDate,
		BankRecDescription,
		BankRecType,
		BankRecAmount,
		CurrencyID,
		CurrencyExchangeRate,
		BankRecCleared)
      SELECT
      v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_BankID,
		BankTransactionID,
		BankRecDocumentNumber,
		`Date`,
		BankRecDescription,
		BankRecType,
		BankRecAmount,
		CurrencyID,
		CurrencyExchangeRate,
		0
      FROM `#tmpBankTransactions`
      WHERE
      GLBankAccount =
      v_GLBankAccount AND
		(BankRecType in('Payment','Service Fee','Check','Withdrawal','Inbound Wire','Transfer')  OR
		(BankRecType = 'Adjustment' AND BankRecAmount > 0)) AND
      BankRecCleared = 0;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'BankReconciliationDetailDebits table insert failed';
		
         DROP TEMPORARY TABLE IF EXISTS tt_tmpBankTransactions;


         IF v_Result <> 1 then
            SET v_Result = 0;
         end if;
         IF v_ErrorMessage <> '' then

            CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'BankReconciliation_Prepare',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankID',v_BankID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if;


   select   fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Sum(IFNULL(BankRecAmount,0)*IFNULL(CurrencyExchangeRate,1)),0),MAX(CurrencyID)) INTO v_Amount from
   BankReconciliationDetailDebits Where
   CompanyID = v_CompanyID
   And DivisionID = v_DivisionID
   And DepartmentID = v_DepartmentID
   And BankID = v_BankID;

   Set v_StartingBalance = v_StartingBalance+v_Amount;
   Set v_PeriodDebit = v_PeriodDebit+v_Amount;
   Set v_PeriodBalance = v_PeriodBalance -v_Amount;



   select   fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Sum(IFNULL(BankRecAmount,0)*IFNULL(CurrencyExchangeRate,1)),0),MAX(CurrencyID)) INTO v_Amount FROM `#tmpBankTransactions` Where
   GLBankAccount = v_GLBankAccount AND
	(BankRecType in('Payment','Service Fee','Check','Withdrawal','Inbound Wire','Transfer')  OR
	(BankRecType = 'Adjustment' AND BankRecAmount > 0));

   Set v_StartingBalance = v_StartingBalance+v_Amount;



   DROP TEMPORARY TABLE IF EXISTS tt_tmpBankTransactions;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


   DROP TEMPORARY TABLE IF EXISTS tt_tmpBankTransactions;


   IF v_Result <> 1 then
      SET v_Result = 0;
   end if;
   IF v_ErrorMessage <> '' then

      CALL Error_InsertError(v_CompanyID,v_DivisionID,DepartmentID,'BankReconciliation_Prepare',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankID',v_BankID);
   end if;

   SET SWP_Ret_Value = -1;
END