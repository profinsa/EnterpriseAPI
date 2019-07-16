CREATE FUNCTION fnRound (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_val DECIMAL(19,4),
	v_CurrencyID NATIONAL VARCHAR(3)) BEGIN

   RETURN
   ROUND(v_val,fnCurrencyPrecision(v_CompanyID,v_DivisionID,v_DepartmentID,v_CurrencyID));

END