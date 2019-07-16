CREATE PROCEDURE RptListPurchaseHeader (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN



   SELECT
	
	
	
   PurchaseNumber,
	TransactionTypeID,
	PurchaseDate, 
	
	
	
	
	
	
	
	
	
	
	VendorID, 
	
	
	
	
	
	
	
	
	
	CurrencyTypes.CurrencyID,
	CurrencyTypes.CurrenycySymbol,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Freight,PurchaseHeader.CurrencyID) as SIGNED INTEGER) AS Freight,
	
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Handling,PurchaseHeader.CurrencyID) as SIGNED INTEGER) AS Handling,
	
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Total,PurchaseHeader.CurrencyID) as SIGNED INTEGER) AS Total
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
   FROM PurchaseHeader
   INNER JOIN CurrencyTypes ON
   PurchaseHeader.CompanyID = CurrencyTypes.CompanyID and
   PurchaseHeader.DivisionID = CurrencyTypes.DivisionID and
   PurchaseHeader.DepartmentID = CurrencyTypes.DepartmentID and
   PurchaseHeader.CurrencyID = CurrencyTypes.CurrencyID
   WHERE
   PurchaseHeader.CompanyID = v_CompanyID and
   PurchaseHeader.DivisionID = v_DivisionID and
   PurchaseHeader.DepartmentID = v_DepartmentID;
END