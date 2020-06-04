CREATE PROCEDURE RptListOrderHeader (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN




   SELECT
	
	
	
   OrderNumber,
	TransactionTypeID,
	OrderTypeID,
	OrderDate, 
	
	
	
	
	
	
	
	CustomerID, 
	
	
	
	
	
	
	
	
	
	
	
	
	
	CurrencyTypes.CurrencyID,
	CurrencyTypes.CurrenycySymbol,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Total,OrderHeader.CurrencyID) as SIGNED INTEGER) AS Total,
	EmployeeID
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
   FROM OrderHeader
   INNER JOIN CurrencyTypes ON
   OrderHeader.CompanyID = CurrencyTypes.CompanyID and
   OrderHeader.DivisionID = CurrencyTypes.DivisionID and
   OrderHeader.DepartmentID = CurrencyTypes.DepartmentID and
   OrderHeader.CurrencyID = CurrencyTypes.CurrencyID
   WHERE
   OrderHeader.CompanyID = v_CompanyID and
   OrderHeader.DivisionID = v_DivisionID and
   OrderHeader.DepartmentID = v_DepartmentID;
END