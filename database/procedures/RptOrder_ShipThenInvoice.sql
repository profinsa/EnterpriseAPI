CREATE PROCEDURE RptOrder_ShipThenInvoice (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber  NATIONAL VARCHAR(36),
	INOUT v_InvoiceNumber NATIONAL VARCHAR(36)  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN









   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Invoiced BOOLEAN;
   DECLARE v_Posted BOOLEAN;
   DECLARE v_OrderCancelDate DATETIME;
   DECLARE v_Shipped BOOLEAN;		
   DECLARE v_ShipDate DATETIME;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;



   select   Invoiced, Posted, OrderCancelDate, Shipped, ShipDate INTO v_Invoiced,v_Posted,v_OrderCancelDate,v_Shipped,v_ShipDate FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;

   IF v_Invoiced = 1 OR v_Posted IS NULL OR v_Posted = 0 OR v_OrderCancelDate IS NOT NULL OR
   v_Shipped IS NULL OR v_Shipped = 0 OR v_ShipDate IS NULL then


      SET v_InvoiceNumber = N'';
      SET v_ErrorMessage = 'Invoicing the order failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RptOrder_ShipThenInvoice',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   CALL Invoice_CreateFromOrder(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber,v_InvoiceNumber); 


   IF @SWV_Error <> 0 then

      SET v_InvoiceNumber = N'';
      SET v_ErrorMessage = 'Creating the invoice failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RptOrder_ShipThenInvoice',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;




   SET @SWV_Error = 0;
   UPDATE
   OrderHeader
   SET
   Invoiced = 1,InvoiceNumber = v_InvoiceNumber,InvoiceDate =(SELECT
   InvoiceDate
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber)
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Updating the order header failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RptOrder_ShipThenInvoice',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RptOrder_ShipThenInvoice',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

   SET SWP_Ret_Value = -1;
END