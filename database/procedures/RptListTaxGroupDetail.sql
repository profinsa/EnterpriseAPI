CREATE PROCEDURE RptListTaxGroupDetail (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN







   SELECT
	
	
	
   TaxGroupDetail.TaxGroupDetailID,
	Sum(Taxes.TaxPercent) As TaxPercent
   FROM TaxGroupDetail
   INNER JOIN Taxes ON
   TaxGroupDetail.CompanyID = Taxes.CompanyID and
   TaxGroupDetail.DivisionID = Taxes.DivisionID and
   TaxGroupDetail.DepartmentID = Taxes.DepartmentID And
   TaxGroupDetail.TaxID = Taxes.TaxID
   WHERE TaxGroupDetail.CompanyID = v_CompanyID and TaxGroupDetail.DivisionID = v_DivisionID and TaxGroupDetail.DepartmentID = v_DepartmentID
   GROUP BY TaxGroupDetail.TaxGroupDetailID;
END