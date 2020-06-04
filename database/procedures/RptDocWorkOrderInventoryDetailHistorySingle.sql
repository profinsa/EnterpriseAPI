CREATE PROCEDURE RptDocWorkOrderInventoryDetailHistorySingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_WorkOrderNumber NATIONAL VARCHAR(36)) BEGIN














   SELECT * FROM WorkOrderDetailHistory
   WHERE
   CompanyID = v_CompanyID
   and DivisionID = v_DivisionID
   and DepartmentID = v_DepartmentID
   and WorkOrderNumber = v_WorkOrderNumber;
END