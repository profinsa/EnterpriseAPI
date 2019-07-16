CREATE PROCEDURE RptDocBankReconciliationSummaryTemp (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36),
 v_BankRecID NATIONAL VARCHAR(36)) BEGIN











   SELECT * FROM BankReconciliationSummaryTemp
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID and BankRecID = v_BankRecID;
END