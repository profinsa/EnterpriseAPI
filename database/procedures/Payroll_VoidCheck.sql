CREATE PROCEDURE Payroll_VoidCheck (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN









   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GLTransactionNumber NATIONAL VARCHAR(36);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_Voided BOOLEAN;


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   IFNULL(Posted,0), IFNULL(Voided,0) INTO v_Posted,v_Voided FROM
   PayrollRegister WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   EmployeeID = v_EmployeeID AND
   PayrollID = v_PayrollID;




   IF v_Posted = 0 OR v_Voided = 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   select   GLTransactionNumber INTO v_GLTransactionNumber FROM
   LedgerTransactions WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   GLTransactionTypeID = 'Payroll' AND
   GLTransactionReference = v_PayrollID;
	


   START TRANSACTION;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = LedgerTransactions_Reverse(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLTransactionNumber);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'LedgerTransactions_Reverse call failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_VoidCheck',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;



   UPDATE
   PayrollRegister
   SET
   Voided = 1
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   EmployeeID = v_EmployeeID AND
   PayrollID = v_PayrollID;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_VoidCheck',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END