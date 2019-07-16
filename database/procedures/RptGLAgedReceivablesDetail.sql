CREATE PROCEDURE RptGLAgedReceivablesDetail (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN




   DECLARE v_AgeInvoicesBy NATIONAL VARCHAR(1);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DROP TEMPORARY TABLE IF EXISTS tt_Result;
   CREATE TEMPORARY TABLE tt_Result
   (
      CustomerID NATIONAL VARCHAR(50) NOT NULL,
      CustomerName NATIONAL VARCHAR(50),
      Reference NATIONAL VARCHAR(36),
      Under30 DECIMAL(19,4),
      Over30 DECIMAL(19,4),
      Over60 DECIMAL(19,4),
      Over90 DECIMAL(19,4),
      Over120 DECIMAL(19,4),
      Over150 DECIMAL(19,4),
      Over180 DECIMAL(19,4)
   );

   select   IFNULL(AgeInvoicesBy,N'1'), IFNULL(CurrencyID,N'') INTO v_AgeInvoicesBy,v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   INSERT INTO tt_Result
   SELECT
   cus.CustomerID AS CustomerID,
	cus.CustomerName AS CustomerName,
	ihd.InvoiceNumber as Reference,
	IFNULL(SUM((IFNULL(Total,0) -IFNULL(AmountPaid,0))*IFNULL(CurrencyExchangeRate,1)),0) AS Under30,
	0 AS Over30,
	0 AS Over60,
	0 AS Over90,
	0 AS Over120,
	0 AS Over150,
	0 AS Over180
   FROM	InvoiceHeader ihd
   INNER JOIN CustomerInformation cus
   ON cus.CustomerID = ihd.CustomerID
   AND cus.CompanyID = ihd.CompanyID
   AND cus.DivisionID = ihd.DivisionID
   AND cus.DepartmentID = ihd.DepartmentID
   WHERE
   ihd.CompanyID = v_CompanyID
   AND ihd.DivisionID = v_DivisionID
   AND ihd.DepartmentID = v_DepartmentID
   AND ihd.Posted = 1
   AND UPPER(IFNULL(ihd.TransactionTypeID,N'')) <> 'RETURN'
   AND (ABS(IFNULL(ihd.Total,0) -IFNULL(ihd.AmountPaid,0)) >= 0.005 OR ABS(IFNULL(ihd.Total,0)) < 0.005) 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN ihd.InvoiceDate
   ELSE ihd.ShipDate
   END,CURRENT_TIMESTAMP) <= 30
   GROUP BY
   cus.CustomerID,cus.CustomerName,ihd.InvoiceNumber;


   INSERT INTO tt_Result
   SELECT
   cus.CustomerID AS CustomerID,
	cus.CustomerName AS CustomerName,
	ihd.InvoiceNumber as Reference,
	0 AS Under30,
	IFNULL(SUM((IFNULL(Total,0) -IFNULL(AmountPaid,0))*IFNULL(CurrencyExchangeRate,1)),0) AS Over30,
	0 AS Over60,
	0 AS Over90,
	0 AS Over120,
	0 AS Over150,
	0 AS Over180
   FROM	InvoiceHeader ihd
   INNER JOIN CustomerInformation cus
   ON cus.CustomerID = ihd.CustomerID
   AND cus.CompanyID = ihd.CompanyID
   AND cus.DivisionID = ihd.DivisionID
   AND cus.DepartmentID = ihd.DepartmentID
   WHERE
   ihd.CompanyID = v_CompanyID
   AND ihd.DivisionID = v_DivisionID
   AND ihd.DepartmentID = v_DepartmentID
   AND ihd.Posted = 1
   AND UPPER(IFNULL(ihd.TransactionTypeID,N'')) <> 'RETURN'
   AND (ABS(IFNULL(ihd.Total,0) -IFNULL(ihd.AmountPaid,0)) >= 0.005 OR ABS(IFNULL(ihd.Total,0)) < 0.005) 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN ihd.InvoiceDate
   ELSE ihd.ShipDate
   END,CURRENT_TIMESTAMP) > 30
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN ihd.InvoiceDate
   ELSE ihd.ShipDate
   END,CURRENT_TIMESTAMP) <= 60
   GROUP BY
   cus.CustomerID,cus.CustomerName,ihd.InvoiceNumber;


   INSERT INTO tt_Result
   SELECT
   cus.CustomerID AS CustomerID,
	cus.CustomerName AS CustomerName,
	ihd.InvoiceNumber as Reference,
	0 AS Under30,
	0 AS Over30,
	IFNULL(SUM((IFNULL(Total,0) -IFNULL(AmountPaid,0))*IFNULL(CurrencyExchangeRate,1)),0) AS Over60,
	0 AS Over90,
	0 AS Over120,
	0 AS Over150,
	0 AS Over180
   FROM	InvoiceHeader ihd
   INNER JOIN CustomerInformation cus
   ON cus.CustomerID = ihd.CustomerID
   AND cus.CompanyID = ihd.CompanyID
   AND cus.DivisionID = ihd.DivisionID
   AND cus.DepartmentID = ihd.DepartmentID
   WHERE
   ihd.CompanyID = v_CompanyID
   AND ihd.DivisionID = v_DivisionID
   AND ihd.DepartmentID = v_DepartmentID
   AND ihd.Posted = 1
   AND UPPER(IFNULL(ihd.TransactionTypeID,N'')) <> 'RETURN'
   AND (ABS(IFNULL(ihd.Total,0) -IFNULL(ihd.AmountPaid,0)) >= 0.005 OR ABS(IFNULL(ihd.Total,0)) < 0.005) 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN ihd.InvoiceDate
   ELSE ihd.ShipDate
   END,CURRENT_TIMESTAMP) > 60
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN ihd.InvoiceDate
   ELSE ihd.ShipDate
   END,CURRENT_TIMESTAMP) <= 90
   GROUP BY
   cus.CustomerID,cus.CustomerName,ihd.InvoiceNumber;


   INSERT INTO tt_Result
   SELECT
   cus.CustomerID AS CustomerID,
	cus.CustomerName AS CustomerName,
	ihd.InvoiceNumber as Reference,
	0 AS Under30,
	0 AS Over30,
	0 AS Over60,
	IFNULL(SUM((IFNULL(Total,0) -IFNULL(AmountPaid,0))*IFNULL(CurrencyExchangeRate,1)),0) AS Over90,
	0 AS Over120,
	0 AS Over150,
	0 AS Over180
   FROM	InvoiceHeader ihd
   INNER JOIN CustomerInformation cus
   ON cus.CustomerID = ihd.CustomerID
   AND cus.CompanyID = ihd.CompanyID
   AND cus.DivisionID = ihd.DivisionID
   AND cus.DepartmentID = ihd.DepartmentID
   WHERE
   ihd.CompanyID = v_CompanyID
   AND ihd.DivisionID = v_DivisionID
   AND ihd.DepartmentID = v_DepartmentID
   AND ihd.Posted = 1
   AND UPPER(IFNULL(ihd.TransactionTypeID,N'')) <> 'RETURN'
   AND (ABS(IFNULL(ihd.Total,0) -IFNULL(ihd.AmountPaid,0)) >= 0.005 OR ABS(IFNULL(ihd.Total,0)) < 0.005) 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN ihd.InvoiceDate
   ELSE ihd.ShipDate
   END,CURRENT_TIMESTAMP) > 90
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN ihd.InvoiceDate
   ELSE ihd.ShipDate
   END,CURRENT_TIMESTAMP) <= 120
   GROUP BY
   cus.CustomerID,cus.CustomerName,ihd.InvoiceNumber;


   INSERT INTO tt_Result
   SELECT
   cus.CustomerID AS CustomerID,
	cus.CustomerName AS CustomerName,
	ihd.InvoiceNumber as Reference,
	0 AS Under30,
	0 AS Over30,
	0 AS Over60,
	0 AS Over90,
	IFNULL(SUM((IFNULL(Total,0) -IFNULL(AmountPaid,0))*IFNULL(CurrencyExchangeRate,1)),0) AS Over120,
	0 AS Over150,
	0 AS Over180
   FROM	InvoiceHeader ihd
   INNER JOIN CustomerInformation cus
   ON cus.CustomerID = ihd.CustomerID
   AND cus.CompanyID = ihd.CompanyID
   AND cus.DivisionID = ihd.DivisionID
   AND cus.DepartmentID = ihd.DepartmentID
   WHERE
   ihd.CompanyID = v_CompanyID
   AND ihd.DivisionID = v_DivisionID
   AND ihd.DepartmentID = v_DepartmentID
   AND ihd.Posted = 1
   AND UPPER(IFNULL(ihd.TransactionTypeID,N'')) <> 'RETURN'
   AND (ABS(IFNULL(ihd.Total,0) -IFNULL(ihd.AmountPaid,0)) >= 0.005 OR ABS(IFNULL(ihd.Total,0)) < 0.005) 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN ihd.InvoiceDate
   ELSE ihd.ShipDate
   END,CURRENT_TIMESTAMP) > 120
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN ihd.InvoiceDate
   ELSE ihd.ShipDate
   END,CURRENT_TIMESTAMP) <= 150
   GROUP BY
   cus.CustomerID,cus.CustomerName,ihd.InvoiceNumber;


   INSERT INTO tt_Result
   SELECT
   cus.CustomerID AS CustomerID,
	cus.CustomerName AS CustomerName,
	ihd.InvoiceNumber as Reference,
	0 AS Under30,
	0 AS Over30,
	0 AS Over60,
	0 AS Over90,
	0 AS Over120,
	IFNULL(SUM((IFNULL(Total,0) -IFNULL(AmountPaid,0))*IFNULL(CurrencyExchangeRate,1)),0) AS Over150,
	0 AS Over180
   FROM	InvoiceHeader ihd
   INNER JOIN CustomerInformation cus
   ON cus.CustomerID = ihd.CustomerID
   AND cus.CompanyID = ihd.CompanyID
   AND cus.DivisionID = ihd.DivisionID
   AND cus.DepartmentID = ihd.DepartmentID
   WHERE
   ihd.CompanyID = v_CompanyID
   AND ihd.DivisionID = v_DivisionID
   AND ihd.DepartmentID = v_DepartmentID
   AND ihd.Posted = 1
   AND UPPER(IFNULL(ihd.TransactionTypeID,N'')) <> 'RETURN'
   AND (ABS(IFNULL(ihd.Total,0) -IFNULL(ihd.AmountPaid,0)) >= 0.005 OR ABS(IFNULL(ihd.Total,0)) < 0.005) 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN ihd.InvoiceDate
   ELSE ihd.ShipDate
   END,CURRENT_TIMESTAMP) > 150
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN ihd.InvoiceDate
   ELSE ihd.ShipDate
   END,CURRENT_TIMESTAMP) <= 180
   GROUP BY
   cus.CustomerID,cus.CustomerName,ihd.InvoiceNumber;


   INSERT INTO tt_Result
   SELECT
   cus.CustomerID AS CustomerID,
	cus.CustomerName AS CustomerName,
	ihd.InvoiceNumber as Reference,
	0 AS Under30,
	0 AS Over30,
	0 AS Over60,
	0 AS Over90,
	0 AS Over120,
	0 AS Over150,
	IFNULL(SUM((IFNULL(Total,0) -IFNULL(AmountPaid,0))*IFNULL(CurrencyExchangeRate,1)),0) AS Over180
   FROM	InvoiceHeader ihd
   INNER JOIN CustomerInformation cus
   ON cus.CustomerID = ihd.CustomerID
   AND cus.CompanyID = ihd.CompanyID
   AND cus.DivisionID = ihd.DivisionID
   AND cus.DepartmentID = ihd.DepartmentID
   WHERE
   ihd.CompanyID = v_CompanyID
   AND ihd.DivisionID = v_DivisionID
   AND ihd.DepartmentID = v_DepartmentID
   AND ihd.Posted = 1
   AND UPPER(IFNULL(ihd.TransactionTypeID,N'')) <> 'RETURN'
   AND (ABS(IFNULL(ihd.Total,0) -IFNULL(ihd.AmountPaid,0)) >= 0.005 OR ABS(IFNULL(ihd.Total,0)) < 0.005) 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgeInvoicesBy = N'1' THEN ihd.InvoiceDate
   ELSE ihd.ShipDate
   END,CURRENT_TIMESTAMP) > 180
   GROUP BY
   cus.CustomerID,cus.CustomerName,ihd.InvoiceNumber;




   SELECT
   CustomerID,
	CustomerName,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Under30),v_CompanyCurrencyID) as SIGNED INTEGER)  AS Under30,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over30),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over30,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over60),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over60,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over90),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over90,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over120),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over120,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over150),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over150,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over180),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over180
   FROM
   tt_Result
   GROUP BY
   CustomerID,CustomerName;




   SELECT
   cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Under30),v_CompanyCurrencyID) as SIGNED INTEGER) AS Under30,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over30),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over30,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over60),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over60,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over90),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over90,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over120),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over120,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over150),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over150,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over180),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over180,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Under30+Over30+Over60+Over90+Over120+Over150+Over180),v_CompanyCurrencyID) as SIGNED INTEGER)  as Totals
   FROM
   tt_Result;





   SELECT
   CustomerID,
	CustomerName,
	Reference,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Under30,v_CompanyCurrencyID) as SIGNED INTEGER) as Under30,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Over30,v_CompanyCurrencyID) as SIGNED INTEGER) as Over30,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Over60,v_CompanyCurrencyID) as SIGNED INTEGER) as Over60,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Over90,v_CompanyCurrencyID) as SIGNED INTEGER) as Over90,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Over120,v_CompanyCurrencyID) as SIGNED INTEGER) as Over120,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Over150,v_CompanyCurrencyID) as SIGNED INTEGER) as Over150,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Over180,v_CompanyCurrencyID) as SIGNED INTEGER) as Over180
   FROM
   tt_Result
   GROUP BY
   CustomerID,CustomerName,Reference,Under30,Over30,Over60,Over90,Over120, 
   Over150,Over180;




   SET SWP_Ret_Value = 0;
END