CREATE PROCEDURE Ledger_YearEndClose (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN



   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_GLRetainedEarningsAccount NATIONAL VARCHAR(36);
   DECLARE v_PeriodCurrent INT;
   DECLARE v_PeriodStartDate DATETIME;
   DECLARE v_PeriodEndDate DATETIME;
   DECLARE v_LastPeriodDate DATETIME;
   DECLARE v_CurrentFiscalYear INT;
   DECLARE v_ErrorID INT;
   DECLARE Temp1 DECIMAL(19,4);
   DECLARE Temp2 DECIMAL(19,4);
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      GET DIAGNOSTICS CONDITION 1
          @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
      SELECT @p1, @p2;
      SET @SWV_Error = 1;
   END;
   select   GLRetainedEarningsAccount INTO v_GLRetainedEarningsAccount FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
	
   START TRANSACTION;
   CALL LedgerMain_CurrentPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PeriodCurrent,v_PeriodStartDate,
   v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus <> 0 then 

      SET v_ErrorMessage = 'Fail to get current Period';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;
   CALL LedgerMain_GetLastPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_LastPeriodDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then 

      SET v_ErrorMessage = 'Fail to get last period';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;
   IF v_LastPeriodDate > v_PeriodEndDate OR v_ReturnStatus > v_PeriodCurrent then

      SET v_ErrorMessage = 'Can't close the year. Not all periods are closed yet';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   select   CurrentFiscalYear INTO v_CurrentFiscalYear FROM
   Companies WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   SET @SWV_Error = 0;
   INSERT INTO LedgerChartOfAccountsPriorYears(CompanyID,
	DivisionID,
	DepartmentID,
	GLAccountNumber,
	GLFiscalYear,
	GLAccountName,
	GLAccountDescription,
	GLAccountUse,
	GLAccountType,
	GLBalanceType,
	GLReportingAccount,
	GLReportLevel,
	CurrencyID,
	CurrencyExchangeRate,
	GLAccountBalance,
	GLAccountBeginningBalance,
	GLOtherNotes,
	GLBudgetID,
	GLPriorYearBeginningBalance,
	GLPriorYearPeriod1,
	GLPriorYearPeriod2,
	GLPriorYearPeriod3,
	GLPriorYearPeriod4,
	GLPriortYearPeriod5,
	GLPriorYearPeriod6,
	GLPriorYearPeriod7,
	GLPriorYearPeriod8,
	GLPriorYearPeriod9,
	GLPriortYearPeriod10,
	GLPriorYearPeriod11,
	GLPriorYearPeriod12,
	GLPriorYearPeriod13,
	GLPriorYearPeriod14)
   SELECT
   CompanyID,
	DivisionID,
	DepartmentID,
	GLAccountNumber,
	CONCAT(CAST(v_CurrentFiscalYear AS CHAR(4)),N'0101'),
	GLAccountName,
	GLAccountDescription,
	GLAccountUse,
	GLAccountType,
	GLBalanceType,
	GLReportingAccount,
	GLReportLevel,
	CurrencyID,
	CurrencyExchangeRate,
	GLAccountBalance,
	GLAccountBeginningBalance,
	GLOtherNotes,
	GLBudgetID,
	GLPriorYearBeginningBalance,
	GLPriorYearPeriod1,
	GLPriorYearPeriod2,
	GLPriorYearPeriod3,
	GLPriorYearPeriod4,
	GLPriortYearPeriod5,
	GLPriorYearPeriod6,
	GLPriorYearPeriod7,
	GLPriorYearPeriod8,
	GLPriorYearPeriod9,
	GLPriortYearPeriod10,
	GLPriorYearPeriod11,
	GLPriorYearPeriod12,
	GLPriorYearPeriod13,
	GLPriorYearPeriod14
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'inserting into the prior year chart of accounts failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   SELECT IFNULL(SUM(IFNULL(GLAccountBalance,0)),0) into Temp1
   FROM LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND (GLBalanceType = 'Income' OR GLBalanceType = 'Revenue');
   
   SELECT IFNULL(SUM(IFNULL(GLAccountBalance,0)),0) into Temp2
   FROM LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLBalanceType = 'Expense';

   
   UPDATE
   LedgerChartOfAccounts
   SET
   GLAccountBalance = Temp1 - Temp2
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLAccountNumber = v_GLRetainedEarningsAccount;
   IF @SWV_Error <> 0 then
	
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 1';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   SET @SWV_Error = 0;
   UPDATE
   LedgerChartOfAccounts
   SET
   GLPriorYearBeginningBalance = GLCurrentYearBeginningBalance
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then
	
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 2';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   SET @SWV_Error = 0;
   UPDATE
   LedgerChartOfAccounts
   SET
   GLPriorYearPeriod1 =
   CASE
   WHEN v_PeriodCurrent = 0 THEN GLAccountBalance
   ELSE GLPriorYearPeriod1
   END,GLPriorYearPeriod2 =
   CASE
   WHEN v_PeriodCurrent = 1 THEN GLAccountBalance
   ELSE GLPriorYearPeriod2
   END,
   GLPriorYearPeriod3 =
   CASE
   WHEN v_PeriodCurrent = 2 THEN GLAccountBalance
   ELSE GLPriorYearPeriod3
   END,GLPriorYearPeriod4 =
   CASE
   WHEN v_PeriodCurrent = 3 THEN GLAccountBalance
   ELSE GLPriorYearPeriod4
   END,
   GLPriortYearPeriod5 =
   CASE
   WHEN v_PeriodCurrent = 4 THEN GLAccountBalance
   ELSE GLPriortYearPeriod5
   END,GLPriorYearPeriod6 =
   CASE
   WHEN v_PeriodCurrent = 5 THEN GLAccountBalance
   ELSE GLPriorYearPeriod6
   END,
   GLPriorYearPeriod7 =
   CASE
   WHEN v_PeriodCurrent = 6 THEN GLAccountBalance
   ELSE GLPriorYearPeriod7
   END,
   GLPriorYearPeriod8 =
   CASE
   WHEN v_PeriodCurrent = 7 THEN GLAccountBalance
   ELSE GLPriorYearPeriod8
   END,GLPriorYearPeriod9 =
   CASE
   WHEN v_PeriodCurrent = 8 THEN GLAccountBalance
   ELSE GLPriorYearPeriod9
   END,
   GLPriortYearPeriod10 =
   CASE
   WHEN v_PeriodCurrent = 9 THEN GLAccountBalance
   ELSE GLPriortYearPeriod10
   END,GLPriorYearPeriod11 =
   CASE
   WHEN v_PeriodCurrent = 10 THEN GLAccountBalance
   ELSE GLPriorYearPeriod11
   END,
   GLPriorYearPeriod12 =
   CASE
   WHEN v_PeriodCurrent = 11 THEN GLAccountBalance
   ELSE GLPriorYearPeriod12
   END,
   GLPriorYearPeriod13 =
   CASE
   WHEN v_PeriodCurrent = 12 THEN GLAccountBalance
   ELSE GLPriorYearPeriod13
   END,GLPriorYearPeriod14 =
   CASE
   WHEN v_PeriodCurrent = 13 THEN GLAccountBalance
   ELSE GLPriorYearPeriod14
   END
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then
	
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 3';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   SET @SWV_Error = 0;
   UPDATE
   LedgerChartOfAccounts
   SET
   GLCurrentYearBeginningBalance = GLAccountBalance
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then
	
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 4';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   SET @SWV_Error = 0;
   UPDATE
   LedgerChartOfAccounts
   SET
   GLAccountBalance = 0
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND (GLBalanceType = 'Income' OR GLBalanceType = 'Revenue' OR GLBalanceType = 'Expense');
   IF @SWV_Error <> 0 then
	
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 5';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   SET @SWV_Error = 0;
   UPDATE
   LedgerChartOfAccounts
   SET
   GLPriorYearPeriod1 = GLCurrentYearPeriod1,GLPriorYearPeriod2 = GLCurrentYearPeriod2,
   GLPriorYearPeriod3 = GLCurrentYearPeriod3,GLPriorYearPeriod4 = GLCurrentYearPeriod4,
   GLPriortYearPeriod5 = GLCurrentYearPeriod5,
   GLPriorYearPeriod6 = GLCurrentYearPeriod6,GLPriorYearPeriod7 = GLCurrentYearPeriod7,
   GLPriorYearPeriod8 = GLCurrentYearPeriod8,GLPriorYearPeriod9 = GLCurrentYearPeriod9,
   GLPriortYearPeriod10 = GLCurrentYearPeriod10,
   GLPriorYearPeriod11 = GLCurrentYearPeriod11,GLPriorYearPeriod12 = GLCurrentYearPeriod12,
   GLPriorYearPeriod13 = GLCurrentYearPeriod13,GLPriorYearPeriod14 = GLCurrentYearPeriod14
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then
	
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 6';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   SET @SWV_Error = 0;
   UPDATE
   VendorFinancials
   SET
   PurchaseLastYear = PurchaseYTD,PaymentsLastYear = PaymentsYTD,ReturnsLastYear = ReturnsYTD,
   DebitMemosLastYear = DebitMemosYTD
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then
	
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 7';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   SalesLastYear = SalesYTD,PaymentsLastYear = PaymentsYTD,WriteOffsLastYear = WriteOffsYTD,
   InvoicesLastYear = InvoicesYTD,CreditMemosLastYear = CreditMemosYTD,
   RMAsLastYear = RMAsYTD
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then
	
	
      SET v_ErrorMessage = 'Updating the chart of accounts failed 8';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   SET @SWV_Error = 0;
   CALL LedgerTransactions_CopyAllToHistory2(v_CompanyID,v_DivisionID,v_DepartmentID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus <> 0 then


      SET v_ErrorMessage = 'Error during copying GL transactions to history';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END