CREATE PROCEDURE Vendor_PopulateVendorInfo (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_VendorID NATIONAL VARCHAR(36),
	v_VendorAddress BOOLEAN) BEGIN










   If (v_VendorAddress = 0) then
	
      Select
      V.VendorID,
			V.TermsID,
			V.CurrencyID ,
			0 As DiscountPers,
			V.TaxGroupID,
			V.TaxIDNo As TaxExemptID,
			V.WarehouseID,
			V.ShipMethodID As ShipMethodID,
			V.AccountNumber AS AccountNumber,
			CASE Companies.DefaultGLPurchaseGLTracking WHEN '1' THEN
         IFNULL(V.GLPurchaseAccount,Companies.GLAPInventoryAccount)
      ELSE Companies.GLAPInventoryAccount END As GLPurchaseAccount,
			W.WarehouseName as ShippingName,
			W.WarehouseAddress1 As ShippingAddress1,
			W.WarehouseAddress2 As ShippingAddress2,
			W.WarehouseAddress3 As ShippingAddress3,
			W.WarehouseCity As ShippingCity,
			W.WarehouseState As ShippingState,
			W.WarehouseZip As ShippingZip,
			'' As ShippingCountry,
			IFNULL(T.NetDays,0) as NetDays
      From VendorInformation V
      INNER JOIN Companies ON
      V.CompanyID = Companies.CompanyID
      AND V.DivisionID = Companies.DivisionID
      AND V.DepartmentID = Companies.DepartmentID
      Left Outer join Warehouses W On  V.CompanyID = W.CompanyID
      AND V.DivisionID = W.DivisionID
      AND V.DepartmentID = W.DepartmentID
      And W.WarehouseID = V.WarehouseID
      Left Outer join Terms T On  V.CompanyID = T.CompanyID
      AND V.DivisionID = T.DivisionID
      AND V.DepartmentID = T.DepartmentID
      And V.TermsID = T.TermsID
      Where V.CompanyID = v_CompanyID
      AND V.DivisionID = v_DivisionID
      AND V.DepartmentID = v_DepartmentID
      AND V.VendorID = v_VendorID;
   Else
      Select
      V.VendorID,
			V.TermsID,
			V.CurrencyID ,
			0 As DiscountPers,
			V.TaxGroupID,
			V.TaxIDNo As TaxExemptID,
			V.WarehouseID,
			V.ShipMethodID As ShipMethodID,
			V.GLPurchaseAccount As GLPurchaseAccount,
			V.VendorName as ShippingName,
			V.VendorAddress1 As ShippingAddress1,
			V.VendorAddress2 As ShippingAddress2,
			V.VendorAddress3 As ShippingAddress3,
			V.VendorCity As ShippingCity,
			V.VendorState As ShippingState,
			V.VendorZip As ShippingZip,
			V.VendorCountry As ShippingCountry,
			IFNULL(T.NetDays,0) as NetDays
      From VendorInformation V
      INNER JOIN Companies ON
      V.CompanyID = Companies.CompanyID
      AND V.DivisionID = Companies.DivisionID
      AND V.DepartmentID = Companies.DepartmentID
      Left Outer join Terms T On  V.CompanyID = T.CompanyID
      AND V.DivisionID = T.DivisionID
      AND V.DepartmentID = T.DepartmentID
      And V.TermsID = T.TermsID
      Where V.CompanyID = v_CompanyID
      AND V.DivisionID = v_DivisionID
      AND V.DepartmentID = v_DepartmentID
      AND V.VendorID = v_VendorID;
   end if;
END