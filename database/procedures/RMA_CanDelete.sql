CREATE PROCEDURE RMA_CanDelete (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	INOUT v_CanDelete BOOLEAN ,INOUT SWP_Ret_Value INT) BEGIN




   select   ~ Received INTO v_CanDelete FROM PurchaseHeader WHERE
   CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;
	
   
SET SWP_Ret_Value = 0;
END