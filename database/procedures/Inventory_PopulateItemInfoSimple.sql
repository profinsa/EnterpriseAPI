CREATE PROCEDURE Inventory_PopulateItemInfoSimple (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36)) BEGIN

















   DECLARE v_CostingMethod NATIONAL VARCHAR(1);
   select   DefaultInventoryCostingMethod INTO v_CostingMethod From
   Companies Where
   CompanyID = v_CompanyID  AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   Select
   InventoryItems.ItemDescription,
	InventoryItems.ItemWeight,
	InventoryItems.ItemCareInstructions,
	InventoryItems.ItemDefaultWarehouse,
	InventoryItems.ItemDefaultWarehouseBin,
	InventoryItems.ItemUOM,
	InventoryItems.GLItemSalesAccount,
	InventoryItems.GLItemCOGSAccount,
	InventoryItems.GLItemInventoryAccount,
	InventoryItems.Price,
	InventoryItems.ItemPricingCode,
	InventoryItems.PricingMethods,
	InventoryItems.Taxable,
	InventoryItems.IsAssembly,
	InventoryItems.LIFO,
	InventoryItems.LIFOValue,
	InventoryItems.LIFOCost,
	InventoryItems.Average,
	InventoryItems.AverageValue,
	InventoryItems.AverageCost,
	InventoryItems.FIFO,
	InventoryItems.FIFOValue,
	InventoryItems.FIFOCost,
	InventoryItems.Expected,
	InventoryItems.ExpectedValue,
	InventoryItems.ExpectedCost,
	InventoryItems.Landed,
	InventoryItems.LandedValue,
	InventoryItems.LandedCost,
	InventoryItems.Other,
	InventoryItems.OtherValue,
	InventoryItems.OtherCost,
	InventoryItems.Commissionable,
	InventoryItems.CommissionType,
	InventoryItems.CommissionPerc,
	InventoryItems.TaxGroupID,
	(CASE
   WHEN v_CostingMethod = 'F' THEN InventoryItems.FIFOCost
   WHEN v_CostingMethod = 'L' THEN InventoryItems.LIFOCost
   WHEN v_CostingMethod = 'A' THEN InventoryItems.AverageCost
   ELSE 0
   END) As ItemCost,
	(SELECT SUM(IFNULL(LaborCost,0))
      FROM InventoryAssemblies
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND AssemblyID = v_ItemID) As LAborCost
   FROM
   InventoryItems
   WHERE
   InventoryItems.CompanyID = v_CompanyID
   AND InventoryItems.DivisionID = v_DivisionID
   AND InventoryItems.DepartmentID = v_DepartmentID
   AND InventoryItems.ItemID = v_ItemID;
END