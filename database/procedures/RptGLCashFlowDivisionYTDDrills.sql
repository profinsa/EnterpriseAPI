CREATE PROCEDURE RptGLCashFlowDivisionYTDDrills (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN











   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;


   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTDDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
    'CollectionsFromCustomersIncome' As FlowID,
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
      GLAccountNumber LIKE '12%'),0)
   As Debit,
	NULL As Credit,
	NULL As Total,
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
      GLAccountNumber LIKE '12%'),0)
   As DebitYTD,
	NULL As CreditYTD,
	NULL As TotalYTD,
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
         GLAccountNumber LIKE '5%') 
	 )*(-1)
   As Credit,
	NULL As Total,
	NULL As DebitYTD,
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
   As CreditYTD,
	NULL As TotalYTD,
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
      GLAccountNumber >= '6' AND
      GLAccountNumber < '9')
   As Credit,
	NULL As Total,
	NULL As DebitYTD,
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
      GLAccountNumber >= '6' AND
      GLAccountNumber < '9')
   As CreditYTD,
	NULL As TotalYTD,
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
      GLAccountNumber Like '15%')
   As Credit,
	NULL As Total,
	NULL As DebitYTD,
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
      GLAccountNumber Like '15%')
   As CreditYTD,
	NULL As TotalYTD,
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
      GLAccountNumber Like '16%')
   As Credit,
	NULL As Total,
	NULL As DebitYTD,
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
      GLAccountNumber Like '16%')
   As CreditYTD,
	NULL As TotalYTD,
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
	NULL As DebitYTD,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0)),0),
   N'') As CreditYTD,
	NULL As TotalYTD,
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
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLDebitAmount,0)),0),
   N'')  As  Debit,
	NULL As Credit,
	NULL As Total,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLDebitAmount,0)),0),
   N'')  As  DebitYTD,
	NULL As CreditYTD,
	NULL As TotalYTD,
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
	NULL As DebitYTD,
	NULL As CreditYTD,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCurrentYearBeginningBalance,0)),0),
   N'') As TotalYTD,
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
	NULL As Debit,
	NULL As Credit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
   N'') As Total,
	NULL As DebitYTD,
	NULL As CreditYTD,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
   N'') As TotalYTD,
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
   GLAccountNumber LIKE '11%'
   ORDER BY  9;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTDDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END