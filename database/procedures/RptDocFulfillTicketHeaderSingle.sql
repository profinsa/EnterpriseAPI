CREATE PROCEDURE RptDocFulfillTicketHeaderSingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_OrderNumber NATIONAL VARCHAR(36)) BEGIN














   SELECT * FROM OrderHeader INNER Join CustomerInformation
   On OrderHeader.CustomerID = CustomerInformation.CustomerID
   AND OrderHeader.CompanyID = CustomerInformation.CompanyID
   AND OrderHeader.DivisionID = CustomerInformation.DivisionID
   AND OrderHeader.DepartmentID = CustomerInformation.DepartmentID
   WHERE OrderHeader.CompanyID = v_CompanyID and OrderHeader.DivisionID = v_DivisionID and OrderHeader.DepartmentID = v_DepartmentID and OrderHeader.OrderNumber = v_OrderNumber;
END