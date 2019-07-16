CREATE PROCEDURE RptListCurrencyTypes (v_CompanyID NATIONAL VARCHAR(36), 
 v_DivisionID NATIONAL VARCHAR(36), 
 v_DepartmentID NATIONAL VARCHAR(36)) BEGIN











   SELECT
	
	
	
   CurrencyID,
	CurrencyType,
	CurrenycySymbol,
	CurrencyExchangeRate,
	CurrencyRateLastUpdate
   FROM CurrencyTypes
   WHERE CompanyID = v_CompanyID and DivisionID = v_DivisionID and DepartmentID = v_DepartmentID;
END