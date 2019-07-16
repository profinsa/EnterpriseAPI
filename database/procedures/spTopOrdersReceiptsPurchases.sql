CREATE PROCEDURE spTopOrdersReceiptsPurchases (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) BEGIN









   SELECT 
   PurchaseNumber,
	  PurchaseDueDate,
	  VendorID,
	  (IFNULL(Total,0)) as ReceiptTotal
   FROM PurchaseHeader
   WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID and
   lower(PurchaseNumber) <> 'default' and
   Total <> 0 and
   PurchaseDueDate <= CURRENT_TIMESTAMP
   ORDER BY ReceiptTotal DESC LIMIT 5;

   SET SWP_Ret_Value = 0;
END