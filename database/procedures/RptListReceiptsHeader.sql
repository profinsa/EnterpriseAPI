CREATE PROCEDURE RptListReceiptsHeader (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN



   SELECT
	
	
	
   ReceiptID,
	ReceiptTypeID,
	ReceiptClassID,
	CheckNumber,
	CustomerID,
	TransactionDate, 
	
	
	
	CurrencyTypes.CurrencyID,
	CurrencyTypes.CurrenycySymbol,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Amount,ReceiptsHeader.CurrencyID) as SIGNED INTEGER) AS Amount,
	
	
	
	
	
	
	Cleared,
	Posted,
	Reconciled,
	Deposited
	
	
	
	
	
	
	
	
	
   FROM ReceiptsHeader
   INNER JOIN CurrencyTypes ON
   ReceiptsHeader.CompanyID = CurrencyTypes.CompanyID and
   ReceiptsHeader.DivisionID = CurrencyTypes.DivisionID and
   ReceiptsHeader.DepartmentID = CurrencyTypes.DepartmentID and
   ReceiptsHeader.CurrencyID = CurrencyTypes.CurrencyID
   WHERE
   ReceiptsHeader.CompanyID = v_CompanyID and
   ReceiptsHeader.DivisionID = v_DivisionID and
   ReceiptsHeader.DepartmentID = v_DepartmentID;
END