CREATE FUNCTION fnCurrencyPrecision (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_CurrencyID NATIONAL VARCHAR(3)) BEGIN

   RETURN
   IFNULL((SELECT CurrencyPrecision
   FROM CurrencyTypes
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CurrencyID = v_CurrencyID), 
   2);

END