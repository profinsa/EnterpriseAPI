CREATE PROCEDURE DebitMemo_PopulateGLPurchaseAccount (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_VendorID NATIONAL VARCHAR(36),
	INOUT v_GLPurchaseAccount NATIONAL VARCHAR(36)  ,INOUT SWP_Ret_Value INT) BEGIN







   select   CASE Companies.DefaultGLPurchaseGLTracking WHEN '1' THEN
      IFNULL(VendorInformation.GLPurchaseAccount,Companies.GLAPInventoryAccount)
   ELSE Companies.GLAPInventoryAccount END INTO v_GLPurchaseAccount FROM VendorInformation
   INNER JOIN Companies ON
   VendorInformation.CompanyID = Companies.CompanyID
   AND VendorInformation.DivisionID = Companies.DivisionID
   AND VendorInformation.DepartmentID = Companies.DepartmentID WHERE
   VendorInformation.CompanyID = v_CompanyID
   AND VendorInformation.DivisionID = v_DivisionID
   AND VendorInformation.DepartmentID = v_DepartmentID
   AND VendorInformation.VendorID = v_VendorID;


   SET SWP_Ret_Value = 0;
END