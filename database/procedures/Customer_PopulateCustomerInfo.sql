CREATE PROCEDURE Customer_PopulateCustomerInfo (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_CustomerID NATIONAL VARCHAR(36)) BEGIN





   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_AllowanceDiscountPercent FLOAT;
   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;
   SET v_AllowanceDiscountPercent = Customer_GetAllowancePercent(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID);
   Select  CustomerID,
	CustomerInformation.TermsID,
	CustomerShipToID,
	CustomerShipForID,
	CASE
   WHEN IFNULL(CurrencyID,N'') = N'' THEN v_CompanyCurrencyID
   ELSE CurrencyID
   END 	AS CurrencyID,
	TaxGroupID,
	TaxIDNo,
	WarehouseID,
	ShipMethodID,
	EmployeeID ,
	GLSalesAccount,
	CustomerName as ShippingName,
	CustomerAddress1 As ShippingAddress1,
	CustomerAddress2 As ShippingAddress2,
	CustomerAddress3 As ShippingAddress3,
	CustomerCity As ShippingCity,
	CustomerState As ShippingState,
	CustomerZip As ShippingZip,
	CustomerCountry As ShippingCountry,
	IFNULL(Terms.NetDays,0) As NetDays,
	v_AllowanceDiscountPercent AS AllowanceDiscountPerc
   From CustomerInformation LEFT OUTER JOIN Terms ON (CustomerInformation.CompanyID = Terms.CompanyID
   AND CustomerInformation.DivisionID = Terms.DivisionID
   AND CustomerInformation.DepartmentID = Terms.DepartmentID
   AND CustomerInformation.TermsID = Terms.TermsID)
   Where CustomerInformation.CompanyID = v_CompanyID
   AND CustomerInformation.DivisionID = v_DivisionID
   AND CustomerInformation.DepartmentID = v_DepartmentID
   AND CustomerInformation.CustomerID = v_CustomerID;
END