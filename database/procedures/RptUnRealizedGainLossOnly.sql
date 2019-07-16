CREATE PROCEDURE RptUnRealizedGainLossOnly (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_GainLoss DECIMAL(19,4) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN



   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_ExchangeRateDate DATETIME;
   DECLARE v_ErrorID INT;
   SET v_ExchangeRateDate = CURRENT_TIMESTAMP;

   select   fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM((Total*CurrencyExchangeRate/CurrencyExchangeRate2(v_CompanyID,v_DivisionID,v_DepartmentID,CurrencyID,v_ExchangeRateDate, 
   NULL))
   -Total),N'') INTO v_GainLoss FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   CALL Error_InsertError(v_CompanyID,v_DepartmentID,v_DivisionID,'RptUnRealizedGainLossOnly',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END