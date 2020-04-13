CREATE PROCEDURE Order_CreditCustomerOrder (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_CustomerID NATIONAL VARCHAR(36),
	v_OrderNumber NATIONAL VARCHAR(36),
	INOUT v_AllowanceDiscountPercent FLOAT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN






   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_ApplyRebate BOOLEAN;
   DECLARE v_RebateAmount FLOAT;
   DECLARE v_ApplyNewStore BOOLEAN;
   DECLARE v_NewStoreDiscount FLOAT;
   DECLARE v_ApplyWarehouse BOOLEAN;
   DECLARE v_WarehouseAllowance FLOAT;
   DECLARE v_ApplyAdvertising BOOLEAN;
   DECLARE v_AdvertisingDiscount FLOAT;
   DECLARE v_ApplyManualAdvert BOOLEAN;
   DECLARE v_ManualAdvertising FLOAT;
   DECLARE v_ApplyTrade BOOLEAN;
   DECLARE v_TradeDiscount FLOAT;
   DECLARE v_OrderAmount DECIMAL(19,4);
   DECLARE v_Amount DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;
   SET v_AllowanceDiscountPercent = 0;



   DELETE
   FROM
   OrderDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber
   AND IFNULL(Total,0) < 0;
   SET v_AllowanceDiscountPercent = Customer_GetAllowancePercent(v_CompanyID,v_DivisionID,v_DepartmentID,v_CustomerID);
   SET @SWV_Error = 0;
   UPDATE
   OrderHeader
   SET
   AllowanceDiscountPerc = v_AllowanceDiscountPercent
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND OrderNumber = v_OrderNumber;
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'OrderHeader update failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_CreditCustomerOrder',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
      SET SWP_Ret_Value = -1;
   end if;
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Order_CreditCustomerOrder',v_ErrorMessage,
   v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'OrderNumber',v_OrderNumber);
   SET SWP_Ret_Value = -1;
END