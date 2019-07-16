CREATE PROCEDURE RptListTaxGroups (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN












   SELECT
	
	
	
   TaxGroups.TaxGroupID, 

	Sum(IFNULL(Taxes.TaxPercent,0))  As TotalPercent
   FROM
   TaxGroups
   INNER JOIN TaxGroupDetail ON
   TaxGroupDetail.CompanyID = TaxGroups.CompanyID AND
   TaxGroupDetail.DivisionID = TaxGroups.DivisionID AND
   TaxGroupDetail.DepartmentID = TaxGroups.DepartmentID AND
   TaxGroupDetail.TaxGroupDetailID = TaxGroups.TaxGroupDetailID
   INNER JOIN Taxes ON
   TaxGroupDetail.CompanyID = Taxes.CompanyID AND
   TaxGroupDetail.DivisionID = Taxes.DivisionID AND
   TaxGroupDetail.DepartmentID = Taxes.DepartmentID AND
   TaxGroupDetail.TaxID = Taxes.TaxID
   WHERE
   TaxGroups.CompanyID = v_CompanyID AND
   TaxGroups.DivisionID = v_DivisionID AND
   TaxGroups.DepartmentID = v_DepartmentID
   GROUP BY TaxGroups.TaxGroupID;
END