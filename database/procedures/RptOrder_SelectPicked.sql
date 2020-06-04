CREATE PROCEDURE RptOrder_SelectPicked (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN



















   SELECT * FROM
   OrderHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND Picked = 1	
   AND (IFNULL(Invoiced,0) = 0 
   OR IFNULL(Shipped,0) = 0);
	

   SET SWP_Ret_Value = 0;
END