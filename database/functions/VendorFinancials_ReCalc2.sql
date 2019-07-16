CREATE FUNCTION VendorFinancials_ReCalc2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_VendorID NATIONAL VARCHAR(36)) BEGIN





   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_CurrentYear SMALLINT;
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_LastPurchaseDate DATETIME;
   DECLARE v_LastDebitMemoDate DATETIME;
   DECLARE v_LastReturnDate DATETIME;
   DECLARE v_PaymentDate DATETIME;
   DECLARE v_DueDate DATETIME;
   DECLARE v_LateDays INT;
   DECLARE v_AverageDaytoPay INT;
   DECLARE v_LastPaymentDate DATETIME;
   DECLARE v_LastPaymentID NATIONAL VARCHAR(36);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_LastPaymentAmount DECIMAL(19,4);
   DECLARE v_PromptPerc FLOAT;
   DECLARE v_OnTimePaymentCount INT;
   DECLARE v_TotalPaymentCount INT;
   DECLARE v_AgePurchaseOrdersBy NATIONAL VARCHAR(1);
   DECLARE v_Under30 DECIMAL(19,4);
   DECLARE v_Over30 DECIMAL(19,4);
   DECLARE v_Over60 DECIMAL(19,4);
   DECLARE v_Over90 DECIMAL(19,4);
   DECLARE v_Over120 DECIMAL(19,4);
   DECLARE v_Over150 DECIMAL(19,4);
   DECLARE v_Over180 DECIMAL(19,4);
   DECLARE v_AgedPurchaseTotal DECIMAL(19,4);



   DECLARE v_PurchaseYTD DECIMAL(19,4);
   DECLARE v_BookedPurchaseAmount DECIMAL(19,4);
   DECLARE v_PaymentsYTD DECIMAL(19,4);
   DECLARE v_DebitMemoYTD DECIMAL(19,4);
   DECLARE v_DebitMemos DECIMAL(19,4);

   DECLARE v_ReturnsYTD DECIMAL(19,4);
   DECLARE v_VendorReturns DECIMAL(19,4);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF v_VendorID IS NULL then
      RETURN -1;
   end if;
   IF NOT EXISTS(SELECT VendorID
   FROM VendorInformation
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID) then
      RETURN -1;
   end if;
   IF NOT EXISTS(SELECT VendorID
   FROM VendorFinancials
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID) then

      INSERT INTO VendorFinancials(CompanyID,
		DivisionID,
		DepartmentID,
		VendorID)
	VALUES(v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_VendorID);
   end if;
   SET v_CurrentYear =(SELECT
   IFNULL(CurrentFiscalYear,YEAR(CURRENT_TIMESTAMP))
   FROM
   Companies
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID);
   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;

   select   MAX(IFNULL(PurchaseDate,CURRENT_TIMESTAMP)) INTO v_LastPurchaseDate FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'RMA'
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'DEBIT MEMO'
   AND Posted = 1; 

   select   MAX(IFNULL(PurchaseDate,CURRENT_TIMESTAMP)) INTO v_LastDebitMemoDate FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND UPPER(IFNULL(TransactionTypeID,N'')) = 'DEBIT MEMO'
   AND Posted = 1; 
   select   MAX(IFNULL(OrderDate,CURRENT_TIMESTAMP)) INTO v_LastReturnDate FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_VendorID
   AND UPPER(IFNULL(OrderHeader.TransactionTypeID,N'')) = 'RETURN'
   AND Posted = 1;

   select   MAX(TIMESTAMPDIFF(Day,IFNULL(DueToDate,PaymentDate),PaymentDate)) INTO v_LateDays FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   And Posted = 1
   And Paid = 1;
   IF IFNULL(v_LateDays,0) < 0 then

      SET v_LateDays = 0;
   end if;

   select   ROUND(AVG(TIMESTAMPDIFF(DAY,IFNULL(PurchaseDate,PaymentDate),PaymentDate)),
   0) INTO v_AverageDaytoPay FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   And Posted = 1
   And Paid = 1
   AND TIMESTAMPDIFF(DAY,IFNULL(PurchaseDate,PaymentDate),PaymentDate) >= 0 
   AND IFNULL(PurchaseDate,'01/01/1980') > '01/01/1980';	  	
   IF IFNULL(v_AverageDaytoPay,0) < 0 then
      SET v_AverageDaytoPay = 0;
   end if;
   SET v_AverageDaytoPay = IFNULL(v_AverageDaytoPay,-1);

   select   IFNULL(PaymentDate,SystemDate), PaymentID INTO v_LastPaymentDate,v_LastPaymentID FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   And Posted = 1
   And Paid = 1   ORDER BY PaymentDate DESC,PaymentID LIMIT 1;

   select   Amount, IFNULL(CurrencyExchangeRate,1) INTO v_Amount,v_CurrencyExchangeRate FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PaymentID = v_LastPaymentID;
   SET v_LastPaymentAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(v_Amount,0)*IFNULL(v_CurrencyExchangeRate,1), 
   v_CompanyCurrencyID);

   select   IFNULL(Count(PaymentID),0) INTO v_OnTimePaymentCount FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND TIMESTAMPDIFF(Day,PaymentDate,IFNULL(DueToDate,PaymentDate)) >= 0
   And Posted = 1 
   And Paid = 1;
   select   IFNULL(Count(PaymentID),0) INTO v_TotalPaymentCount FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   And Posted = 1
   And Paid = 1;
   IF IFNULL(v_TotalPaymentCount,0) > 0 then
      SET v_PromptPerc = cast(IFNULL(v_OnTimePaymentCount,0) as DECIMAL(15,15))/IFNULL(v_TotalPaymentCount,0);
   end if;

   select   IFNULL(AgePurchaseOrdersBy,N'1') INTO v_AgePurchaseOrdersBy FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Amount,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_Under30 FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND IFNULL(Posted,0) = 1 AND IFNULL(Paid,0) = 0 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) <= 30
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) > 0;


   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Amount,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_Over30 FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND IFNULL(Posted,0) = 1 AND IFNULL(Paid,0) = 0 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) > 30
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) <= 60;


   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Amount,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_Over60 FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND IFNULL(Posted,0) = 1 AND IFNULL(Paid,0) = 0 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) > 60
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) <= 90;


   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Amount,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_Over90 FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND IFNULL(Posted,0) = 1 AND IFNULL(Paid,0) = 0 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) > 90
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) <= 120;


   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Amount,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_Over120 FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND IFNULL(Posted,0) = 1 AND IFNULL(Paid,0) = 0 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) > 120
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) <= 150;


   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Amount,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_Over150 FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND IFNULL(Posted,0) = 1 AND IFNULL(Paid,0) = 0 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) > 150
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) <= 180;


   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Amount,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_Over180 FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND IFNULL(Posted,0) = 1 AND IFNULL(Paid,0) = 0 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) > 180;



   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_BookedPurchaseAmount FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'RMA'
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'DEBIT MEMO'
   AND Posted = 1
   AND IFNULL(Received,0) = 0; 
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_DebitMemos FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND UPPER(IFNULL(TransactionTypeID,N'')) = 'DEBIT MEMO'
   AND Posted = 1
   AND (ABS(IFNULL(Total,0)) < 0.005
   OR ABS(IFNULL(Total,0) -IFNULL(AmountPaid,0)) >= 0.005);
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_DebitMemoYTD FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND UPPER(IFNULL(TransactionTypeID,N'')) = 'DEBIT MEMO'
   AND Posted = 1
   AND (ABS(IFNULL(Total,0)) >= 0.005
   AND ABS(IFNULL(Total,0) -IFNULL(AmountPaid,0)) < 0.005);
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_PurchaseYTD FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'RMA'
   AND UPPER(IFNULL(TransactionTypeID,N'')) <> 'DEBIT MEMO'
   AND Posted = 1
   AND Received = 1; 
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_VendorReturns FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_VendorID
   AND UPPER(IFNULL(TransactionTypeID,N'')) = 'RETURN'
   AND Posted = 1 
   AND Invoiced = 0; 
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Total,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_ReturnsYTD FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_VendorID
   AND UPPER(IFNULL(TransactionTypeID,N'')) = 'RETURN'
   AND Posted = 1 
   AND Invoiced = 1; 
   select   IFNULL(SUM(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,IFNULL(Amount,0)*IFNULL(CurrencyExchangeRate,1), 
   v_CompanyCurrencyID)),0) INTO v_PaymentsYTD FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID
   AND Posted = 1
   AND Paid = 1; 



   SET @SWV_Error = 0;
   UPDATE
   VendorFinancials
   SET
   LateDays = v_LateDays,AverageDaytoPay = v_AverageDaytoPay,LastPaymentDate = v_LastPaymentDate,
   LastPaymentAmount = IFNULL(v_LastPaymentAmount,0),BookedPurchaseOrders = IFNULL(v_BookedPurchaseAmount,0),
   DebitMemos = IFNULL(v_DebitMemos,0),
   VendorReturns = IFNULL(v_VendorReturns,0),PromptPerc = IFNULL(v_PromptPerc,0),
   HighestCredit = IFNULL(HighestCredit,0),HighestBalance = IFNULL(HighestBalance,0),
   AvailableCredit = IFNULL(AvailableCredit,0),
   AdvertisingDollars = IFNULL(AdvertisingDollars,0),

	PaymentsYTD = IFNULL(v_PaymentsYTD,0),
   PurchaseYTD = IFNULL(v_PurchaseYTD,0),DebitMemosYTD = IFNULL(v_DebitMemoYTD,0),
   ReturnsYTD = IFNULL(v_ReturnsYTD,0),

	PaymentsLifetime = IFNULL(v_PaymentsYTD,0)+IFNULL(PaymentsLastYear,0),PurchaseLifetime = IFNULL(v_PurchaseYTD,0)+IFNULL(PurchaseLastYear,0),DebitMemosLifetime = IFNULL(v_DebitMemoYTD,0)+IFNULL(DebitMemosLastYear,0),ReturnsLifetime = IFNULL(v_ReturnsYTD,0)+IFNULL(ReturnsLastYear,0),
   LastReturnDate = v_LastReturnDate,
   LastPurchaseDate = v_LastPurchaseDate,LastDebitMemoDate = v_LastDebitMemoDate,

   CurrentAPBalance = IFNULL(v_Under30,0),TotalAP = IFNULL(v_Under30,0)+IFNULL(v_Over30,0)+IFNULL(v_Over60,0)+IFNULL(v_Over90,0)+IFNULL(v_Over120,0)+IFNULL(v_Over150,0)+IFNULL(v_Over180,0) -IFNULL(v_DebitMemos,0),
   Under30 = IFNULL(v_Under30,0),Over30 = IFNULL(v_Over30,0),
   Over60 = IFNULL(v_Over60,0),Over90 = IFNULL(v_Over90,0),Over120 = IFNULL(v_Over120,0),
   Over150 = IFNULL(v_Over150,0),Over180 = IFNULL(v_Over180,0)
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND VendorID = v_VendorID;
   IF @SWV_Error <> 0 then
	
      SET v_ErrorMessage = 'Updating vendor financials failed';
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'VendorFinancials_ReCalc',v_ErrorMessage,
      v_ErrorID);
      RETURN -1;
   end if;	
   RETURN 0;






   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'VendorFinancials_ReCalc',v_ErrorMessage,
   v_ErrorID);
   RETURN -1;
END