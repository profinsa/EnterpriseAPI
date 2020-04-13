CREATE PROCEDURE RptDocDebitMemoHeaderSingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_PurchaseNumber NATIONAL VARCHAR(36)) BEGIN



   SELECT PurchaseHeader.*, VendorInformation.*, MajorUnits, MinorUnits
   FROM PurchaseHeader INNER Join VendorInformation
   On PurchaseHeader.VendorID = VendorInformation.VendorID
   AND PurchaseHeader.CompanyID = VendorInformation.CompanyID
   AND PurchaseHeader.DivisionID = VendorInformation.DivisionID
   AND PurchaseHeader.DepartmentID = VendorInformation.DepartmentID
   LEFT OUTER JOIN CurrencyTypes ON
   PurchaseHeader.CompanyID = CurrencyTypes.CompanyID AND
   PurchaseHeader.DivisionID = CurrencyTypes.DivisionID AND
   PurchaseHeader.DepartmentID = CurrencyTypes.DepartmentID AND
   PurchaseHeader.CurrencyID = CurrencyTypes.CurrencyID
   WHERE
   PurchaseHeader.CompanyID = v_CompanyID
   and PurchaseHeader.DivisionID = v_DivisionID
   and PurchaseHeader.DepartmentID = v_DepartmentID and
   PurchaseHeader.PurchaseNumber = v_PurchaseNumber;
END