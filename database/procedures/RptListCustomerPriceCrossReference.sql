CREATE PROCEDURE RptListCustomerPriceCrossReference (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   CustomerID,
	ItemPricingCode,
	ItemPrice,
	CurrencyID,
	Freight,
	Handling,
	Advertising,
	Shipping
   FROM CustomerPriceCrossReference
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END