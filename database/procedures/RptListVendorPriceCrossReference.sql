CREATE PROCEDURE RptListVendorPriceCrossReference (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   VendorID,
	ItemPricingCode,
	CurrencyID,
	ItemPrice,
	Freight,
	Handling,
	Advertising,
	Shipping
   FROM VendorPriceCrossReference
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END