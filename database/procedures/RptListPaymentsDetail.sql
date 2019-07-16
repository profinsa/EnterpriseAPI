CREATE PROCEDURE RptListPaymentsDetail (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN



   SELECT
	
	
	
   PaymentsDetail.PaymentID,
	PaymentDetailID,
	PayedID, 
	
	
	
	
	CurrencyTypes.CurrencyID,
	CurrencyTypes.CurrenycySymbol,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,AppliedAmount,PaymentsHeader.CurrencyID) as SIGNED INTEGER) AS AppliedAmount,
	PaymentsDetail.Cleared
   FROM PaymentsDetail
   INNER JOIN PaymentsHeader ON
   PaymentsHeader.CompanyID = PaymentsDetail.CompanyID and
   PaymentsHeader.DivisionID = PaymentsDetail.DivisionID and
   PaymentsHeader.DepartmentID = PaymentsDetail.DepartmentID and
   PaymentsHeader.PaymentID = PaymentsDetail.PaymentID
   INNER JOIN CurrencyTypes ON
   PaymentsHeader.CompanyID = CurrencyTypes.CompanyID and
   PaymentsHeader.DivisionID = CurrencyTypes.DivisionID and
   PaymentsHeader.DepartmentID = CurrencyTypes.DepartmentID and
   PaymentsHeader.CurrencyID = CurrencyTypes.CurrencyID
   WHERE
   PaymentsDetail.CompanyID = v_CompanyID and
   PaymentsDetail.DivisionID = v_DivisionID and
   PaymentsDetail.DepartmentID = v_DepartmentID;
END