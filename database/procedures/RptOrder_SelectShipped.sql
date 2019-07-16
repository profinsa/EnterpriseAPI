CREATE PROCEDURE RptOrder_SelectShipped (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN
















   SELECT * FROM
   OrderHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND Picked = 1	
   AND Shipped = 1	
   AND (Invoiced = 0 OR Invoiced IS NULL);

   SET SWP_Ret_Value = 0;
END