-- simple wrapper around Error_InsertErrorDetail2 to omit optional parameters(mysql does not support optional parameters)

DELIMITER ;;
DROP PROCEDURE IF EXISTS Error_InsertErrorDetail;
-- //
CREATE       PROCEDURE Error_InsertErrorDetail(v_CompanyID NATIONAL VARCHAR(36),
 	v_DivisionID NATIONAL VARCHAR(36),
 	v_DepartmentID NATIONAL VARCHAR(36),
	v_ErrorID INT,
	v_ParameterName NATIONAL VARCHAR(50),
	v_ParameterValue NATIONAL VARCHAR(50))
BEGIN
	SET @ret = Error_InsertErrorDetail2(v_CompanyID, v_DivisionID, v_DepartmentID, v_ErrorID, v_ParameterName, v_ParameterValue, 0);
		
END;;

-- Stored procedure definition script Error_InsertErrorDetail2 for MySQL
-- Generated by (c) Ispirer SQLWays 4.0 Build 219 Licensed to STFB
-- Timestamp: Tue Jul 28 16:20:00 2015

DELIMITER //
DROP FUNCTION IF EXISTS Error_InsertErrorDetail2;
//
/* The procedure was converted to function because it contains the RETURN statement with expression*/
CREATE FUNCTION Error_InsertErrorDetail2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_ErrorID INT,
	v_ParameterName NATIONAL VARCHAR(50),
	v_ParameterValue NATIONAL VARCHAR(50),
	v_IsRaise BOOLEAN)
RETURNS INT
BEGIN





/*
Name of stored procedure: Error_InsertErrorDetail
Method: 
	Inserts an error detail information into the error detail table

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@ErrorID INT			 - the ID of error in the ErrorLog table
	@ParameterName NVARCHAR(50)	 - the name of the parameter that identify the transaction in which the error occur
	@ParameterValue NVARCHAR(50)	 - the value of the parameter that identify the transaction in which the error occur
	@IsRaise BIT 			 - if @IsRaise = 1, the procedure dosn't insert record into the error table, 

							   but raise the sete of exceptions that should be processed by exteral program.

							   external programm should catch all errors and when all rollbacks related with

							   current transaction will be done, will write catched errors calling this procedure

							   with @IsRaise = 0. Such approach is used to avoid rollback of error recording 

							   when this procedure is called inside nested transactions

							   If @IsRaise = 0, procedure writes error descriptrion to the error table

Output Parameters:

	NONE

Called From:

	WarehouseBinShipGoods, ServiceOrder_FulfillServiceRequesAll, ReturnReceipt_AdjustVendorFinancials, Bank_PostWithdrawal, ServiceInvoice_CreateFromOrder, Payroll_ItemsRecur, Payroll_FUTA, LedgerTransactions_PostPayment, RMA_CreateFromMemorized, LedgerTransactions_Recur, Contract_CreateFromOrder, Receipt_CopyToHistory, DebitMemo_CopyToHistory, Purchase_Cancel, Invoice_CustomerFinancialsUpdateAging, VendorFinancials_UpdateAging, ServiceInvoice_Post, Return_CreditVendorOrderDiscountItem, ServiceInvoice_CreateFromMemorized, Order_MakeInvoiceReceipt, Payroll_ItemBegBalAppend, Invoice_Recalc, RMA_CopyAllToHistory, ServiceInvoice_CopyAllToHistory, DebitMemo_CreateGLTransaction, ServiceOrder_CreateFromMemorized, Payment_AdjustVendorFinancials, Payroll_Gross_Create_Details, Customer_CreateFromLead, Payment_Approve, Payment_CreateFromPurchase, ReturnInvoice_CopyAllClosedToHistory, Payment_PrintCheck, Receipt_Cash, ServiceOrder_Recalc, RMAReceiving_AdjustCustomerFinancials, CreditMemo_CreateFromInvoice, Invoice_CreateFromMemorized, Purchase_Post, Receiving_Post, ReturnInvoice_Recalc, ServiceOrder_Cancel, Invoice_CreditMemoPost, Return_CreateAllFromMemorized, ServiceOrder_ServicePerformed, Payment_Recur, Contract_Recalc, Invoice_Post, Return_Allocate, Order_Split, Inventory_Costing, Purchase_CopyToHistory, Return_Cancel, Order_Cancel, ReturnInvoice_CreateFromMemorized, CreditMemo_CreatePayment, Invoice_CreateFromServiceOrder, Invoice_CopyAllToHistory, Payroll_Emp_Duplicate, Payment_ApproveAll, Inventory_RecalcFIFOCost, ReceiptCash_CreateGLTransaction, Payroll_GROSS, Payroll_Basis_GROSS, Receiving_CreateGLTransaction, Project_ReCalc, WarehouseBinPutGoods, Invoice_UndoAdjustCustomerFinancials, Invoice_Control, Receiving_AdjustInventory, Payment_Recalc, Order_CopyToHistory, Receiving_UpdateInventoryCosting, Return_CopyToHistory, Payment_CreateFromRMA, Vendor_CreateFromCustomer, Purchase_Recur, ServiceOrder_FulfillServiceRequest, PaymentCheck_PrintDelete, Return_PickAll, DebitMemo_CreateFromPurchase, Order_Picked, LedgerTransactions_CreateFromMemorized, Purchase_Recalc, ReturnInvoice_AdjustVendorFinancials, CreditMemo_CreateFromMemorized, ReturnInvoice_AdjustInventory, OrderDetail_SplitToWarehouseBin, ReturnInvoice_CreateGLTransaction, ReturnDetail_SplitToWarehouseBin, Receipt_CreateGLTransaction, Order_PickAll, Return_Split, Payroll_Net_Create_Details, CreditMemo_CopyToHistory, Payroll_CalcPayDate, ServiceInvoice_CopyAllClosedToHistory, Order_CreditCustomerOrderDiscountItem, Purchase_Control, RMA_CopyToHistory, CustomerFinancials_UpdateAging, InventoryAdjustments_CreateGLTransaction, Order_ShipThenInvoice, Receipt_Post, RMA_Cancel, LedgerMain_PostCOA, ServiceInvoice_Cancel, DebitMemo_Post, Invoice_UndoCustomerFinancialsUpdateAging, LedgerChartsOfAccount_UpdateAccountBalancesBudget, Inventory_RecalcItemCost, LedgerTransactions_CopyAllToHistory, Payment_CopyAllToHistory, Order_CreditCustomerAccount, Inventory_RecalcLIFOCost, ServiceReceipt_CreateFromInvoice, LedgerTransactions_PostManual, ReturnInvoice_VendorFinancialsUpdateAging, Invoice_CreateFromOrder, ServiceOrder_Post, Payment_CreateFromMemorized, SerialNumber_Cancel, LedgerTransactions_Reverse, ServiceReceipt_Recalc, PaymentCheck_CreateGLTransaction, Receipt_CreateFromInvoice, Return_Recalc, ServiceReceipt_CreateGLTransaction, LedgerMain_VerifyPeriod, Inventory_Assemblies, Payroll_Net_Calc, SerialNumber_Get, Receipt_Recalc, Inventory_Transfer, Order_CopyAllToHistory, GetNextEntityID, Receipt_AdjustCustomerFinancials, RMA_Recur, Order_Shipped, PaymentCheck_Run, ReturnInvoice_CreateFromReturn, ReturnReceipt_Recalc, Return_CreateFromMemorized, Payment_CreateGLTransaction, Order_Post, Return_CreditVendorOrder, PaymentCheck_PrintInsert, CreditMemo_CreateFromReturnInvoice, LedgerTransactions_CopyToHistory, ReceiptCash_Return_CreateGLTransaction, Payment_CreateCreditMemo, Payroll_Agi_Create_Details, LedgerTransactions_PostCOA_AllRecords, ReturnInvoice_CopyAllToHistory, Invoice_CreateGLTransaction, RMA_Post, ServiceInvoice_Recalc, RMA_Recalc, RMAReceiving_CreateGLTransaction, Inventory_RecalcAverageCost, Payroll_AppendEmployeesID, RMA_CreateFromInvoice, Payment_CopyToHistory, ServiceOrder_FulfillServiceRequestAll, Payroll_CALC, Order_Billed, Order_CreateFromMemorized, Contract_CreateFromServiceOrder, PaymentCheck_Post, Order_InvoiceThenShip, ServiceInvoice_CreateGLTransaction, Order_Printed, Order_Allocate, Error_InsertErrorDetail.vb, Return_Picked, Purchase_DebitMemoPost, InventoryAdjustments_Cancel, RMA_Split, Receiving_AdjustVendorFinancials, Invoice_CreditMemoCreateGLTransaction, Order_CreateFromQuote, ServiceOrder_ServicePerformedAll, LedgerTransactions_PostCOA, Return_CreditVendorAccount, CreditMemo_Post, RMAReceiving_Post, Bank_CreateGLTransaction, ReturnInvoice_CopyToHistory, Purchase_CopyAllToHistory, SerialNumber_Put, Order_ShipAll, ServiceOrder_CopyToHistory, Order_UpdateCosting, Payment_Post, ReturnInvoice_Post, Inventory_CreateILTransaction, CreditMemo_CopyAllToHistory, PaymentCheck_PostAllChecks, ServiceOrder_CopyAllToHistory, Order_Recalc, ReturnInvoice_Cancel, Purchase_CreateFromMemorized, BankReconciliation_Prepare, PaymentCheck_Printed, Invoice_Cancel, Invoice_AdjustCustomerFinancials, Order_CreditCustomerOrder, Bank_PostTransfer, Payroll_Gross_Calc, Invoice_AdjustInventory, Return_CopyAllToHistory, DebitMemo_ApplyToPayment, Order_CreateAssembly, Invoice_CreateFromReturn, Payroll_FICA, BankTransaction_Control, ServiceReceipt_Post, Bank_PostDeposit, WarehouseBinLockGoods, Invoice_UndoAdjustInventory, DebitMemo_Recalc, Receipt_CreateFromOrder, Return_MakeInvoiceReceipt, Return_Post, Contract_CreditCustomerContract, Payroll_ItemBegBalUnmatched, DebitMemo_Cancel, Invoice_CopyToHistory, ReturnReceipt_CreateFromInvoice, DebitMemo_CreateFromMemorized, InventoryAdjustments_Post, CreateObjectCopy, DebitMemo_CopyAllToHistory, ServiceOrder_Close, Payroll_FIT, Purchase_Split, Customer_CreateFromVendor, ServiceOrder_MakeInvoiceReceipt, Receipt_CreateFromMemorized, CreditMemo_CreateGLTransaction, ReturnReceipt_CreateGLTransaction, CreditMemo_CreateFromRMA, ReturnReceipt_Cash, Payroll_BegBalYTDUpdate, ReturnReceipt_Post, Return_Shipped, Return_ShipAll, Purchase_GetAPInvoiceDiscount, Receipt_CopyAllToHistory, ReturnInvoice_CreateAllFromMemorized, ServiceInvoice_CopyToHistory, CreditMemo_Recalc, ServiceOrder_Split, Payroll_Agi_Calc, Order_Autoship

Calls:

	NONE

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   IF v_IsRaise is null then
      set v_IsRaise = 1;
   END IF;
   SET @SWV_Error = 0;
   IF v_IsRaise = 1 then
	
      -- Not supported RAISERROR (@ParameterName, 16, 21);
-- Not supported RAISERROR (@ParameterValue, 16, 22);
SET @SWV_Null_Var = 0;
   ELSE
		-- Insert the error detail data into the error detail table
      SET @SWV_Error = 0;
      INSERT INTO ErrorLogDetail(CompanyID,
			DivisionID,
			DepartmentID,
			ErrorID,
			ParameterName,
			ParameterValue)
		VALUES(v_CompanyID,
			v_DivisionID,
			v_DepartmentID,
			v_ErrorID,
			v_ParameterName,
			v_ParameterValue);
		
		-- If an error occurs return -1
		
      IF @SWV_Error <> 0 then
		
         RETURN -1;
      end if;
   end if;

-- Everything is OK
   RETURN 0;
END;














//

DELIMITER ;
