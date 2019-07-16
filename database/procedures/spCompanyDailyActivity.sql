CREATE PROCEDURE spCompanyDailyActivity (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN







   SELECT count(OrderNumber) as Quotes,
	sum(IFNULL(Total,0)) as QuoteTotals
   FROM OrderHeader
   WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID and
   IFNULL(Invoiced,0) = 0  and
   TransactionTypeID = N'Quote' and
   DAYOFYEAR(OrderDate) = DAYOFYEAR(CURRENT_TIMESTAMP);

   SELECT count(OrderNumber) as Orders,
	sum(IFNULL(Total,0)) as OrderTotals
   FROM OrderHeader
   WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID and
   IFNULL(Invoiced,0) = 0 and
   TransactionTypeID = N'Order' and
   DAYOFYEAR(OrderDate) = DAYOFYEAR(CURRENT_TIMESTAMP);

   SELECT count(OrderNumber) as Shipments,
	sum(IFNULL(Total,0)) as ShipTotals
   FROM OrderHeader
   WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID and
   DAYOFYEAR(OrderShipDate) = DAYOFYEAR(CURRENT_TIMESTAMP);

   SELECT count(PurchaseNumber) as Purchases,
	sum(IFNULL(Total,0)) as PurchaseTotals
   FROM PurchaseHeader
   WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID and
   IFNULL(Received,0) = 0 and
   DAYOFYEAR(PurchaseDate) = DAYOFYEAR(CURRENT_TIMESTAMP);

   SELECT count(PurchaseNumber) as Receivings,
	sum(IFNULL(Total,0)) as ReceiptTotals
   FROM PurchaseHeader
   WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID and
   IFNULL(Received,0) = 0 and
   DAYOFYEAR(PurchaseDueDate) = DAYOFYEAR(CURRENT_TIMESTAMP);

   SET SWP_Ret_Value = 0;
END