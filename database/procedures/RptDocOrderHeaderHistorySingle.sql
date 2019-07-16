CREATE PROCEDURE RptDocOrderHeaderHistorySingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_OrderNumber NATIONAL VARCHAR(36)) BEGIN







   SELECT * FROM OrderHeaderHistory INNER Join CustomerInformation
   On OrderHeaderHistory.CustomerID = CustomerInformation.CustomerID
   AND OrderHeaderHistory.CompanyID = CustomerInformation.CompanyID
   AND OrderHeaderHistory.DivisionID = CustomerInformation.DivisionID
   AND OrderHeaderHistory.DepartmentID = CustomerInformation.DepartmentID
   WHERE OrderHeaderHistory.CompanyID = v_CompanyID and OrderHeaderHistory.DivisionID = v_DivisionID and OrderHeaderHistory.DepartmentID = v_DepartmentID and OrderHeaderHistory.OrderNumber = v_OrderNumber;
END