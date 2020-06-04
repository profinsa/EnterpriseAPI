DELIMITER //
DROP PROCEDURE IF EXISTS spTopOrdersReceipts;
//
CREATE PROCEDURE spTopOrdersReceipts(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
BEGIN







/*
Name of stored procedure: spTopOrdersReceipts
Method: 
	

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department

Output Parameters:

	NONE

Called From:

	NONE

Calls:

	NONE

Last Modified: 

Last Modified By: 

Revision History: 

*/

   SELECT 
   OrderNumber,
	  OrderShipDate,
	  CustomerID,
	  (IFNULL(Total,0)) as OrderTotal
   FROM OrderHeader
   WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID and
   lower(OrderNumber) <> 'default' and
   Total <> 0 and
   OrderDate <= CURRENT_TIMESTAMP AND
   (LOWER(IFNULL(OrderHeader.TransactionTypeID, N'')) NOT IN ('return', 'service order', 'quote')) AND
   (LOWER(IFNULL(OrderHeader.OrderTypeID, N'')) <> 'hold')AND
   (IFNULL(Posted, 0) = 1)
   ORDER BY OrderTotal DESC LIMIT 5;

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
END;





//

DELIMITER ;
