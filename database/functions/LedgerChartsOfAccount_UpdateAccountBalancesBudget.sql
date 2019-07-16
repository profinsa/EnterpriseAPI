CREATE FUNCTION LedgerChartsOfAccount_UpdateAccountBalancesBudget (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLAccountNumber NATIONAL VARCHAR(36),
	v_GLBudgetBeginningBalance DECIMAL(19,4),
	v_GLBudgetPeriod1 DECIMAL(19,4),
	v_GLBudgetPeriod2 DECIMAL(19,4),
	v_GLBudgetPeriod3 DECIMAL(19,4),
	v_GLBudgetPeriod4 DECIMAL(19,4),
	v_GLBudgetPeriod5 DECIMAL(19,4),
	v_GLBudgetPeriod6 DECIMAL(19,4),
	v_GLBudgetPeriod7 DECIMAL(19,4),
	v_GLBudgetPeriod8 DECIMAL(19,4),
	v_GLBudgetPeriod9 DECIMAL(19,4),
	v_GLBudgetPeriod10 DECIMAL(19,4),
	v_GLBudgetPeriod11 DECIMAL(19,4),
	v_GLBudgetPeriod12 DECIMAL(19,4),
	v_GLBudgetPeriod13 DECIMAL(19,4),
	v_GLBudgetPeriod14 DECIMAL(19,4)) BEGIN












   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   UPDATE	LedgerChartOfAccounts
   SET	GLBudgetBeginningBalance = v_GLBudgetBeginningBalance,GLBudgetPeriod1 = v_GLBudgetPeriod1,
   GLBudgetPeriod2 = v_GLBudgetPeriod2,GLBudgetPeriod3 = v_GLBudgetPeriod3,
   GLBudgetPeriod4 = v_GLBudgetPeriod4,GLBudgetPeriod5 = v_GLBudgetPeriod5,
   GLBudgetPeriod6 = v_GLBudgetPeriod6,GLBudgetPeriod7 = v_GLBudgetPeriod7,
   GLBudgetPeriod8 = v_GLBudgetPeriod8,GLBudgetPeriod9 = v_GLBudgetPeriod9,
   GLBudgetPeriod10 = v_GLBudgetPeriod10,GLBudgetPeriod11 = v_GLBudgetPeriod11,
   GLBudgetPeriod12 = v_GLBudgetPeriod12,
   GLBudgetPeriod13 = v_GLBudgetPeriod13,GLBudgetPeriod14 = v_GLBudgetPeriod14
   WHERE	CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLAccountNumber = v_GLAccountNumber;

   IF @SWV_Error <> 0 then 


      SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerChartsOfAccount_UpdateAccountBalancesBudget',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetBeginningBalance',
      v_GLBudgetBeginningBalance);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod1',v_GLBudgetPeriod1);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod2',v_GLBudgetPeriod2);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod3',v_GLBudgetPeriod3);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod6',v_GLBudgetPeriod6);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod7',v_GLBudgetPeriod7);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod8',v_GLBudgetPeriod8);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod9',v_GLBudgetPeriod9);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod10',v_GLBudgetPeriod10);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod11',v_GLBudgetPeriod11);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod12',v_GLBudgetPeriod12);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod13',v_GLBudgetPeriod13);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod14',v_GLBudgetPeriod14);
      RETURN -1;
   end if;

   RETURN 0;









   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerChartsOfAccount_UpdateAccountBalancesBudget',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetBeginningBalance',
   v_GLBudgetBeginningBalance);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod1',v_GLBudgetPeriod1);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod2',v_GLBudgetPeriod2);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod3',v_GLBudgetPeriod3);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod6',v_GLBudgetPeriod6);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod7',v_GLBudgetPeriod7);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod8',v_GLBudgetPeriod8);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod9',v_GLBudgetPeriod9);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod10',v_GLBudgetPeriod10);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod11',v_GLBudgetPeriod11);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod12',v_GLBudgetPeriod12);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod13',v_GLBudgetPeriod13);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLBudgetPeriod14',v_GLBudgetPeriod14);


   RETURN -1;
END