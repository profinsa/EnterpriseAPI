CREATE FUNCTION fnInventory_PopulateCartPrice (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_CustomerID NATIONAL VARCHAR(36)) BEGIN
   DECLARE v_Price DECIMAL(19,4);
   DECLARE v_DefaultPricingCode NATIONAL VARCHAR(36);
   DECLARE v_UsePricingCode BOOLEAN;
   DECLARE v_UseCustomerSpecificPricing BOOLEAN;

   select   IFNULL(UsePricingCodes,0), UseCustomerSpecificPricing, DefaultPricingCode INTO v_UsePricingCode,v_UseCustomerSpecificPricing,v_DefaultPricingCode FROM InventoryCart WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;
   IF IFNULL(v_UsePricingCode,0) = 0 then
      SET v_DefaultPricingCode = NULL;
   ELSE 
      IF IFNULL(v_UseCustomerSpecificPricing,0) = 0 then
         SET v_CustomerID = NULL;
      end if;
   end if;

   SET  v_Price = fnInventory_PopulatePrice(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_DefaultPricingCode,
   v_CustomerID,NULL);
   RETURN v_Price;

END