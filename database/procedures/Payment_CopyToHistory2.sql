CREATE PROCEDURE Payment_CopyToHistory2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN
























   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);




   DECLARE v_Memorize BOOLEAN;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   Memorize INTO v_Memorize FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PaymentID = v_PaymentID
   AND IFNULL(Posted,0) = 1
   AND IFNULL(Paid,0) = 1
   AND PaymentID <> 'DEFAULT';
   IF ROW_COUNT() = 0 then

      SET SWP_Ret_Value = -2;
      LEAVE SWL_return;
   end if;


   START TRANSACTION;
   IF NOT EXISTS(SELECT PaymentID
   FROM PaymentsHeaderHistory
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PaymentID = v_PaymentID) then

      SET @SWV_Error = 0;
      INSERT INTO
      PaymentsDetailHistory(CompanyID,
		DivisionID,
		DepartmentID,
		PaymentID, 
		
		PayedID,
		DocumentNumber,
		DocumentDate,
		CurrencyID,
		CurrencyExchangeRate,
		DiscountTaken,
		WriteOffAmount,
		AppliedAmount,
		Cleared,
		GLExpenseAccount,
		ProjectID,
		LockedBy,
		LockTS)
      SELECT
      CompanyID,
		DivisionID,
		DepartmentID,
		PaymentID, 
		
		PayedID,
		DocumentNumber,
		DocumentDate,
		CurrencyID,
		CurrencyExchangeRate,
		DiscountTaken,
		WriteOffAmount,
		AppliedAmount,
		Cleared,
		GLExpenseAccount,
		ProjectID,
		NULL,
		NULL
      FROM
      PaymentsDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PaymentID = v_PaymentID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into PaymentsDetailHistory failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      INSERT INTO
      PaymentsHeaderHistory
      SELECT * FROM
      PaymentsHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PaymentID = v_PaymentID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into PaymentsHistory failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF IFNULL(v_Memorize,0) <> 1 then

      SET @SWV_Error = 0;
      DELETE
      FROM
      PaymentsDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PaymentID = v_PaymentID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from PaymentsDetail failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      DELETE
      FROM
      PaymentsHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PaymentID = v_PaymentID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from PaymentsHeader failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   end if;	


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;



   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CopyToHistory',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');

   SET SWP_Ret_Value = -1;
END