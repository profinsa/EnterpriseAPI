CREATE PROCEDURE RptDocServiceInvoiceHeaderHistorySingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_InvoiceNumber NATIONAL VARCHAR(36)) BEGIN














   SELECT * FROM InvoiceHeaderHistory INNER Join CustomerInformation
   On InvoiceHeaderHistory.CustomerID = CustomerInformation.CustomerID
   AND InvoiceHeaderHistory.CompanyID = CustomerInformation.CompanyID
   AND InvoiceHeaderHistory.DivisionID = CustomerInformation.DivisionID
   AND InvoiceHeaderHistory.DepartmentID = CustomerInformation.DepartmentID
   WHERE InvoiceHeaderHistory.CompanyID = v_CompanyID and InvoiceHeaderHistory.DivisionID = v_DivisionID and InvoiceHeaderHistory.DepartmentID = v_DepartmentID and InvoiceHeaderHistory.InvoiceNumber = v_InvoiceNumber;
END