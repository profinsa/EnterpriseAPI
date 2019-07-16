CREATE PROCEDURE spCompanyDailyActivityShipments (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN







   SELECT count(OrderNumber) as Shipments,
	sum(IFNULL(Total,0)) as ShipTotals
   FROM OrderHeader
   WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID and
   DAYOFYEAR(OrderShipDate) = DAYOFYEAR(CURRENT_TIMESTAMP);

   SET SWP_Ret_Value = 0;
END