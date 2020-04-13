CREATE PROCEDURE VendorInformation_CanDelete (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_VendorID NATIONAL VARCHAR(36),
	INOUT v_CanDelete BOOLEAN ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN










	
   SET v_CanDelete = 1;

	
   IF EXISTS(SELECT * FROM PurchaseHeader
   WHERE
   IFNULL(Received,0) = 0 AND
   CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID) then
	
      
SET v_CanDelete = 0;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

	
   IF EXISTS(SELECT * FROM PaymentsHeader
   WHERE
   IFNULL(Posted,0) <> 0 AND
   CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID)
   OR
   EXISTS(SELECT * FROM PaymentsHeaderHistory
   WHERE
   IFNULL(Posted,0) <> 0 AND
   CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND
   VendorID = v_VendorID) then
	
      
SET v_CanDelete = 0;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   
SET SWP_Ret_Value = 0;
END