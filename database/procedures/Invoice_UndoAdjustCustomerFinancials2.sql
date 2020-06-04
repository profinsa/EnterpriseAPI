CREATE PROCEDURE Invoice_UndoAdjustCustomerFinancials2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN












   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_CustomerID NATIONAL VARCHAR(50);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_InvoiceDate DATETIME;
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_ConvertedTotal DECIMAL(19,4);
   DECLARE v_CreditLimit DECIMAL(19,4);
   DECLARE v_AvailibleCredit DECIMAL(19,4);




   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   WriteError:
   BEGIN
      select   CustomerID, Total, CurrencyID, CurrencyExchangeRate, InvoiceDate INTO v_CustomerID,v_Total,v_CurrencyID,v_CurrencyExchangeRate,v_InvoiceDate FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND InvoiceNumber = v_InvoiceNumber;
      START TRANSACTION;


      SET @SWV_Error = 0;
      CALL VerifyCurrency(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
      v_CurrencyID,v_CurrencyExchangeRate);
      IF @SWV_Error <> 0 then

	
         SET v_ErrorMessage = 'Currency retrieving failed';
         LEAVE WriteError;
      end if;
      SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total*v_CurrencyExchangeRate, 
      v_CompanyCurrencyID);
      select   IFNULL(AvailibleCredit,0) INTO v_AvailibleCredit FROM
      CustomerFinancials WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      SET v_AvailibleCredit = v_AvailibleCredit -v_ConvertedTotal;
      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      AvailibleCredit = v_AvailibleCredit
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then

         SET v_ErrorMessage = 'customer financials updating failed';
         LEAVE WriteError;
      end if;
      COMMIT;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return; 






   END;
   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_UndoAdjustCustomerFinancials',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'Number',v_InvoiceNumber);
END