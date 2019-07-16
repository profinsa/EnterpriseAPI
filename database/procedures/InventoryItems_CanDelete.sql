CREATE PROCEDURE InventoryItems_CanDelete (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	INOUT v_CanDelete BOOLEAN ,INOUT SWP_Ret_Value INT) BEGIN










   SET v_CanDelete = 1;
   IF EXISTS(SELECT * FROM
   ItemTransactions
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID) OR
   EXISTS(SELECT * FROM
   ItemHistoryTransactions
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   ItemID = v_ItemID) then
      SET v_CanDelete = 0;
   end if;

   SET SWP_Ret_Value = 0;
END