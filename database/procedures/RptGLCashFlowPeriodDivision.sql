CREATE PROCEDURE RptGLCashFlowPeriodDivision (v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlow',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;






   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
((SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Year = 0 AND v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Year = 0 AND v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Year = 0 AND v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Year = 0 AND v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Year = 0 AND v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Year = 0 AND v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Year = 0 AND v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Year = 0 AND v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Year = 0 AND v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Year = 0 AND v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Year = 0 AND v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Year = 0 AND v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Year = 0 AND v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Year = 0 AND v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      WHEN v_Year = 1 AND v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
      WHEN v_Year = 1 AND v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
      WHEN v_Year = 1 AND v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
      WHEN v_Year = 1 AND v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
      WHEN v_Year = 1 AND v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
      WHEN v_Year = 1 AND v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
      WHEN v_Year = 1 AND v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
      WHEN v_Year = 1 AND v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
      WHEN v_Year = 1 AND v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
      WHEN v_Year = 1 AND v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
      WHEN v_Year = 1 AND v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
      WHEN v_Year = 1 AND v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
      WHEN v_Year = 1 AND v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
      WHEN v_Year = 1 AND v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      GLAccountNumber LIKE '4%' AND
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
      END)
   -(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Year = 0 AND v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Year = 0 AND v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Year = 0 AND v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Year = 0 AND v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Year = 0 AND v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Year = 0 AND v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Year = 0 AND v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Year = 0 AND v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Year = 0 AND v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Year = 0 AND v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Year = 0 AND v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Year = 0 AND v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Year = 0 AND v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Year = 0 AND v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      WHEN v_Year = 1 AND v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
      WHEN v_Year = 1 AND v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
      WHEN v_Year = 1 AND v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
      WHEN v_Year = 1 AND v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
      WHEN v_Year = 1 AND v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
      WHEN v_Year = 1 AND v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
      WHEN v_Year = 1 AND v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
      WHEN v_Year = 1 AND v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
      WHEN v_Year = 1 AND v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
      WHEN v_Year = 1 AND v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
      WHEN v_Year = 1 AND v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
      WHEN v_Year = 1 AND v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
      WHEN v_Year = 1 AND v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
      WHEN v_Year = 1 AND v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      GLAccountNumber LIKE '12%' AND
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
      END))
   As Debit,
	NULL As Credit,
	NULL As Total,
	0 RowNum


   UNION
   SELECT
   'Operating Activities' As CashFlowType,
	'Payments for Merchandise (Cost of Goods)' As FlowTitle,
	NULL As Debit,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Year = 0 AND v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Year = 0 AND v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Year = 0 AND v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Year = 0 AND v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Year = 0 AND v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Year = 0 AND v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Year = 0 AND v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Year = 0 AND v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Year = 0 AND v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Year = 0 AND v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Year = 0 AND v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Year = 0 AND v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Year = 0 AND v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Year = 0 AND v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      WHEN v_Year = 1 AND v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
      WHEN v_Year = 1 AND v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
      WHEN v_Year = 1 AND v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
      WHEN v_Year = 1 AND v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
      WHEN v_Year = 1 AND v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
      WHEN v_Year = 1 AND v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
      WHEN v_Year = 1 AND v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
      WHEN v_Year = 1 AND v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
      WHEN v_Year = 1 AND v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
      WHEN v_Year = 1 AND v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
      WHEN v_Year = 1 AND v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
      WHEN v_Year = 1 AND v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
      WHEN v_Year = 1 AND v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
      WHEN v_Year = 1 AND v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      GLAccountNumber LIKE '5%' AND
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
      END)
   -(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Year = 0 AND v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Year = 0 AND v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Year = 0 AND v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Year = 0 AND v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Year = 0 AND v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Year = 0 AND v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Year = 0 AND v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Year = 0 AND v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Year = 0 AND v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Year = 0 AND v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Year = 0 AND v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Year = 0 AND v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Year = 0 AND v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Year = 0 AND v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      WHEN v_Year = 1 AND v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
      WHEN v_Year = 1 AND v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
      WHEN v_Year = 1 AND v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
      WHEN v_Year = 1 AND v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
      WHEN v_Year = 1 AND v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
      WHEN v_Year = 1 AND v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
      WHEN v_Year = 1 AND v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
      WHEN v_Year = 1 AND v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
      WHEN v_Year = 1 AND v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
      WHEN v_Year = 1 AND v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
      WHEN v_Year = 1 AND v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
      WHEN v_Year = 1 AND v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
      WHEN v_Year = 1 AND v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
      WHEN v_Year = 1 AND v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      GLAccountNumber LIKE '2%' AND
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
      END)
   As Credit,
	NULL As Total,
	1 As RowNum


   UNION
   SELECT
   'Operating Activities' As CashFlowType,
	'Payments for Expenses (Expenses)' As FlowTitle,
	NULL As Debit,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Year = 0 AND v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Year = 0 AND v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Year = 0 AND v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Year = 0 AND v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Year = 0 AND v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Year = 0 AND v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Year = 0 AND v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Year = 0 AND v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Year = 0 AND v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Year = 0 AND v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Year = 0 AND v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Year = 0 AND v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Year = 0 AND v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Year = 0 AND v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      WHEN v_Year = 1 AND v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
      WHEN v_Year = 1 AND v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
      WHEN v_Year = 1 AND v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
      WHEN v_Year = 1 AND v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
      WHEN v_Year = 1 AND v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
      WHEN v_Year = 1 AND v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
      WHEN v_Year = 1 AND v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
      WHEN v_Year = 1 AND v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
      WHEN v_Year = 1 AND v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
      WHEN v_Year = 1 AND v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
      WHEN v_Year = 1 AND v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
      WHEN v_Year = 1 AND v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
      WHEN v_Year = 1 AND v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
      WHEN v_Year = 1 AND v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      GLAccountNumber >= '6' AND
      GLAccountNumber < '9' AND
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
      END)
   As Credit,
	NULL As Total,
	2 As RowNum



   UNION
   SELECT
   'Investing Activities' As CashFlowType,
	'Purchase of Equipment (Fixed Assets)' As FlowTitle,
	NULL As Debit,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Year = 0 AND v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Year = 0 AND v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Year = 0 AND v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Year = 0 AND v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Year = 0 AND v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Year = 0 AND v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Year = 0 AND v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Year = 0 AND v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Year = 0 AND v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Year = 0 AND v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Year = 0 AND v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Year = 0 AND v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Year = 0 AND v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Year = 0 AND v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      WHEN v_Year = 1 AND v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
      WHEN v_Year = 1 AND v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
      WHEN v_Year = 1 AND v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
      WHEN v_Year = 1 AND v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
      WHEN v_Year = 1 AND v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
      WHEN v_Year = 1 AND v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
      WHEN v_Year = 1 AND v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
      WHEN v_Year = 1 AND v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
      WHEN v_Year = 1 AND v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
      WHEN v_Year = 1 AND v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
      WHEN v_Year = 1 AND v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
      WHEN v_Year = 1 AND v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
      WHEN v_Year = 1 AND v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
      WHEN v_Year = 1 AND v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      GLAccountNumber Like '15%' AND
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
      END)
   As Credit,
	NULL As Total,
	3 As RowNum


   UNION
   SELECT
   'Investing Activities' As CashFlowType,
	'Other' As FlowTitle,
	NULL As Debit,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Year = 0 AND v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Year = 0 AND v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Year = 0 AND v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Year = 0 AND v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Year = 0 AND v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Year = 0 AND v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Year = 0 AND v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Year = 0 AND v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Year = 0 AND v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Year = 0 AND v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Year = 0 AND v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Year = 0 AND v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Year = 0 AND v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Year = 0 AND v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      WHEN v_Year = 1 AND v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
      WHEN v_Year = 1 AND v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
      WHEN v_Year = 1 AND v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
      WHEN v_Year = 1 AND v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
      WHEN v_Year = 1 AND v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
      WHEN v_Year = 1 AND v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
      WHEN v_Year = 1 AND v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
      WHEN v_Year = 1 AND v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
      WHEN v_Year = 1 AND v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
      WHEN v_Year = 1 AND v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
      WHEN v_Year = 1 AND v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
      WHEN v_Year = 1 AND v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
      WHEN v_Year = 1 AND v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
      WHEN v_Year = 1 AND v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      GLAccountNumber Like '16%' AND
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
      END)
   As Credit,
	NULL As Total,
	4 As RowNum




   UNION
   SELECT
   'Financing Activities' As CashFlowType,
	GLAccountName As FlowTitle,
	NULL As Debit,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Year = 0 AND v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
   WHEN v_Year = 0 AND v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
   WHEN v_Year = 0 AND v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
   WHEN v_Year = 0 AND v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
   WHEN v_Year = 0 AND v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
   WHEN v_Year = 0 AND v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
   WHEN v_Year = 0 AND v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
   WHEN v_Year = 0 AND v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
   WHEN v_Year = 0 AND v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
   WHEN v_Year = 0 AND v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
   WHEN v_Year = 0 AND v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
   WHEN v_Year = 0 AND v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
   WHEN v_Year = 0 AND v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
   WHEN v_Year = 0 AND v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
   WHEN v_Year = 1 AND v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
   WHEN v_Year = 1 AND v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
   WHEN v_Year = 1 AND v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
   WHEN v_Year = 1 AND v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
   WHEN v_Year = 1 AND v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
   WHEN v_Year = 1 AND v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
   WHEN v_Year = 1 AND v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
   WHEN v_Year = 1 AND v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
   WHEN v_Year = 1 AND v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
   WHEN v_Year = 1 AND v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
   WHEN v_Year = 1 AND v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
   WHEN v_Year = 1 AND v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
   WHEN v_Year = 1 AND v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
   WHEN v_Year = 1 AND v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
   ELSE 0
   END,
   N'') AS Credit,
	NULL As Total,
	5 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   GLAccountType = 'Expense' AND
		(GLAccountName LIKE '% Draw%' OR GLAccountName LIKE '% Paid%') AND
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
   END
   GROUP BY
   GLAccountName





   UNION
   SELECT
   'Financing Activities' As CashFlowType,
	GLAccountName As FlowTitle,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Year = 0 AND v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
   WHEN v_Year = 0 AND v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
   WHEN v_Year = 0 AND v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
   WHEN v_Year = 0 AND v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
   WHEN v_Year = 0 AND v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
   WHEN v_Year = 0 AND v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
   WHEN v_Year = 0 AND v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
   WHEN v_Year = 0 AND v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
   WHEN v_Year = 0 AND v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
   WHEN v_Year = 0 AND v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
   WHEN v_Year = 0 AND v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
   WHEN v_Year = 0 AND v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
   WHEN v_Year = 0 AND v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
   WHEN v_Year = 0 AND v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
   WHEN v_Year = 1 AND v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
   WHEN v_Year = 1 AND v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
   WHEN v_Year = 1 AND v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
   WHEN v_Year = 1 AND v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
   WHEN v_Year = 1 AND v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
   WHEN v_Year = 1 AND v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
   WHEN v_Year = 1 AND v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
   WHEN v_Year = 1 AND v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
   WHEN v_Year = 1 AND v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
   WHEN v_Year = 1 AND v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
   WHEN v_Year = 1 AND v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
   WHEN v_Year = 1 AND v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
   WHEN v_Year = 1 AND v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
   WHEN v_Year = 1 AND v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
   ELSE 0
   END,
   N'') AS Debit,
	NULL As Credit,
	NULL As Total,
	6 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   GLAccountType = 'Expense' AND
   Not (GLAccountName LIKE 'Draw%' OR GLAccountName LIKE 'Paid%') AND
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
   END
   GROUP BY
   GLAccountName



   UNION
   SELECT
   'BeginningYearBalance' As CashFlowType,
	'Cash at the Beginning of the year' As FlowTitle,
	NULL As Debit,
	NULL As Credit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCurrentYearBeginningBalance,0)),0),
   N'') As Total,
	7 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   GLAccountNumber LIKE '11%' And
   IFNULL(GLCurrentYearBeginningBalance,0) <> 0



   UNION
   SELECT
   'EndYearBalance' As CashFlowType,
	'Cash at the End of the Year' As FlowTitle,
	NULL As Debit,
	NULL As Credit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Year = 0 AND v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
   WHEN v_Year = 0 AND v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
   WHEN v_Year = 0 AND v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
   WHEN v_Year = 0 AND v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
   WHEN v_Year = 0 AND v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
   WHEN v_Year = 0 AND v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
   WHEN v_Year = 0 AND v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
   WHEN v_Year = 0 AND v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
   WHEN v_Year = 0 AND v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
   WHEN v_Year = 0 AND v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
   WHEN v_Year = 0 AND v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
   WHEN v_Year = 0 AND v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
   WHEN v_Year = 0 AND v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
   WHEN v_Year = 0 AND v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
   WHEN v_Year = 1 AND v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
   WHEN v_Year = 1 AND v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
   WHEN v_Year = 1 AND v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
   WHEN v_Year = 1 AND v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
   WHEN v_Year = 1 AND v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
   WHEN v_Year = 1 AND v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
   WHEN v_Year = 1 AND v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
   WHEN v_Year = 1 AND v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
   WHEN v_Year = 1 AND v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
   WHEN v_Year = 1 AND v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
   WHEN v_Year = 1 AND v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
   WHEN v_Year = 1 AND v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
   WHEN v_Year = 1 AND v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
   WHEN v_Year = 1 AND v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
   ELSE 0
   END,
   N'') AS Total,
	8 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   GLAccountNumber LIKE '11%' And
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
   END
   ORDER BY  6;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlow',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END