CREATE PROCEDURE RMA_Post2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




























   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GLTransNumber NATIONAL VARCHAR(36);
   DECLARE v_OrderWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_DetailWarehouseID NATIONAL VARCHAR(36);
   DECLARE v_WarehouseBinID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseDetailID CHAR(144);
   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_OrderQty FLOAT;

   DECLARE v_OrderNumber NATIONAL VARCHAR(36);

   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);

   DECLARE v_Total DECIMAL(19,4);


   DECLARE v_CustomerID NATIONAL VARCHAR(50);
   DECLARE v_CustomerCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_PurchaseCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_PurchaseCurrencyExchangeRate FLOAT;
   DECLARE v_PurchaseDate DATETIME;
   DECLARE v_PurchaseAmount DECIMAL(19,4);
   DECLARE v_HighestCredit DECIMAL(19,4);
   DECLARE v_AvailableCredit DECIMAL(19,4);

   DECLARE v_PurchasePosted BOOLEAN;
   DECLARE v_PurchasePaid BOOLEAN;
   DECLARE v_PurchaseShipped BOOLEAN;
   DECLARE v_PurchaseCancelDate DATETIME;
   DECLARE v_AmountPaid DECIMAL(19,4);

   DECLARE v_IsOverflow BOOLEAN;

   DECLARE v_TermsID NATIONAL VARCHAR(36);
   DECLARE v_NetDays INT;

   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cPurchaseDetail CURSOR FOR
   SELECT
   PurchaseNumber,
		ItemID, 
		WarehouseID, 
		WarehouseBinID,
		IFNULL(OrderQty,0),
		IFNULL(Total,0)
   FROM
   PurchaseDetail
   WHERE
   PurchaseNumber = v_PurchaseNumber AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT * FROM
   PurchaseDetail
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber) then

      SET v_PostingResult = 'RMA was not posted: there are no detail items';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT * FROM
   PurchaseDetail
   WHERE
		(IFNULL(OrderQty,0) = 0 OR IFNULL(ItemUnitPrice,0) = 0) AND
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber) then

      SET v_PostingResult = 'RMA was not posted: there is the RMA detail item with undefined Total value';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Posted,0), PurchaseCancelDate, IFNULL(Paid,0), IFNULL(AmountPaid,0), IFNULL(VendorInvoiceNumber,'') INTO v_PurchasePosted,v_PurchaseCancelDate,v_PurchasePaid,v_AmountPaid,v_OrderNumber FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   IF v_PurchasePosted <> 0 then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;



   IF ((NOT v_PurchaseCancelDate IS NULL) AND v_PurchaseCancelDate < CURRENT_TIMESTAMP) then

      SET v_PostingResult = 'RMA was not posted: Cancel date is older then current date.';
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;



   IF NOT EXISTS(SELECT
   InvoiceNumber
   FROM
   InvoiceHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_OrderNumber
   UNION
   SELECT
   InvoiceNumber
   FROM
   InvoiceHeaderHistory
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   InvoiceNumber = v_OrderNumber) then

      SET v_PostingResult = CONCAT('RMA was not posted: there is no Customer invoice number ',v_OrderNumber);
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;




   START TRANSACTION;
   SET @SWV_Error = 0;
   CALL RMA_Recalc(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);

   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Recalculating the RMA failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   CALL Inventory_GetWarehouseForPurchase2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_OrderWarehouseID, v_ReturnStatus);


   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Inventory_GetWarehouseForPurchase call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;	


   OPEN cPurchaseDetail;
   SET NO_DATA = 0;
   FETCH cPurchaseDetail INTO v_PurchaseDetailID,v_ItemID,v_DetailWarehouseID,v_WarehouseBinID,v_OrderQty, 
   v_Total;

   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL WarehouseBinPutGoods2(v_CompanyID,v_DivisionID,v_DepartmentID,v_DetailWarehouseID,v_WarehouseBinID,
      v_ItemID,NULL,NULL,NULL,NULL,v_OrderQty,1,v_IsOverflow, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
         CLOSE cPurchaseDetail;
		
         SET v_ErrorMessage = 'WarehouseBinPutGoods failed';
         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cPurchaseDetail INTO v_PurchaseDetailID,v_ItemID,v_DetailWarehouseID,v_WarehouseBinID,v_OrderQty, 
      v_Total;
   END WHILE;

   CLOSE cPurchaseDetail;






   select   VendorID, IFNULL(Total,0), CurrencyID, CurrencyExchangeRate, PurchaseDate INTO v_CustomerID,v_PurchaseAmount,v_PurchaseCurrencyID,v_PurchaseCurrencyExchangeRate,
   v_PurchaseDate FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,2,v_CompanyCurrencyID,
   v_PurchaseCurrencyID,v_PurchaseCurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;



   IF v_PurchaseCurrencyID <> v_CompanyCurrencyID then

      SET v_PurchaseAmount = v_PurchaseAmount*v_PurchaseCurrencyExchangeRate;
   end if;

   select   TermsID INTO v_TermsID FROM
   CustomerInformation WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;

   SET @SWV_Error = 0;
   CALL Terms_GetNetDays2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TermsID,v_NetDays);
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Terms_GetNetDays the order failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   UPDATE PurchaseHeader
   SET
   PurchaseHeader.TermsID = v_TermsID,PurchaseHeader.PurchaseDueDate = TIMESTAMPADD(Day,v_NetDays,PurchaseDate)
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Checking special terms failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;


   UPDATE
   PurchaseHeader
   SET
   Posted = 1,PostedDate = CURRENT_TIMESTAMP
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   SET @SWV_Error = 0;
   CALL Vendor_CreateFromCustomer2(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID, v_ReturnStatus);
   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Vendor_CreateFromCustomer call failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   UPDATE
   CustomerFinancials
   SET
   RMAs = IFNULL(RMAs,0)+v_PurchaseAmount,LastRMADate = v_PurchaseDate
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   CustomerID = v_CustomerID;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update CustomerFinancials failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      SET SWP_Ret_Value = -1;
   end if;	



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;









   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Post',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
   SET SWP_Ret_Value = -1;
END