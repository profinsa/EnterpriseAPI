CREATE PROCEDURE RMA_Close (v_CompanyID 	NATIONAL VARCHAR(36),
	v_DivisionID 	NATIONAL VARCHAR(36),
	v_DepartmentID	NATIONAL VARCHAR(36),
	v_PurchaseNumber  NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN





   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_Work INT;
   DECLARE v_WorkB BOOLEAN;
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;



   select   COUNT(*) INTO v_Work from PurchaseHeaderHistory where
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;
   IF (v_Work = 0) then

      SET @SWV_Error = 0;
      INSERT INTO PurchaseHeaderHistory
      SELECT * FROM    PurchaseHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber = v_PurchaseNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Cannot create RMA HeaderHistory';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_CreateFromMemorizedRMA',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      INSERT INTO PurchaseDetailHistory(CompanyID,
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
		LockTS)
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
		LockedBy,
		LockTS
      FROM         PurchaseDetailHistory	WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber = v_PurchaseNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Cannot create RMA Details';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_CreateFromMemorizedRMA',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;


   select   Memorize INTO v_WorkB from PurchaseHeader where
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   IF (v_WorkB <> 1) then

      DELETE FROM         PurchaseDetail   WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber = v_PurchaseNumber;
      DELETE FROM         PurchaseHeader   WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber = v_PurchaseNumber;
   end if;
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_CreateFromMemorizedRMA',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);

   SET SWP_Ret_Value = -1;
END