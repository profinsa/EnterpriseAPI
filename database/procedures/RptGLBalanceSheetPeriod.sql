CREATE PROCEDURE RptGLBalanceSheetPeriod (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Year INT,
	v_Period INT,
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN











   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);



   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   CALL LedgerMain_PeriodEndDate(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodEndDate, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus < 0 then

	
      SET v_ErrorMessage = 'Period End Date retrieving failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheet',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;




   SELECT
   GLBalanceType,
	GLAccountName,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Year = 0 AND v_Period = 0 THEN IFNULL(GLCurrentYearPeriod1,0)
   WHEN v_Year = 0 AND v_Period = 1 THEN IFNULL(GLCurrentYearPeriod2,0)
   WHEN v_Year = 0 AND v_Period = 2 THEN IFNULL(GLCurrentYearPeriod3,0)
   WHEN v_Year = 0 AND v_Period = 3 THEN IFNULL(GLCurrentYearPeriod4,0)
   WHEN v_Year = 0 AND v_Period = 4 THEN IFNULL(GLCurrentYearPeriod5,0)
   WHEN v_Year = 0 AND v_Period = 5 THEN IFNULL(GLCurrentYearPeriod6,0)
   WHEN v_Year = 0 AND v_Period = 6 THEN IFNULL(GLCurrentYearPeriod7,0)
   WHEN v_Year = 0 AND v_Period = 7 THEN IFNULL(GLCurrentYearPeriod8,0)
   WHEN v_Year = 0 AND v_Period = 8 THEN IFNULL(GLCurrentYearPeriod9,0)
   WHEN v_Year = 0 AND v_Period = 9 THEN IFNULL(GLCurrentYearPeriod10,0)
   WHEN v_Year = 0 AND v_Period = 10 THEN IFNULL(GLCurrentYearPeriod11,0)
   WHEN v_Year = 0 AND v_Period = 11 THEN IFNULL(GLCurrentYearPeriod12,0)
   WHEN v_Year = 0 AND v_Period = 12 THEN IFNULL(GLCurrentYearPeriod13,0)
   WHEN v_Year = 0 AND v_Period = 13 THEN IFNULL(GLCurrentYearPeriod14,0)
   WHEN v_Year = 1 AND v_Period = 0 THEN IFNULL(GLPriorYearPeriod1,0)
   WHEN v_Year = 1 AND v_Period = 1 THEN IFNULL(GLPriorYearPeriod2,0)
   WHEN v_Year = 1 AND v_Period = 2 THEN IFNULL(GLPriorYearPeriod3,0)
   WHEN v_Year = 1 AND v_Period = 3 THEN IFNULL(GLPriorYearPeriod4,0)
   WHEN v_Year = 1 AND v_Period = 4 THEN IFNULL(GLPriortYearPeriod5,0)
   WHEN v_Year = 1 AND v_Period = 5 THEN IFNULL(GLPriorYearPeriod6,0)
   WHEN v_Year = 1 AND v_Period = 6 THEN IFNULL(GLPriorYearPeriod7,0)
   WHEN v_Year = 1 AND v_Period = 7 THEN IFNULL(GLPriorYearPeriod8,0)
   WHEN v_Year = 1 AND v_Period = 8 THEN IFNULL(GLPriorYearPeriod9,0)
   WHEN v_Year = 1 AND v_Period = 9 THEN IFNULL(GLPriortYearPeriod10,0)
   WHEN v_Year = 1 AND v_Period = 10 THEN IFNULL(GLPriorYearPeriod11,0)
   WHEN v_Year = 1 AND v_Period = 11 THEN IFNULL(GLPriorYearPeriod12,0)
   WHEN v_Year = 1 AND v_Period = 12 THEN IFNULL(GLPriorYearPeriod13,0)
   WHEN v_Year = 1 AND v_Period = 13 THEN IFNULL(GLPriorYearPeriod14,0)
   ELSE 0
   END,
   N'') AS GLAccountBalance
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity') AND
   0 <>
   CASE
   WHEN v_Year = 0 AND v_Period = 0 THEN IFNULL(GLCurrentYearPeriod1,0)
   WHEN v_Year = 0 AND v_Period = 1 THEN IFNULL(GLCurrentYearPeriod2,0)
   WHEN v_Year = 0 AND v_Period = 2 THEN IFNULL(GLCurrentYearPeriod3,0)
   WHEN v_Year = 0 AND v_Period = 3 THEN IFNULL(GLCurrentYearPeriod4,0)
   WHEN v_Year = 0 AND v_Period = 4 THEN IFNULL(GLCurrentYearPeriod5,0)
   WHEN v_Year = 0 AND v_Period = 5 THEN IFNULL(GLCurrentYearPeriod6,0)
   WHEN v_Year = 0 AND v_Period = 6 THEN IFNULL(GLCurrentYearPeriod7,0)
   WHEN v_Year = 0 AND v_Period = 7 THEN IFNULL(GLCurrentYearPeriod8,0)
   WHEN v_Year = 0 AND v_Period = 8 THEN IFNULL(GLCurrentYearPeriod9,0)
   WHEN v_Year = 0 AND v_Period = 9 THEN IFNULL(GLCurrentYearPeriod10,0)
   WHEN v_Year = 0 AND v_Period = 10 THEN IFNULL(GLCurrentYearPeriod11,0)
   WHEN v_Year = 0 AND v_Period = 11 THEN IFNULL(GLCurrentYearPeriod12,0)
   WHEN v_Year = 0 AND v_Period = 12 THEN IFNULL(GLCurrentYearPeriod13,0)
   WHEN v_Year = 0 AND v_Period = 13 THEN IFNULL(GLCurrentYearPeriod14,0)
   WHEN v_Year = 1 AND v_Period = 0 THEN IFNULL(GLPriorYearPeriod1,0)
   WHEN v_Year = 1 AND v_Period = 1 THEN IFNULL(GLPriorYearPeriod2,0)
   WHEN v_Year = 1 AND v_Period = 2 THEN IFNULL(GLPriorYearPeriod3,0)
   WHEN v_Year = 1 AND v_Period = 3 THEN IFNULL(GLPriorYearPeriod4,0)
   WHEN v_Year = 1 AND v_Period = 4 THEN IFNULL(GLPriortYearPeriod5,0)
   WHEN v_Year = 1 AND v_Period = 5 THEN IFNULL(GLPriorYearPeriod6,0)
   WHEN v_Year = 1 AND v_Period = 6 THEN IFNULL(GLPriorYearPeriod7,0)
   WHEN v_Year = 1 AND v_Period = 7 THEN IFNULL(GLPriorYearPeriod8,0)
   WHEN v_Year = 1 AND v_Period = 8 THEN IFNULL(GLPriorYearPeriod9,0)
   WHEN v_Year = 1 AND v_Period = 9 THEN IFNULL(GLPriortYearPeriod10,0)
   WHEN v_Year = 1 AND v_Period = 10 THEN IFNULL(GLPriorYearPeriod11,0)
   WHEN v_Year = 1 AND v_Period = 11 THEN IFNULL(GLPriorYearPeriod12,0)
   WHEN v_Year = 1 AND v_Period = 12 THEN IFNULL(GLPriorYearPeriod13,0)
   WHEN v_Year = 1 AND v_Period = 13 THEN IFNULL(GLPriorYearPeriod14,0)
   ELSE 0
   END;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheet',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END