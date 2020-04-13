CREATE PROCEDURE RptGLCashFlowComparativeDrills (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN











   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;


   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_Returnstatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowComparativeDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
    'CollectionsFromCustomersIncome' As FlowID,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      GLAccountNumber LIKE '4%') -GREATEST((SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      GLAccountNumber LIKE '12%'),0)
   As Debit,
	NULL As Credit,
	NULL As Total,
((SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      GLAccountNumber LIKE '4%' AND
      0 <>
      CASE
      WHEN v_Period = 0 THEN IFNULL(GLPriorYearPeriod1,0)
      WHEN v_Period = 1 THEN IFNULL(GLPriorYearPeriod2,0)
      WHEN v_Period = 2 THEN IFNULL(GLPriorYearPeriod3,0)
      WHEN v_Period = 3 THEN IFNULL(GLPriorYearPeriod4,0)
      WHEN v_Period = 4 THEN IFNULL(GLPriortYearPeriod5,0)
      WHEN v_Period = 5 THEN IFNULL(GLPriorYearPeriod6,0)
      WHEN v_Period = 6 THEN IFNULL(GLPriorYearPeriod7,0)
      WHEN v_Period = 7 THEN IFNULL(GLPriorYearPeriod8,0)
      WHEN v_Period = 8 THEN IFNULL(GLPriorYearPeriod9,0)
      WHEN v_Period = 9 THEN IFNULL(GLPriortYearPeriod10,0)
      WHEN v_Period = 10 THEN IFNULL(GLPriorYearPeriod11,0)
      WHEN v_Period = 11 THEN IFNULL(GLPriorYearPeriod12,0)
      WHEN v_Period = 12 THEN IFNULL(GLPriorYearPeriod13,0)
      WHEN v_Period = 13 THEN IFNULL(GLPriorYearPeriod14,0)
      ELSE 0
      END)
   -(SELECT
      CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
      ELSE 0
      END
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      GLAccountNumber LIKE '12%' AND
      0 <>
      CASE
      WHEN v_Period = 0 THEN IFNULL(GLPriorYearPeriod1,0)
      WHEN v_Period = 1 THEN IFNULL(GLPriorYearPeriod2,0)
      WHEN v_Period = 2 THEN IFNULL(GLPriorYearPeriod3,0)
      WHEN v_Period = 3 THEN IFNULL(GLPriorYearPeriod4,0)
      WHEN v_Period = 4 THEN IFNULL(GLPriortYearPeriod5,0)
      WHEN v_Period = 5 THEN IFNULL(GLPriorYearPeriod6,0)
      WHEN v_Period = 6 THEN IFNULL(GLPriorYearPeriod7,0)
      WHEN v_Period = 7 THEN IFNULL(GLPriorYearPeriod8,0)
      WHEN v_Period = 8 THEN IFNULL(GLPriorYearPeriod9,0)
      WHEN v_Period = 9 THEN IFNULL(GLPriortYearPeriod10,0)
      WHEN v_Period = 10 THEN IFNULL(GLPriorYearPeriod11,0)
      WHEN v_Period = 11 THEN IFNULL(GLPriorYearPeriod12,0)
      WHEN v_Period = 12 THEN IFNULL(GLPriorYearPeriod13,0)
      WHEN v_Period = 13 THEN IFNULL(GLPriorYearPeriod14,0)
      ELSE 0
      END))
   As DebitComparative,
	NULL As CreditComparative,
	NULL As TotalComparative,
	0 RowNum




   UNION
   SELECT
   'Operating Activities' As CashFlowType,
	'Payments for Merchandise (Cost of Goods)' As FlowTitle,
    'PaymentsForMerchandiseCostofGoods' As FlowID,
	NULL As Debit,
	((SELECT
         fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLDebitAmount,0)),0),
         N'')
         FROM
         LedgerTransactionsDetail
         INNER JOIN LedgerChartOfAccounts ON
         GLTransactionAccount = GLAccountNumber AND
         LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
         LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
         LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
         WHERE
         LedgerTransactionsDetail.CompanyID = v_CompanyID AND
         LedgerTransactionsDetail.DivisionID = v_DivisionID AND
         LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
         GLAccountNumber LIKE '5%') 
	 )*(-1)
   As Credit,
	NULL As Total,
	NULL As DebitComparative,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      GLAccountNumber LIKE '5%' AND
      0 <>
      CASE
      WHEN v_Period = 0 THEN IFNULL(GLPriorYearPeriod1,0)
      WHEN v_Period = 1 THEN IFNULL(GLPriorYearPeriod2,0)
      WHEN v_Period = 2 THEN IFNULL(GLPriorYearPeriod3,0)
      WHEN v_Period = 3 THEN IFNULL(GLPriorYearPeriod4,0)
      WHEN v_Period = 4 THEN IFNULL(GLPriortYearPeriod5,0)
      WHEN v_Period = 5 THEN IFNULL(GLPriorYearPeriod6,0)
      WHEN v_Period = 6 THEN IFNULL(GLPriorYearPeriod7,0)
      WHEN v_Period = 7 THEN IFNULL(GLPriorYearPeriod8,0)
      WHEN v_Period = 8 THEN IFNULL(GLPriorYearPeriod9,0)
      WHEN v_Period = 9 THEN IFNULL(GLPriortYearPeriod10,0)
      WHEN v_Period = 10 THEN IFNULL(GLPriorYearPeriod11,0)
      WHEN v_Period = 11 THEN IFNULL(GLPriorYearPeriod12,0)
      WHEN v_Period = 12 THEN IFNULL(GLPriorYearPeriod13,0)
      WHEN v_Period = 13 THEN IFNULL(GLPriorYearPeriod14,0)
      ELSE 0
      END)
   -(SELECT
      CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
      ELSE 0
      END
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      GLAccountNumber LIKE '2%' AND
      0 <>
      CASE
      WHEN v_Period = 0 THEN IFNULL(GLPriorYearPeriod1,0)
      WHEN v_Period = 1 THEN IFNULL(GLPriorYearPeriod2,0)
      WHEN v_Period = 2 THEN IFNULL(GLPriorYearPeriod3,0)
      WHEN v_Period = 3 THEN IFNULL(GLPriorYearPeriod4,0)
      WHEN v_Period = 4 THEN IFNULL(GLPriortYearPeriod5,0)
      WHEN v_Period = 5 THEN IFNULL(GLPriorYearPeriod6,0)
      WHEN v_Period = 6 THEN IFNULL(GLPriorYearPeriod7,0)
      WHEN v_Period = 7 THEN IFNULL(GLPriorYearPeriod8,0)
      WHEN v_Period = 8 THEN IFNULL(GLPriorYearPeriod9,0)
      WHEN v_Period = 9 THEN IFNULL(GLPriortYearPeriod10,0)
      WHEN v_Period = 10 THEN IFNULL(GLPriorYearPeriod11,0)
      WHEN v_Period = 11 THEN IFNULL(GLPriorYearPeriod12,0)
      WHEN v_Period = 12 THEN IFNULL(GLPriorYearPeriod13,0)
      WHEN v_Period = 13 THEN IFNULL(GLPriorYearPeriod14,0)
      ELSE 0
      END)
   As CreditComparative,
	NULL As TotalComparative,
	1 As RowNum




   UNION
   SELECT
   'Operating Activities' As CashFlowType,
	'Payments for Expenses (Expenses)' As FlowTitle,
    'PaymentsForExpenses' As FlowID,
	NULL As Debit,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      GLAccountNumber >= '6' AND
      GLAccountNumber < '9')
   As Credit,
	NULL As Total,
	NULL As DebitComparative,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      GLAccountNumber >= '6' AND
      GLAccountNumber < '9' AND
      0 <>
      CASE
      WHEN v_Period = 0 THEN IFNULL(GLPriorYearPeriod1,0)
      WHEN v_Period = 1 THEN IFNULL(GLPriorYearPeriod2,0)
      WHEN v_Period = 2 THEN IFNULL(GLPriorYearPeriod3,0)
      WHEN v_Period = 3 THEN IFNULL(GLPriorYearPeriod4,0)
      WHEN v_Period = 4 THEN IFNULL(GLPriortYearPeriod5,0)
      WHEN v_Period = 5 THEN IFNULL(GLPriorYearPeriod6,0)
      WHEN v_Period = 6 THEN IFNULL(GLPriorYearPeriod7,0)
      WHEN v_Period = 7 THEN IFNULL(GLPriorYearPeriod8,0)
      WHEN v_Period = 8 THEN IFNULL(GLPriorYearPeriod9,0)
      WHEN v_Period = 9 THEN IFNULL(GLPriortYearPeriod10,0)
      WHEN v_Period = 10 THEN IFNULL(GLPriorYearPeriod11,0)
      WHEN v_Period = 11 THEN IFNULL(GLPriorYearPeriod12,0)
      WHEN v_Period = 12 THEN IFNULL(GLPriorYearPeriod13,0)
      WHEN v_Period = 13 THEN IFNULL(GLPriorYearPeriod14,0)
      ELSE 0
      END)
   As CreditComparative,
	NULL As TotalComparative,
	2 As RowNum




   UNION
   SELECT
   'Investing Activities' As CashFlowType,
	'Purchase of Equipment (Fixed Assets)' As FlowTitle,
    'PurchaseOfEquipment' As FlowID,
	NULL As Debit,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      GLAccountNumber Like '15%')
   As Credit,
	NULL As Total,
	NULL As DebitComparative,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      GLAccountNumber Like '15%' AND
      0 <>
      CASE
      WHEN v_Period = 0 THEN IFNULL(GLPriorYearPeriod1,0)
      WHEN v_Period = 1 THEN IFNULL(GLPriorYearPeriod2,0)
      WHEN v_Period = 2 THEN IFNULL(GLPriorYearPeriod3,0)
      WHEN v_Period = 3 THEN IFNULL(GLPriorYearPeriod4,0)
      WHEN v_Period = 4 THEN IFNULL(GLPriortYearPeriod5,0)
      WHEN v_Period = 5 THEN IFNULL(GLPriorYearPeriod6,0)
      WHEN v_Period = 6 THEN IFNULL(GLPriorYearPeriod7,0)
      WHEN v_Period = 7 THEN IFNULL(GLPriorYearPeriod8,0)
      WHEN v_Period = 8 THEN IFNULL(GLPriorYearPeriod9,0)
      WHEN v_Period = 9 THEN IFNULL(GLPriortYearPeriod10,0)
      WHEN v_Period = 10 THEN IFNULL(GLPriorYearPeriod11,0)
      WHEN v_Period = 11 THEN IFNULL(GLPriorYearPeriod12,0)
      WHEN v_Period = 12 THEN IFNULL(GLPriorYearPeriod13,0)
      WHEN v_Period = 13 THEN IFNULL(GLPriorYearPeriod14,0)
      ELSE 0
      END)
   As CreditComparative,
	NULL As TotalComparative,
	3 As RowNum




   UNION
   SELECT
   'Investing Activities' As CashFlowType,
	'Other' As FlowTitle,
    'Other' As FlowID,
	NULL As Debit,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      GLAccountNumber Like '16%')
   As Credit,
	NULL As Total,
	NULL As DebitComparative,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      GLAccountNumber Like '16%' AND
      0 <>
      CASE
      WHEN v_Period = 0 THEN IFNULL(GLPriorYearPeriod1,0)
      WHEN v_Period = 1 THEN IFNULL(GLPriorYearPeriod2,0)
      WHEN v_Period = 2 THEN IFNULL(GLPriorYearPeriod3,0)
      WHEN v_Period = 3 THEN IFNULL(GLPriorYearPeriod4,0)
      WHEN v_Period = 4 THEN IFNULL(GLPriortYearPeriod5,0)
      WHEN v_Period = 5 THEN IFNULL(GLPriorYearPeriod6,0)
      WHEN v_Period = 6 THEN IFNULL(GLPriorYearPeriod7,0)
      WHEN v_Period = 7 THEN IFNULL(GLPriorYearPeriod8,0)
      WHEN v_Period = 8 THEN IFNULL(GLPriorYearPeriod9,0)
      WHEN v_Period = 9 THEN IFNULL(GLPriortYearPeriod10,0)
      WHEN v_Period = 10 THEN IFNULL(GLPriorYearPeriod11,0)
      WHEN v_Period = 11 THEN IFNULL(GLPriorYearPeriod12,0)
      WHEN v_Period = 12 THEN IFNULL(GLPriorYearPeriod13,0)
      WHEN v_Period = 13 THEN IFNULL(GLPriorYearPeriod14,0)
      ELSE 0
      END)
   As CreditComparative,
	NULL As TotalComparative,
	4 As RowNum






   UNION
   SELECT
   'Financing Activities' As CashFlowType,
	GLAccountName As FlowTitle,
    'FinancingActivitiesCredit' As FlowID,
	NULL As Debit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0)),0),
   N'') As Credit,
	NULL As Total,
	NULL As DebitComparative,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(CASE
   WHEN v_Period = 0 THEN IFNULL(GLPriorYearPeriod1,0)
   WHEN v_Period = 1 THEN IFNULL(GLPriorYearPeriod2,0)
   WHEN v_Period = 2 THEN IFNULL(GLPriorYearPeriod3,0)
   WHEN v_Period = 3 THEN IFNULL(GLPriorYearPeriod4,0)
   WHEN v_Period = 4 THEN IFNULL(GLPriortYearPeriod5,0)
   WHEN v_Period = 5 THEN IFNULL(GLPriorYearPeriod6,0)
   WHEN v_Period = 6 THEN IFNULL(GLPriorYearPeriod7,0)
   WHEN v_Period = 7 THEN IFNULL(GLPriorYearPeriod8,0)
   WHEN v_Period = 8 THEN IFNULL(GLPriorYearPeriod9,0)
   WHEN v_Period = 9 THEN IFNULL(GLPriortYearPeriod10,0)
   WHEN v_Period = 10 THEN IFNULL(GLPriorYearPeriod11,0)
   WHEN v_Period = 11 THEN IFNULL(GLPriorYearPeriod12,0)
   WHEN v_Period = 12 THEN IFNULL(GLPriorYearPeriod13,0)
   WHEN v_Period = 13 THEN IFNULL(GLPriorYearPeriod14,0)
   ELSE 0
   END),N'') AS CreditComparative,
	NULL As TotalComparative,
	5 As RowNum
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID AND
   LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
   GLCreditAmount <> 0 AND
   GLAccountType = 'Equity'
   And GLAccountNumber Like '3%'
   GROUP BY
   GLAccountName






   UNION
   SELECT
   'Financing Activities' As CashFlowType,
	GLAccountName As FlowTitle,
    'FinancingActivitiesDedit' As FlowID,
	IFNULL(SUM(GLDebitAmount),0)  As  Debit,
	NULL As Credit,
	NULL As Total,
	SUM(CASE
   WHEN v_Period = 0 THEN IFNULL(GLPriorYearPeriod1,0)
   WHEN v_Period = 1 THEN IFNULL(GLPriorYearPeriod2,0)
   WHEN v_Period = 2 THEN IFNULL(GLPriorYearPeriod3,0)
   WHEN v_Period = 3 THEN IFNULL(GLPriorYearPeriod4,0)
   WHEN v_Period = 4 THEN IFNULL(GLPriortYearPeriod5,0)
   WHEN v_Period = 5 THEN IFNULL(GLPriorYearPeriod6,0)
   WHEN v_Period = 6 THEN IFNULL(GLPriorYearPeriod7,0)
   WHEN v_Period = 7 THEN IFNULL(GLPriorYearPeriod8,0)
   WHEN v_Period = 8 THEN IFNULL(GLPriorYearPeriod9,0)
   WHEN v_Period = 9 THEN IFNULL(GLPriortYearPeriod10,0)
   WHEN v_Period = 10 THEN IFNULL(GLPriorYearPeriod11,0)
   WHEN v_Period = 11 THEN IFNULL(GLPriorYearPeriod12,0)
   WHEN v_Period = 12 THEN IFNULL(GLPriorYearPeriod13,0)
   WHEN v_Period = 13 THEN IFNULL(GLPriorYearPeriod14,0)
   ELSE 0
   END) AS DebitComparative,
	NULL As CreditComparative,
	NULL As TotalComparative,
	6 As RowNum
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID AND
   LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
   GLDebitAmount <> 0 AND
   GLAccountType = 'Equity'
   And GLAccountNumber Like '3%'
   GROUP BY
   GLAccountName



   UNION
   SELECT
   'BeginningYearBalance' As CashFlowType,
	'Cash at the Beginning of the year' As FlowTitle,
	NULL As Debit,
    'CashAtTheBeginningOfTheYear' As FlowID,
	NULL As Credit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCurrentYearBeginningBalance,0)),0),
   N'') As Total,
	NULL As DebitComparative,
	NULL As CreditComparative,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCurrentYearBeginningBalance,0)),0),
   N'') As TotalComparative,
	7 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   GLAccountNumber LIKE '11%' And
   IFNULL(GLCurrentYearBeginningBalance,0) <> 0



   UNION
   SELECT
   'EndYearBalance' As CashFlowType,
	'Cash at the End of the Year' As FlowTitle,
    NULL As Debit,
	NULL As Debit,
	NULL As Credit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
   N'') As Total,
	NULL As DebitComparative,
	NULL As CreditComparative,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Period = 0 THEN SUM(IFNULL(GLPriorYearPeriod1,0))
   WHEN v_Period = 1 THEN SUM(IFNULL(GLPriorYearPeriod2,0))
   WHEN v_Period = 2 THEN SUM(IFNULL(GLPriorYearPeriod3,0))
   WHEN v_Period = 3 THEN SUM(IFNULL(GLPriorYearPeriod4,0))
   WHEN v_Period = 4 THEN SUM(IFNULL(GLPriortYearPeriod5,0))
   WHEN v_Period = 5 THEN SUM(IFNULL(GLPriorYearPeriod6,0))
   WHEN v_Period = 6 THEN SUM(IFNULL(GLPriorYearPeriod7,0))
   WHEN v_Period = 7 THEN SUM(IFNULL(GLPriorYearPeriod8,0))
   WHEN v_Period = 8 THEN SUM(IFNULL(GLPriorYearPeriod9,0))
   WHEN v_Period = 9 THEN SUM(IFNULL(GLPriortYearPeriod10,0))
   WHEN v_Period = 10 THEN SUM(IFNULL(GLPriorYearPeriod11,0))
   WHEN v_Period = 11 THEN SUM(IFNULL(GLPriorYearPeriod12,0))
   WHEN v_Period = 12 THEN SUM(IFNULL(GLPriorYearPeriod13,0))
   WHEN v_Period = 13 THEN SUM(IFNULL(GLPriorYearPeriod14,0))
   ELSE 0
   END,N'') AS TotalComparative,
	8 As RowNum
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID AND
   LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
   GLAccountNumber LIKE '11%'
   ORDER BY  9;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowComparativeDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END