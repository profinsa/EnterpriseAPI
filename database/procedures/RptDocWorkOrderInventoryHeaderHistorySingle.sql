CREATE PROCEDURE RptDocWorkOrderInventoryHeaderHistorySingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_WorkOrderNumber NATIONAL VARCHAR(36)) BEGIN















   SELECT * FROM WorkOrderHeaderHistory
   WHERE
   WorkOrderHeaderHistory.CompanyID = v_CompanyID
   and WorkOrderHeaderHistory.DivisionID = v_DivisionID
   and WorkOrderHeaderHistory.DepartmentID = v_DepartmentID
   and WorkOrderHeaderHistory.WorkOrderNumber = v_WorkOrderNumber;
END