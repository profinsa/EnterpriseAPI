CREATE PROCEDURE RptListReceiptsDetail (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN




   SELECT
	
	
	
   ReceiptsDetail.ReceiptID,
	ReceiptDetailID,
	DocumentNumber,
	PaymentID,
	PayedID, 
	
	
	
	
	CurrencyTypes.CurrencyID,
	CurrencyTypes.CurrenycySymbol,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,AppliedAmount,ReceiptsHeader.CurrencyID) as SIGNED INTEGER) AS AppliedAmount,
	ReceiptsDetail.Cleared
	
	
	
	
	
   FROM ReceiptsDetail
   INNER JOIN ReceiptsHeader ON
   ReceiptsHeader.CompanyID = ReceiptsDetail.CompanyID and
   ReceiptsHeader.DivisionID = ReceiptsDetail.DivisionID and
   ReceiptsHeader.DepartmentID = ReceiptsDetail.DepartmentID and
   ReceiptsHeader.ReceiptID = ReceiptsDetail.ReceiptID
   INNER JOIN CurrencyTypes ON
   ReceiptsHeader.CompanyID = CurrencyTypes.CompanyID and
   ReceiptsHeader.DivisionID = CurrencyTypes.DivisionID and
   ReceiptsHeader.DepartmentID = CurrencyTypes.DepartmentID and
   ReceiptsHeader.CurrencyID = CurrencyTypes.CurrencyID
   WHERE
   ReceiptsDetail.CompanyID = v_CompanyID and
   ReceiptsDetail.DivisionID = v_DivisionID and
   ReceiptsDetail.DepartmentID = v_DepartmentID;
END