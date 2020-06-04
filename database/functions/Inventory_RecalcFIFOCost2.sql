CREATE FUNCTION Inventory_RecalcFIFOCost2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_RunningQuantitySold BIGINT) BEGIN
	DECLARE SWP_Ret_Value INT;
	CALL Inventory_RecalcFIFOCost(v_CompanyID, v_DivisionID, v_DepartmentID, v_ItemID, v_RunningQuantitySold, SWP_Ret_Value);
	RETURN SWP_Ret_Value;

END