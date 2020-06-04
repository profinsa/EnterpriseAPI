CREATE PROCEDURE RptDocReceivingHeaderSingleFromReceivingNumber (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_RecivingNumber NATIONAL VARCHAR(36)) BEGIN






   SELECT * FROM PurchaseHeader INNER Join VendorInformation
   On PurchaseHeader.VendorID = VendorInformation.VendorID
   AND PurchaseHeader.CompanyID = VendorInformation.CompanyID
   AND PurchaseHeader.DivisionID = VendorInformation.DivisionID
   AND PurchaseHeader.DepartmentID = VendorInformation.DepartmentID
   WHERE PurchaseHeader.CompanyID = v_CompanyID and PurchaseHeader.DivisionID = v_DivisionID and PurchaseHeader.DepartmentID = v_DepartmentID and PurchaseHeader.RecivingNumber = v_RecivingNumber;
END