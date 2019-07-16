CREATE PROCEDURE WorkOrderList (v_WorkOrderApprovedBy NATIONAL VARCHAR(36)) BEGIN
   SELECT
   DISTINCT WD.WorkOrderBOMNumber AS ItemID,
		WD.WorkOrderBOMDescription AS ItemDescription,
		WD.WorkOrderBOMQuantity AS Quantity,
		WD.WorkOrderTotalCost AS TotalCost
   FROM
   WorkOrderDetail WD
   INNER JOIN
   WorkOrderHeader WH
   ON
   WD.CompanyID = WH.CompanyID
   AND
   WD.DivisionID = WH.DivisionID
   AND
   WD.DepartmentID = WH.DepartmentID
   AND
   WorkOrderApprovedBy = v_WorkOrderApprovedBy;
END