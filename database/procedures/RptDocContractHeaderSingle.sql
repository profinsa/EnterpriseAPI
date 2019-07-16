CREATE PROCEDURE RptDocContractHeaderSingle (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_OrderNumber NATIONAL VARCHAR(36)) BEGIN












   SELECT * FROM ContractsHeader INNER Join CustomerInformation
   On ContractsHeader.CustomerID = CustomerInformation.CustomerID
   AND ContractsHeader.CompanyID = CustomerInformation.CompanyID
   AND ContractsHeader.DivisionID = CustomerInformation.DivisionID
   AND ContractsHeader.DepartmentID = CustomerInformation.DepartmentID
   WHERE ContractsHeader.CompanyID = v_CompanyID and ContractsHeader.DivisionID = v_DivisionID and ContractsHeader.DepartmentID = v_DepartmentID and ContractsHeader.OrderNumber = v_OrderNumber;
END