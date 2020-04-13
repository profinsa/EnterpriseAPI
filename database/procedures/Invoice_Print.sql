CREATE PROCEDURE Invoice_Print (v_CompanyID 	NATIONAL VARCHAR(36),
	v_DivisionID 	NATIONAL VARCHAR(36),
	v_DepartmentID 	NATIONAL VARCHAR(36),
	v_InvoiceNumber 	NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN













   SELECT * FROM
   InvoiceHeader
   WHERE
   InvoiceNumber = v_InvoiceNumber AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   Posted = 1 AND 
   IFNULL(Printed,0) = 0;  
	

   SET SWP_Ret_Value = 0;
END