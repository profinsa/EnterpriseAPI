CREATE PROCEDURE RptGLBalanceSheetDivision (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN










   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);



   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheet',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;




   SELECT
   DepartmentID,
	GLBalanceType,
	GLAccountName,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLAccountBalance),N'') AS GLAccountBalance
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')
   GROUP BY
   GLBalanceType,GLAccountName,DepartmentID;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheet',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END