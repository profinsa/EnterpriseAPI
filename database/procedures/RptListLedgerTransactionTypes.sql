CREATE PROCEDURE RptListLedgerTransactionTypes (v_CompanyID NATIONAL VARCHAR(36),
v_DivisionID NATIONAL VARCHAR(36),
v_DepartmentID NATIONAL VARCHAR(36)) BEGIN








   SELECT     TransactionTypeID, TransactionTypeDescription
   FROM         LedgerTransactionTypes
   WHERE     (CompanyID = v_CompanyID) AND (DivisionID = v_DivisionID) AND (DepartmentID = v_DepartmentID);
END