CREATE PROCEDURE RptUnRealizedGainsLosses (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN










   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_ExchangeRateDate DATETIME;
   DECLARE v_ErrorID INT;
   SET v_ExchangeRateDate = CURRENT_TIMESTAMP;

   SELECT
   InvoiceNumber,
	CustomerID,
	CurrencyID,
	CurrencyExchangeRate,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Total,CurrencyID),
	CurrencyExchangeRate2(v_CompanyID,v_DivisionID,v_DepartmentID,CurrencyID,v_ExchangeRateDate, 
   NULL)
   AS CurrentCurrencyExchangeRate,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Total*CurrencyExchangeRate/CurrencyExchangeRate2(v_CompanyID,v_DivisionID,v_DepartmentID,CurrencyID,v_ExchangeRateDate, 
   NULL),
   N'')
   AS NewTotal,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(Total*CurrencyExchangeRate/CurrencyExchangeRate2(v_CompanyID,v_DivisionID,v_DepartmentID,CurrencyID,v_ExchangeRateDate, 
   NULL))
   -Total,N'')
   AS GainLoss
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ABS((Total*CurrencyExchangeRate/CurrencyExchangeRate2(v_CompanyID,v_DivisionID,v_DepartmentID,CurrencyID,v_ExchangeRateDate, 
   NULL))
   -Total) > 0.005;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptUnRealizedGainsLosses',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END