CREATE PROCEDURE CustomerFinancials_ReCalc (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_CustomerID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN







   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(200);
   DECLARE v_CurrentYear SMALLINT;
   DECLARE v_LastSalesDate DATETIME;
   DECLARE v_LastCreditMemoDate DATETIME;
   DECLARE v_LastRMADate DATETIME;
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_DueDate DATETIME;
   DECLARE v_LateDays INT;
   DECLARE v_AverageDaytoPay INT;
   DECLARE v_LastPaymentDate DATETIME;
   DECLARE v_LastReceiptID NATIONAL VARCHAR(36);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_LastPaymentAmount DECIMAL(19,4);
   DECLARE v_PromptPerc FLOAT;
   DECLARE v_OnTimePaymentCount INT;
   DECLARE v_TotalPaymentCount INT;
   DECLARE v_AgeInvoicesBy NATIONAL VARCHAR(1);
   DECLARE v_Under30 DECIMAL(19,4);
   DECLARE v_Over30 DECIMAL(19,4);
   DECLARE v_Over60 DECIMAL(19,4);
   DECLARE v_Over90 DECIMAL(19,4);
   DECLARE v_Over120 DECIMAL(19,4);
   DECLARE v_Over150 DECIMAL(19,4);
   DECLARE v_Over180 DECIMAL(19,4);
   DECLARE v_TotalAR DECIMAL(19,4);
   DECLARE v_SalesYTD DECIMAL(19,4);
   DECLARE v_BookedOrders DECIMAL(19,4);
   DECLARE v_PaymentsYTD DECIMAL(19,4);
   DECLARE v_InvoicesYTD DECIMAL(19,4);
   DECLARE v_RMAs DECIMAL(19,4);
   DECLARE v_RMA_YTD DECIMAL(19,4);
   DECLARE v_CreditMemosYTD DECIMAL(19,4);
   DECLARE v_CreditMemos DECIMAL(19,4);
   DECLARE v_CreditLimit DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF v_CustomerID IS NULL then
      SET SWP_Ret_Value = 1;
      LEAVE SWL_return;
   end if;
   IF NOT EXISTS(SELECT CustomerID
   FROM CustomerInformation
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID) then
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;
   IF NOT EXISTS(SELECT CustomerID
   FROM CustomerFinancials
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID) then

      INSERT INTO CustomerFinancials(CompanyID,
		DivisionID,
		DepartmentID,
		CustomerID)
	VALUES(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_CustomerID);
   end if;
   START TRANSACTION;

   select   IFNULL(v_CompanyCurrencyID,N''), IFNULL(CurrentFiscalYear,YEAR(CURRENT_TIMESTAMP)) INTO v_CompanyCurrencyID,v_CurrentYear FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   select   MAX(IFNULL(OrderDate,CURRENT_TIMESTAMP)) INTO v_LastSalesDate FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND UPPER(IFNULL(OrderHeader.TransactionTypeID,N'')) <> 'RETURN'
   AND Posted = 1;

   select   MAX(IFNULL(InvoiceDate,CURRENT_TIMESTAMP)) INTO v_LastCreditMemoDate FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND UPPER(IFNULL(TransactionTypeID,N'')) = 'CREDIT MEMO'
   AND Posted = 1;
   select   MAX(IFNULL(PurchaseDate,CURRENT_TIMESTAMP)) INTO v_LastRMADate FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_CustomerID
   AND UPPER(IFNULL(TransactionTypeID,N'')) = 'RMA'
   AND Posted = 1; 

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

   select   IFNULL(TransactionDate,SystemDate), ReceiptID INTO v_LastPaymentDate,v_LastReceiptID FROM
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

   select   IFNULL(AgeInvoicesBy,N'1') INTO v_AgeInvoicesBy FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(IFNULL(Total,0) -IFNULL(AmountPaid,0))*IFNULL(CurrencyExchangeRate,1),v_CompanyCurrencyID)),0) INTO v_Under30 FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'RETURN'
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'CREDIT MEMO'
   AND (ABS(IFNULL(Total,0) -IFNULL(AmountPaid,0)) >= 0.005 OR ABS(IFNULL(Total,0)) < 0.005) 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN InvoiceDate
   ELSE ShipDate
   END,CURRENT_TIMESTAMP) <= 30;
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(IFNULL(Total,0) -IFNULL(AmountPaid,0))*IFNULL(CurrencyExchangeRate,1),v_CompanyCurrencyID)),0) INTO v_Over30 FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'RETURN'
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'CREDIT MEMO'
   AND (ABS(IFNULL(Total,0) -IFNULL(AmountPaid,0)) >= 0.005 OR ABS(IFNULL(Total,0)) < 0.005) 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN InvoiceDate
   ELSE ShipDate
   END,CURRENT_TIMESTAMP) > 30
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN InvoiceDate
   ELSE ShipDate
   END,CURRENT_TIMESTAMP) <= 60;
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(IFNULL(Total,0) -IFNULL(AmountPaid,0))*IFNULL(CurrencyExchangeRate,1),v_CompanyCurrencyID)),0) INTO v_Over60 FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'RETURN'
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'CREDIT MEMO'
   AND (ABS(IFNULL(Total,0) -IFNULL(AmountPaid,0)) >= 0.005 OR ABS(IFNULL(Total,0)) < 0.005) 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN InvoiceDate
   ELSE ShipDate
   END,CURRENT_TIMESTAMP) > 60
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN InvoiceDate
   ELSE ShipDate
   END,CURRENT_TIMESTAMP) <= 90;
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(IFNULL(Total,0) -IFNULL(AmountPaid,0))*IFNULL(CurrencyExchangeRate,1),v_CompanyCurrencyID)),0) INTO v_Over90 FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'RETURN'
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'CREDIT MEMO'
   AND (ABS(IFNULL(Total,0) -IFNULL(AmountPaid,0)) >= 0.005 OR ABS(IFNULL(Total,0)) < 0.005) 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN InvoiceDate
   ELSE ShipDate
   END,CURRENT_TIMESTAMP) > 90
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN InvoiceDate
   ELSE ShipDate
   END,CURRENT_TIMESTAMP) <= 120;
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(IFNULL(Total,0) -IFNULL(AmountPaid,0))*IFNULL(CurrencyExchangeRate,1),v_CompanyCurrencyID)),0) INTO v_Over120 FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'RETURN'
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'CREDIT MEMO'
   AND (ABS(IFNULL(Total,0) -IFNULL(AmountPaid,0)) >= 0.005 OR ABS(IFNULL(Total,0)) < 0.005) 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN InvoiceDate
   ELSE ShipDate
   END,CURRENT_TIMESTAMP) > 120
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN InvoiceDate
   ELSE ShipDate
   END,CURRENT_TIMESTAMP) <= 150;
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(IFNULL(Total,0) -IFNULL(AmountPaid,0))*IFNULL(CurrencyExchangeRate,1),v_CompanyCurrencyID)),0) INTO v_Over150 FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'RETURN'
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'CREDIT MEMO'
   AND (ABS(IFNULL(Total,0) -IFNULL(AmountPaid,0)) >= 0.005 OR ABS(IFNULL(Total,0)) < 0.005) 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN InvoiceDate
   ELSE ShipDate
   END,CURRENT_TIMESTAMP) > 150
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN InvoiceDate
   ELSE ShipDate
   END,CURRENT_TIMESTAMP) <= 180;
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(IFNULL(Total,0) -IFNULL(AmountPaid,0))*IFNULL(CurrencyExchangeRate,1),v_CompanyCurrencyID)),0) INTO v_Over180 FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'RETURN'
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'CREDIT MEMO'
   AND (ABS(IFNULL(Total,0) -IFNULL(AmountPaid,0)) >= 0.005 OR ABS(IFNULL(Total,0)) < 0.005) 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN InvoiceDate
   ELSE ShipDate
   END,CURRENT_TIMESTAMP) > 180;
   SET v_TotalAR = IFNULL(v_Under30,0)+IFNULL(v_Over30,0)+IFNULL(v_Over60,0)+IFNULL(v_Over90,0)+IFNULL(v_Over120,0)+IFNULL(v_Over150,0)+IFNULL(v_Over180,0);
	


   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_BookedOrders FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'RETURN'
   AND Posted = 1 
   AND IFNULL(Invoiced,0) = 0; 
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_SalesYTD FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'RETURN'
   AND Posted = 1 
   AND Invoiced = 1; 
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_RMAs FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_CustomerID
   AND UPPER(TransactionTypeID) = 'RMA'
   AND Posted = 1
   AND IFNULL(Received,0) = 0; 
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_RMA_YTD FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_CustomerID
   AND UPPER(TransactionTypeID) = 'RMA'
   AND Posted = 1
   AND Received = 1; 
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_InvoicesYTD FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1 
   AND ABS(IFNULL(Total,0) -IFNULL(AmountPaid,0)) < 0.005
   AND ABS(IFNULL(Total,0)) >= 0.005
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> UPPER('Return')
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> Upper('Credit Memo');
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_CreditMemosYTD FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1 
   AND ABS(IFNULL(Total,0) -IFNULL(AmountPaid,0)) < 0.005
   AND ABS(IFNULL(Total,0)) >= 0.005
   AND UPPER(IFNULL(TransactionTypeID,N'')) = Upper('Credit Memo');
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_CreditMemos FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1 
   AND (ABS(IFNULL(Total,0) -IFNULL(AmountPaid,0)) >= 0.005
   OR ABS(IFNULL(Total,0)) < 0.005)
   AND UPPER(IFNULL(TransactionTypeID,N'')) = Upper('Credit Memo');
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Amount,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_PaymentsYTD FROM
   ReceiptsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID
   AND Posted = 1 
   AND LOWER(IFNULL(ReceiptsHeader.ReceiptClassID,N'')) <> LOWER('Vendor'); 
   select   IFNULL(CreditLimit,0) INTO v_CreditLimit FROM
   CustomerInformation WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;

   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   AvailibleCredit = IFNULL(v_CreditLimit,0) -IFNULL(v_BookedOrders,0) -IFNULL(v_TotalAR,0),LateDays = v_LateDays,AverageDaytoPay = v_AverageDaytoPay,
   LastPaymentDate = v_LastPaymentDate,LastPaymentAmount = v_LastPaymentAmount,
   HighestCredit = IFNULL(HighestCredit,0),HighestBalance = IFNULL(HighestBalance,0),
   PromptPerc = IFNULL(v_PromptPerc,0),BookedOrders = IFNULL(v_BookedOrders,0),
   RMAs = IFNULL(v_RMAs,0),CreditMemos = IFNULL(v_CreditMemos,0),
   AdvertisingDollars = IFNULL(AdvertisingDollars,0),	

	SalesYTD = v_SalesYTD,
   PaymentsYTD = v_PaymentsYTD,InvoicesYTD = v_InvoicesYTD,RMAsYTD = v_RMA_YTD,
   CreditMemosYTD = v_CreditMemosYTD,

	SalesLifetime = v_SalesYTD+IFNULL(SalesLastYear,0),
   PaymentsLifetime = v_PaymentsYTD+IFNULL(PaymentsLastYear,0),
   InvoicesLifetime = v_InvoicesYTD+IFNULL(InvoicesLastYear,0),
   RMAsLifetime = v_RMA_YTD+IFNULL(RMAsLastYear,0),CreditMemosLifetime = v_CreditMemosYTD+IFNULL(CreditMemosLastYear,0),LastSalesDate = v_LastSalesDate,
   LastRMADate = v_LastRMADate,LastCreditMemoDate = v_LastCreditMemoDate,
   WriteOffsYTD = IFNULL(WriteOffsYTD,0),WriteOffsLastYear = IFNULL(WriteOffsLastYear,0),
   WriteOffsLifetime = IFNULL(WriteOffsLifetime,0),

   CurrentARBalance = IFNULL(v_Under30,0) -CreditMemos,Under30 = IFNULL(v_Under30,0),
   Over30 = IFNULL(v_Over30,0),Over60 = IFNULL(v_Over60,0),Over90 = IFNULL(v_Over90,0),
   Over120 = IFNULL(v_Over120,0),Over150 = IFNULL(v_Over150,0),
   Over180 = IFNULL(v_Over180,0),TotalAR = IFNULL(v_TotalAR,0) -CreditMemos
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;

   SET @SWV_Error = 0;
   IF @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Updating customer financials failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CustomerFinancials_ReCalc',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	
   IF @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Updating customer financials failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CustomerFinancials_ReCalc',v_ErrorMessage,
      v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;	

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'CustomerFinancials_ReCalc',v_ErrorMessage,
   v_ErrorID);
   SET SWP_Ret_Value = -1;
END