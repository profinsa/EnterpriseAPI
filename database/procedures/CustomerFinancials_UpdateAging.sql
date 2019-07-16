CREATE PROCEDURE CustomerFinancials_UpdateAging (v_CompanyID NATIONAL VARCHAR(36),
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
   select   IFNULL(AgeInvoicesBy,N'1') INTO v_AgeInvoicesBy FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   IF v_AgeInvoicesBy = N'1' then
      select   IFNULL(InvoiceDate,CURRENT_TIMESTAMP) INTO v_DateToAgeBy FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND InvoiceNumber = v_InvoiceNumber;
   end if;

   IF v_AgeInvoicesBy = N'2' then
      select   IFNULL(ShipDate,CURRENT_TIMESTAMP) INTO v_DateToAgeBy FROM
      InvoiceHeader WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND InvoiceNumber = v_InvoiceNumber;
   end if;


   select   IFNULL(AmountPaid,0), CurrencyID, CurrencyExchangeRate, InvoiceDate, IFNULL(CustomerID,'') INTO v_Amount,v_CurrencyID,v_CurrencyExchangeRate,v_InvoiceDate,v_CustomerID FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber;

   SET @SWV_Error = 0;
   CALL VerifyCurrency(v_CompanyID,v_DivisionID,v_DepartmentID,v_InvoiceDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,CustomerFinancials_UpdateAging,
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;


   SET v_ConvertedAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);
   START TRANSACTION;

   SET v_position = TIMESTAMPDIFF(DAY,v_DateToAgeBy,CURRENT_TIMESTAMP);
   IF v_position < 30 then

      SET @SWV_Error = 0;
      UPDATE
      CustomerFinancials
      SET
      Under30 = IFNULL(Under30,0)+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Updating CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,CustomerFinancials_UpdateAging,
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
      Over30 = IFNULL(Over30,0)+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Updating CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,CustomerFinancials_UpdateAging,
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
      Over60 = IFNULL(Over60,0)+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Updating CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,CustomerFinancials_UpdateAging,
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
      Over90 = IFNULL(Over90,0)+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Updating CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,CustomerFinancials_UpdateAging,
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
      Over120 = IFNULL(Over120,0)+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Updating CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,CustomerFinancials_UpdateAging,
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
      Over150 = IFNULL(Over150,0)+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Updating CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,CustomerFinancials_UpdateAging,
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
      Over180 = IFNULL(Over180,0)+v_ConvertedAmount
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Updating CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,CustomerFinancials_UpdateAging,
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;


   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   CurrentARBalance = IFNULL(Under30,0)
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Updating CustomerFinancials failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,CustomerFinancials_UpdateAging,
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
      SET SWP_Ret_Value = -1;
   end if;



   select   IFNULL(HighestBalance,0) -IFNULL(CurrentARBalance,0) INTO v_Balance FROM
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
      HighestBalance = IFNULL(CurrentARBalance,0)
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND CustomerID = v_CustomerID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Updating CustomerFinancials failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,CustomerFinancials_UpdateAging,
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,CustomerFinancials_UpdateAging,
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'InvoiceNumber',v_InvoiceNumber);

   SET SWP_Ret_Value = -1;
END