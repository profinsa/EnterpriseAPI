CREATE PROCEDURE RptDocDebitMemoDetailHistorySingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_PurchaseNumber NATIONAL VARCHAR(36)) BEGIN













   SELECT * FROM PurchaseDetailHistory
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID and PurchaseNumber = v_PurchaseNumber;
END