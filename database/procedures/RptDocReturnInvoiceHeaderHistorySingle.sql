CREATE PROCEDURE RptDocReturnInvoiceHeaderHistorySingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_InvoiceNumber NATIONAL VARCHAR(36)) BEGIN















   SELECT * FROM InvoiceHeaderHistory INNER Join VendorInformation
   On InvoiceHeaderHistory.CustomerID = VendorInformation.VendorID
   AND InvoiceHeaderHistory.CompanyID = VendorInformation.CompanyID
   AND InvoiceHeaderHistory.DivisionID = VendorInformation.DivisionID
   AND InvoiceHeaderHistory.DepartmentID = VendorInformation.DepartmentID
   WHERE InvoiceHeaderHistory.CompanyID = v_CompanyID and InvoiceHeaderHistory.DivisionID = v_DivisionID and InvoiceHeaderHistory.DepartmentID = v_DepartmentID and InvoiceHeaderHistory.InvoiceNumber = v_InvoiceNumber;
END