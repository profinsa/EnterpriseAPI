CREATE PROCEDURE RptLedgerYearlyCashForcast (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36)) BEGIN




















   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID   LIMIT 1;


   SELECT
   PurchaseNumber,
	TransactionTypeID,
	PurchaseDate,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Total,v_CompanyCurrencyID) as Total,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,BalanceDue,v_CompanyCurrencyID) as BalanceDue,
	TIMESTAMPADD(DAY,(EXTRACT(YEAR FROM PurchaseDueDate) -1)*-1,PurchaseDueDate) AS DueDate
   FROM
   PurchaseHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   Posted = 1 
		
   UNION


   SELECT
   OrderNumber,
	TransactionTypeID,
	OrderDate,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,Total,v_CompanyCurrencyID) as Total,
	fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,BalanceDue,v_CompanyCurrencyID) as BalanceDue,
	TIMESTAMPADD(DAY,(EXTRACT(YEAR FROM OrderDueDate) -1)*-1,OrderDueDate) AS DueDate
   FROM
   OrderHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   Posted = 1 

   ORDER BY  6;
END