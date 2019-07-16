CREATE PROCEDURE InventoryAssembliesAlternateItemID () BEGIN
   SELECT DISTINCT
   ItemID
   FROM
   InventoryAssemblies;
END