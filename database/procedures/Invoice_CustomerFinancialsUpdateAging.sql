CREATE PROCEDURE Invoice_CustomerFinancialsUpdateAging (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN


















   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_DateToAgeBy DATETIME;
   DECLARE v_AgeInvoicesBy NATIONAL VARCHAR(1);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_InvoiceDate DATETIME;
   DECLARE v_position INT;
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_Balance DECIMAL(19,4);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   AgeInvoicesBy INTO v_AgeInvoicesBy FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   IF v_AgeInvoicesBy = N'1' then


      select   InvoiceDate INTO v_DateToAgeBy FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND InvoiceNumber = v_InvoiceNumber;
   end if;

   IF v_AgeInvoicesBy = N'2' then


      select   ShipDate INTO v_DateToAgeBy FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND InvoiceNumber = v_InvoiceNumber;
   end if;


   select   AmountPaid, CurrencyID, CurrencyExchangeRate, InvoiceDate, CustomerID INTO v_Amount,v_CurrencyID,v_CurrencyExchangeRate,v_InvoiceDate,v_CustomerID FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;



   SET v_position = TIMESTAMPDIFF(DAY,v_DateToAgeBy,CURRENT_TIMESTAMP);

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


   SET v_ConvertedAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);


   IF v_position < 30 then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      Under30 = Under30+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF v_position >= 30 AND v_position < 60 then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      Over30 = Over30+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF v_position >= 60 AND v_position < 90 then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      Over60 = Over60+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF v_position >= 90 AND v_position < 120 then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      Over90 = Over90+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF v_position >= 120 AND v_position < 150 then
      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      Over120 = Over120+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF v_position >= 150 AND v_position < 180 then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      Over150 = Over150+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF v_position >= 180 then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      Over180 = Over180+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;


   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   CurrentARBalance = Under30
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;
   IF @SWV_Error <> 0 then


      SET v_ErrorMessage = 'Update CustomerFinancials failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;



   select   HighestBalance -CurrentARBalance INTO v_Balance FROM
   CustomerFinancials WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;

   IF v_Balance < 0 then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      HighestBalance = CurrentARBalance
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
	
         SET v_ErrorMessage = 'Update CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CustomerFinancialsUpdateAging',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END