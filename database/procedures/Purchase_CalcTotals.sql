CREATE PROCEDURE Purchase_CalcTotals (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber  NATIONAL VARCHAR(36) ,
	INOUT v_Total DECIMAL(19,4)  ,INOUT SWP_Ret_Value INT) BEGIN

















   select   SUM(Total) INTO v_Total FROM
   PurchaseDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber  = v_PurchaseNumber;
   SET SWP_Ret_Value = 0;
END