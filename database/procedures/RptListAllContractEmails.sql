CREATE PROCEDURE RptListAllContractEmails (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN







   SELECT
   CustomerInformation.CustomerEmail
   FROM CustomerInformation
   INNER JOIN ContractsHeader ON
   ContractsHeader.CustomerID = CustomerInformation.CustomerID and
   ContractsHeader.CompanyID = v_CompanyID and
   ContractsHeader.DivisionID = v_DivisionID and
   ContractsHeader.DepartmentID = v_DepartmentID
   WHERE CustomerInformation.CompanyID = v_CompanyID and
   CustomerInformation.DivisionID = v_DivisionID and
   CustomerInformation.DepartmentID = v_DepartmentID;
END