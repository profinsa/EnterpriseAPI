CREATE PROCEDURE LedgerTransactions_CopyAllToHistory2 (v_CompanyID 	NATIONAL VARCHAR(36),
	v_DivisionID 	NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN


























   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);


   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;
   DECLARE v_PeriodEnd DATETIME;

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cLedgerTransaction CURSOR 
   FOR SELECT
   GLTransactionNumber
   FROM
   LedgerTransactions
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND IFNULL(GLTransactionPostedYN,0) = 1 
   AND UPPER(GLTransactionNumber) <> 'DEFAULT'
   AND GLTransactionDate < v_PeriodStart;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;
   SET @SWV_Error = 0;
   CALL LedgerMain_VerifyPeriodCurrent(v_CompanyID,v_DivisionID,v_DepartmentID,v_Period,v_PeriodStart,v_PeriodEnd, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
	
      SET v_ErrorMessage = 'LedgerMain_VerifyPeriodCurrent call failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CopyAllToHistory',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
      SET SWP_Ret_Value = -1;
   end if;



   OPEN cLedgerTransaction;

   SET @SWV_Error = 0;
   SET NO_DATA = 0;
   FETCH cLedgerTransaction INTO v_GLTransactionNumber;

   IF @SWV_Error <> 0 then
	
      CLOSE cLedgerTransaction;
		
      SET v_ErrorMessage = 'Fetching from the LedgerTransactions cursor failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CopyAllToHistory',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
      SET SWP_Ret_Value = -1;
   end if;


   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL LedgerTransactions_CopyToHistory2(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionNumber, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
		
         CLOSE cLedgerTransaction;
			
         SET v_ErrorMessage = 'LedgerTransactions_CopyToHistory call failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CopyAllToHistory',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      SET NO_DATA = 0;
      FETCH cLedgerTransaction INTO v_GLTransactionNumber;
      IF @SWV_Error <> 0 then
		
         CLOSE cLedgerTransaction;
			
         SET v_ErrorMessage = 'Fetching from the LedgerTransactions cursor failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CopyAllToHistory',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   END WHILE;

   CLOSE cLedgerTransaction;





   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_CopyAllToHistory',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');

   SET SWP_Ret_Value = -1;
END