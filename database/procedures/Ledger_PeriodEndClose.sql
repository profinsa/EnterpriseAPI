CREATE PROCEDURE Ledger_PeriodEndClose (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_CurrentYear SMALLINT;
   DECLARE v_CurrentPeriod INT;
   DECLARE v_PeriodStartDate DATETIME;
   DECLARE v_PeriodEndDate DATETIME;
   DECLARE v_NextPeriodStartDate DATETIME;
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;
   CALL LedgerMain_CurrentPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CurrentPeriod,v_PeriodStartDate,
   v_PeriodEndDate, v_ReturnStatus);

   IF v_ReturnStatus <> 0 then   

      SET v_ErrorMessage = 'Fail to get current Period';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   IF v_PeriodEndDate IS NULL then

      SET v_ErrorMessage = 'All Periods have been closed.';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_PeriodEndDate >= CURRENT_TIMESTAMP then

      SET v_ErrorMessage = 'Can't close period. Current period is not finished yet.';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   select   CurrentFiscalYear INTO v_CurrentYear FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID
   AND CurrentFiscalYear = YEAR(CurrentPeriod);
   SET v_NextPeriodStartDate = TIMESTAMPADD(day,1,v_PeriodEndDate);
   SET v_NextPeriodStartDate = STR_TO_DATE(DATE_FORMAT(v_NextPeriodStartDate,'%Y-%m-%d'),'%Y%m%d');

   SET @SWV_Error = 0;
   CALL FinancialsRecalc(v_CompanyID,v_DivisionID,v_DepartmentID, v_ReturnStatus);
   IF @SWV_Error <> 0 AND v_ReturnStatus = -1 then
	
	
      SET v_ErrorMessage = 'Financials recalc failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	



   CREATE TEMPORARY TABLE tt_Temp AS SELECT
      CASE
      WHEN SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)) < 0 THEN -SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
      ELSE SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0))
      END AS Balance,
		GLTransactionAccount

      FROM
      LedgerTransactionsDetail
      INNER JOIN LedgerChartOfAccounts ON
      GLTransactionAccount = GLAccountNumber AND
      LedgerTransactionsDetail.CompanyID = LedgerChartOfAccounts.CompanyID AND
      LedgerTransactionsDetail.DivisionID = LedgerChartOfAccounts.DivisionID AND
      LedgerTransactionsDetail.DepartmentID = LedgerChartOfAccounts.DepartmentID
      INNER JOIN LedgerTransactions ON
      LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber
      WHERE
      LedgerTransactionsDetail.CompanyID = v_CompanyID AND
      LedgerTransactionsDetail.DivisionID = v_DivisionID AND
      LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
      LedgerTransactions.GLTransactionDate < v_NextPeriodStartDate AND
      IFNULL(LedgerTransactions.GLTransactionPostedYN,0) = 1 AND
      UPPER(LedgerTransactions.GLTransactionNumber) <> 'DEFAULT'
      GROUP BY
      GLTransactionAccount;
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Selecting summaries from LedgerTransactionsDetail failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   IF v_CurrentPeriod = 0 then

      UPDATE
      LedgerChartOfAccounts
      SET
      GLCurrentYearPeriod1 =(SELECT
      Balance
      FROM
      tt_Temp T
      WHERE
      T.GLTransactionAccount = GLAccountNumber)
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;

   ELSE 
      IF v_CurrentPeriod = 1 then

         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod2 =(SELECT
         Balance
         FROM
         tt_Temp T
         WHERE
         T.GLTransactionAccount = GLAccountNumber)
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID;

      ELSE 
         IF v_CurrentPeriod = 2 then

            UPDATE
            LedgerChartOfAccounts
            SET
            GLCurrentYearPeriod3 =(SELECT
            Balance
            FROM
            tt_Temp T
            WHERE
            T.GLTransactionAccount = GLAccountNumber)
            WHERE
            CompanyID = v_CompanyID AND
            DivisionID = v_DivisionID AND
            DepartmentID = v_DepartmentID;

         ELSE 
            IF v_CurrentPeriod = 3 then

               UPDATE
               LedgerChartOfAccounts
               SET
               GLCurrentYearPeriod4 =(SELECT
               Balance
               FROM
               tt_Temp T
               WHERE
               T.GLTransactionAccount = GLAccountNumber)
               WHERE
               CompanyID = v_CompanyID AND
               DivisionID = v_DivisionID AND
               DepartmentID = v_DepartmentID;

            ELSE 
               IF v_CurrentPeriod = 4 then

                  UPDATE
                  LedgerChartOfAccounts
                  SET
                  GLCurrentYearPeriod5 =(SELECT
                  Balance
                  FROM
                  tt_Temp T
                  WHERE
                  T.GLTransactionAccount = GLAccountNumber)
                  WHERE
                  CompanyID = v_CompanyID AND
                  DivisionID = v_DivisionID AND
                  DepartmentID = v_DepartmentID;

               ELSE 
                  IF v_CurrentPeriod = 5 then

                     UPDATE
                     LedgerChartOfAccounts
                     SET
                     GLCurrentYearPeriod6 =(SELECT
                     Balance
                     FROM
                     tt_Temp T
                     WHERE
                     T.GLTransactionAccount = GLAccountNumber)
                     WHERE
                     CompanyID = v_CompanyID AND
                     DivisionID = v_DivisionID AND
                     DepartmentID = v_DepartmentID;

                  ELSE 
                     IF v_CurrentPeriod = 6 then

                        UPDATE
                        LedgerChartOfAccounts
                        SET
                        GLCurrentYearPeriod7 =(SELECT
                        Balance
                        FROM
                        tt_Temp T
                        WHERE
                        T.GLTransactionAccount = GLAccountNumber)
                        WHERE
                        CompanyID = v_CompanyID AND
                        DivisionID = v_DivisionID AND
                        DepartmentID = v_DepartmentID;

                     ELSE 
                        IF v_CurrentPeriod = 7 then

                           UPDATE
                           LedgerChartOfAccounts
                           SET
                           GLCurrentYearPeriod8 =(SELECT
                           Balance
                           FROM
                           tt_Temp T
                           WHERE
                           T.GLTransactionAccount = GLAccountNumber)
                           WHERE
                           CompanyID = v_CompanyID AND
                           DivisionID = v_DivisionID AND
                           DepartmentID = v_DepartmentID;

                        ELSE 
                           IF v_CurrentPeriod = 8 then

                              UPDATE
                              LedgerChartOfAccounts
                              SET
                              GLCurrentYearPeriod9 =(SELECT
                              Balance
                              FROM
                              tt_Temp T
                              WHERE
                              T.GLTransactionAccount = GLAccountNumber)
                              WHERE
                              CompanyID = v_CompanyID AND
                              DivisionID = v_DivisionID AND
                              DepartmentID = v_DepartmentID;

                           ELSE 
                              IF v_CurrentPeriod = 9 then

                                 UPDATE
                                 LedgerChartOfAccounts
                                 SET
                                 GLCurrentYearPeriod10 =(SELECT
                                 Balance
                                 FROM
                                 tt_Temp T
                                 WHERE
                                 T.GLTransactionAccount = GLAccountNumber)
                                 WHERE
                                 CompanyID = v_CompanyID AND
                                 DivisionID = v_DivisionID AND
                                 DepartmentID = v_DepartmentID;
                              ELSE 
                                 IF v_CurrentPeriod = 10 then

                                    UPDATE
                                    LedgerChartOfAccounts
                                    SET
                                    GLCurrentYearPeriod11 =(SELECT
                                    Balance
                                    FROM
                                    tt_Temp T
                                    WHERE
                                    T.GLTransactionAccount = GLAccountNumber)
                                    WHERE
                                    CompanyID = v_CompanyID AND
                                    DivisionID = v_DivisionID AND
                                    DepartmentID = v_DepartmentID;
                                 ELSE 
                                    IF v_CurrentPeriod = 11 then

                                       UPDATE
                                       LedgerChartOfAccounts
                                       SET
                                       GLCurrentYearPeriod12 =(SELECT
                                       Balance
                                       FROM
                                       tt_Temp T
                                       WHERE
                                       T.GLTransactionAccount = GLAccountNumber)
                                       WHERE
                                       CompanyID = v_CompanyID AND
                                       DivisionID = v_DivisionID AND
                                       DepartmentID = v_DepartmentID;
                                    ELSE 
                                       IF v_CurrentPeriod = 12 then

                                          UPDATE
                                          LedgerChartOfAccounts
                                          SET
                                          GLCurrentYearPeriod13 =(SELECT
                                          Balance
                                          FROM
                                          tt_Temp T
                                          WHERE
                                          T.GLTransactionAccount = GLAccountNumber)
                                          WHERE
                                          CompanyID = v_CompanyID AND
                                          DivisionID = v_DivisionID AND
                                          DepartmentID = v_DepartmentID;
                                       ELSE 
                                          IF v_CurrentPeriod = 13 then

                                             UPDATE
                                             LedgerChartOfAccounts
                                             SET
                                             GLCurrentYearPeriod14 =(SELECT
                                             Balance
                                             FROM
                                             tt_Temp T
                                             WHERE
                                             T.GLTransactionAccount = GLAccountNumber)
                                             WHERE
                                             CompanyID = v_CompanyID AND
                                             DivisionID = v_DivisionID AND
                                             DepartmentID = v_DepartmentID;
                                          end if;
                                       end if;
                                    end if;
                                 end if;
                              end if;
                           end if;
                        end if;
                     end if;
                  end if;
               end if;
            end if;
         end if;
      end if;
   end if;
   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'Updating LedgerChartOfAccounts failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	
   SET @SWV_Error = 0;
   UPDATE
   Companies
   SET
   Period1Closed = CASE v_CurrentPeriod WHEN 0 THEN 1 ELSE Period1Closed END,Period2Closed = CASE v_CurrentPeriod WHEN 1 THEN 1 ELSE Period2Closed END,Period3Closed = CASE v_CurrentPeriod WHEN 2 THEN 1 ELSE Period3Closed END,Period4Closed = CASE v_CurrentPeriod WHEN 3 THEN 1 ELSE Period4Closed END,Period5Closed = CASE v_CurrentPeriod WHEN 4 THEN 1 ELSE Period5Closed END,Period6Closed = CASE v_CurrentPeriod WHEN 5 THEN 1 ELSE Period6Closed END,Period7Closed = CASE v_CurrentPeriod WHEN 6 THEN 1 ELSE Period7Closed END,Period8Closed = CASE v_CurrentPeriod WHEN 7 THEN 1 ELSE Period8Closed END,Period9Closed = CASE v_CurrentPeriod WHEN 8 THEN 1 ELSE Period9Closed END,Period10Closed = CASE v_CurrentPeriod WHEN 9 THEN 1 ELSE Period10Closed END,Period11Closed = CASE v_CurrentPeriod WHEN 10 THEN 1 ELSE Period11Closed END,Period12Closed = CASE v_CurrentPeriod WHEN 11 THEN 1 ELSE Period12Closed END,Period13Closed = CASE v_CurrentPeriod WHEN 12 THEN 1 ELSE Period13Closed END,Period14Closed = CASE v_CurrentPeriod WHEN 13 THEN 1 ELSE Period14Closed END
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'Updating Companies failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   SET @SWV_Error = 0;
   DROP TEMPORARY TABLE IF EXISTS tt_Temp;
   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'Dropping temporary table failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	


   CALL LedgerMain_CurrentPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CurrentPeriod,v_PeriodStartDate,
   v_PeriodEndDate, v_ReturnStatus);
   IF v_ReturnStatus <> 0 then 

      SET v_ErrorMessage = 'Fail to get current Period';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;
   UPDATE
   Companies
   SET
   CurrentPeriod = v_PeriodEndDate
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_PeriodEndClose',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END