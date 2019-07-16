CREATE PROCEDURE RptServiceDocInvoiceHeaderSingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_InvoiceNumber NATIONAL VARCHAR(36)) BEGIN













   SELECT * FROM InvoiceHeader INNER Join CustomerInformation
   On InvoiceHeader.CustomerID = CustomerInformation.CustomerID
   AND InvoiceHeader.CompanyID = CustomerInformation.CompanyID
   AND InvoiceHeader.DivisionID = CustomerInformation.DivisionID
   AND InvoiceHeader.DepartmentID = CustomerInformation.DepartmentID
   WHERE InvoiceHeader.CompanyID = v_CompanyID and InvoiceHeader.DivisionID = v_DivisionID and InvoiceHeader.DepartmentID = v_DepartmentID and InvoiceHeader.InvoiceNumber = v_InvoiceNumber;
END