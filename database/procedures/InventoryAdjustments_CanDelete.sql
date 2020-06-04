CREATE PROCEDURE InventoryAdjustments_CanDelete (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_AdjustmentID NATIONAL VARCHAR(36),
	INOUT v_CanDelete BOOLEAN ,INOUT SWP_Ret_Value INT) BEGIN







   DECLARE v_AdjustmentPosted BOOLEAN;
   DECLARE v_AdjustmentPostToGL BOOLEAN;
   SET v_CanDelete = 1;
   select   AdjustmentPosted, AdjustmentPostToGL INTO v_AdjustmentPosted,v_AdjustmentPostToGL FROM
   InventoryAdjustments WHERE
   CompanyID = v_CompanyID AND DivisionID = v_DivisionID AND DepartmentID = v_DepartmentID AND
   AdjustmentID = v_AdjustmentID;

   IF IFNULL(v_AdjustmentPosted,0) = 1 OR  IFNULL(v_AdjustmentPostToGL,0) = 1 then
      SET v_CanDelete = 0;
   ELSE
      SET v_CanDelete = 1;
   end if;

   
SET SWP_Ret_Value = 0;
END