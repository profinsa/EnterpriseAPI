CREATE PROCEDURE RptListPaymentsHeader (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN



   SELECT
	
	
	
   PaymentID,
	PaymentTypeID,
	CheckNumber,
	VendorID,
	PaymentDate, 
	
	CurrencyTypes.CurrencyID,
	CurrencyTypes.CurrenycySymbol,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Amount,PaymentsHeader.CurrencyID) as SIGNED INTEGER) AS Amount, 
	
	
	
	
	
	
	
	
	
	Cleared, 
	
	Posted,
	Reconciled
	
   FROM PaymentsHeader
   INNER JOIN CurrencyTypes ON
   PaymentsHeader.CompanyID = CurrencyTypes.CompanyID and
   PaymentsHeader.DivisionID = CurrencyTypes.DivisionID and
   PaymentsHeader.DepartmentID = CurrencyTypes.DepartmentID and
   PaymentsHeader.CurrencyID = CurrencyTypes.CurrencyID
   WHERE
   PaymentsHeader.CompanyID = v_CompanyID and
   PaymentsHeader.DivisionID = v_DivisionID and
   PaymentsHeader.DepartmentID = v_DepartmentID;
END