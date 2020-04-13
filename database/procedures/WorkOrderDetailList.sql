CREATE PROCEDURE WorkOrderDetailList (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WorkOrderNumber NATIONAL VARCHAR(36)) BEGIN
   SELECT
   WorkOrderBOMNumber AS ItemID,
			WorkOrderBOMDescription AS ItemDescription,
			WorkOrderBOMQuantity AS Quantity,
			WorkOrderTotalCost AS TotalCost
   FROM
   WorkOrderDetail
   WHERE
   CompanyID = v_CompanyID
   AND
   DivisionID = v_DivisionID
   AND
   DepartmentID = v_DepartmentID
   AND
   WorkOrderNumber = v_WorkOrderNumber;			
END