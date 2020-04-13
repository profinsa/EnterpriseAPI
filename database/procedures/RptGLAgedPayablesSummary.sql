CREATE PROCEDURE RptGLAgedPayablesSummary (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN














   SELECT
   VendorInformation.VendorID,
	VendorInformation.VendorName,
	IFNULL(VendorFinancials.Under30,0) AS Under30,
	IFNULL(VendorFinancials.Over30,0) AS Over30,
	IFNULL(VendorFinancials.Over60,0) AS Over60,
	IFNULL(VendorFinancials.Over90,0) AS Over90,
	IFNULL(VendorFinancials.Over120,0) AS Over120,
	IFNULL(VendorFinancials.Over150,0) AS Over150,
	IFNULL(VendorFinancials.Over180,0) AS Over180
   FROM
   VendorInformation INNER JOIN VendorFinancials ON
   VendorInformation.CompanyID = VendorFinancials.CompanyID AND
   VendorInformation.DivisionID = VendorFinancials.DivisionID AND
   VendorInformation.DepartmentID = VendorFinancials.DepartmentID AND
   VendorInformation.VendorID = VendorFinancials.VendorID
   WHERE
   VendorInformation.CompanyID = v_CompanyID AND
   VendorInformation.DivisionID = v_DivisionID AND
   VendorInformation.DepartmentID = v_DepartmentID AND
	(IFNULL(VendorFinancials.Under30,0) <> 0 OR
   IFNULL(VendorFinancials.Over30,0) <> 0 OR
   IFNULL(VendorFinancials.Over60,0) <> 0 OR
   IFNULL(VendorFinancials.Over90,0) <> 0 OR
   IFNULL(VendorFinancials.Over120,0) <> 0 OR
   IFNULL(VendorFinancials.Over150,0) <> 0 OR
   IFNULL(VendorFinancials.Over180,0) <> 0);

	
	

   SET SWP_Ret_Value = 0;
END