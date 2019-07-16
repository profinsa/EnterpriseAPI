CREATE PROCEDURE Inventory_GetWarehouseForPurchase2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	INOUT v_WarehouseID NATIONAL VARCHAR(36)  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN












   DECLARE v_VendorID NATIONAL VARCHAR(50);



   select   IFNULL(WarehouseID,N''), VendorID INTO v_WarehouseID,v_VendorID FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;


   IF v_WarehouseID <> N'' then

	
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;



   select   IFNULL(WarehouseID,N'') INTO v_WarehouseID FROM
   VendorInformation WHERE
   VendorID = v_VendorID AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   IF v_WarehouseID <> N'' then

	
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   select   IFNULL(WarehouseID,N'') INTO v_WarehouseID FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;

   IF v_WarehouseID <> N'' then

	
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