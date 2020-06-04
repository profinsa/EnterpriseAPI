CREATE PROCEDURE PaymentCheck_PrintInsert (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN

  
    
       SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT
   EmployeeID
   FROM
   PayrollEmployees
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   EmployeeID = v_EmployeeID) then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF NOT EXISTS(SELECT
   PaymentID
   FROM
   PaymentsHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID AND
   Posted = 1 AND
   IFNULL(Paid,0) = 0 AND
   IFNULL(CheckPrinted,0) = 0 AND
   ApprovedForPayment = 1) then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT
   PaymentID
   FROM
   PaymentChecks
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID AND
   EmployeeID = v_EmployeeID) then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   START TRANSACTION;

   SET @SWV_Error = 0;
   INSERT INTO PaymentChecks(CompanyID,
		DivisionID,
		DepartmentID,
		EmployeeID,
		PaymentID,
		CheckNumber,
		VendorID,
		Amount,
		GLBankAccount,
		CurrencyID)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_EmployeeID,
		PaymentID,
		CheckNumber,
		VendorID,
		CASE WHEN IFNULL(CreditAmount,0) = 0 THEN IFNULL(Amount,0) ELSE CreditAmount END,
		GLBankAccount,
		CurrencyID
   FROM
   PaymentsHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;	


	
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Inserting Data';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_PrintInsert',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   UPDATE
   PaymentsHeader
   SET
   SelectedForPayment = 1,SelectedForPaymentDate = now()
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;	

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error updating Data';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_PrintInsert',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_PrintInsert',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);

   SET SWP_Ret_Value = -1;
END