CREATE PROCEDURE Payroll_Commissions_SetPaid2 (v_CompanyID 	NATIONAL VARCHAR(36),
	v_DivisionID 	NATIONAL VARCHAR(36),
	v_DepartmentID 	NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN











   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_InvoiceNumber NATIONAL VARCHAR(36);
   DECLARE v_CommissionItem DECIMAL(19,4);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;


   SET @SWV_Error = 0;
   UPDATE
   InvoiceHeader
   SET
   CommissionPaid = 1
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber IN(SELECT
   inh.InvoiceNumber
   FROM
   InvoiceHeader inh
   INNER JOIN InvoiceDetail ind ON ind.InvoiceNumber = inh.InvoiceNumber
   INNER JOIN InventoryItems inv ON inv.ItemID = ind.ItemID
   INNER JOIN PayrollEmployees emp ON inh.EmployeeID = emp.EmployeeID
   INNER JOIN PayrollEmployeesDetail emd ON inh.EmployeeID = emd.EmployeeID
   WHERE
   inh.CompanyID = v_CompanyID
   AND inh.DivisionID = v_DivisionID
   AND inh.DepartmentID = v_DepartmentID
   AND inh.EmployeeID = v_EmployeeID
   AND ind.CompanyID = v_CompanyID
   AND ind.DivisionID = v_DivisionID
   AND ind.DepartmentID = v_DepartmentID
   AND inv.CompanyID = v_CompanyID
   AND inv.DivisionID = v_DivisionID
   AND inv.DepartmentID = v_DepartmentID
   AND emp.CompanyID = v_CompanyID
   AND emp.DivisionID = v_DivisionID
   AND emp.DepartmentID = v_DepartmentID
   AND emd.CompanyID = v_CompanyID
   AND emd.DivisionID = v_DivisionID
   AND emd.DepartmentID = v_DepartmentID
   AND inh.TransactionTypeID = 'Invoice'
   AND IFNULL(inh.Posted,0) = 1
   AND IFNULL(inh.CommissionPaid,0) = 0
   AND IFNULL(inh.CommissionSelectToPay,0) = 1
   AND IFNULL(inv.Commissionable,0) = 1
   AND IFNULL(emp.Commissionable,0) = 1);


   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Update InvoiceHeader failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Commissions_SetPaid',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   UPDATE
   PurchaseHeader
   SET
   CommissionPaid = 1
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber IN(SELECT
   prh.PurchaseNumber
   FROM
   PurchaseHeader prh
   INNER JOIN InvoiceHeader inh ON prh.OrderNumber = inh.InvoiceNumber
   INNER JOIN PurchaseDetail prd ON prd.PurchaseNumber = prh.PurchaseNumber
   INNER JOIN InventoryItems inv ON inv.ItemID = prd.ItemID
   INNER JOIN PayrollEmployees emp ON inh.EmployeeID = emp.EmployeeID
   INNER JOIN PayrollEmployeesDetail emd ON inh.EmployeeID = emd.EmployeeID
   WHERE
   prh.CompanyID = v_CompanyID
   AND prh.DivisionID = v_DivisionID
   AND prh.DepartmentID = v_DepartmentID
   AND inh.CompanyID = v_CompanyID
   AND inh.DivisionID = v_DivisionID
   AND inh.DepartmentID = v_DepartmentID
   AND inh.EmployeeID = v_EmployeeID
   AND prd.CompanyID = v_CompanyID
   AND prd.DivisionID = v_DivisionID
   AND prd.DepartmentID = v_DepartmentID
   AND inv.CompanyID = v_CompanyID
   AND inv.DivisionID = v_DivisionID
   AND inv.DepartmentID = v_DepartmentID
   AND emp.CompanyID = v_CompanyID
   AND emp.DivisionID = v_DivisionID
   AND emp.DepartmentID = v_DepartmentID
   AND emd.CompanyID = v_CompanyID
   AND emd.DivisionID = v_DivisionID
   AND emd.DepartmentID = v_DepartmentID
   AND prh.TransactionTypeID = 'RMA'
   AND IFNULL(prh.Posted,0) = 1
   AND IFNULL(prh.CommissionPaid,0) = 0
   AND IFNULL(prh.CommissionSelectToPay,0) = 1
   AND IFNULL(inv.Commissionable,0) = 1
   AND IFNULL(emp.Commissionable,0) = 1);


   IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Update PurchaseHeader failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Commissions_SetPaid',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Commissions_SetPaid',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);

   SET SWP_Ret_Value = -1;
END