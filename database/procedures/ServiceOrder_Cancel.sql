CREATE PROCEDURE ServiceOrder_Cancel (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN












   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_OrderLineNumber NUMERIC(9,0);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty FLOAT;
   DECLARE v_BackOrderQyyty FLOAT;
   DECLARE v_SerialNumber NATIONAL VARCHAR(50);

   DECLARE v_Posted BOOLEAN;
   DECLARE v_Picked BOOLEAN;
   DECLARE v_Shipped BOOLEAN;
   DECLARE v_Invoiced BOOLEAN;
   DECLARE v_OrderTypeID NATIONAL VARCHAR(36);

   DECLARE v_CustomerID NATIONAL VARCHAR(50);

   DECLARE v_DifferenceQty FLOAT;


   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_OrderDate DATETIME;
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_ConvertedTotal DECIMAL(19,4);
   DECLARE v_HighestCredit DECIMAL(19,4);
   DECLARE v_AvailibleCredit DECIMAL(19,4);
   DECLARE v_AmountPaid DECIMAL(19,4);


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   IFNULL(Posted,0), IFNULL(Picked,0), IFNULL(Shipped,0), IFNULL(Invoiced,0), IFNULL(AmountPaid,0), IFNULL(OrderTypeID,N'') INTO v_Posted,v_Picked,v_Shipped,v_Invoiced,v_AmountPaid,v_OrderTypeID FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;


   IF v_Posted = 0 OR v_Picked = 1 OR v_Shipped = 1 OR v_Invoiced = 1 OR v_AmountPaid > 0  OR LOWER(v_OrderTypeID) = 'quote' then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;




   select   CustomerID, Total, CurrencyID, CurrencyExchangeRate, OrderDate INTO v_CustomerID,v_Total,v_CurrencyID,v_CurrencyExchangeRate,v_OrderDate FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;

   START TRANSACTION;


   SET @SWV_Error = 0;
   CALL VerifyCurrency(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderDate,1,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Cancel',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);


      SET SWP_Ret_Value = -1;
   end if;

   SET v_ConvertedTotal = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Total*v_CurrencyExchangeRate, 
   v_CompanyCurrencyID);


   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   AvailibleCredit = IFNULL(AvailibleCredit,0)+v_ConvertedTotal,BookedOrders = IFNULL(BookedOrders,0) -v_ConvertedTotal,
   SalesYTD = IFNULL(SalesYTD,0) -v_ConvertedTotal
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'customer financials updating failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Cancel',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);


      SET SWP_Ret_Value = -1;
   end if;




   SET @SWV_Error = 0;
   UPDATE
   OrderHeader
   SET
   Posted = 0
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Order header updating failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Cancel',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);


      SET SWP_Ret_Value = -1;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_Cancel',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);


   SET SWP_Ret_Value = -1;
END