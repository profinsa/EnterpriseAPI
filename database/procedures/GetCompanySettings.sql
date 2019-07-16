CREATE PROCEDURE GetCompanySettings (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36)) BEGIN









   Select  Companies.CurrencyID As CurrencyID, CurrencyTypes.CurrencyExchangeRate As CurrencyExchangeRate, CurrencyTypes.CurrenycySymbol As CurrencySymbol
   From CurrencyTypes
   Inner Join Companies On
   Companies.CompanyID = CurrencyTypes.CompanyID AND
   Companies.DivisionID = CurrencyTypes.DivisionID AND
   Companies.DepartmentID = CurrencyTypes.DepartmentID AND
   Companies.CurrencyID = CurrencyTypes.CurrencyID
   Where CurrencyTypes.CompanyID = v_CompanyID
   AND CurrencyTypes.DivisionID = v_DivisionID
   AND CurrencyTypes.DepartmentID = v_DepartmentID;
END