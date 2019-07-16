CREATE PROCEDURE RptGLCompareBalanceSheetCompanyComparative (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN











   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);



   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ErrorID INT;
   SET v_ReturnStatus = LedgerMain_VerifyPeriodCurrent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetComparativeDrills',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;





   SELECT
   CompanyID,
	DivisionID,
	DepartmentID,
	GLBalanceType,
	GLAccountName,
    GLAccountNumber,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLAccountBalance),v_CompanyCurrencyID) AS GLAccountBalance
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')
   GROUP BY
   CompanyID,DivisionID,DepartmentID,GLBalanceType,GLAccountName;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetComparativeDrills',
   v_ErrorMessage,v_ErrorID);
   SET SWP_Ret_Value = -1;
END