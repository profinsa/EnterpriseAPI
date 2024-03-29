DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowDrills;
//

DELIMITER ;
DELIMITER ;;

CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
BEGIN











   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;


   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowDrills',v_ErrorMessage,
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
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      GLAccountNumber LIKE '4%') - GREATEST((SELECT
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
      GLAccountNumber LIKE '12%'), 0)
   As Debit,
	NULL As Credit,
	NULL As Total,
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
	/*+ 	
	(SELECT 
		ISNULL(SUM(GLDebitAmount),0)
	FROM 
		LedgerTransactionsDetail 
			INNER JOIN LedgerChartOfAccounts ON 
			GLTransactionAccount = GLAccountNumber AND

			LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
			LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
			LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
	WHERE
		LedgerTransactionsDetail.CompanyID = @CompanyID AND
		LedgerTransactionsDetail.DivisionID = @DivisionID AND
		LedgerTransactionsDetail.DepartmentID = @DepartmentID AND
		GLAccountNumber LIKE '13%') */ )*(-1)
   As Credit,
	NULL As Total,
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
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLDebitAmount,0)),0),
   N'')  As  Debit,
	NULL As Credit,
	NULL As Total,
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
   ORDER BY  6;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowCompanyDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowCompanyDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
BEGIN











   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;


   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowDrills',v_ErrorMessage,
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
      GLAccountNumber LIKE '12%'),0)
   As Debit,
	NULL As Credit,
	NULL As Total,
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
         GLAccountNumber LIKE '5%') 
	/*+ 	
	(SELECT 
		ISNULL(SUM(GLDebitAmount),0)
	FROM 
		LedgerTransactionsDetail 
			INNER JOIN LedgerChartOfAccounts ON 
			GLTransactionAccount = GLAccountNumber AND
			LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
			LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
			LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
	WHERE
		LedgerTransactionsDetail.CompanyID = @CompanyID AND
		GLAccountNumber LIKE '13%') */ )*(-1)
   As Credit,
	NULL As Total,
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
      GLAccountNumber >= '6' AND
      GLAccountNumber < '9')
   As Credit,
	NULL As Total,
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
      GLAccountNumber Like '15%')
   As Credit,
	NULL As Total,
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
      GLAccountNumber Like '16%')
   As Credit,
	NULL As Total,
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
	7 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
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
   GLAccountNumber LIKE '11%'
   ORDER BY  6;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowCompanyComparativeDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowCompanyComparativeDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
BEGIN











   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;


   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
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
         GLAccountNumber LIKE '5%') 
	/*+ 	
	(SELECT 
		ISNULL(SUM(GLDebitAmount),0)
	FROM 
		LedgerTransactionsDetail 
			INNER JOIN LedgerChartOfAccounts ON 
			GLTransactionAccount = GLAccountNumber AND
			LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
			LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
			LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
	WHERE
		LedgerTransactionsDetail.CompanyID = @CompanyID AND
		GLAccountNumber LIKE '13%') */ )*(-1)
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
   END),N'') AS DebitComparative,
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
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLPriorYearBeginningBalance,0)),0),
   N'') As TotalComparative,
	7 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
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
   GLAccountNumber LIKE '11%'
   ORDER BY  9;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowComparativeDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowCompanyYTDDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowCompanyYTDDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
         GLAccountNumber LIKE '5%') 
	/*+ 	
	(SELECT 
		ISNULL(SUM(GLDebitAmount),0)
	FROM 
		LedgerTransactionsDetail 
			INNER JOIN LedgerChartOfAccounts ON 
			GLTransactionAccount = GLAccountNumber AND
			LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
			LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
			LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
	WHERE
		LedgerTransactionsDetail.CompanyID = @CompanyID AND
		GLAccountNumber LIKE '13%') */ )*(-1)
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
	/*+ 	
	(SELECT 
		dbo.fnRound(@CompanyID, @DivisionID , @DepartmentID, ISNULL(SUM(ISNULL(GLDebitAmount,0)),0),N'')
	FROM 
		LedgerTransactionsDetail 
			INNER JOIN LedgerChartOfAccounts ON 
			GLTransactionAccount = GLAccountNumber AND
			LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
			LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
			LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
	WHERE
		LedgerTransactionsDetail.CompanyID = @CompanyID AND
		LedgerTransactionsDetail.DivisionID = @DivisionID AND
		LedgerTransactionsDetail.DepartmentID = @DepartmentID AND
		GLAccountNumber LIKE '13%') */ )*(-1)
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
   GLAccountNumber LIKE '11%'
   ORDER BY  9;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTDDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowComparativeDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowComparativeDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
	/*+ 	
	(SELECT 
		ISNULL(SUM(GLDebitAmount),0)
	FROM 
		LedgerTransactionsDetail 
			INNER JOIN LedgerChartOfAccounts ON 
			GLTransactionAccount = GLAccountNumber AND
			LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
			LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
			LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
	WHERE
		LedgerTransactionsDetail.CompanyID = @CompanyID AND
		LedgerTransactionsDetail.DivisionID = @DivisionID AND
		LedgerTransactionsDetail.DepartmentID = @DepartmentID AND
		GLAccountNumber LIKE '13%') */ )*(-1)
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
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowDivisionDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowDivisionDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
BEGIN










   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;


   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowDrills',v_ErrorMessage,
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
	/*+ 	
	(SELECT 
		ISNULL(SUM(GLDebitAmount),0)
	FROM 
		LedgerTransactionsDetail 
			INNER JOIN LedgerChartOfAccounts ON 
			GLTransactionAccount = GLAccountNumber AND
			LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
			LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
			LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
	WHERE
		LedgerTransactionsDetail.CompanyID = @CompanyID AND
		LedgerTransactionsDetail.DivisionID = @DivisionID AND
		GLAccountNumber LIKE '13%') */ )*(-1)
   As Credit,
	NULL As Total,
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
   ORDER BY  6;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowDivisionComparativeDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowDivisionComparativeDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
BEGIN











   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;


   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
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
         GLAccountNumber LIKE '5%') 
	/*+ 	
	(SELECT 
		ISNULL(SUM(GLDebitAmount),0)
	FROM 
		LedgerTransactionsDetail 
			INNER JOIN LedgerChartOfAccounts ON 
			GLTransactionAccount = GLAccountNumber AND
			LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
			LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
			LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
	WHERE
		LedgerTransactionsDetail.CompanyID = @CompanyID AND
		LedgerTransactionsDetail.DivisionID = @DivisionID AND
		GLAccountNumber LIKE '13%') */ )*(-1)
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
   END),N'') AS DebitComparative,
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
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLPriorYearBeginningBalance,0)),0),
   N'') As TotalComparative,
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
   GLAccountNumber LIKE '11%'
   ORDER BY  9;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowComparativeDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowDivisionYTDDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowDivisionYTDDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
	/*+ 	
	(SELECT 
		ISNULL(SUM(GLDebitAmount),0)
	FROM 
		LedgerTransactionsDetail 
			INNER JOIN LedgerChartOfAccounts ON 
			GLTransactionAccount = GLAccountNumber AND
			LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
			LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
			LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
	WHERE
		LedgerTransactionsDetail.CompanyID = @CompanyID AND
		LedgerTransactionsDetail.DivisionID = @DivisionID AND
		GLAccountNumber LIKE '13%') */ )*(-1)
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
	/*+ 	
	(SELECT 
		dbo.fnRound(@CompanyID, @DivisionID , @DepartmentID, ISNULL(SUM(ISNULL(GLDebitAmount,0)),0),N'')
	FROM 
		LedgerTransactionsDetail 
			INNER JOIN LedgerChartOfAccounts ON 
			GLTransactionAccount = GLAccountNumber AND
			LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
			LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
			LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
	WHERE
		LedgerTransactionsDetail.CompanyID = @CompanyID AND
		LedgerTransactionsDetail.DivisionID = @DivisionID AND
		LedgerTransactionsDetail.DepartmentID = @DepartmentID AND
		GLAccountNumber LIKE '13%') */ )*(-1)
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
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowPeriodDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Year INT,
	v_Period INT,
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
    'CollectionsFromCustomersIncome' As FlowID,
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
      DepartmentID = v_DepartmentID AND
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
      DepartmentID = v_DepartmentID AND
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
	null  As Credit,
	NULL As Total,
	0 RowNum


   UNION
   SELECT
   'Operating Activities' As CashFlowType,
	'Payments for Merchandise (Cost of Goods)' As FlowTitle,
    'PaymentsForMerchandiseCostofGoods' As FlowID,
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
      DepartmentID = v_DepartmentID AND
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
      DepartmentID = v_DepartmentID AND
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
	'0.00' As Total,
	1 As RowNum


   UNION
   SELECT
   'Operating Activities' As CashFlowType,
	'Payments for Expenses (Expenses)' As FlowTitle,
    'PaymentsForExpenses' As FlowID,
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
      DepartmentID = v_DepartmentID AND
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
    'PurchaseOfEquipment' As FlowID,
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
      DepartmentID = v_DepartmentID AND
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
    'Other' As FlowID,
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
      DepartmentID = v_DepartmentID AND
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
    'FinancingActivitiesCredit' As FlowID,
	NULL As Debit,
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
   N'') AS Credit,
	NULL As Total,
	5 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
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





   UNION
   SELECT
   'Financing Activities' As CashFlowType,
	GLAccountName As FlowTitle,
    'FinancingActivitiesDedit' As FlowID,
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
   N'') AS Debit,
	NULL As Credit,
	NULL As Total,
	6 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
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



   UNION
   SELECT
   'BeginningYearBalance' As CashFlowType,
	'Cash at the Beginning of the year' As FlowTitle,
	NULL As Debit,
    'CashAtTheBeginningOfTheYear' As FlowID,
	NULL As Credit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCurrentYearBeginningBalance,0)),0),
   N'') As Total,
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
   DepartmentID = v_DepartmentID AND
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowPeriodCompanyDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodCompanyDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Year INT,
	v_Period INT,
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;






   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
    'CollectionsFromCustomersIncome' As FlowID,
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
    'PaymentsForMerchandiseCostofGoods' As FlowID,
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
    'PaymentsForExpenses' As FlowID,
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
    'PurchaseOfEquipment' As FlowID,
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
    'Other' As FlowID,
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
    'FinancingActivitiesCredit' As FlowID,
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
    'FinancingActivitiesDedit' As FlowID,
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
    'CashAtTheBeginningOfTheYear' As FlowID,
	NULL As Credit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCurrentYearBeginningBalance,0)),0),
   N'') As Total,
	7 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   GLAccountNumber LIKE '11%' And
   IFNULL(GLCurrentYearBeginningBalance,0) <> 0



   UNION
   SELECT
   'EndYearBalance' As CashFlowType,
	'Cash at the End of the Year' As FlowTitle,
    NULL As Debit,
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowPeriodCompanyComparativeDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodCompanyComparativeDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Year INT,
	v_Period INT,
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowPeriodCompanyComparativeDrills',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
    'CollectionsFromCustomersIncome' As FlowID,
((SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      GLAccountNumber LIKE '4%')
   -(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      GLAccountNumber LIKE '12%'))
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
      GLAccountNumber LIKE '4%')
   -(SELECT
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
      GLAccountNumber LIKE '12%'))
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
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      GLAccountNumber LIKE '5%')
   -(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      GLAccountNumber LIKE '2%')
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
      GLAccountNumber LIKE '5%')
   -(SELECT
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
      GLAccountNumber LIKE '2%')
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
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
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
      GLAccountNumber >= '6' AND
      GLAccountNumber < '9')
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
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
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
      GLAccountNumber Like '15%')
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
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
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
      GLAccountNumber Like '16%')
   As CreditComparative,
	NULL As TotalComparative,
	4 As RowNum






   UNION
   SELECT
   'Financing Activities' As CashFlowType,
	GLAccountName As FlowTitle,
    'FinancingActivitiesCredit' As FlowID,
	NULL As Debit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Period = 0 THEN IFNULL(GLCurrentYearPeriod1,0)
   WHEN v_Period = 1 THEN IFNULL(GLCurrentYearPeriod2,0)
   WHEN v_Period = 2 THEN IFNULL(GLCurrentYearPeriod3,0)
   WHEN v_Period = 3 THEN IFNULL(GLCurrentYearPeriod4,0)
   WHEN v_Period = 4 THEN IFNULL(GLCurrentYearPeriod5,0)
   WHEN v_Period = 5 THEN IFNULL(GLCurrentYearPeriod6,0)
   WHEN v_Period = 6 THEN IFNULL(GLCurrentYearPeriod7,0)
   WHEN v_Period = 7 THEN IFNULL(GLCurrentYearPeriod8,0)
   WHEN v_Period = 8 THEN IFNULL(GLCurrentYearPeriod9,0)
   WHEN v_Period = 9 THEN IFNULL(GLCurrentYearPeriod10,0)
   WHEN v_Period = 10 THEN IFNULL(GLCurrentYearPeriod11,0)
   WHEN v_Period = 11 THEN IFNULL(GLCurrentYearPeriod12,0)
   WHEN v_Period = 12 THEN IFNULL(GLCurrentYearPeriod13,0)
   WHEN v_Period = 13 THEN IFNULL(GLCurrentYearPeriod14,0)
   ELSE 0
   END,
   N'') AS Credit,
	NULL As Total,
	NULL As DebitComparative,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
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
   END,N'') AS CreditComparative,
	NULL As TotalComparative,
	5 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   GLAccountType = 'Expense' AND
		(GLAccountName LIKE '% Draw%' OR GLAccountName LIKE '% Paid%')






   UNION
   SELECT
   'Financing Activities' As CashFlowType,
	GLAccountName As FlowTitle,
    'FinancingActivitiesDedit' As FlowID,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Period = 0 THEN IFNULL(GLCurrentYearPeriod1,0)
   WHEN v_Period = 1 THEN IFNULL(GLCurrentYearPeriod2,0)
   WHEN v_Period = 2 THEN IFNULL(GLCurrentYearPeriod3,0)
   WHEN v_Period = 3 THEN IFNULL(GLCurrentYearPeriod4,0)
   WHEN v_Period = 4 THEN IFNULL(GLCurrentYearPeriod5,0)
   WHEN v_Period = 5 THEN IFNULL(GLCurrentYearPeriod6,0)
   WHEN v_Period = 6 THEN IFNULL(GLCurrentYearPeriod7,0)
   WHEN v_Period = 7 THEN IFNULL(GLCurrentYearPeriod8,0)
   WHEN v_Period = 8 THEN IFNULL(GLCurrentYearPeriod9,0)
   WHEN v_Period = 9 THEN IFNULL(GLCurrentYearPeriod10,0)
   WHEN v_Period = 10 THEN IFNULL(GLCurrentYearPeriod11,0)
   WHEN v_Period = 11 THEN IFNULL(GLCurrentYearPeriod12,0)
   WHEN v_Period = 12 THEN IFNULL(GLCurrentYearPeriod13,0)
   WHEN v_Period = 13 THEN IFNULL(GLCurrentYearPeriod14,0)
   ELSE 0
   END,
   N'') AS Debit,
	NULL As Credit,
	NULL As Total,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
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
   END,N'') AS DebitComparative,
	NULL As CreditComparative,
	NULL As TotalComparative,
	6 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   GLAccountType = 'Expense' AND
   Not (GLAccountName LIKE 'Draw%' OR GLAccountName LIKE 'Paid%')




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
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLPriorYearBeginningBalance,0)),0),
   N'') As TotalComparative,
	7 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   GLAccountNumber LIKE '11%' And
   IFNULL(GLCurrentYearBeginningBalance,0) <> 0



   UNION
   SELECT
   'EndYearBalance' As CashFlowType,
	'Cash at the End of the Year' As FlowTitle,
    NULL As Debit,
	NULL As Debit,
	NULL As Credit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
   WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
   WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
   WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
   WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
   WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
   WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
   WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
   WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
   WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
   WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
   WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
   WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
   WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
   ELSE 0
   END,
   N'') AS Total,
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
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   GLAccountNumber LIKE '11%'
   ORDER BY  9;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowPeriodCompanyComparativeDrills',
   v_ErrorMessage,v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowPeriodCompanyYTDDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodCompanyYTDDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Year INT,
	v_Period INT,
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTDDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;






   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
    'CollectionsFromCustomersIncome' As FlowID,
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
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      GLTransactionDate < v_PeriodEndDate AND
      GLAccountNumber LIKE '4%') -GREATEST((SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      GLTransactionDate < v_PeriodEndDate AND
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
	NULL As DebitYTD,
	((SELECT
         fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLDebitAmount,0)),0),
         N'')
         FROM
         LedgerTransactionsDetail
         INNER JOIN LedgerTransactions ON
         LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
         LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
         LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
         LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
         INNER JOIN LedgerChartOfAccounts ON
         GLTransactionAccount = GLAccountNumber AND
         LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
         LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
         LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
         WHERE
         LedgerTransactionsDetail.CompanyID = v_CompanyID AND
         GLTransactionDate < v_PeriodEndDate AND
         GLAccountNumber LIKE '5%'))*(-1)
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
	NULL As DebitYTD,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      GLTransactionDate < v_PeriodEndDate AND
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
	NULL As DebitYTD,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      GLTransactionDate < v_PeriodEndDate AND
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
	NULL As DebitYTD,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      GLTransactionDate < v_PeriodEndDate AND
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
	NULL As DebitYTD,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0)),0),
   N'') As CreditYTD,
	NULL As TotalYTD,
	5 As RowNum
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerTransactions ON
   LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   GLTransactionDate < v_PeriodEndDate AND
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
    'FinancingActivitiesDedit' As FlowID,
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
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLDebitAmount,0)),0),
   N'') As  DebitYTD,
	NULL As CreditYTD,
	NULL As TotalYTD,
	6 As RowNum
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerTransactions ON
   LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   GLTransactionDate < v_PeriodEndDate AND
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
   GLAccountNumber LIKE '11%' And
   IFNULL(GLCurrentYearBeginningBalance,0) <> 0



   UNION
   SELECT
   'EndYearBalance' As CashFlowType,
	'Cash at the End of the Year' As FlowTitle,
    NULL As Debit,
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
	NULL As DebitYTD,
	NULL As CreditYTD,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCurrentYearBeginningBalance,0)),0),
   N'') As TotalYTD,
	8 As RowNum
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerTransactions ON
   LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   GLTransactionDate < v_PeriodEndDate AND
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
   ORDER BY  9;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTDDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowPeriodComparativeDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodComparativeDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Year INT,
	v_Period INT,
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowComparativeDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
    'CollectionsFromCustomersIncome' As FlowID,
((SELECT
      CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      GLAccountNumber LIKE '4%')
   -(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      GLAccountNumber LIKE '12%'))
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
      GLAccountNumber LIKE '4%')
   -(SELECT
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
      GLAccountNumber LIKE '12%'))
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
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      GLAccountNumber LIKE '5%')
   -(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      GLAccountNumber LIKE '2%')
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
      GLAccountNumber LIKE '5%')
   -(SELECT
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
      GLAccountNumber LIKE '2%')
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
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
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
      GLAccountNumber < '9')
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
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
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
      GLAccountNumber Like '15%')
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
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
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
      GLAccountNumber Like '16%')
   As CreditComparative,
	NULL As TotalComparative,
	4 As RowNum






   UNION
   SELECT
   'Financing Activities' As CashFlowType,
	GLAccountName As FlowTitle,
    'FinancingActivitiesCredit' As FlowID,
	NULL As Debit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Period = 0 THEN IFNULL(GLCurrentYearPeriod1,0)
   WHEN v_Period = 1 THEN IFNULL(GLCurrentYearPeriod2,0)
   WHEN v_Period = 2 THEN IFNULL(GLCurrentYearPeriod3,0)
   WHEN v_Period = 3 THEN IFNULL(GLCurrentYearPeriod4,0)
   WHEN v_Period = 4 THEN IFNULL(GLCurrentYearPeriod5,0)
   WHEN v_Period = 5 THEN IFNULL(GLCurrentYearPeriod6,0)
   WHEN v_Period = 6 THEN IFNULL(GLCurrentYearPeriod7,0)
   WHEN v_Period = 7 THEN IFNULL(GLCurrentYearPeriod8,0)
   WHEN v_Period = 8 THEN IFNULL(GLCurrentYearPeriod9,0)
   WHEN v_Period = 9 THEN IFNULL(GLCurrentYearPeriod10,0)
   WHEN v_Period = 10 THEN IFNULL(GLCurrentYearPeriod11,0)
   WHEN v_Period = 11 THEN IFNULL(GLCurrentYearPeriod12,0)
   WHEN v_Period = 12 THEN IFNULL(GLCurrentYearPeriod13,0)
   WHEN v_Period = 13 THEN IFNULL(GLCurrentYearPeriod14,0)
   ELSE 0
   END,
   N'') AS Credit,
	NULL As Total,
	NULL As DebitComparative,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
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
   END,N'') AS CreditComparative,
	NULL As TotalComparative,
	5 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   GLAccountType = 'Expense' AND
		(GLAccountName LIKE '% Draw%' OR GLAccountName LIKE '% Paid%')






   UNION
   SELECT
   'Financing Activities' As CashFlowType,
	GLAccountName As FlowTitle,
    'FinancingActivitiesDedit' As FlowID,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Period = 0 THEN IFNULL(GLCurrentYearPeriod1,0)
   WHEN v_Period = 1 THEN IFNULL(GLCurrentYearPeriod2,0)
   WHEN v_Period = 2 THEN IFNULL(GLCurrentYearPeriod3,0)
   WHEN v_Period = 3 THEN IFNULL(GLCurrentYearPeriod4,0)
   WHEN v_Period = 4 THEN IFNULL(GLCurrentYearPeriod5,0)
   WHEN v_Period = 5 THEN IFNULL(GLCurrentYearPeriod6,0)
   WHEN v_Period = 6 THEN IFNULL(GLCurrentYearPeriod7,0)
   WHEN v_Period = 7 THEN IFNULL(GLCurrentYearPeriod8,0)
   WHEN v_Period = 8 THEN IFNULL(GLCurrentYearPeriod9,0)
   WHEN v_Period = 9 THEN IFNULL(GLCurrentYearPeriod10,0)
   WHEN v_Period = 10 THEN IFNULL(GLCurrentYearPeriod11,0)
   WHEN v_Period = 11 THEN IFNULL(GLCurrentYearPeriod12,0)
   WHEN v_Period = 12 THEN IFNULL(GLCurrentYearPeriod13,0)
   WHEN v_Period = 13 THEN IFNULL(GLCurrentYearPeriod14,0)
   ELSE 0
   END,
   N'') AS Debit,
	NULL As Credit,
	NULL As Total,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
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
   END,N'') AS DebitComparative,
	NULL As CreditComparative,
	NULL As TotalComparative,
	6 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   GLAccountType = 'Expense' AND
   Not (GLAccountName LIKE 'Draw%' OR GLAccountName LIKE 'Paid%')




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
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLPriorYearBeginningBalance,0)),0),
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
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
   WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
   WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
   WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
   WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
   WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
   WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
   WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
   WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
   WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
   WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
   WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
   WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
   WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
   ELSE 0
   END,
   N'') AS Total,
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
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   GLAccountNumber LIKE '11%'
   ORDER BY  9;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowComparativeDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowPeriodDivisionDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodDivisionDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Year INT,
	v_Period INT,
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;






   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
    'CollectionsFromCustomersIncome' As FlowID,
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
    'PaymentsForMerchandiseCostofGoods' As FlowID,
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
    'PaymentsForExpenses' As FlowID,
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
    'PurchaseOfEquipment' As FlowID,
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
    'Other' As FlowID,
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
    'FinancingActivitiesCredit' As FlowID,
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
    'FinancingActivitiesDedit' As FlowID,
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
    'CashAtTheBeginningOfTheYear' As FlowID,
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowPeriodDivisionComparativeDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodDivisionComparativeDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Year INT,
	v_Period INT,
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowPerionDivisionComparativeDrills',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
    'CollectionsFromCustomersIncome' As FlowID,
((SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      GLAccountNumber LIKE '4%')
   -(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      GLAccountNumber LIKE '12%'))
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
      GLAccountNumber LIKE '4%')
   -(SELECT
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
      GLAccountNumber LIKE '12%'))
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
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      GLAccountNumber LIKE '5%')
   -(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      GLAccountNumber LIKE '2%')
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
      GLAccountNumber LIKE '5%')
   -(SELECT
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
      GLAccountNumber LIKE '2%')
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
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
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
      GLAccountNumber >= '6' AND
      GLAccountNumber < '9')
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
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
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
      GLAccountNumber Like '15%')
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
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
      WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
      WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
      WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
      WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
      WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
      WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
      WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
      WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
      WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
      WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
      WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
      WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
      WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
      WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
      ELSE 0
      END,
      N'')
      FROM
      LedgerChartOfAccounts
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
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
      GLAccountNumber Like '16%')
   As CreditComparative,
	NULL As TotalComparative,
	4 As RowNum






   UNION
   SELECT
   'Financing Activities' As CashFlowType,
	GLAccountName As FlowTitle,
    'FinancingActivitiesCredit' As FlowID,
	NULL As Debit,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Period = 0 THEN IFNULL(GLCurrentYearPeriod1,0)
   WHEN v_Period = 1 THEN IFNULL(GLCurrentYearPeriod2,0)
   WHEN v_Period = 2 THEN IFNULL(GLCurrentYearPeriod3,0)
   WHEN v_Period = 3 THEN IFNULL(GLCurrentYearPeriod4,0)
   WHEN v_Period = 4 THEN IFNULL(GLCurrentYearPeriod5,0)
   WHEN v_Period = 5 THEN IFNULL(GLCurrentYearPeriod6,0)
   WHEN v_Period = 6 THEN IFNULL(GLCurrentYearPeriod7,0)
   WHEN v_Period = 7 THEN IFNULL(GLCurrentYearPeriod8,0)
   WHEN v_Period = 8 THEN IFNULL(GLCurrentYearPeriod9,0)
   WHEN v_Period = 9 THEN IFNULL(GLCurrentYearPeriod10,0)
   WHEN v_Period = 10 THEN IFNULL(GLCurrentYearPeriod11,0)
   WHEN v_Period = 11 THEN IFNULL(GLCurrentYearPeriod12,0)
   WHEN v_Period = 12 THEN IFNULL(GLCurrentYearPeriod13,0)
   WHEN v_Period = 13 THEN IFNULL(GLCurrentYearPeriod14,0)
   ELSE 0
   END,
   N'') AS Credit,
	NULL As Total,
	NULL As DebitComparative,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
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
   END,N'') AS CreditComparative,
	NULL As TotalComparative,
	5 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   GLAccountType = 'Expense' AND
		(GLAccountName LIKE '% Draw%' OR GLAccountName LIKE '% Paid%')






   UNION
   SELECT
   'Financing Activities' As CashFlowType,
	GLAccountName As FlowTitle,
    'FinancingActivitiesDedit' As FlowID,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Period = 0 THEN IFNULL(GLCurrentYearPeriod1,0)
   WHEN v_Period = 1 THEN IFNULL(GLCurrentYearPeriod2,0)
   WHEN v_Period = 2 THEN IFNULL(GLCurrentYearPeriod3,0)
   WHEN v_Period = 3 THEN IFNULL(GLCurrentYearPeriod4,0)
   WHEN v_Period = 4 THEN IFNULL(GLCurrentYearPeriod5,0)
   WHEN v_Period = 5 THEN IFNULL(GLCurrentYearPeriod6,0)
   WHEN v_Period = 6 THEN IFNULL(GLCurrentYearPeriod7,0)
   WHEN v_Period = 7 THEN IFNULL(GLCurrentYearPeriod8,0)
   WHEN v_Period = 8 THEN IFNULL(GLCurrentYearPeriod9,0)
   WHEN v_Period = 9 THEN IFNULL(GLCurrentYearPeriod10,0)
   WHEN v_Period = 10 THEN IFNULL(GLCurrentYearPeriod11,0)
   WHEN v_Period = 11 THEN IFNULL(GLCurrentYearPeriod12,0)
   WHEN v_Period = 12 THEN IFNULL(GLCurrentYearPeriod13,0)
   WHEN v_Period = 13 THEN IFNULL(GLCurrentYearPeriod14,0)
   ELSE 0
   END,
   N'') AS Debit,
	NULL As Credit,
	NULL As Total,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
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
   END,N'') AS DebitComparative,
	NULL As CreditComparative,
	NULL As TotalComparative,
	6 As RowNum
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   GLAccountType = 'Expense' AND
   Not (GLAccountName LIKE 'Draw%' OR GLAccountName LIKE 'Paid%')




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
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLPriorYearBeginningBalance,0)),0),
   N'') As TotalComparative,
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
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN v_Period = 0 THEN SUM(IFNULL(GLCurrentYearPeriod1,0))
   WHEN v_Period = 1 THEN SUM(IFNULL(GLCurrentYearPeriod2,0))
   WHEN v_Period = 2 THEN SUM(IFNULL(GLCurrentYearPeriod3,0))
   WHEN v_Period = 3 THEN SUM(IFNULL(GLCurrentYearPeriod4,0))
   WHEN v_Period = 4 THEN SUM(IFNULL(GLCurrentYearPeriod5,0))
   WHEN v_Period = 5 THEN SUM(IFNULL(GLCurrentYearPeriod6,0))
   WHEN v_Period = 6 THEN SUM(IFNULL(GLCurrentYearPeriod7,0))
   WHEN v_Period = 7 THEN SUM(IFNULL(GLCurrentYearPeriod8,0))
   WHEN v_Period = 8 THEN SUM(IFNULL(GLCurrentYearPeriod9,0))
   WHEN v_Period = 9 THEN SUM(IFNULL(GLCurrentYearPeriod10,0))
   WHEN v_Period = 10 THEN SUM(IFNULL(GLCurrentYearPeriod11,0))
   WHEN v_Period = 11 THEN SUM(IFNULL(GLCurrentYearPeriod12,0))
   WHEN v_Period = 12 THEN SUM(IFNULL(GLCurrentYearPeriod13,0))
   WHEN v_Period = 13 THEN SUM(IFNULL(GLCurrentYearPeriod14,0))
   ELSE 0
   END,
   N'') AS Total,
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
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   GLAccountNumber LIKE '11%'
   ORDER BY  9;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowPerionDivisionComparativeDrills',
   v_ErrorMessage,v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowPeriodDivisionYTDDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodDivisionYTDDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Year INT,
	v_Period INT,
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTDDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;






   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
    'CollectionsFromCustomersIncome' As FlowID,
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
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      GLTransactionDate < v_PeriodEndDate AND
      GLAccountNumber LIKE '4%') -GREATEST((SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      GLTransactionDate < v_PeriodEndDate AND
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
	NULL As DebitYTD,
	((SELECT
         fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLDebitAmount,0)),0),
         N'')
         FROM
         LedgerTransactionsDetail
         INNER JOIN LedgerTransactions ON
         LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
         LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
         LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
         LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
         INNER JOIN LedgerChartOfAccounts ON
         GLTransactionAccount = GLAccountNumber AND
         LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
         LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
         LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
         WHERE
         LedgerTransactionsDetail.CompanyID = v_CompanyID AND
         LedgerTransactionsDetail.DivisionID = v_DivisionID AND
         GLTransactionDate < v_PeriodEndDate AND
         GLAccountNumber LIKE '5%'))*(-1)
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
	NULL As DebitYTD,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      GLTransactionDate < v_PeriodEndDate AND
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
	NULL As DebitYTD,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      GLTransactionDate < v_PeriodEndDate AND
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
	NULL As DebitYTD,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      GLTransactionDate < v_PeriodEndDate AND
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
	NULL As DebitYTD,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0)),0),
   N'') As CreditYTD,
	NULL As TotalYTD,
	5 As RowNum
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerTransactions ON
   LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID AND
   GLAccountType = 'Expense' AND
   GLTransactionDate < v_PeriodEndDate AND
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
    'FinancingActivitiesDedit' As FlowID,
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
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLDebitAmount,0)),0),
   N'') As  DebitYTD,
	NULL As CreditYTD,
	NULL As TotalYTD,
	6 As RowNum
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerTransactions ON
   LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID AND
   GLAccountType = 'Expense' AND
   GLTransactionDate < v_PeriodEndDate AND
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
	NULL As DebitYTD,
	NULL As CreditYTD,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
   N'') As TotalYTD,
	8 As RowNum
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerTransactions ON
   LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID AND
   GLTransactionDate < v_PeriodEndDate AND
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
   ORDER BY  9;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTDDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowPeriodYTDDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodYTDDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Year INT,
	v_Period INT,
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTDDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
    'CollectionsFromCustomersIncome' As FlowID,
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
      DepartmentID = v_DepartmentID AND
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
      DepartmentID = v_DepartmentID AND
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
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      GLTransactionDate < v_PeriodEndDate AND
      GLAccountNumber LIKE '4%') -GREATEST((SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      GLTransactionDate < v_PeriodEndDate AND
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
      DepartmentID = v_DepartmentID AND
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
      DepartmentID = v_DepartmentID AND
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
	NULL As DebitYTD,
	((SELECT
         fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLDebitAmount,0)),0),
         N'')
         FROM
         LedgerTransactionsDetail
         INNER JOIN LedgerTransactions ON
         LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
         LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
         LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
         LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
         INNER JOIN LedgerChartOfAccounts ON
         GLTransactionAccount = GLAccountNumber AND
         LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
         LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
         LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
         WHERE
         LedgerTransactionsDetail.CompanyID = v_CompanyID AND
         LedgerTransactionsDetail.DivisionID = v_DivisionID AND
         LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
         GLTransactionDate < v_PeriodEndDate AND
         GLAccountNumber LIKE '5%'))*(-1)
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
      DepartmentID = v_DepartmentID AND
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
	NULL As DebitYTD,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      GLTransactionDate < v_PeriodEndDate AND
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
      DepartmentID = v_DepartmentID AND
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
	NULL As DebitYTD,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      GLTransactionDate < v_PeriodEndDate AND
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
      DepartmentID = v_DepartmentID AND
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
	NULL As DebitYTD,
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
      N'')
      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      GLTransactionDate < v_PeriodEndDate AND
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
   N'') AS Credit,
	NULL As Total,
	NULL As DebitYTD,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0)),0),
   N'') As CreditYTD,
	NULL As TotalYTD,
	5 As RowNum
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerTransactions ON
   LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID AND
   LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
   GLTransactionDate < v_PeriodEndDate AND
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
   GLAccountName,fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
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
   N'')






   UNION
   SELECT
   'Financing Activities' As CashFlowType,
	GLAccountName As FlowTitle,
    'FinancingActivitiesDedit' As FlowID,
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
   N'') AS Debit,
	NULL As Credit,
	NULL As Total,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLDebitAmount,0)),0),
   N'') As  DebitYTD,
	NULL As CreditYTD,
	NULL As TotalYTD,
	6 As RowNum
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerTransactions ON
   LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID AND
   LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
   GLTransactionDate < v_PeriodEndDate AND
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
   GLAccountName,fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
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
   N'')



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
	NULL As DebitYTD,
	NULL As CreditYTD,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0),
   N'') As TotalYTD,
	8 As RowNum
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerTransactions ON
   LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID
   INNER JOIN LedgerChartOfAccounts ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID AND
   LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
   GLTransactionDate < v_PeriodEndDate AND
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
   GROUP BY
   GLAccountName,fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
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
   N'')
   ORDER BY  9;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTDDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLCashFlowYTDDrills;
//

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowYTDDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(GLCreditAmount),0),
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
	(SELECT
      fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(SUM(GLCreditAmount),0),
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
         LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
         GLAccountNumber LIKE '5%') 
	/*+ 	
	(SELECT 
		ISNULL(SUM(GLDebitAmount),0)
	FROM 
		LedgerTransactionsDetail 
			INNER JOIN LedgerChartOfAccounts ON 
			GLTransactionAccount = GLAccountNumber AND
			LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
			LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
			LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
	WHERE
		LedgerTransactionsDetail.CompanyID = @CompanyID AND
		LedgerTransactionsDetail.DivisionID = @DivisionID AND
		LedgerTransactionsDetail.DepartmentID = @DepartmentID AND
		GLAccountNumber LIKE '13%') */ )*(-1)
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
	/*+ 	
	(SELECT 
		dbo.fnRound(@CompanyID, @DivisionID , @DepartmentID, ISNULL(SUM(ISNULL(GLDebitAmount,0)),0),N'')
	FROM 
		LedgerTransactionsDetail 
			INNER JOIN LedgerChartOfAccounts ON 
			GLTransactionAccount = GLAccountNumber AND
			LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
			LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
			LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
	WHERE
		LedgerTransactionsDetail.CompanyID = @CompanyID AND
		LedgerTransactionsDetail.DivisionID = @DivisionID AND
		LedgerTransactionsDetail.DepartmentID = @DepartmentID AND
		GLAccountNumber LIKE '13%') */ )*(-1)
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
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
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
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
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
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
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
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
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
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
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
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
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
   LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
   GLAccountNumber LIKE '11%'
   ORDER BY  9;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTDDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
