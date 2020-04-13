CREATE PROCEDURE RptDocQuoteDetailSingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_OrderNumber NATIONAL VARCHAR(36)) BEGIN












   SELECT * FROM OrderDetail
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID and OrderNumber = v_OrderNumber;
END