CREATE PROCEDURE Purchase_CopyToHistory2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36), 
	INOUT v_PostingResult NATIONAL VARCHAR(200) ,INOUT SWP_Ret_Value INT) SWL_return:
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
   AND LOWER(IFNULL(TransactionTypeID,N'')) NOT IN('rma','debit memo')
   AND (IFNULL(Received,0) = 1)
   AND (IFNULL(Paid,0) = 1);
   IF ROW_COUNT() = 0 then

      set v_PostingResult = N'Purchase is not paid yet';
      SET SWP_Ret_Value = -2;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;


   IF NOT EXISTS(SELECT PurchaseNumber
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
		LockedBy,
		LockTS,
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
		NULL,
		NULL,
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



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
         LEAVE SWL_return;

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
	
         SET v_ErrorMessage = 'Insert into PurchaseHistory failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
         LEAVE SWL_return;

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



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
         LEAVE SWL_return;

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



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CopyToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
         LEAVE SWL_return;

      end if;
   end if;	


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;



   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CopyToHistory',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');

   SET SWP_Ret_Value = -1;
   LEAVE SWL_return;




END