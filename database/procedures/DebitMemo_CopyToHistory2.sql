CREATE PROCEDURE DebitMemo_CopyToHistory2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




























   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);




   DECLARE v_Memorize BOOLEAN;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
       SET @SWV_Error = 1;
   END;
   select   Memorize INTO v_Memorize FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber
   AND ABS(IFNULL(BalanceDue,0)) < 0.005
   AND ABS(IFNULL(PurchaseHeader.Total,0)) >= 0.005
   AND LOWER(IFNULL(PurchaseHeader.TransactionTypeID,N'')) = 'debit memo';
   IF ROW_COUNT() = 0 then

      SET SWP_Ret_Value = -2;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   IF NOT Exists(SELECT PurchaseNumber
   FROM PurchaseHeaderHistory
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber) then

      SET @SWV_Error = 0;
      INSERT INTO
      PurchaseDetailHistory(CompanyID,
		DivisionID,
		DepartmentID,
		PurchaseNumber, 
		
		ItemID,
		VendorItemID,
		Description,
		WarehouseID,
		WarehouseBinID,
		SerialNumber,
		OrderQty,
		ItemUOM,
		ItemWeight,
		DiscountPerc,
		Taxable,
		ItemCost,
		CurrencyID,
		CurrencyExchangeRate,
		ItemUnitPrice,
		Total,
		TotalWeight,
		GLPurchaseAccount,
		ProjectID,
		Received,
		ReceivedDate,
		ReceivedQty,
		RecivingNumber,
		TrackingNumber,
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
		PurchaseNumber, 
		
		ItemID,
		VendorItemID,
		Description,
		WarehouseID,
		WarehouseBinID,
		SerialNumber,
		OrderQty,
		ItemUOM,
		ItemWeight,
		DiscountPerc,
		Taxable,
		ItemCost,
		CurrencyID,
		CurrencyExchangeRate,
		ItemUnitPrice,
		Total,
		TotalWeight,
		GLPurchaseAccount,
		ProjectID,
		Received,
		ReceivedDate,
		ReceivedQty,
		RecivingNumber,
		TrackingNumber,
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
      PurchaseDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber = v_PurchaseNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into PurchaseDetailHistory failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      INSERT INTO
      PurchaseHeaderHistory
      SELECT * FROM
      PurchaseHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber = v_PurchaseNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into PurchaselHistory failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF IFNULL(v_Memorize,0) <> 1 then
	
      SET @SWV_Error = 0;
      DELETE
      FROM
      PurchaseDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber = v_PurchaseNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from PurchaseDetail failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      DELETE
      FROM
      PurchaseHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber = v_PurchaseNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from PurchaseHeader failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   end if;	


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;



   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'DebitMemo_CopyToHistory',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');

   SET SWP_Ret_Value = -1;
END