CREATE PROCEDURE LedgerTransactions_VerifyTransaction2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_GLTransactionNumber NATIONAL VARCHAR(36),
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,
	INOUT v_DisbalanceAmount DECIMAL(19,4) ,
	INOUT v_IsValid INT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN













   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_Balance DECIMAL(19,4);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_TranDate DATETIME;
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   SET v_DisbalanceAmount = 0;

   
IF NOT EXISTS(SELECT
   GLTransactionNumber
   FROM
   LedgerTransactionsDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   GLTransactionNumber = v_GLTransactionNumber) then

      SET v_PostingResult = 'Transaction was not posted: there are no detail transaction items';
      SET v_IsValid = 0;
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT * FROM
   LedgerTransactionsDetail
   WHERE
		(IFNULL(GLDebitAmount,0) = 0 AND IFNULL(GLCreditAmount,0) = 0) AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   GLTransactionNumber = v_GLTransactionNumber) then

      SET v_PostingResult = 'Can't post transaction. Transaction has detail item with empty or zero amount';
      SET v_IsValid = -3;
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;


SELECT 
    IFNULL(GLTransactionPostedYN, 0), GLTransactionDate
INTO v_Posted , v_TranDate FROM
    LedgerTransactions
WHERE
    CompanyID = v_CompanyID
        AND DivisionID = v_DivisionID
        AND DepartmentID = v_DepartmentID
        AND GLTransactionNumber = v_GLTransactionNumber;

   IF v_Posted = 1 then

      SET v_PostingResult = 'Transaction is posted already';
      SET v_IsValid = -4;
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF v_TranDate IS NULL then

      SET v_PostingResult = 'Can't post transaction. Transaction date is undefined';
      SET v_IsValid = -5;
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   SET v_ReturnStatus = 1;
   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);

   IF v_PeriodClosed <> 0 OR v_ReturnStatus = -1 then

      SET v_PostingResult = 'Can't post transaction for closed period';
      SET v_IsValid = -6;
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT * FROM
   LedgerTransactionsDetail
   WHERE
   IFNULL(GLTransactionAccount,N'') = N'' AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   GLTransactionNumber = v_GLTransactionNumber) then

      SET v_PostingResult = 'Can't post transaction. Transaction has detail item with unspecified account';
      SET v_IsValid = -2;
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;


SELECT 
    SUM(IFNULL(GLDebitAmount, 0)) - SUM(IFNULL(GLCreditAmount, 0))
INTO v_Balance FROM
    LedgerTransactionsDetail
WHERE
    CompanyID = v_CompanyID
        AND DivisionID = v_DivisionID
        AND DepartmentID = v_DepartmentID
        AND GLTransactionNumber = v_GLTransactionNumber;

   SET v_Balance = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(v_Balance,-1),N'');

   IF v_Balance <> 0 then

      SET v_PostingResult = 'Can't post transaction. Transaction has nonzero balance';
      SET v_IsValid = -1;
      SET v_DisbalanceAmount = v_Balance;
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;


   SET v_IsValid = 1;
   SET SWP_Ret_Value = 0;
END