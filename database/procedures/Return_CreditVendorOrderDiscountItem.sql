CREATE PROCEDURE Return_CreditVendorOrderDiscountItem (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_VendorID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),
	v_ItemID NATIONAL VARCHAR(36),
	v_Description NATIONAL VARCHAR(80),
	v_Amount DECIMAL(19,4),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN













   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   UPDATE
   OrderDetail
   SET
   Total = v_Amount
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber
   AND ItemID = v_ItemID
   AND IFNULL(OrderQty,0) = 0;

   IF ROW_COUNT() = 0 then
		
      SET @SWV_Error = 0;
      INSERT INTO OrderDetail(CompanyID,
				DivisionID,
				DepartmentID,
				OrderNumber,
				ItemID,
				WarehouseID,
				SerialNumber,
				Description,
				OrderQty,
				BackOrdered,
				BackOrderQyyty,
				ItemUOM,
				ItemWeight,
				DiscountPerc,
				Taxable,
				ItemCost,
				ItemUnitPrice,
				Total,
				TotalWeight,
				GLSalesAccount,
				ProjectID,
				TrackingNumber,
				DetailMemo1,
				DetailMemo2,
				DetailMemo3,
				DetailMemo4,
				DetailMemo5)
			VALUES(v_CompanyID,
				v_DivisionID,
				v_DepartmentID,
				v_OrderNumber,
				v_ItemID,
				NULL,
				NULL,
				v_Description,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				v_Amount,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL);
			
      IF @SWV_Error <> 0 then
			
         SET v_ErrorMessage = 'Inserting order detail failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_CreditVendorOrderDiscountItem',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
         SET SWP_Ret_Value = -1;
      end if;
   end if;
		

   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_CreditVendorOrderDiscountItem',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);

   SET SWP_Ret_Value = -1;
END