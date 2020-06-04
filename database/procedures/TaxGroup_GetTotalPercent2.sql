CREATE PROCEDURE TaxGroup_GetTotalPercent2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_TaxGroupID  NATIONAL VARCHAR(36), 
	INOUT v_TotalPercent  FLOAT) BEGIN




   set v_TotalPercent = fnTaxGroup_GetTotalPercent2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TaxGroupID);
END