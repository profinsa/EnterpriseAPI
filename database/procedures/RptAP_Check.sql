CREATE PROCEDURE RptAP_Check (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN









   SELECT
   PH.CheckNumber,
	PH.CheckDate,
	VI.VendorName,
	PH.GLBankAccount,
	PH.Amount
   FROM
   PaymentsHeader PH
   INNER JOIN VendorInformation VI
   ON (PH.VendorID = VI.VendorID
   AND PH.CompanyID = VI.CompanyID
   AND PH.DivisionID = VI.DivisionID
   AND PH.DepartmentID = VI.DepartmentID)
   WHERE
   PH.CompanyID = v_CompanyID
   AND PH.DivisionID = v_DivisionID
   AND PH.DepartmentID = v_DepartmentID
   AND PH.Posted = 1 
   AND (PH.Void IS NULL OR PH.Void = 0) 
   AND PH.Paid = 1; 
	


   SET SWP_Ret_Value = 0;
END