CREATE PROCEDURE spCompanyDailyActivityReceivings (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN







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