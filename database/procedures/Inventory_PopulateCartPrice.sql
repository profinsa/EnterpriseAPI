CREATE PROCEDURE Inventory_PopulateCartPrice (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_CustomerID NATIONAL VARCHAR(36),
	INOUT v_Price DECIMAL(19,4) ,INOUT SWP_Ret_Value INT) BEGIN






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

   CALL Inventory_PopulatePrice(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_DefaultPricingCode,
   v_CustomerID,NULL,v_Price);



   SET SWP_Ret_Value = 0;
END