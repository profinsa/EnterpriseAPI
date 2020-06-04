CREATE PROCEDURE CreditMemo_PopulateGLSalesAccount (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_CustomerID NATIONAL VARCHAR(36),
	INOUT v_GLSalesAccount NATIONAL VARCHAR(36)  ,INOUT SWP_Ret_Value INT) BEGIN






   select   CASE Companies.DefaultSalesGLTracking WHEN '1' THEN
      IFNULL(GLSalesAccount,Companies.GLARSalesAccount)
   ELSE Companies.GLARSalesAccount END INTO v_GLSalesAccount FROM CustomerInformation
   INNER JOIN Companies ON
   CustomerInformation.CompanyID = Companies.CompanyID
   AND CustomerInformation.DivisionID = Companies.DivisionID
   AND CustomerInformation.DepartmentID = Companies.DepartmentID WHERE
   CustomerInformation.CompanyID = v_CompanyID
   AND CustomerInformation.DivisionID = v_DivisionID
   AND CustomerInformation.DepartmentID = v_DepartmentID
   AND CustomerInformation.CustomerID = v_CustomerID;


   SET SWP_Ret_Value = 0;
END