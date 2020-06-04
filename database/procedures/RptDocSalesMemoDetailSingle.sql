CREATE PROCEDURE RptDocSalesMemoDetailSingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_InvoiceNumber NATIONAL VARCHAR(36)) BEGIN







   SELECT * FROM InvoiceDetail
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID and InvoiceNumber = v_InvoiceNumber;
END