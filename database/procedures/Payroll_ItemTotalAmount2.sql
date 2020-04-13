CREATE PROCEDURE Payroll_ItemTotalAmount2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),
	v_PayrollItemID NATIONAL VARCHAR(36),
	v_Check NATIONAL VARCHAR(36),
	INOUT v_ItemTotalAmount DECIMAL(19,4) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Basis NATIONAL VARCHAR(20); 
   DECLARE v_ItemAmount DECIMAL(19,4);
   DECLARE v_GROSS DECIMAL(19,4);
   DECLARE v_AGI DECIMAL(19,4);
   DECLARE v_Net DECIMAL(19,4);
   DECLARE v_ItemPercent DECIMAL(19,4);

   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   SET @SWV_Error = 0;
   SET v_ReturnStatus = Payroll_GROSS(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_Check,v_GROSS);
   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Call enterprise.Payroll_GROSS failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_ItemTotalAmount',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;


   SET v_AGI = 0;
   SET v_Net = 0;


   select   IFNULL(Gross,0), IFNULL(AGI,0), IFNULL(NetPay,0) INTO v_GROSS,v_AGI,v_Net FROM PayrollRegister WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
   AND UPPER(PayrollID) = UPPER(v_PayrollID); 	





   select   IFNULL(ItemAmount,0), IFNULL(ItemPercent,0), IFNULL(Basis,'Gross') INTO v_ItemAmount,v_ItemPercent,v_Basis FROM	PayrollItems WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
   AND UPPER(PayrollItemID) = UPPER(v_PayrollItemID)   LIMIT 1;

   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;


   IF UPPER(v_Basis) = UPPER('Gross') then
      SET v_ItemTotalAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemAmount+(v_GROSS*(v_ItemPercent/100)), 
      v_CompanyCurrencyID);
   ELSE
      IF UPPER(v_Basis) = UPPER('AGI') then
         SET v_ItemTotalAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemAmount+(v_AGI*(v_ItemPercent/100)), 
         v_CompanyCurrencyID);
      ELSE
         IF UPPER(v_Basis) = UPPER('Net') then
            SET v_ItemTotalAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemAmount+(v_Net*(v_ItemPercent/100)), 
            v_CompanyCurrencyID);
         ELSE
            SET v_ErrorMessage = CONCAT('@Basis=',v_Basis);
            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_ItemTotalAmount',v_ErrorMessage,
            v_ErrorID);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
   end if;

		    

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_ItemTotalAmount',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END