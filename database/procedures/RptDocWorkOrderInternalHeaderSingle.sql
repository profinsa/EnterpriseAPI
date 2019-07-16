CREATE PROCEDURE RptDocWorkOrderInternalHeaderSingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_WorkOrderNumber NATIONAL VARCHAR(36)) BEGIN














   SELECT * FROM WorkOrderHeader
   WHERE
   WorkOrderHeader.CompanyID = v_CompanyID
   and WorkOrderHeader.DivisionID = v_DivisionID
   and WorkOrderHeader.DepartmentID = v_DepartmentID
   and WorkOrderHeader.WorkOrderNumber = v_WorkOrderNumber;
END