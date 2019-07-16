CREATE PROCEDURE RptDocDebitMemoHeaderHistorySingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_PurchaseNumber NATIONAL VARCHAR(36)) BEGIN











   SELECT * FROM PurchaseHeaderHistory INNER Join VendorInformation
   On PurchaseHeaderHistory.VendorID = VendorInformation.VendorID
   AND PurchaseHeaderHistory.CompanyID = VendorInformation.CompanyID
   AND PurchaseHeaderHistory.DivisionID = VendorInformation.DivisionID
   AND PurchaseHeaderHistory.DepartmentID = VendorInformation.DepartmentID
   WHERE PurchaseHeaderHistory.CompanyID = v_CompanyID and PurchaseHeaderHistory.DivisionID = v_DivisionID and PurchaseHeaderHistory.DepartmentID = v_DepartmentID and PurchaseHeaderHistory.PurchaseNumber = v_PurchaseNumber;
END