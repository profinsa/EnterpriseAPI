CREATE PROCEDURE LedgerTransactions_PostCOA_AllRecords2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLTransNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_GLTransactionAccount NATIONAL VARCHAR(36);
   DECLARE v_GLTransactionDate DATETIME;
   DECLARE v_GLDebitAmount DECIMAL(19,4);
   DECLARE v_GLCreditAmount DECIMAL(19,4);
   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);
   DECLARE v_PostCOA BOOLEAN;
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE C CURSOR FOR
   SELECT
   LedgerTransactionsDetail.GLTransactionAccount,
		LedgerTransactions.GLTransactionDate,
		LedgerTransactionsDetail.GLDebitAmount,
		LedgerTransactionsDetail.GLCreditAmount,
		LedgerTransactions.GLTransactionNumber
   FROM
   LedgerTransactions
   INNER JOIN LedgerTransactionsDetail ON
   LedgerTransactions.CompanyID = LedgerTransactionsDetail.CompanyID AND
   LedgerTransactions.DivisionID = LedgerTransactionsDetail.DivisionID AND
   LedgerTransactions.DepartmentID = LedgerTransactionsDetail.DepartmentID AND
   LedgerTransactions.GLTransactionNumber = LedgerTransactionsDetail.GLTransactionNumber
   WHERE
   LedgerTransactions.CompanyID = v_CompanyID AND
   LedgerTransactions.DivisionID = v_DivisionID AND
   LedgerTransactions.DepartmentID = v_DepartmentID AND
   LedgerTransactions.GLTransactionNumber = v_GLTransNumber;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   START TRANSACTION;
   OPEN C;

   SET NO_DATA = 0;
   FETCH C INTO v_GLTransactionAccount,v_GLTransactionDate,v_GLDebitAmount,v_GLCreditAmount, 
   v_GLTransactionNumber;
   WHILE NO_DATA = 0 DO
	
      CALL LedgerMain_PostCOA(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionAccount,v_GLTransactionDate,
      v_GLDebitAmount,v_GLCreditAmount,v_PostCOA, v_ReturnStatus);
      IF v_PostCOA = 0 OR v_ReturnStatus = -1 then
	
		
         CLOSE C;
		
         SET v_ErrorMessage = 'LedgerMain_PostCOA call failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_PostCOA_AllRecords',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
         v_GLTransactionNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH C INTO v_GLTransactionAccount,v_GLTransactionDate,v_GLDebitAmount,v_GLCreditAmount, 
      v_GLTransactionNumber;
   END WHILE;
   CLOSE C;

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'LedgerTransactions_PostCOA_AllRecords',
   v_ErrorMessage,v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'GLTransactionNumber',
   v_GLTransactionNumber);
   SET SWP_Ret_Value = -1;
END