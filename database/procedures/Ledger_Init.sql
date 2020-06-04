CREATE PROCEDURE Ledger_Init (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_CurrentYear SMALLINT;
   DECLARE v_CurrentPeriod INT;
   DECLARE v_ActualPeriod INT;
   DECLARE v_PeriodStartDate DATETIME;
   DECLARE v_PeriodEndDate DATETIME;
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;
   UPDATE LedgerChartOfAccounts
   SET
   GLAccountBalance = 0,GLAccountBeginningBalance = 0,GLCurrentYearBeginningBalance = 0,
   GLCurrentYearPeriod1 = 0,GLCurrentYearPeriod2 = 0,GLCurrentYearPeriod3 = 0,
   GLCurrentYearPeriod4 = 0,GLCurrentYearPeriod5 = 0,GLCurrentYearPeriod6 = 0,
   GLCurrentYearPeriod7 = 0,GLCurrentYearPeriod8 = 0,GLCurrentYearPeriod9 = 0,
   GLCurrentYearPeriod10 = 0,GLCurrentYearPeriod11 = 0,GLCurrentYearPeriod12 = 0,
   GLCurrentYearPeriod13 = 0,GLCurrentYearPeriod14 = 0,GLBudgetBeginningBalance = 0,
   GLBudgetPeriod1 = 0,GLBudgetPeriod2 = 0,GLBudgetPeriod3 = 0,GLBudgetPeriod4 = 0,
   GLBudgetPeriod5 = 0,GLBudgetPeriod6 = 0,GLBudgetPeriod7 = 0,GLBudgetPeriod8 = 0,
   GLBudgetPeriod9 = 0,GLBudgetPeriod10 = 0,GLBudgetPeriod11 = 0,
   GLBudgetPeriod12 = 0,GLBudgetPeriod13 = 0,GLBudgetPeriod14 = 0,GLPriorYearBeginningBalance = 0,
   GLPriorYearPeriod1 = 0,GLPriorYearPeriod2 = 0,GLPriorYearPeriod3 = 0,
   GLPriorYearPeriod4 = 0,GLPriortYearPeriod5 = 0,GLPriorYearPeriod6 = 0,
   GLPriorYearPeriod7 = 0,GLPriorYearPeriod8 = 0,GLPriorYearPeriod9 = 0,
   GLPriortYearPeriod10 = 0,GLPriorYearPeriod11 = 0,GLPriorYearPeriod12 = 0,GLPriorYearPeriod13 = 0,
   GLPriorYearPeriod14 = 0
   WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
   select   CurrentFiscalYear INTO v_CurrentYear FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   SET @SWV_Error = 0;
   CALL FinancialsRecalc2(v_CompanyID,v_DivisionID,v_DepartmentID);
   IF @SWV_Error <> 0 then
	
	
      SET v_ErrorMessage = 'Financials recalc failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_Init',v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	
   SET v_CurrentPeriod = 0;
   SWL_Label:
   WHILE (v_CurrentPeriod < 14) DO
      SET v_ReturnStatus = LedgerMain_PeriodDate(v_CompanyID,v_DivisionID,v_DepartmentID,v_CurrentPeriod,v_PeriodStartDate,
      v_PeriodEndDate);
	
      IF v_ReturnStatus = -1 then
	
         SET v_ErrorMessage = 'Procedure call LedgerMain_VerifyPeriod failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_Init',v_ErrorMessage,v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
      if v_PeriodEndDate > CURRENT_TIMESTAMP then
         LEAVE SWL_Label;
      end if;		
	
	
	
      CREATE TEMPORARY TABLE tt_Temp AS SELECT
         CASE
         WHEN IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0) < 0 THEN -IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0)
         ELSE IFNULL(SUM(IFNULL(GLCreditAmount,0) -IFNULL(GLDebitAmount,0)),0)
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
         LedgerTransactionsDetail.CompanyID = LedgerTransactions.CompanyID AND
         LedgerTransactionsDetail.DivisionID = LedgerTransactions.DivisionID AND
         LedgerTransactionsDetail.DepartmentID = LedgerTransactions.DepartmentID AND
         LedgerTransactionsDetail.GLTransactionNumber = LedgerTransactions.GLTransactionNumber
         WHERE
         LedgerTransactionsDetail.CompanyID = v_CompanyID AND
         LedgerTransactionsDetail.DivisionID = v_DivisionID AND
         LedgerTransactionsDetail.DepartmentID = v_DepartmentID AND
         LedgerTransactions.GLTransactionDate >= v_PeriodStartDate AND
         LedgerTransactions.GLTransactionDate < v_PeriodEndDate
         GROUP BY
         GLTransactionAccount;
      IF @SWV_Error <> 0 then
	
		
         SET v_ErrorMessage = 'Selecting summaries from LedgerTransactionsDetail failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_Init',v_ErrorMessage,v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
	
	
	
	
	
      SET @SWV_Error = 0;
      IF v_CurrentPeriod = 0 then
	
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod1 = IFNULL((SELECT
         Balance
         FROM
         tt_Temp T
         WHERE
         T.GLTransactionAccount = GLAccountNumber),0)
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID;
	
      ELSE 
         IF v_CurrentPeriod = 1 then
	
            UPDATE
            LedgerChartOfAccounts
            SET
            GLCurrentYearPeriod2 = IFNULL((SELECT
            Balance
            FROM
            tt_Temp T
            WHERE
            T.GLTransactionAccount = GLAccountNumber),0)
            WHERE
            CompanyID = v_CompanyID AND
            DivisionID = v_DivisionID AND
            DepartmentID = v_DepartmentID;
	
         ELSE 
            IF v_CurrentPeriod = 2 then
	
               UPDATE
               LedgerChartOfAccounts
               SET
               GLCurrentYearPeriod3 = IFNULL((SELECT
               Balance
               FROM
               tt_Temp T
               WHERE
               T.GLTransactionAccount = GLAccountNumber),0)
               WHERE
               CompanyID = v_CompanyID AND
               DivisionID = v_DivisionID AND
               DepartmentID = v_DepartmentID;
	
            ELSE 
               IF v_CurrentPeriod = 3 then
	
                  UPDATE
                  LedgerChartOfAccounts
                  SET
                  GLCurrentYearPeriod4 = IFNULL((SELECT
                  Balance
                  FROM
                  tt_Temp T
                  WHERE
                  T.GLTransactionAccount = GLAccountNumber),0)
                  WHERE
                  CompanyID = v_CompanyID AND
                  DivisionID = v_DivisionID AND
                  DepartmentID = v_DepartmentID;
	
               ELSE 
                  IF v_CurrentPeriod = 4 then
	
                     UPDATE
                     LedgerChartOfAccounts
                     SET
                     GLCurrentYearPeriod5 = IFNULL((SELECT
                     Balance
                     FROM
                     tt_Temp T
                     WHERE
                     T.GLTransactionAccount = GLAccountNumber),0)
                     WHERE
                     CompanyID = v_CompanyID AND
                     DivisionID = v_DivisionID AND
                     DepartmentID = v_DepartmentID;
	
                  ELSE 
                     IF v_CurrentPeriod = 5 then
	
                        UPDATE
                        LedgerChartOfAccounts
                        SET
                        GLCurrentYearPeriod6 = IFNULL((SELECT
                        Balance
                        FROM
                        tt_Temp T
                        WHERE
                        T.GLTransactionAccount = GLAccountNumber),0)
                        WHERE
                        CompanyID = v_CompanyID AND
                        DivisionID = v_DivisionID AND
                        DepartmentID = v_DepartmentID;
	
                     ELSE 
                        IF v_CurrentPeriod = 6 then
	
                           UPDATE
                           LedgerChartOfAccounts
                           SET
                           GLCurrentYearPeriod7 = IFNULL((SELECT
                           Balance
                           FROM
                           tt_Temp T
                           WHERE
                           T.GLTransactionAccount = GLAccountNumber),0)
                           WHERE
                           CompanyID = v_CompanyID AND
                           DivisionID = v_DivisionID AND
                           DepartmentID = v_DepartmentID;
	
                        ELSE 
                           IF v_CurrentPeriod = 7 then
	
                              UPDATE
                              LedgerChartOfAccounts
                              SET
                              GLCurrentYearPeriod8 = IFNULL((SELECT
                              Balance
                              FROM
                              tt_Temp T
                              WHERE
                              T.GLTransactionAccount = GLAccountNumber),0)
                              WHERE
                              CompanyID = v_CompanyID AND
                              DivisionID = v_DivisionID AND
                              DepartmentID = v_DepartmentID;
	
                           ELSE 
                              IF v_CurrentPeriod = 8 then
	
                                 UPDATE
                                 LedgerChartOfAccounts
                                 SET
                                 GLCurrentYearPeriod9 = IFNULL((SELECT
                                 Balance
                                 FROM
                                 tt_Temp T
                                 WHERE
                                 T.GLTransactionAccount = GLAccountNumber),0)
                                 WHERE
                                 CompanyID = v_CompanyID AND
                                 DivisionID = v_DivisionID AND
                                 DepartmentID = v_DepartmentID;
	
                              ELSE 
                                 IF v_CurrentPeriod = 9 then
	
                                    UPDATE
                                    LedgerChartOfAccounts
                                    SET
                                    GLCurrentYearPeriod10 = IFNULL((SELECT
                                    Balance
                                    FROM
                                    tt_Temp T
                                    WHERE
                                    T.GLTransactionAccount = GLAccountNumber),0)
                                    WHERE
                                    CompanyID = v_CompanyID AND
                                    DivisionID = v_DivisionID AND
                                    DepartmentID = v_DepartmentID;
                                 ELSE 
                                    IF v_CurrentPeriod = 10 then
	
                                       UPDATE
                                       LedgerChartOfAccounts
                                       SET
                                       GLCurrentYearPeriod11 = IFNULL((SELECT
                                       Balance
                                       FROM
                                       tt_Temp T
                                       WHERE
                                       T.GLTransactionAccount = GLAccountNumber),0)
                                       WHERE
                                       CompanyID = v_CompanyID AND
                                       DivisionID = v_DivisionID AND
                                       DepartmentID = v_DepartmentID;
                                    ELSE 
                                       IF v_CurrentPeriod = 11 then
	
                                          UPDATE
                                          LedgerChartOfAccounts
                                          SET
                                          GLCurrentYearPeriod12 = IFNULL((SELECT
                                          Balance
                                          FROM
                                          tt_Temp T
                                          WHERE
                                          T.GLTransactionAccount = GLAccountNumber),0)
                                          WHERE
                                          CompanyID = v_CompanyID AND
                                          DivisionID = v_DivisionID AND
                                          DepartmentID = v_DepartmentID;
                                       ELSE 
                                          IF v_CurrentPeriod = 12 then
	
                                             UPDATE
                                             LedgerChartOfAccounts
                                             SET
                                             GLCurrentYearPeriod13 = IFNULL((SELECT
                                             Balance
                                             FROM
                                             tt_Temp T
                                             WHERE
                                             T.GLTransactionAccount = GLAccountNumber),0)
                                             WHERE
                                             CompanyID = v_CompanyID AND
                                             DivisionID = v_DivisionID AND
                                             DepartmentID = v_DepartmentID;
                                          ELSE 
                                             IF v_CurrentPeriod = 13 then
	
                                                UPDATE
                                                LedgerChartOfAccounts
                                                SET
                                                GLCurrentYearPeriod14 = IFNULL((SELECT
                                                Balance
                                                FROM
                                                tt_Temp T
                                                WHERE
                                                T.GLTransactionAccount = GLAccountNumber),0)
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

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_Init',v_ErrorMessage,v_ErrorID);
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

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_Init',v_ErrorMessage,v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
      DROP TEMPORARY TABLE IF EXISTS tt_Temp;
      SET v_CurrentPeriod = v_CurrentPeriod+1;
   END WHILE;
   SET @SWV_Error = 0;
   UPDATE
   Companies
   SET
   CurrentPeriod = v_PeriodEndDate
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'Dropping temporary table failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_Init',v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Ledger_Init',v_ErrorMessage,v_ErrorID);
   SET SWP_Ret_Value = -1;
END