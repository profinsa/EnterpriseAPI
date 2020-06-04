CREATE PROCEDURE LedgerTransaction_Post (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),	
	v_GLTransacTypeID NATIONAL VARCHAR(36),
	v_GLTransactionAccount NATIONAL VARCHAR(36),
	v_GLAmount DECIMAL(19,4),
	v_GLTransactionPostedYN BOOLEAN,
	v_IsDebit BOOLEAN,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN
   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);
   DECLARE v_GLTransactionAmount NATIONAL VARCHAR(36);
   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;
    
   SET @SWV_Error = 0;
   IF v_IsDebit = 0 then
	
      SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextGLTransNumber',v_GLTransNumber);
      INSERT INTO LedgerTransactions(CompanyID
			,DivisionID
			,DepartmentID
			,GLTransactionNumber
			,GLTransactionTypeID
			,GLTransactionDate
			,SystemDate
			,GLTransactionAmount
			,GLTransactionPostedYN)
		VALUES(v_CompanyID
			,v_DivisionID
			,v_DepartmentID
			,v_GLTransNumber
			,v_GLTransacTypeID
			,DATE_FORMAT(CURRENT_TIMESTAMP, '%m/%d/%Y')
			,DATE_FORMAT(CURRENT_TIMESTAMP, '%m/%d/%Y')
			,v_GLAmount
			,v_GLTransactionPostedYN);
		
      select   GLTransactionNumber INTO v_GLTransactionNumber FROM
      LedgerTransactions WHERE GLTransactionNumber =(SELECT
         MAX(GLTransactionNumber)
         FROM
         LedgerTransactions
         WHERE
         CompanyID = v_CompanyID
         AND
         DivisionID = v_DivisionID
         AND
         DepartmentID = v_DepartmentID);
      INSERT INTO LedgerTransactionsDetail(CompanyID
			,DivisionID
			,DepartmentID
			,GLTransactionNumber
			,GLTransactionAccount
			,GLDebitAmount)
		VALUES(v_CompanyID
			,v_DivisionID
			,v_DepartmentID
			,v_GLTransNumber
			,v_GLTransactionAccount
			,v_GLAmount);
   ELSE 
      IF v_IsDebit = 1 then
		
         select   GLTransactionNumber INTO v_GLTransactionNumber FROM
         LedgerTransactions WHERE GLTransactionNumber =(SELECT
            MAX(GLTransactionNumber)
            FROM
            LedgerTransactions
            WHERE
            CompanyID = v_CompanyID
            AND
            DivisionID = v_DivisionID
            AND
            DepartmentID = v_DepartmentID);
         select   GLTransactionAmount INTO v_GLTransactionAmount FROM
         LedgerTransactions WHERE
         CompanyID = v_CompanyID
         AND
         DivisionID = v_DivisionID
         AND
         DepartmentID = v_DepartmentID
         AND
         GLTransactionNumber = v_GLTransactionNumber;
         INSERT INTO LedgerTransactionsDetail(CompanyID
				,DivisionID
				,DepartmentID
				,GLTransactionNumber
				,GLTransactionAccount
				,GLCreditAmount)
			VALUES(v_CompanyID
				,v_DivisionID
				,v_DepartmentID
				,v_GLTransactionNumber
				,v_GLTransactionAccount
				,v_GLTransactionAmount);
      end if;
   end if;	
	
   IF @SWV_Error <> 0 then
		
      SET v_ErrorMessage = 'LedgerTransactions insertion failed';
			
      ROLLBACK;
      SET SWP_Ret_Value = -1;
   end if;	
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;

   ROLLBACK;
   SET SWP_Ret_Value = -1;
END