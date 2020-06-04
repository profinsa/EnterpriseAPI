CREATE PROCEDURE RptDocRMAPurchaseOrderHeaderSingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_PurchaseNumber NATIONAL VARCHAR(36)) BEGIN












   SELECT * FROM PurchaseHeader INNER Join CustomerInformation
   On PurchaseHeader.VendorID = CustomerInformation.CustomerID
   AND PurchaseHeader.CompanyID = CustomerInformation.CompanyID
   AND PurchaseHeader.DivisionID = CustomerInformation.DivisionID
   AND PurchaseHeader.DepartmentID = CustomerInformation.DepartmentID
   WHERE PurchaseHeader.CompanyID = v_CompanyID and PurchaseHeader.DivisionID = v_DivisionID and PurchaseHeader.DepartmentID = v_DepartmentID and PurchaseHeader.PurchaseNumber = v_PurchaseNumber;
END