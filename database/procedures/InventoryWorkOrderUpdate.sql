CREATE PROCEDURE InventoryWorkOrderUpdate (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),	
	v_WorkOrderNumber NATIONAL VARCHAR(36),
	v_WorkOrderCompletedDate DATETIME,
	v_WorkOrderCompleted BOOLEAN) BEGIN
   UPDATE
   WorkOrderHeader
   SET
   WorkOrderCompletedDate = v_WorkOrderCompletedDate,WorkOrderCompleted = v_WorkOrderCompleted
   WHERE
   CompanyID = v_CompanyID
   AND
   DivisionID = v_DivisionID
   AND
   DepartmentID = v_DepartmentID
   AND
   WorkOrderNumber = v_WorkOrderNumber;
END