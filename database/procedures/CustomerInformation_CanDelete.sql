CREATE PROCEDURE CustomerInformation_CanDelete (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_CustomerID NATIONAL VARCHAR(36),
	INOUT v_CanDelete BOOLEAN ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN











	
   SET v_CanDelete = 1;

	
   IF EXISTS(SELECT * FROM OrderHeader
   WHERE
   CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID) then
	
      
SET v_CanDelete = 0;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

	
   IF EXISTS(SELECT * FROM InvoiceHeader
   WHERE
   IFNULL(Posted,0) <> 0 AND
   CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID)
   OR
   EXISTS(SELECT * FROM InvoiceHeaderHistory
   WHERE
   IFNULL(Posted,0) <> 0 AND
   CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID) then
	
      
SET v_CanDelete = 0;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
	
	
   IF EXISTS(SELECT * FROM ReceiptsHeader
   WHERE
   IFNULL(Posted,0) <> 0 AND
   CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID)
   OR
   EXISTS(SELECT * FROM ReceiptsHeaderHistory
   WHERE
   IFNULL(Posted,0) <> 0 AND
   CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID) then	
      
SET v_CanDelete = 0;
      LEAVE SWL_return;
   end if;
	
   
SET SWP_Ret_Value = 0;
END