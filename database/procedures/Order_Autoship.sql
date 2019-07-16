CREATE PROCEDURE Order_Autoship (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),
	v_TrackingNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN













   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_OrderTypeID NATIONAL VARCHAR(36);
   DECLARE v_Posted BOOLEAN;
   DECLARE v_Shipped BOOLEAN;
   DECLARE v_OrderCancelDate DATETIME;
   DECLARE v_CustomerID NATIONAL VARCHAR(36);
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_PaymentMethodID NATIONAL VARCHAR(36);
   DECLARE v_OrderAmount DECIMAL(19,4);

   DECLARE v_ShipToID NATIONAL VARCHAR(36);
   DECLARE v_ShipToName NATIONAL VARCHAR(50);
   DECLARE v_ShipToAddress1 NATIONAL VARCHAR(50);
   DECLARE v_ShipToAddress2 NATIONAL VARCHAR(50);
   DECLARE v_ShipToAddress3 NATIONAL VARCHAR(50);
   DECLARE v_ShipToCity NATIONAL VARCHAR(50);
   DECLARE v_ShipToState NATIONAL VARCHAR(50);
   DECLARE v_ShipToZip NATIONAL VARCHAR(50);
   DECLARE v_ShipToCountry NATIONAL VARCHAR(50);





   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   CustomerID, OrderTypeID, IFNULL(AmountPaid,0), PaymentMethodID, IFNULL(Posted,0), IFNULL(Shipped,0), OrderCancelDate, Total INTO v_CustomerID,v_OrderTypeID,v_AmountPaid,v_PaymentMethodID,v_Posted,v_Shipped,
   v_OrderCancelDate,v_OrderAmount FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;


   IF v_Posted <> 1 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF v_Shipped <> 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF LOWER(v_OrderTypeID) = LOWER('Quote') then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF v_OrderCancelDate IS NULL OR v_OrderCancelDate < CURRENT_TIMESTAMP then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;


   SET @SWV_Error = 0;
   UPDATE
   OrderHeader
   SET
   TrackingNumber = v_TrackingNumber,Shipped = 1,ShipDate = CURRENT_TIMESTAMP
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   OrderNumber = v_OrderNumber;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Order header updating failed';
      COMMIT;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Autoship',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderAutoship',v_OrderNumber);


      SET SWP_Ret_Value = -1;
   end if;


   select   IFNULL(ShipToID,''), IFNULL(ShippingName,''), IFNULL(ShippingAddress1,''), IFNULL(ShippingAddress2,''), IFNULL(ShippingAddress3,''), IFNULL(ShippingCity,''), IFNULL(ShippingState,''), IFNULL(ShippingZip,''), IFNULL(ShippingCountry,''), CustomerID INTO v_ShipToID,v_ShipToName,v_ShipToAddress1,v_ShipToAddress2,v_ShipToAddress3,
   v_ShipToCity,v_ShipToState,v_ShipToZip,v_ShipToCountry,v_CustomerID FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;

   IF (LOWER(v_ShipToID) = LOWER('SAME')) then


      SET @SWV_Error = 0;
      UPDATE OrderHeader, CustomerShipToLocations INNER JOIN CustomerInformation ON
      CustomerInformation.CompanyID = CustomerInformation.CompanyID AND
      CustomerInformation.DivisionID = CustomerInformation.DivisionID AND
      CustomerInformation.DepartmentID = CustomerInformation.DepartmentID AND
      CustomerInformation.CustomerID = CustomerInformation.CustomerID
      SET
      OrderHeader.ShipToID = CustomerInformation.ShipMethodID,OrderHeader.ShippingName = CustomerInformation.CustomerName,
      OrderHeader.ShippingAddress1 = CustomerInformation.CustomerAddress1,
      OrderHeader.ShippingAddress2 = CustomerInformation.CustomerAddress2,
      OrderHeader.ShippingAddress3 = CustomerInformation.CustomerAddress3,
      OrderHeader.ShippingCity = CustomerInformation.CustomerCity,
      OrderHeader.ShippingState = CustomerInformation.CustomerState,
      OrderHeader.ShippingZip = CustomerInformation.CustomerZip,
      OrderHeader.ShippingCountry = CustomerInformation.CustomerCountry
      WHERE
      OrderHeader.CompanyID = v_CompanyID AND
      OrderHeader.DivisionID = v_DivisionID AND
      OrderHeader.DepartmentID = v_DepartmentID AND
      OrderHeader.OrderNumber = v_OrderNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Update OrderHeader failed';
         COMMIT;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Autoship',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderAutoship',v_OrderNumber);


         SET SWP_Ret_Value = -1;
      end if;
   ELSE
      IF(LOWER(v_ShipToID) = LOWER('Drop Ship')) then
	
	
         IF (v_ShipToID = '' OR v_ShipToName = '' OR
			(v_ShipToAddress1 = '' AND v_ShipToAddress2 = '' AND v_ShipToAddress3 = '') OR
         v_ShipToCity = '' OR (v_ShipToState = '' AND v_ShipToCountry = '')) then
		
            ROLLBACK;
            SET SWP_Ret_Value = -1;
            LEAVE SWL_return;
         end if;
      ELSE
         SET @SWV_Error = 0;
         UPDATE CustomerShipToLocations INNER JOIN OrderHeader ON
         CustomerShipToLocations.CompanyID = OrderHeader.CompanyID AND
         CustomerShipToLocations.DivisionID = OrderHeader.DivisionID AND
         CustomerShipToLocations.DepartmentID = OrderHeader.DepartmentID AND
         CustomerShipToLocations.CustomerID = OrderHeader.CustomerID
         SET
         OrderHeader.ShipToID = CustomerShipToLocations.ShipToID,OrderHeader.ShippingName = CustomerShipToLocations.ShipToName,
         OrderHeader.ShippingAddress1 = CustomerShipToLocations.ShipToAddress1,OrderHeader.ShippingAddress2 = CustomerShipToLocations.ShipToAddress2,OrderHeader.ShippingAddress3 = CustomerShipToLocations.ShipToAddress3,OrderHeader.ShippingCity = CustomerShipToLocations.ShipToCity,
         OrderHeader.ShippingState = CustomerShipToLocations.ShipToState,
         OrderHeader.ShippingZip = CustomerShipToLocations.ShipToZip,
         OrderHeader.ShippingCountry = CustomerShipToLocations.ShipToZip
         WHERE
         OrderHeader.CompanyID = v_CompanyID AND
         OrderHeader.DivisionID = v_DivisionID AND
         OrderHeader.DepartmentID = v_DepartmentID AND
         OrderHeader.OrderNumber = v_OrderNumber;
         IF @SWV_Error <> 0 then
		
            SET v_ErrorMessage = 'Update OrderHeader failed';
            COMMIT;
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Autoship',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderAutoship',v_OrderNumber);


            SET SWP_Ret_Value = -1;
         end if;
      end if;
   end if;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   COMMIT;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_Autoship',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderAutoship',v_OrderNumber);


   SET SWP_Ret_Value = -1;
END