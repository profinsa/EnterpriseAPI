CREATE PROCEDURE RptDocReturnInvoiceHeaderSingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_InvoiceNumber NATIONAL VARCHAR(36)) BEGIN














   SELECT * FROM InvoiceHeader INNER Join VendorInformation
   On InvoiceHeader.CustomerID = VendorInformation.VendorID
   AND InvoiceHeader.CompanyID = VendorInformation.CompanyID
   AND InvoiceHeader.DivisionID = VendorInformation.DivisionID
   AND InvoiceHeader.DepartmentID = VendorInformation.DepartmentID
   WHERE InvoiceHeader.CompanyID = v_CompanyID and InvoiceHeader.DivisionID = v_DivisionID and InvoiceHeader.DepartmentID = v_DepartmentID and InvoiceHeader.InvoiceNumber = v_InvoiceNumber;
END