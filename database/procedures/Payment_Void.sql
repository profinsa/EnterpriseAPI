CREATE PROCEDURE Payment_Void (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Posted BOOLEAN;
   DECLARE v_Void BOOLEAN;
   DECLARE v_Paid BOOLEAN;
   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   IFNULL(Posted,0), IFNULL(Void,0), IFNULL(Paid,0) INTO v_Posted,v_Void,v_Paid FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;

   IF ROW_COUNT() = 0 then

      SET v_PostingResult = 'There is no payment with such PaymentID';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF (v_Posted = 1 AND v_Paid = 1) then

      SET v_PostingResult = 'Can't void closed payment';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF (v_Void = 1) then

      SET v_PostingResult = 'The payment is voided already';
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;


   select   GLTransactionNumber INTO v_GLTransactionNumber FROM
   LedgerTransactions WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
	(GLTransactionTypeID = N'Check' OR GLTransactionTypeID = N'Voucher') AND
   GLTransactionReference = v_PaymentID AND
   IFNULL(Reversal,0) = 0;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Get GLTransactionNumber failed';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Void',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   if IFNULL(v_GLTransactionNumber,N'') <> N'' then


      SET v_ReturnStatus = LedgerTransactions_Reverse(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionNumber);
      IF v_ReturnStatus = -1 then
	
         SET v_ErrorMessage = 'LedgerTransactions_Reverse call failed';
         ROLLBACK;


         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Void',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
   end if; 

   SET @SWV_Error = 0;
   UPDATE
   PaymentsHeader
   SET
   Void = 1
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;
	
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update PaymentsHeader failed';
      ROLLBACK;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Void',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_Void',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
   end if;
   SET SWP_Ret_Value = -1;
END