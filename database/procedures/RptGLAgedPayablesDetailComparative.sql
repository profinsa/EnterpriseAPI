CREATE PROCEDURE RptGLAgedPayablesDetailComparative (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN




   DECLARE v_AgePurchaseOrdersBy NATIONAL VARCHAR(1);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DROP TEMPORARY TABLE IF EXISTS tt_Result;
   CREATE TEMPORARY TABLE tt_Result
   (
      VendorID NATIONAL VARCHAR(36) NOT NULL,
      VendorName NATIONAL VARCHAR(80),
      Reference NATIONAL VARCHAR(36),
      Under30 DECIMAL(19,4),
      Over30 DECIMAL(19,4),
      Over60 DECIMAL(19,4),
      Over90 DECIMAL(19,4),
      Over120 DECIMAL(19,4),
      Over150 DECIMAL(19,4),
      Over180 DECIMAL(19,4)
   );


   select   IFNULL(AgePurchaseOrdersBy,N'1'), IFNULL(CurrencyID,N'') INTO v_AgePurchaseOrdersBy,v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   INSERT INTO tt_Result
   SELECT
   vnd.VendorID AS VendorID,
	vnd.VendorName AS VendorName,
	phd.PaymentID as Reference,
	IFNULL(SUM(IFNULL(phd.Amount,0)*IFNULL(phd.CurrencyExchangeRate,1)), 
   0) AS Under30,
	0 AS Over30,
	0 AS Over60,
	0 AS Over90,
	0 AS Over120,
	0 AS Over150,
	0 AS Over180
   FROM
   PaymentsHeader phd
   INNER JOIN VendorInformation vnd
   ON vnd.VendorID = phd.VendorID
   AND vnd.CompanyID = phd.CompanyID
   AND vnd.DivisionID = phd.DivisionID
   AND vnd.DepartmentID = phd.DepartmentID
   WHERE
   phd.CompanyID = v_CompanyID
   AND phd.DivisionID = v_DivisionID
   AND phd.DepartmentID = v_DepartmentID
   AND IFNULL(phd.Posted,0) = 1 AND IFNULL(phd.Paid,0) = 0 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN phd.PaymentDate
   ELSE phd.DueToDate
   END,CURRENT_TIMESTAMP) <= 30
   GROUP BY
   vnd.VendorID,vnd.VendorName,phd.PaymentID;


   INSERT INTO tt_Result
   SELECT
   vnd.VendorID AS VendorID,
	vnd.VendorName AS VendorName,
	phd.PaymentID as Reference,
	0 AS Under30,
	IFNULL(SUM(IFNULL(phd.Amount,0)*IFNULL(phd.CurrencyExchangeRate,1)), 
   0) AS Over30,
	0 AS Over60,
	0 AS Over90,
	0 AS Over120,
	0 AS Over150,
	0 AS Over180
   FROM
   PaymentsHeader phd
   INNER JOIN VendorInformation vnd
   ON vnd.VendorID = phd.VendorID
   AND vnd.CompanyID = phd.CompanyID
   AND vnd.DivisionID = phd.DivisionID
   AND vnd.DepartmentID = phd.DepartmentID
   WHERE
   phd.CompanyID = v_CompanyID
   AND phd.DivisionID = v_DivisionID
   AND phd.DepartmentID = v_DepartmentID
   AND IFNULL(phd.Posted,0) = 1 AND IFNULL(phd.Paid,0) = 0 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) > 30
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) <= 60
   GROUP BY
   vnd.VendorID,vnd.VendorName,phd.PaymentID;


   INSERT INTO tt_Result
   SELECT
   vnd.VendorID AS VendorID,
	vnd.VendorName AS VendorName,
	phd.PaymentID as Reference,
	0 AS Under30,
	0 AS Over30,
	IFNULL(SUM(IFNULL(phd.Amount,0)*IFNULL(phd.CurrencyExchangeRate,1)), 
   0) AS Over60,
	0 AS Over90,
	0 AS Over120,
	0 AS Over150,
	0 AS Over180
   FROM
   PaymentsHeader phd
   INNER JOIN VendorInformation vnd
   ON vnd.VendorID = phd.VendorID
   AND vnd.CompanyID = phd.CompanyID
   AND vnd.DivisionID = phd.DivisionID
   AND vnd.DepartmentID = phd.DepartmentID
   WHERE
   phd.CompanyID = v_CompanyID
   AND phd.DivisionID = v_DivisionID
   AND phd.DepartmentID = v_DepartmentID
   AND IFNULL(phd.Posted,0) = 1 AND IFNULL(phd.Paid,0) = 0 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) > 60
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) <= 90
   GROUP BY
   vnd.VendorID,vnd.VendorName,phd.PaymentID;


   INSERT INTO tt_Result
   SELECT
   vnd.VendorID AS VendorID,
	vnd.VendorName AS VendorName,
	phd.PaymentID as Reference,
	0 AS Under30,
	0 AS Over30,
	0 AS Over60,
	IFNULL(SUM(IFNULL(phd.Amount,0)*IFNULL(phd.CurrencyExchangeRate,1)), 
   0) AS Over90,
	0 AS Over120,
	0 AS Over150,
	0 AS Over180
   FROM
   PaymentsHeader phd
   INNER JOIN VendorInformation vnd
   ON vnd.VendorID = phd.VendorID
   AND vnd.CompanyID = phd.CompanyID
   AND vnd.DivisionID = phd.DivisionID
   AND vnd.DepartmentID = phd.DepartmentID
   WHERE
   phd.CompanyID = v_CompanyID
   AND phd.DivisionID = v_DivisionID
   AND phd.DepartmentID = v_DepartmentID
   AND IFNULL(phd.Posted,0) = 1 AND IFNULL(phd.Paid,0) = 0 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) > 90
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) <= 120
   GROUP BY
   vnd.VendorID,vnd.VendorName,phd.PaymentID;



   INSERT INTO tt_Result
   SELECT
   vnd.VendorID AS VendorID,
	vnd.VendorName AS VendorName,
	phd.PaymentID as Reference,
	0 AS Under30,
	0 AS Over30,
	0 AS Over60,
	0 AS Over90,
	IFNULL(SUM(IFNULL(phd.Amount,0)*IFNULL(phd.CurrencyExchangeRate,1)), 
   0) AS Over120,
	0 AS Over150,
	0 AS Over180
   FROM
   PaymentsHeader phd
   INNER JOIN VendorInformation vnd
   ON vnd.VendorID = phd.VendorID
   AND vnd.CompanyID = phd.CompanyID
   AND vnd.DivisionID = phd.DivisionID
   AND vnd.DepartmentID = phd.DepartmentID
   WHERE
   phd.CompanyID = v_CompanyID
   AND phd.DivisionID = v_DivisionID
   AND phd.DepartmentID = v_DepartmentID
   AND IFNULL(phd.Posted,0) = 1 AND IFNULL(phd.Paid,0) = 0 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) > 120
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) <= 150
   GROUP BY
   vnd.VendorID,vnd.VendorName,phd.PaymentID;



   INSERT INTO tt_Result
   SELECT
   vnd.VendorID AS VendorID,
	vnd.VendorName AS VendorName,
	phd.PaymentID as Reference,
	0 AS Under30,
	0 AS Over30,
	0 AS Over60,
	0 AS Over90,
	0 AS Over120,
	IFNULL(SUM(IFNULL(phd.Amount,0)*IFNULL(phd.CurrencyExchangeRate,1)), 
   0) AS Over150,
	0 AS Over180
   FROM
   PaymentsHeader phd
   INNER JOIN VendorInformation vnd
   ON vnd.VendorID = phd.VendorID
   AND vnd.CompanyID = phd.CompanyID
   AND vnd.DivisionID = phd.DivisionID
   AND vnd.DepartmentID = phd.DepartmentID
   WHERE
   phd.CompanyID = v_CompanyID
   AND phd.DivisionID = v_DivisionID
   AND phd.DepartmentID = v_DepartmentID
   AND IFNULL(phd.Posted,0) = 1 AND IFNULL(phd.Paid,0) = 0 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) > 150
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) <= 180
   GROUP BY
   vnd.VendorID,vnd.VendorName,phd.PaymentID;



   INSERT INTO tt_Result
   SELECT
   vnd.VendorID AS VendorID,
	vnd.VendorName AS VendorName,
	phd.PaymentID as Reference,
	0 AS Under30,
	0 AS Over30,
	0 AS Over60,
	0 AS Over90,
	0 AS Over120,
	0 AS Over150,
	IFNULL(SUM(IFNULL(phd.Amount,0)*IFNULL(phd.CurrencyExchangeRate,1)), 
   0) AS Over180
   FROM
   PaymentsHeader phd
   INNER JOIN VendorInformation vnd
   ON vnd.VendorID = phd.VendorID
   AND vnd.CompanyID = phd.CompanyID
   AND vnd.DivisionID = phd.DivisionID
   AND vnd.DepartmentID = phd.DepartmentID
   WHERE
   phd.CompanyID = v_CompanyID
   AND phd.DivisionID = v_DivisionID
   AND phd.DepartmentID = v_DepartmentID
   AND IFNULL(phd.Posted,0) = 1 AND IFNULL(phd.Paid,0) = 0 
   AND TIMESTAMPDIFF(DAY,CASE
   WHEN v_AgePurchaseOrdersBy = N'1' THEN PaymentDate
   ELSE DueToDate
   END,CURRENT_TIMESTAMP) > 180
   GROUP BY
   vnd.VendorID,vnd.VendorName,phd.PaymentID;




   SELECT
   VendorID,
	VendorName,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Under30),v_CompanyCurrencyID) as SIGNED INTEGER) AS Under30,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over30),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over30,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over60),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over60,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over90),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over90,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over120),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over120,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over150),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over150,
	cast(fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,SUM(Over180),v_CompanyCurrencyID) as SIGNED INTEGER) AS Over180
   FROM
   tt_Result
   GROUP BY
   VendorID,VendorName;




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
   VendorID,
	VendorName,
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
   VendorID,VendorName,Reference,Under30,Over30,Over60,Over90,Over120,Over150, 
   Over180;



   SET SWP_Ret_Value = 0;
END