CREATE PROCEDURE ApprovedWorkOrderDetails (v_ApprovedBy NATIONAL VARCHAR(36)) BEGIN






  
   SELECT
   DISTINCT WD.WorkOrderBOMNumber AS AssemblyID,
			WD.WorkOrderBOMQuantity AS NumberOfItemsInAssembly,
			WH.WorkOrderApprovedBy AS ApprovedBy
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
   WD.WorkOrderNumber = WH.WorkOrderNumber
   AND
   WH.WorkOrderApprovedBy = v_ApprovedBy
   AND
   WH.WorkOrderCompleted = 0;
END