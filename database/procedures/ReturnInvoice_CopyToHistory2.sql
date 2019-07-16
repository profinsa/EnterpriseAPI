CREATE PROCEDURE ReturnInvoice_CopyToHistory2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_InvoiceNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN























   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);




   DECLARE v_Memorize BOOLEAN;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   Memorize INTO v_Memorize FROM
   InvoiceHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber
   AND IFNULL(Shipped,0) = 1
   AND ABS(IFNULL(BalanceDue,0)) < 0.005
   AND ABS(IFNULL(Total,0)) >= 0.005
   AND LOWER(IFNULL(TransactionTypeID,N'')) = 'return';

   IF ROW_COUNT() = 0 then

      SET SWP_Ret_Value = -2;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;
   IF NOT EXISTS(SELECT InvoiceNumber
   FROM InvoiceHeaderHistory
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND InvoiceNumber = v_InvoiceNumber) then

	
	
	
      SET @SWV_Error = 0;
      INSERT INTO
      InvoiceDetailHistory(CompanyID,
		DivisionID,
		DepartmentID,
		InvoiceNumber,
		
		ItemID,
		WarehouseID,
		WarehouseBinID,
		SerialNumber,
		OrderQty,
		BackOrdered,
		BackOrderQty,
		ItemUOM,
		ItemWeight,
		Description,
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
		WarehouseBinZone,
		PalletLevel,
		CartonLevel,
		PackLevelA,
		PackLevelB,
		PackLevelC,
		TrackingNumber,
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
		InvoiceNumber,
		
		ItemID,
		WarehouseID,
		WarehouseBinID,
		SerialNumber,
		OrderQty,
		BackOrdered,
		BackOrderQty,
		ItemUOM,
		ItemWeight,
		Description,
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
		WarehouseBinZone,
		PalletLevel,
		CartonLevel,
		PackLevelA,
		PackLevelB,
		PackLevelC,
		TrackingNumber,
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
      InvoiceDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND InvoiceNumber = v_InvoiceNumber; 
	
	
	
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into InvoiceDetailHistory failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CopyClosed',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      INSERT INTO
      InvoiceHeaderHistory
      SELECT * FROM
      InvoiceHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND InvoiceNumber = v_InvoiceNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into InvoiceHistory failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CopyClosed',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF IFNULL(v_Memorize,0) <> 1 then

      SET @SWV_Error = 0;
      DELETE
      FROM
      InvoiceDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND InvoiceNumber = v_InvoiceNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from InvoiceDetail failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CopyClosed',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      DELETE
      FROM
      InvoiceHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND InvoiceNumber = v_InvoiceNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from InvoiceHeader failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CopyClosed',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   end if;	


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;



   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Invoice_CopyClosed',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');

   SET SWP_Ret_Value = -1;
END