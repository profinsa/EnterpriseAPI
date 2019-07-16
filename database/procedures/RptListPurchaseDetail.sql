CREATE PROCEDURE RptListPurchaseDetail (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN



   SELECT
	
	
	
   PurchaseDetail.PurchaseNumber,
	PurchaseLineNumber,
	ItemID,
	VendorItemID, 
	
	
	
	OrderQty, 
	
	
	
	
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,ItemCost,N'') as SIGNED INTEGER) AS ItemCost, 
	
	
	
	CurrencyTypes.CurrencyID,
	CurrencyTypes.CurrenycySymbol,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,PurchaseDetail.Total,PurchaseHeader.CurrencyID) as SIGNED INTEGER) AS Total, 
	
	
	ProjectID
	
	
	
	
	
	
	
	
	
   FROM PurchaseDetail
   INNER JOIN PurchaseHeader ON
   PurchaseHeader.CompanyID = PurchaseDetail.CompanyID and
   PurchaseHeader.DivisionID = PurchaseDetail.DivisionID and
   PurchaseHeader.DepartmentID = PurchaseDetail.DepartmentID and
   PurchaseHeader.PurchaseNumber = PurchaseDetail.PurchaseNumber
   INNER JOIN CurrencyTypes ON
   PurchaseHeader.CompanyID = CurrencyTypes.CompanyID and
   PurchaseHeader.DivisionID = CurrencyTypes.DivisionID and
   PurchaseHeader.DepartmentID = CurrencyTypes.DepartmentID and
   PurchaseHeader.CurrencyID = CurrencyTypes.CurrencyID
   WHERE
   PurchaseDetail.CompanyID = v_CompanyID and
   PurchaseDetail.DivisionID = v_DivisionID and
   PurchaseDetail.DepartmentID = v_DepartmentID;
END