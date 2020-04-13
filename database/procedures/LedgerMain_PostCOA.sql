CREATE PROCEDURE LedgerMain_PostCOA (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLAccountNumber NATIONAL VARCHAR(36),
	v_TranDate DATETIME,
	v_DebitAmount DECIMAL(19,4),
	v_CreditAmount DECIMAL(19,4),
	INOUT v_PostCOA BOOLEAN  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_TransactionAmount DECIMAL(19,4);
   DECLARE v_GLBalanceType NATIONAL VARCHAR(36);
   DECLARE v_SQLString NATIONAL VARCHAR(2000);



   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   UPPER(GLBalanceType) INTO v_GLBalanceType FROM
   LedgerChartOfAccounts WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND GLAccountNumber = v_GLAccountNumber;


   SET v_PostCOA = 1;

   START TRANSACTION;


   Set v_TransactionAmount = CASE

	
	
   When IFNULL(v_CreditAmount,0) <> 0  AND v_GLBalanceType = 'ASSET'  THEN 0 -v_CreditAmount
	
   When IFNULL(v_DebitAmount,0) <> 0  AND v_GLBalanceType = 'ASSET'  THEN v_DebitAmount

	
	
   When IFNULL(v_CreditAmount,0) <> 0  AND v_GLBalanceType = 'LIABILITY'  THEN v_CreditAmount
	
   When IFNULL(v_DebitAmount,0) <> 0  AND v_GLBalanceType = 'LIABILITY'  THEN 0 -v_DebitAmount

	
	
   When IFNULL(v_CreditAmount,0) <> 0  AND v_GLBalanceType = 'EQUITY'  THEN v_CreditAmount
	
   When IFNULL(v_DebitAmount,0) <> 0  AND v_GLBalanceType = 'EQUITY'  THEN 0 -v_DebitAmount

	
	
   When IFNULL(v_CreditAmount,0) <> 0  AND v_GLBalanceType = 'INCOME'  THEN v_CreditAmount
	
   When IFNULL(v_DebitAmount,0) <> 0  AND v_GLBalanceType = 'INCOME'  THEN 0 -v_DebitAmount

	
	
   When IFNULL(v_CreditAmount,0) <> 0  AND v_GLBalanceType = 'EXPENSE'  THEN 0 -v_CreditAmount
	
   When IFNULL(v_DebitAmount,0) <> 0  AND v_GLBalanceType = 'EXPENSE'  THEN v_DebitAmount

	
	
   ELSE v_DebitAmount
   END;


   SET @SWV_Error = 0;
   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then


      SET v_ErrorMessage = 'LedgerMain_VerifyPeriod call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
      SET SWP_Ret_Value = -1;
   end if;

   IF v_PeriodClosed <> 0 then



      SET v_ErrorMessage = 'Period is closed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
      SET SWP_Ret_Value = -1;
   end if;


   IF v_PeriodToPost >= 0 AND v_ReturnStatus = 0 then

      SET @SWV_Error = 0;
      UPDATE
      LedgerChartOfAccounts
      SET
      GLAccountBalance = IFNULL(GLAccountBalance,0)+IFNULL(v_TransactionAmount,0)
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND GLAccountNumber = v_GLAccountNumber;
      IF @SWV_Error <> 0 then
	
	
         SET v_PostCOA = 0;
         SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
         SET SWP_Ret_Value = -1;
      end if;
      IF v_PeriodToPost = 0 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod1 = IFNULL(GLCurrentYearPeriod1,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then
		
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 1 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod2 = IFNULL(GLCurrentYearPeriod2,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 2 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod3 = IFNULL(GLCurrentYearPeriod3,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 3 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod4 = IFNULL(GLCurrentYearPeriod4,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 4 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod5 = IFNULL(GLCurrentYearPeriod5,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 5 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod6 = IFNULL(GLCurrentYearPeriod6,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 6 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod7 = IFNULL(GLCurrentYearPeriod7,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 7 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod8 = IFNULL(GLCurrentYearPeriod8,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 8 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod9 = IFNULL(GLCurrentYearPeriod9,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 9 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod10 = IFNULL(GLCurrentYearPeriod10,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 10 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod11 = IFNULL(GLCurrentYearPeriod11,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 11 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod12 = IFNULL(GLCurrentYearPeriod12,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 12 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod13 = IFNULL(GLCurrentYearPeriod13,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      IF v_PeriodToPost = 13 then
	
         SET @SWV_Error = 0;
         UPDATE
         LedgerChartOfAccounts
         SET
         GLCurrentYearPeriod14 = IFNULL(GLCurrentYearPeriod14,0)+IFNULL(v_TransactionAmount,0)
         WHERE
         CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND GLAccountNumber = v_GLAccountNumber;
         IF @SWV_Error <> 0 then 
		
		
            SET v_PostCOA = 0;
            SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
   ELSE
      SET @SWV_Error = 0;
      UPDATE
      LedgerChartOfAccounts
      SET
      GLAccountBalance = IFNULL(GLAccountBalance,0)+IFNULL(v_TransactionAmount,0),GLAccountBeginningBalance =  IFNULL(GLAccountBeginningBalance,0)+IFNULL(v_TransactionAmount,0)
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND GLAccountNumber = v_GLAccountNumber;
      IF @SWV_Error <> 0 then 
		
		
         SET v_PostCOA = 0;
         SET v_ErrorMessage = 'Update LedgerChartOfAccounts failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);
         SET SWP_Ret_Value = -1;
      end if;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerMain_PostCOA',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLAccountNumber',v_GLAccountNumber);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'TranDate',v_TranDate);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DebitAmount',v_DebitAmount);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CreditAmount',v_CreditAmount);

   SET SWP_Ret_Value = -1;
END