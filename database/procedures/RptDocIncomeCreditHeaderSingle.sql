CREATE PROCEDURE RptDocIncomeCreditHeaderSingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_InvoiceNumber NATIONAL VARCHAR(36)) BEGIN




   SELECT InvoiceHeader.*, VendorInformation.*, MajorUnits, MinorUnits
   FROM InvoiceHeader INNER Join VendorInformation
   On InvoiceHeader.CustomerID = VendorInformation.VendorID
   AND InvoiceHeader.CompanyID = VendorInformation.CompanyID
   AND InvoiceHeader.DivisionID = VendorInformation.DivisionID
   AND InvoiceHeader.DepartmentID = VendorInformation.DepartmentID
   INNER JOIN Companies  ON
   Companies.CompanyID = InvoiceHeader.CompanyID AND
   Companies.DivisionID = InvoiceHeader.DivisionID AND
   Companies.DepartmentID = InvoiceHeader.DepartmentID
   INNER JOIN CurrencyTypes ON
   Companies.CompanyID = CurrencyTypes.CompanyID AND
   Companies.DivisionID = CurrencyTypes.DivisionID AND
   Companies.DepartmentID = CurrencyTypes.DepartmentID AND
   Companies.CurrencyID = CurrencyTypes.CurrencyID
   WHERE InvoiceHeader.CompanyID = v_CompanyID and
   InvoiceHeader.DivisionID = v_DivisionID and
   InvoiceHeader.DepartmentID = v_DepartmentID and
   InvoiceHeader.InvoiceNumber = v_InvoiceNumber;
END