CREATE PROCEDURE ServiceOrder_CopyToHistory2 (v_CompanyID 	NATIONAL VARCHAR(36),
	v_DivisionID 	NATIONAL VARCHAR(36),
	v_DepartmentID	NATIONAL VARCHAR(36),
	v_OrderNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN
















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_Memorize BOOLEAN;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_Memorize = NULL;
   select   IFNULL(Memorize,0) INTO v_Memorize FROM
   OrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber
   AND IFNULL(Invoiced,0) = 1
   AND LOWER(IFNULL(TransactionTypeID,N'')) = LOWER('Service Order');
   IF ROW_COUNT() = 0 then

      SET SWP_Ret_Value = -2;
      LEAVE SWL_return;
   end if;



   START TRANSACTION;

   IF NOT EXISTS(SELECT OrderNumber
   FROM OrderHeaderHistory
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber) then

	
	
      SET @SWV_Error = 0;
      INSERT INTO
      OrderHeaderHistory
      SELECT * FROM
      OrderHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND OrderNumber = v_OrderNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Cannot create OrderHeaderHistory record';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET SWP_Ret_Value = -1;
      end if;
	
	
	
      SET @SWV_Error = 0;
      INSERT INTO
      OrderDetailHistory(CompanyID,
		DivisionID,
		DepartmentID,
		OrderNumber,
		
		ItemID,
		WarehouseID,
		WarehouseBinID,
		SerialNumber,
		Description,
		OrderQty,
		BackOrdered,
		BackOrderQyyty,
		ItemUOM,
		ItemWeight,
		DiscountPerc,
		Taxable,
		CurrencyID,
		CurrencyExchangeRate,
		ItemCost,
		ItemUnitPrice,
		Total,
		TotalWeight,
		GLSalesAccount,
		ProjectID,
		TrackingNumber,
		WarehouseBinZone,
		PalletLevel,
		CartonLevel,
		PackLevelA,
		PackLevelB,
		PackLevelC,
		ScheduledStartDate,
		ScheduledEndDate,
		ServiceStartDate,
		ServiceEndDate,
		PerformedBy,
		DetailMemo1,
		DetailMemo2,
		DetailMemo3,
		DetailMemo4,
		DetailMemo5,
		TaxGroupID,
		TaxAmount,
		TaxPercent,
		SubTotal)
      SELECT
      CompanyID,
		DivisionID,
		DepartmentID,
		OrderNumber,
		
		ItemID,
		WarehouseID,
		WarehouseBinID,
		SerialNumber,
		Description,
		OrderQty,
		BackOrdered,
		BackOrderQyyty,
		ItemUOM,
		ItemWeight,
		DiscountPerc,
		Taxable,
		CurrencyID,
		CurrencyExchangeRate,
		ItemCost,
		ItemUnitPrice,
		Total,
		TotalWeight,
		GLSalesAccount,
		ProjectID,
		TrackingNumber,
		WarehouseBinZone,
		PalletLevel,
		CartonLevel,
		PackLevelA,
		PackLevelB,
		PackLevelC,
		ScheduledStartDate,
		ScheduledEndDate,
		ServiceStartDate,
		ServiceEndDate,
		PerformedBy,
		DetailMemo1,
		DetailMemo2,
		DetailMemo3,
		DetailMemo4,
		DetailMemo5,
		TaxGroupID,
		TaxAmount,
		TaxPercent,
		SubTotal
      FROM
      OrderDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND OrderNumber = v_OrderNumber;
	
	
	
	
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Cannot create Order Detail record';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF (v_Memorize <> 1) then

      SET @SWV_Error = 0;
      DELETE FROM         OrderDetail   WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND OrderNumber = v_OrderNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete OrderDetail record failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      DELETE FROM         OrderHeader   WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND OrderNumber = v_OrderNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete OrderHeader record failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'ServiceOrder_CopyToHistory',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

   SET SWP_Ret_Value = -1;
END