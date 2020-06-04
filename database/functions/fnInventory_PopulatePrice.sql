CREATE FUNCTION fnInventory_PopulatePrice (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_DefaultPricingCode NATIONAL VARCHAR(36),
	v_CustomerID NATIONAL VARCHAR(36),
	v_VendorID NATIONAL VARCHAR(36)) BEGIN
   DECLARE v_Price DECIMAL(19,4);
   DECLARE v_ItemPricingCode NATIONAL VARCHAR(36);
   DECLARE v_PriceMatrix NATIONAL VARCHAR(36);
   DECLARE v_SpecialPrice DECIMAL(19,4);

   select   Price, ItemPricingCode INTO v_Price,v_ItemPricingCode FROM InventoryItems WHERE
   ItemID = v_ItemID
   AND CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;


   IF NOT v_CustomerID IS NULL then

      select   PriceMatrix INTO v_PriceMatrix FROM CustomerInformation WHERE CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF NOT v_PriceMatrix IS NULL then
         SET v_SpecialPrice = fnInventoryPricingCode_PopulatePrice(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_PriceMatrix);
      end if;
   ELSE 
      IF NOT v_VendorID IS NULL then

         select   PriceMatrix INTO v_PriceMatrix FROM VendorInformation WHERE CompanyID = v_CompanyID
         AND DivisionID = v_DivisionID
         AND DepartmentID = v_DepartmentID
         AND VendorID = v_VendorID;
         IF NOT v_PriceMatrix IS NULL then
            SET v_SpecialPrice = fnInventoryPricingCode_PopulatePrice(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_PriceMatrix);
         end if;
	
	
         SET v_Price = v_SpecialPrice;
         RETURN v_Price;
      end if;
   end if;



   IF NOT v_SpecialPrice IS NULL AND v_SpecialPrice > 0 then

      SET v_Price = v_SpecialPrice;
      RETURN v_Price;
   end if;

   IF NOT v_DefaultPricingCode IS NULL then

      SET v_SpecialPrice = fnInventoryPricingCode_PopulatePrice(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_DefaultPricingCode);
      IF NOT v_SpecialPrice IS NULL AND v_SpecialPrice > 0 then
	
         SET v_Price = v_SpecialPrice;
         RETURN v_Price;
      end if;
   end if;

   IF NOT v_ItemPricingCode IS NULL then

      SET v_SpecialPrice = fnInventoryPricingCode_PopulatePrice(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_ItemPricingCode);
      IF NOT v_SpecialPrice IS NULL AND v_SpecialPrice > 0 then
	
         SET v_Price = v_SpecialPrice;
         RETURN v_Price;
      end if;
   end if;
   RETURN v_Price;

END