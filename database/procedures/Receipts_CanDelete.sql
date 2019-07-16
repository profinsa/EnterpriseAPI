CREATE PROCEDURE Receipts_CanDelete (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ReceiptID NATIONAL VARCHAR(36),
	INOUT v_CanDelete BOOLEAN ,INOUT SWP_Ret_Value INT) BEGIN







   select   ~ IFNULL(Posted,0) INTO v_CanDelete FROM ReceiptsHeader WHERE
   CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND
   ReceiptID = v_ReceiptID;

   
SET SWP_Ret_Value = 0;
END