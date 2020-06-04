CREATE PROCEDURE Payment_AdjustVendorFinancials (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PaymentID  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN








   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_VendorID NATIONAL VARCHAR(50);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_ConvertedAmount DECIMAL(19,4);
   DECLARE v_AverageDaytoPay INT;
   DECLARE v_LateDays INT;
   DECLARE v_PromptPerc FLOAT;
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_DueDate DATETIME;
   DECLARE v_OnTimePaymentCount INT;
   DECLARE v_TotalPaymentCount INT;
   DECLARE v_TotalDayToPay INT;




   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   VendorID, Amount, CurrencyID, CurrencyExchangeRate, PaymentDate, IFNULL(v_DueDate,PaymentDate) INTO v_VendorID,v_Amount,v_CurrencyID,v_CurrencyExchangeRate,v_PaymentDate,
   v_DueDate FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PaymentID = v_PaymentID;

   START TRANSACTION;


   SET @SWV_Error = 0;
   CALL VerifyCurrency(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_AdjustVendorFinancials',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ConvertedAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);



   select   LateDays, PromptPerc, AverageDaytoPay INTO v_LateDays,v_PromptPerc,v_AverageDaytoPay FROM
   VendorFinancials WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID;

   SET v_LateDays = TIMESTAMPDIFF(Day,v_DueDate,v_PaymentDate);
   select   IFNULL(Count(PaymentID),0) INTO v_OnTimePaymentCount FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND TIMESTAMPDIFF(Day,IFNULL(DueToDate,PaymentDate),PaymentDate) >= 0;
   select   IFNULL(Count(PaymentID),0) INTO v_TotalPaymentCount FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID;
   IF v_TotalPaymentCount > 0 then
      SET v_PromptPerc = cast(v_OnTimePaymentCount as DECIMAL(15,15))/v_TotalPaymentCount;
   end if;


   IF v_AverageDaytoPay <> -1 AND  v_TotalPaymentCount > 0 then

      select   SUM(TIMESTAMPDIFF(Day,PaymentDate,IFNULL(PurchaseDate,PaymentDate))) INTO v_TotalDayToPay FROM
      PaymentsHeader WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PaymentID = v_PaymentID
      AND VendorID = v_VendorID
      AND TIMESTAMPDIFF(Day,DueToDate,PaymentDate) >= 0;
      SET  v_TotalDayToPay = IFNULL(v_TotalDayToPay,0);
      SET v_AverageDaytoPay = v_TotalDayToPay/v_TotalPaymentCount;
   end if;

   SET @SWV_Error = 0;
   UPDATE
   VendorFinancials
   SET
   LateDays = v_LateDays,AverageDaytoPay = v_AverageDaytoPay,LastPaymentDate = v_PaymentDate,
   LastPaymentAmount = v_ConvertedAmount,PromptPerc = v_PromptPerc,
   PaymentsYTD = IFNULL(PaymentsYTD,0)+v_ConvertedAmount
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Vendor financials updating failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_AdjustVendorFinancials',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return; 






   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_AdjustVendorFinancials',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);

   SET SWP_Ret_Value = -1;
END