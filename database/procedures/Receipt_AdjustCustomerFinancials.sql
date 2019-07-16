CREATE PROCEDURE Receipt_AdjustCustomerFinancials (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ReceiptID  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN














   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_CustomerID NATIONAL VARCHAR(50);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_ReceiptDate DATETIME;
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




   DECLARE v_LastPaymentDate DATETIME;
   DECLARE v_LastReceiptID NATIONAL VARCHAR(36);
   DECLARE v_LastPaymentAmount DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   CustomerID, Amount, CurrencyID, CurrencyExchangeRate, OrderDate, TransactionDate, IFNULL(DueToDate,TransactionDate) INTO v_CustomerID,v_Amount,v_CurrencyID,v_CurrencyExchangeRate,v_ReceiptDate,
   v_PaymentDate,v_DueDate FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ReceiptID = v_ReceiptID;

   START TRANSACTION;


   SET @SWV_Error = 0;
   CALL VerifyCurrency(v_CompanyID,v_DivisionID,v_DepartmentID,v_ReceiptDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_AdjustCustomerFinancials',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;

   SET v_ConvertedAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Amount*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);



   select   MAX(TIMESTAMPDIFF(Day,TransactionDate,IFNULL(DueToDate,TransactionDate))) INTO v_LateDays FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor') 
   AND Posted = 1;

   IF IFNULL(v_LateDays,0) <= 0 then

      SET v_LateDays = 0;
   end if;

   select   ROUND(AVG(TIMESTAMPDIFF(DAY,IFNULL(OrderDate,TransactionDate),TransactionDate)),0) INTO v_AverageDaytoPay FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor') 
   AND Posted = 1;

   SET v_AverageDaytoPay = IFNULL(v_AverageDaytoPay,-1);



   select   TransactionDate, ReceiptID INTO v_LastPaymentDate,v_LastReceiptID FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor') 
   AND Posted = 1   ORDER BY TransactionDate,ReceiptID DESC LIMIT 1;


   select   Amount, IFNULL(CurrencyExchangeRate,1) INTO v_Amount,v_CurrencyExchangeRate FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND ReceiptID = v_LastReceiptID;

   SET v_LastPaymentAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(v_Amount,0)*IFNULL(v_CurrencyExchangeRate,1), 
   v_CompanyCurrencyID);



   select   IFNULL(Count(ReceiptID),0) INTO v_OnTimePaymentCount FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1
   AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor') 
   AND TIMESTAMPDIFF(Day,TransactionDate,IFNULL(DueToDate,TransactionDate)) >= 0;

   select   IFNULL(Count(ReceiptID),0) INTO v_TotalPaymentCount FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1
   AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor'); 

   IF IFNULL(v_TotalPaymentCount,0) > 0 then
      SET v_PromptPerc = cast(IFNULL(v_OnTimePaymentCount,0) as DECIMAL(15,15))/IFNULL(v_TotalPaymentCount,1);
   end if;
   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   LateDays = v_LateDays,AverageDaytoPay = v_AverageDaytoPay,LastPaymentDate = v_PaymentDate,
   LastPaymentAmount = v_ConvertedAmount,PromptPerc = v_PromptPerc,
   PaymentsYTD = IFNULL(PaymentsYTD,0)+v_ConvertedAmount
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'customer financials updating failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_AdjustCustomerFinancials',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);
      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return; 






   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receipt_AdjustCustomerFinancials',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'ReceiptID',v_ReceiptID);

   SET SWP_Ret_Value = -1;
END