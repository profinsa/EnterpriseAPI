CREATE PROCEDURE WorkinProgressDetails (v_EmployeeID NATIONAL VARCHAR(72)) BEGIN
   SELECT
   DISTINCT WH.WorkOrderNumber,
				DATE_FORMAT(WH.WorkOrderStartDate,'%m/%d/%Y') as WorkOrderStartDate,
				DATE_FORMAT(WH.WorkOrderCompletedDate,'%m/%d/%Y') AS WorkOrderEndDate			
				
				
   FROM
   WorkOrderHeader WH
   INNER JOIN
   WorkOrderDetail WD
   ON
   WH.CompanyID = WD.CompanyID
   AND
   WH.DivisionID = WD.DivisionID
   AND
   WH.DepartmentID = WD.DepartmentID
   AND
   WH.WorkOrderApprovedBy = v_EmployeeID;	
END