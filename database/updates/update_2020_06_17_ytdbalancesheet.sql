DELIMITER //
DROP PROCEDURE IF EXISTS RptGLBalanceSheetYTD;
//
CREATE PROCEDURE RptGLBalanceSheetYTD (v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTD',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;




   SELECT
   GLBalanceType, GLAccountName,
	GLAccountBalance,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,case GLBalanceType
   when 'Asset' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   when 'Expense' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   else SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
   end,
   N'') as GLAccountBalanceYTD from(SELECT GLAccountName, GLAccountBalance, GLBalanceType, GLDebitAmount, GLCreditAmount FROM
      LedgerChartOfAccounts
      LEFT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerChartOfAccounts.DivisionID = v_DivisionID AND
      LedgerChartOfAccounts.DepartmentID = v_DepartmentID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      LedgerTransactions.DivisionID = v_DivisionID AND
      LedgerTransactions.DepartmentID = v_DepartmentID AND
      GLTransactionDate < CURRENT_TIMESTAMP AND
      IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')
      UNION
      SELECT GLAccountName, GLAccountBalance, GLBalanceType, GLDebitAmount, GLCreditAmount FROM
      LedgerChartOfAccounts
      RIGHT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerChartOfAccounts.DivisionID = v_DivisionID AND
      LedgerChartOfAccounts.DepartmentID = v_DepartmentID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      LedgerTransactions.DivisionID = v_DivisionID AND
      LedgerTransactions.DepartmentID = v_DepartmentID AND
      GLTransactionDate < CURRENT_TIMESTAMP AND
      IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')) AS TabAl GROUP BY
   GLBalanceType,GLAccountName,GLAccountBalance;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTD',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END

//

DELIMITER ;


DELIMITER //
DROP PROCEDURE IF EXISTS RptGLBalanceSheetYTDDrills;
//
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetYTDDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
BEGIN













   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);



   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTDDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;




   SELECT
   GLBalanceType, GLAccountName,
   GLAccountNumber,
	GLAccountBalance,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,case GLBalanceType
   when 'Asset' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   when 'Expense' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   else SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
   end,
   N'') as GLAccountBalanceYTD from(SELECT GLAccountName, GLAccountNumber, GLAccountBalance, GLBalanceType, GLDebitAmount, GLCreditAmount FROM
      LedgerChartOfAccounts
      LEFT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerChartOfAccounts.DivisionID = v_DivisionID AND
      LedgerChartOfAccounts.DepartmentID = v_DepartmentID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      LedgerTransactions.DivisionID = v_DivisionID AND
      LedgerTransactions.DepartmentID = v_DepartmentID AND
      GLTransactionDate < CURRENT_TIMESTAMP AND
      IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')
      UNION
      SELECT GLAccountNumber, GLAccountName, GLAccountBalance, GLBalanceType, GLDebitAmount, GLCreditAmount FROM
      LedgerChartOfAccounts
      RIGHT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerChartOfAccounts.DivisionID = v_DivisionID AND
      LedgerChartOfAccounts.DepartmentID = v_DepartmentID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      LedgerTransactions.DivisionID = v_DivisionID AND
      LedgerTransactions.DepartmentID = v_DepartmentID AND
      GLTransactionDate < CURRENT_TIMESTAMP AND
      IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')) AS TabAl GROUP BY
   GLBalanceType,GLAccountName,GLAccountBalance, GLAccountNumber;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTDDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;

//

DELIMITER ;

DELIMITER ;;
DROP PROCEDURE IF EXISTS RptGLBalanceSheetDivisionYTDDrills;
CREATE  PROCEDURE `RptGLBalanceSheetDivisionYTDDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
BEGIN












   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);



   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTDDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;




   SELECT
        DepartmentID,
	GLBalanceType,
	GLAccountName,
    GLAccountNumber,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLAccountBalance),N'') AS GLAccountBalance,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,case GLBalanceType
   when 'Asset' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   when 'Expense' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   else SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
   end,
   N'') as GLAccountBalanceYTD from(SELECT  LedgerTransactions.DepartmentID as DepartmentID, GLAccountName, GLAccountNumber, GLAccountBalance, GLBalanceType, GLDebitAmount, GLCreditAmount FROM
      LedgerChartOfAccounts
      LEFT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerChartOfAccounts.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      LedgerTransactions.DivisionID = v_DivisionID AND
      GLTransactionDate < CURRENT_TIMESTAMP AND
      IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')
      UNION
      SELECT  LedgerTransactions.DepartmentID as DepartmentID, GLAccountNumber, GLAccountName, GLAccountBalance, GLBalanceType, GLDebitAmount, GLCreditAmount  FROM
      LedgerChartOfAccounts
      RIGHT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerChartOfAccounts.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      LedgerTransactions.DivisionID = v_DivisionID AND
      GLTransactionDate < CURRENT_TIMESTAMP AND
      IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')) AS TabAl GROUP BY
   GLBalanceType, GLAccountNumber, GLAccountName, DepartmentID;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTDDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;


DELIMITER //
DROP PROCEDURE IF EXISTS RptGLBalanceSheetDivisionYTD;
//
CREATE    PROCEDURE RptGLBalanceSheetDivisionYTD(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN










/*
Name of stored procedure: RptGLBalanceSheetDivisionYTD
Method: 
	

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department

Output Parameters:

	@PeriodEndDate DateTime 

Called From:

	NONE

Calls:

	LedgerMain_VerifyPeriodCurrent, Error_InsertError

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


-- Get information about current period ending date
   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTD',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

-- Now we create final report
-- We gather all Account Names with their Balances for Asset, Liability and Equity accoutns
-- The data  will be rendered by aspx page in diferent manner depending on GLAccountBalance value
   SELECT
        DepartmentID,
	GLBalanceType,
	GLAccountName,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLAccountBalance),N'') AS GLAccountBalance,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,case GLBalanceType
   when 'Asset' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   when 'Expense' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   else SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
   end,
   N'') as GLAccountBalanceYTD from(SELECT LedgerTransactions.DepartmentID as DepartmentID, GLAccountName, GLAccountBalance, GLBalanceType, GLDebitAmount, GLCreditAmount FROM
      LedgerChartOfAccounts
      LEFT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerChartOfAccounts.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      LedgerTransactions.DivisionID = v_DivisionID AND
      GLTransactionDate < CURRENT_TIMESTAMP AND
      IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')
      UNION
      SELECT LedgerTransactions.DepartmentID as DepartmentID, GLAccountName, GLAccountBalance, GLBalanceType, GLDebitAmount, GLCreditAmount FROM
      LedgerChartOfAccounts
      RIGHT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerChartOfAccounts.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      LedgerTransactions.DivisionID = v_DivisionID AND
      GLTransactionDate < CURRENT_TIMESTAMP AND
      IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')) AS TabAl GROUP BY
   GLBalanceType, GLAccountName,DepartmentID;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;
-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTD',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END;








//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLBalanceSheetCompanyYTD;
//
CREATE    PROCEDURE RptGLBalanceSheetCompanyYTD(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN












/*
Name of stored procedure: RptGLBalanceSheetCompanyYTD
Method: 
	

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department

Output Parameters:

	@PeriodEndDate DateTime 

Called From:

	NONE

Calls:

	LedgerMain_VerifyPeriodCurrent, Error_InsertError

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


-- Get information about current period ending date
   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetCompanyYTD',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

-- Now we create final report
-- We gather all Account Names with their Balances for Asset, Liability and Equity accoutns
-- The data  will be rendered by aspx page in diferent manner depending on GLAccountBalance value
   SELECT
        DivisionID,
	DepartmentID,
	GLBalanceType,
	GLAccountName,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLAccountBalance),N'') AS GLAccountBalance,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,case GLBalanceType
   when 'Asset' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   when 'Expense' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   else SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
   end,
   N'') as GLAccountBalanceYTD from(SELECT LedgerChartOfAccounts.DivisionID, LedgerChartOfAccounts.DepartmentID, GLAccountName, GLAccountBalance, GLBalanceType, GLDebitAmount, GLCreditAmount FROM
      LedgerChartOfAccounts
      LEFT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      GLTransactionDate < CURRENT_TIMESTAMP AND
      IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')
      UNION
      SELECT LedgerChartOfAccounts.DivisionID, LedgerChartOfAccounts.DepartmentID, GLAccountName, GLAccountBalance, GLBalanceType, GLDebitAmount, GLCreditAmount FROM
      LedgerChartOfAccounts
      RIGHT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      GLTransactionDate < CURRENT_TIMESTAMP AND
      IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')) AS TabAl GROUP BY
   GLBalanceType,GLAccountName,DivisionID,DepartmentID;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;
-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetCompanyYTD',
   v_ErrorMessage,v_ErrorID);
   SET SWP_Ret_Value = -1;
END;








//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLBalanceSheetCompanyDrills;
//
CREATE  PROCEDURE RptGLBalanceSheetCompanyDrills(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
BEGIN












   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);



   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetCompanyDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;




   SELECT
   CompanyID,
   DivisionID,
	DepartmentID,
	GLBalanceType,
	GLAccountName,
    GLAccountNumber,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLAccountBalance),N'') AS GLAccountBalance
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')
   GROUP BY
   GLBalanceType,GLAccountNumber,GLAccountName,DivisionID,DepartmentID;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetCompanyDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;

//
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLBalanceSheetCompanyYTDDrills;
//

CREATE PROCEDURE `RptGLBalanceSheetCompanyYTDDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
BEGIN














   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);



   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetCompanyYTDDrills',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;




   SELECT
   DivisionID,
	DepartmentID,
	GLBalanceType,
	GLAccountName,
    GLAccountNumber,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLAccountBalance),N'') AS GLAccountBalance,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,case GLBalanceType
   when 'Asset' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   when 'Expense' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   else SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
   end,
   N'') as GLAccountBalanceYTD from(SELECT LedgerChartOfAccounts.DivisionID, LedgerChartOfAccounts.DepartmentID, GLAccountNumber, GLAccountName, GLAccountBalance, GLBalanceType, GLDebitAmount, GLCreditAmount FROM
      LedgerChartOfAccounts
      LEFT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      GLTransactionDate < CURRENT_TIMESTAMP AND
      IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')
      UNION
      SELECT LedgerChartOfAccounts.DivisionID, LedgerChartOfAccounts.DepartmentID, GLAccountNumber, GLAccountName, GLAccountBalance, GLBalanceType, GLDebitAmount, GLCreditAmount FROM
      LedgerChartOfAccounts
      RIGHT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      GLTransactionDate < CURRENT_TIMESTAMP AND
      IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')) AS TabAl GROUP BY
   GLBalanceType,GLAccountNumber, GLAccountName,DivisionID,DepartmentID;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetCompanyYTDDrills',
   v_ErrorMessage,v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;

//
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RptGLBalanceSheetDivisionDrills;
//

CREATE PROCEDURE `RptGLBalanceSheetDivisionDrills`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
BEGIN










   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);



   DECLARE v_ErrorID INT;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerMain_CurrenPeriod call failed';
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;




   SELECT
   DepartmentID,
	GLBalanceType,
	GLAccountName,
    GLAccountNumber,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLAccountBalance),N'') AS GLAccountBalance
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')
   GROUP BY
   GLBalanceType, GLAccountNumber, GLAccountName,DepartmentID;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
//
DELIMITER ;
