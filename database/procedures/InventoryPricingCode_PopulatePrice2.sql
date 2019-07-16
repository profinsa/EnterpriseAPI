CREATE PROCEDURE InventoryPricingCode_PopulatePrice2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_PricingCode NATIONAL VARCHAR(36),
	INOUT v_Price DECIMAL(19,4) ,INOUT SWP_Ret_Value INT) BEGIN




   DECLARE v_SalesPrice DECIMAL(19,4);
   SET v_Price = NULL;
   select   Price INTO v_Price FROM
   InventoryPricingCode WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ItemID = v_ItemID
   AND ItemPricingCode = IFNULL(v_PricingCode,N'');

   select   SalesPrice INTO v_SalesPrice FROM
   InventoryPricingCode WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ItemID = v_ItemID
   AND ItemPricingCode = IFNULL(v_PricingCode,N'')
   AND (CURRENT_TIMESTAMP BETWEEN SaleStartDate AND SaleEndDate);

   IF NOT v_SalesPrice IS NULL then
      SET v_Price = v_SalesPrice;
   end if;

   SET SWP_Ret_Value = 0;
END