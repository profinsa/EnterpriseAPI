CREATE PROCEDURE Inventory_GetWarehouseForInvoice (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),
	INOUT v_WarehouseID NATIONAL VARCHAR(36) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN










   DECLARE v_CustomerID NATIONAL VARCHAR(50);

   select   IFNULL(WarehouseID,N''), CustomerID INTO v_WarehouseID,v_CustomerID FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   IF v_WarehouseID <> N'' then
	
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   select   IFNULL(WarehouseID,N'') INTO v_WarehouseID FROM
   CustomerInformation WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;

   IF v_WarehouseID  <> N'' then
	
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   select   IFNULL(WarehouseID,N'') INTO v_WarehouseID FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   IF v_WarehouseID  <> N'' then
	
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   select   IFNULL(WarehouseID,N'DEFAULT') INTO v_WarehouseID FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   SET SWP_Ret_Value = 0;
END