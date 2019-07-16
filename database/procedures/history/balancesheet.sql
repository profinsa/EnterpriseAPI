/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
   GLBalanceType, GLAccountName, GLAccountNumber,fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,GLAccountBalance,N'') AS GLAccountBalance
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity'); 


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetCompanyDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetCompanyDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
   GLBalanceType,GLAccountName,DivisionID,DepartmentID;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetCompanyDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetCompanyComparativeDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetCompanyComparativeDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetCompanyComparativeDrills',
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
   END),N'') AS GLAccountBalanceComparative
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity')
   GROUP BY
   GLBalanceType,GLAccountName,DivisionID,DepartmentID;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetCompanyComparativeDrills',
   v_ErrorMessage,v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetCompanyYTDDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetCompanyYTDDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
   LedgerChartOfAccounts.DivisionID as DivisionID,
	LedgerChartOfAccounts.DepartmentID as DepartmentID,
	GLBalanceType,
	GLAccountName,
    GLAccountNumber,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLAccountBalance),N'') AS GLAccountBalance,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,case GLBalanceType
   when 'Asset' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   when 'Expense' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   else SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
   end,
   N'') as GLAccountBalanceYTD from(SELECT * FROM
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
      SELECT * FROM
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
   GLBalanceType,GLAccountName,LedgerChartOfAccounts.DivisionID,LedgerChartOfAccounts.DepartmentID;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetCompanyYTDDrills',
   v_ErrorMessage,v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetComparativeDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetComparativeDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetComparativeDrills',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;




   SELECT
   GLBalanceType, GLAccountName,
   GLAccountNumber,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,GLAccountBalance,N'') AS GLAccountBalance,
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
   END,N'') AS GLAccountBalanceComparative
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   IFNULL(GLAccountBalance,0) <> 0 AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity'); 


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetComparativeDrills',
   v_ErrorMessage,v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetDivisionDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetDivisionDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
   GLBalanceType,GLAccountName,DepartmentID;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetDivisionComparativeDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetDivisionComparativeDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetComparativeDrills',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;




   SELECT
   DepartmentID,
	GLBalanceType,
	GLAccountName,
    GLAccountNumber,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLAccountBalance),N'') AS GLAccountBalance,
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
   END),N'') AS GLAccountBalanceComparative
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






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetComparativeDrills',
   v_ErrorMessage,v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetDivisionYTDDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetDivisionYTDDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
   LedgerChartOfAccounts.DepartmentID as DepartmentID,
	GLBalanceType,
	GLAccountName,
    GLAccountNumber,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(GLAccountBalance),N'') AS GLAccountBalance,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,case GLBalanceType
   when 'Asset' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   when 'Expense' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   else SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
   end,
   N'') as GLAccountBalanceYTD from(SELECT * FROM
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
      SELECT * FROM
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
   GLBalanceType,GLAccountName,LedgerChartOfAccounts.DepartmentID;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTDDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetPeriodDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetPeriodDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;




   SELECT
   GLBalanceType,
	GLAccountName,
    GLAccountNumber,
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






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetPeriodCompanyDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetPeriodCompanyDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;




   SELECT
   GLBalanceType,
	GLAccountName,
    GLAccountNumber,
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
   N'') AS GLAccountBalance
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
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
   END
   GROUP BY
   GLBalanceType,GLAccountName;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetPeriodCompanyComparativeDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetPeriodCompanyComparativeDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetComparativeDrills',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;




   SELECT
   GLBalanceType,
	GLAccountName,
    GLAccountNumber,
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
   N'') AS GLAccountBalance,
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
   END,N'') AS GLAccountBalanceComparative
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity') AND
	(0 <>
   CASE
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
   END)
   OR
		(0 <>
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
   GROUP BY
   GLBalanceType,GLAccountName;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetComparativeDrills',
   v_ErrorMessage,v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetPeriodCompanyYTDDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetPeriodCompanyYTDDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTDDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;




   SELECT
   GLBalanceType,
	GLAccountName,
    GLAccountNumber,
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
   N'') AS GLAccountBalance,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,case GLBalanceType
   when 'Asset' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   when 'Expense' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   else SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
   end,
   N'') as GLAccountBalanceYTD from(SELECT * FROM
      LedgerChartOfAccounts
      LEFT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      GLTransactionDate < v_PeriodEndDate AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity') AND
      0 <>
      CASE
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
      END
      UNION
      SELECT * FROM
      LedgerChartOfAccounts
      RIGHT outer join LedgerTransactionsDetail
      on LedgerTransactionsDetail.GLTransactionAccount = LedgerChartOfAccounts.GLAccountNumber
      inner join LedgerTransactions
      on LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
      WHERE
      LedgerChartOfAccounts.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactions.CompanyID = v_CompanyID AND
      GLTransactionDate < v_PeriodEndDate AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity') AND
      0 <>
      CASE
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
      END) AS TabAl GROUP BY
   GLBalanceType,GLAccountName,CASE
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
   END;



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTDDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetPeriodComparativeDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetPeriodComparativeDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetComparativeDrills',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;




   SELECT
   GLBalanceType,
	GLAccountName,
    GLAccountNumber,
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
   N'') AS GLAccountBalance,
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
   END,N'') AS GLAccountBalanceComparative
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity') AND
	(0 <>
   CASE
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
   END)
   OR
		(0 <>
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
   END);


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetComparativeDrills',
   v_ErrorMessage,v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetPeriodDivisionDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetPeriodDivisionDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;





   SELECT
   GLBalanceType,
	GLAccountName,
    GLAccountNumber,
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
   N'') AS GLAccountBalance
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
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
   END
   GROUP BY
   GLBalanceType,GLAccountName;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetPeriodDivisionComparativeDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetPeriodDivisionComparativeDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetComparativeDrills',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;





   SELECT
   GLBalanceType,
	GLAccountName,
    GLAccountNumber,
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
   N'') AS GLAccountBalance,
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
   END,N'') AS GLAccountBalanceComparative
   FROM
   LedgerChartOfAccounts
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity') AND
	(0 <>
   CASE
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
   END)
   OR
		(0 <>
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
   GROUP BY
   GLBalanceType,GLAccountName;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetComparativeDrills',
   v_ErrorMessage,v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetPeriodDivisionYTDDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetPeriodDivisionYTDDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTDDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;





   SELECT
   GLBalanceType,
	GLAccountName,
    GLAccountNumber,
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
   N'') AS GLAccountBalance,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,case GLBalanceType
   when 'Asset' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   when 'Expense' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   else SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
   end,
   N'') as GLAccountBalanceYTD from(SELECT * FROM
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
      GLTransactionDate < v_PeriodEndDate AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity') AND
      0 <>
      CASE
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
      END
      UNION
      SELECT * FROM
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
      GLTransactionDate < v_PeriodEndDate AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity') AND
      0 <>
      CASE
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
      END) AS TabAl GROUP BY
   GLBalanceType,GLAccountName,CASE
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
   END;



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTDDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetPeriodYTDDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBalanceSheetPeriodYTDDrills`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTDDrills',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   IF v_Year = 1 then
	
      SET v_PeriodEndDate = TIMESTAMPADD(year,-1,v_PeriodEndDate);
   end if;




   SELECT
   GLBalanceType,
	GLAccountName,
    GLAccountNumber,
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
   N'') AS GLAccountBalance,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,case GLBalanceType
   when 'Asset' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   when 'Expense' then SUM(IFNULL(GLDebitAmount,0) -IFNULL(GLCreditAmount,0))
   else SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
   end,
   N'') as GLAccountBalanceYTD from(SELECT * FROM
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
      GLTransactionDate < v_PeriodEndDate AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity') AND
      0 <>
      CASE
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
      END
      UNION
      SELECT * FROM
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
      GLTransactionDate < v_PeriodEndDate AND
	(GLBalanceType = 'Asset' OR GLBalanceType = 'Liability' OR GLBalanceType = 'Equity') AND
      0 <>
      CASE
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
      END) AS TabAl GROUP BY
   GLBalanceType,GLAccountName,fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
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
   N'');



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTDDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBalanceSheetYTDDrills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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
   N'') as GLAccountBalanceYTD from(SELECT * FROM
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
      SELECT * FROM
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






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTDDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBudgetingTrialBalance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBudgetingTrialBalance`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;




   SELECT
   GLBudgetID As GLAccountName,
   GLAccountNumber,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN -SUM(GLCreditAmount -GLDebitAmount)
   ELSE SUM(GLCreditAmount -GLDebitAmount)
   END,v_CompanyCurrencyID) AS GLAccountBalance,
		CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN 'Debit'
   ELSE 'Credit'
   END AS GLBalanceType
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerChartOfAccountsBudgets ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccountsBudgets.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccountsBudgets.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccountsBudgets.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID AND
   LedgerTransactionsDetail.DepartmentID = v_DepartmentID
   GROUP BY
   GLAccountNumber,GLBudgetID
   ORDER BY
   GLBalanceType DESC;



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBudgetingTrialBalanceCompany` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBudgetingTrialBalanceCompany`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;




   SELECT
   GLBudgetID As GLAccountName,
   GLAccountNumber,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN -SUM(GLCreditAmount -GLDebitAmount)
   ELSE SUM(GLCreditAmount -GLDebitAmount)
   END,v_CompanyCurrencyID) AS GLAccountBalance,
		CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN 'Debit'
   ELSE 'Credit'
   END AS GLBalanceType
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerChartOfAccountsBudgets ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccountsBudgets.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccountsBudgets.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccountsBudgets.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID
   GROUP BY
   GLAccountNumber,GLBudgetID
   ORDER BY
   GLBalanceType DESC;



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBudgetingTrialBalanceCompanyYTD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBudgetingTrialBalanceCompanyYTD`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;



   SELECT
   GLBudgetID As GLAccountName,
   GLAccountNumber,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN -SUM(GLCreditAmount -GLDebitAmount)
   ELSE SUM(GLCreditAmount -GLDebitAmount)
   END,v_CompanyCurrencyID) AS GLAccountBalance,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN -SUM(GLCreditAmount -GLDebitAmount)
   ELSE SUM(GLCreditAmount -GLDebitAmount)
   END,v_CompanyCurrencyID) AS GLAccountBalanceYTD,
		CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN 'Debit'
   ELSE 'Credit'
   END AS GLBalanceType
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerChartOfAccountsBudgets ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccountsBudgets.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccountsBudgets.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccountsBudgets.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID
   GROUP BY
   GLAccountNumber,GLBudgetID
   ORDER BY
   GLBalanceType DESC;



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBudgetingTrialBalanceDivision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBudgetingTrialBalanceDivision`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;



   SELECT
   GLBudgetID As GLAccountName,
   GLAccountNumber,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN -SUM(GLCreditAmount -GLDebitAmount)
   ELSE SUM(GLCreditAmount -GLDebitAmount)
   END,v_CompanyCurrencyID) AS GLAccountBalance,
		CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN 'Debit'
   ELSE 'Credit'
   END AS GLBalanceType
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerChartOfAccountsBudgets ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccountsBudgets.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccountsBudgets.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccountsBudgets.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID
   GROUP BY
   GLAccountNumber,GLBudgetID
   ORDER BY
   GLBalanceType DESC;



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBudgetingTrialBalanceDivisionYTD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBudgetingTrialBalanceDivisionYTD`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;



   SELECT
   GLBudgetID As GLAccountName,
   GLAccountNumber,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN -SUM(GLCreditAmount -GLDebitAmount)
   ELSE SUM(GLCreditAmount -GLDebitAmount)
   END,v_CompanyCurrencyID) AS GLAccountBalance,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN -SUM(GLCreditAmount -GLDebitAmount)
   ELSE SUM(GLCreditAmount -GLDebitAmount)
   END,v_CompanyCurrencyID) AS GLAccountBalanceYTD,
		CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN 'Debit'
   ELSE 'Credit'
   END AS GLBalanceType
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerChartOfAccountsBudgets ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccountsBudgets.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccountsBudgets.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccountsBudgets.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID
   GROUP BY
   GLAccountNumber,GLBudgetID
   ORDER BY
   GLBalanceType DESC;



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLBudgetingTrialBalanceYTD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLBudgetingTrialBalanceYTD`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;



   SELECT
   GLBudgetID As GLAccountName,
   GLAccountNumber,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN -SUM(GLCreditAmount -GLDebitAmount)
   ELSE SUM(GLCreditAmount -GLDebitAmount)
   END,v_CompanyCurrencyID) AS GLAccountBalance,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN -SUM(GLCreditAmount -GLDebitAmount)
   ELSE SUM(GLCreditAmount -GLDebitAmount)
   END,v_CompanyCurrencyID) AS GLAccountBalanceYTD,
		CASE
   WHEN SUM(GLCreditAmount -GLDebitAmount) < 0 THEN 'Debit'
   ELSE 'Credit'
   END AS GLBalanceType
   FROM
   LedgerTransactionsDetail
   INNER JOIN LedgerChartOfAccountsBudgets ON
   GLTransactionAccount = GLAccountNumber AND
   LedgerTransactionsDetail.CompanyID = LedgerChartOfAccountsBudgets.CompanyID AND
   LedgerTransactionsDetail.DivisionID = LedgerChartOfAccountsBudgets.DivisionID AND
   LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccountsBudgets.DepartmentID
   WHERE
   LedgerTransactionsDetail.CompanyID = v_CompanyID AND
   LedgerTransactionsDetail.DivisionID = v_DivisionID AND
   LedgerTransactionsDetail.DepartmentID = v_DepartmentID
   GROUP BY
   GLAccountNumber,GLBudgetID
   ORDER BY
   GLBalanceType DESC;



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptBalanceSheet',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlow` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlow`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlow',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
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
      GLAccountNumber LIKE '4%') -(SELECT
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
      GLAccountNumber LIKE '12%')
   As Debit,
	NULL As Credit,
	NULL As Total,
	0 RowNum



   UNION
   SELECT
   'Operating Activities' As CashFlowType,
	'Payments for Merchandise (Cost of Goods)' As FlowTitle,
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlow',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowCompany` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowCompany`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlow',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
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
      GLAccountNumber LIKE '4%') -(SELECT
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
      GLAccountNumber LIKE '12%')
   As Debit,
	NULL As Credit,
	NULL As Total,
	0 RowNum


   UNION
   SELECT
   'Operating Activities' As CashFlowType,
	'Payments for Merchandise (Cost of Goods)' As FlowTitle,
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlow',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowCompanyComparative` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowCompanyComparative`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowComparative',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
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
      GLAccountNumber LIKE '4%') -(SELECT
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
      GLAccountNumber LIKE '12%')
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowComparative',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowCompanyYTD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowCompanyYTD`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTD',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
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
      GLAccountNumber LIKE '4%') -(SELECT
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
      GLAccountNumber LIKE '12%')
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
      GLAccountNumber LIKE '4%') -(SELECT
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
      GLAccountNumber LIKE '12%')
   As DebitYTD,
	NULL As CreditYTD,
	NULL As TotalYTD,
	0 RowNum



   UNION
   SELECT
   'Operating Activities' As CashFlowType,
	'Payments for Merchandise (Cost of Goods)' As FlowTitle,
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTD',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowComparative` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowComparative`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowComparative',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
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
      GLAccountNumber LIKE '4%') -(SELECT
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
      GLAccountNumber LIKE '12%')
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowComparative',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowDivision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowDivision`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlow',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
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
      GLAccountNumber LIKE '4%') -(SELECT
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
      GLAccountNumber LIKE '12%')
   As Debit,
	NULL As Credit,
	NULL As Total,
	0 RowNum


   UNION
   SELECT
   'Operating Activities' As CashFlowType,
	'Payments for Merchandise (Cost of Goods)' As FlowTitle,
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlow',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowDivisionComparative` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowDivisionComparative`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowComparative',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
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
      GLAccountNumber LIKE '4%') -(SELECT
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
      GLAccountNumber LIKE '12%')
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowComparative',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowDivisionYTD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowDivisionYTD`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTD',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
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
      GLAccountNumber LIKE '4%') -(SELECT
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
      GLAccountNumber LIKE '12%')
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
      GLAccountNumber LIKE '4%') -(SELECT
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
      GLAccountNumber LIKE '12%')
   As DebitYTD,
	NULL As CreditYTD,
	NULL As TotalYTD,
	0 RowNum



   UNION
   SELECT
   'Operating Activities' As CashFlowType,
	'Payments for Merchandise (Cost of Goods)' As FlowTitle,
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTD',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowPeriod` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriod`(v_CompanyID NATIONAL VARCHAR(36),
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlow',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowPeriodCompany` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodCompany`(v_CompanyID NATIONAL VARCHAR(36),
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlow',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowPeriodCompanyComparative` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodCompanyComparative`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowPeriodCompanyComparative',
      v_ErrorMessage,v_ErrorID);
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowPeriodCompanyComparative',
   v_ErrorMessage,v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowPeriodCompanyYTD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodCompanyYTD`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTD',v_ErrorMessage,
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
      GLAccountNumber LIKE '4%') -(SELECT
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
      GLAccountNumber LIKE '12%')
   As DebitYTD,
	NULL As CreditYTD,
	NULL As TotalYTD,
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTD',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowPeriodComparative` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodComparative`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowComparative',v_ErrorMessage,
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowComparative',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowPeriodDivision` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodDivision`(v_CompanyID NATIONAL VARCHAR(36),
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowPeriodDivisionComparative` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodDivisionComparative`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowPerionDivisionComparative',
      v_ErrorMessage,v_ErrorID);
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowPerionDivisionComparative',
   v_ErrorMessage,v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowPeriodDivisionYTD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodDivisionYTD`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTD',v_ErrorMessage,
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
      GLAccountNumber LIKE '4%') -(SELECT
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
      GLAccountNumber LIKE '12%')
   As DebitYTD,
	NULL As CreditYTD,
	NULL As TotalYTD,
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTD',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowPeriodYTD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowPeriodYTD`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTD',v_ErrorMessage,
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
      GLAccountNumber LIKE '4%') -(SELECT
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
      GLAccountNumber LIKE '12%')
   As DebitYTD,
	NULL As CreditYTD,
	NULL As TotalYTD,
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTD',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCashFlowYTD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCashFlowYTD`(v_CompanyID NATIONAL VARCHAR(36),
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTD',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;





   SELECT
   'Operating Activities' As CashFlowType,
	'Collections from Customers (Income)' As FlowTitle,
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
      GLAccountNumber LIKE '4%') -(SELECT
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
      GLAccountNumber LIKE '12%')
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
      GLAccountNumber LIKE '4%') -(SELECT
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
      GLAccountNumber LIKE '12%')
   As DebitYTD,
	NULL As CreditYTD,
	NULL As TotalYTD,
	0 RowNum



   UNION
   SELECT
   'Operating Activities' As CashFlowType,
	'Payments for Merchandise (Cost of Goods)' As FlowTitle,
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







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLCashFlowYTD',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCompareBalanceSheetCompany` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCompareBalanceSheetCompany`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetDrills',v_ErrorMessage,
      v_ErrorID);
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






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCompareBalanceSheetCompanyComparative` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCompareBalanceSheetCompanyComparative`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RptGLCompareBalanceSheetCompanyYTD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RptGLCompareBalanceSheetCompanyYTD`(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodEndDate DATETIME ,INOUT SWP_Ret_Value INT)
SWL_return:
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
      CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTDDrills',v_ErrorMessage,
      v_ErrorID);
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






   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptGLBalanceSheetYTDDrills',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END ;;
DELIMITER ;