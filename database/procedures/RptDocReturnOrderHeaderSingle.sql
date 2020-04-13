CREATE PROCEDURE RptDocReturnOrderHeaderSingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_OrderNumber NATIONAL VARCHAR(36)) BEGIN








   SELECT * FROM OrderHeader INNER Join VendorInformation
   On OrderHeader.CustomerID = VendorInformation.VendorID
   AND OrderHeader.CompanyID = VendorInformation.CompanyID
   AND OrderHeader.DivisionID = VendorInformation.DivisionID
   AND OrderHeader.DepartmentID = VendorInformation.DepartmentID
   WHERE OrderHeader.CompanyID = v_CompanyID and OrderHeader.DivisionID = v_DivisionID and OrderHeader.DepartmentID = v_DepartmentID and OrderHeader.OrderNumber = v_OrderNumber;
END