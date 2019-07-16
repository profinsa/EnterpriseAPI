CREATE FUNCTION Customer_GetAllowancePercent2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_CustomerID NATIONAL VARCHAR(36)) BEGIN
	
	
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
   DECLARE v_AllowanceDiscountPercent FLOAT;
	
   SET v_AllowanceDiscountPercent = 0;
	
   select   IFNULL(ApplyRebate,0), IFNULL(RebateAmount,0), IFNULL(ApplyNewStore,0), IFNULL(NewStoreDiscount,0), IFNULL(ApplyWarehouse,0), IFNULL(WarehouseAllowance,0), IFNULL(ApplyAdvertising,0), IFNULL(AdvertisingDiscount,0), IFNULL(ApplyManualAdvert,0), IFNULL(ManualAdvertising,0), IFNULL(ApplyTrade,0), IFNULL(TradeDiscount,0) INTO v_ApplyRebate,v_RebateAmount,v_ApplyNewStore,v_NewStoreDiscount,v_ApplyWarehouse,
   v_WarehouseAllowance,v_ApplyAdvertising,v_AdvertisingDiscount,
   v_ApplyManualAdvert,v_ManualAdvertising,v_ApplyTrade,v_TradeDiscount FROM
   CustomerInformation WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND CustomerID = v_CustomerID;
	
	
   IF (v_ApplyRebate = 1) AND (v_RebateAmount > 0) then
	
      SET v_AllowanceDiscountPercent = v_AllowanceDiscountPercent+v_RebateAmount;
   end if;
	
	
   IF (v_ApplyNewStore = 1) AND (v_NewStoreDiscount > 0) then
	
      SET v_AllowanceDiscountPercent = v_AllowanceDiscountPercent+v_NewStoreDiscount;
   end if;
	
	
   IF (v_ApplyWarehouse = 1) AND (v_WarehouseAllowance > 0) then
	
      SET v_AllowanceDiscountPercent = v_AllowanceDiscountPercent+v_WarehouseAllowance;
   end if;
	
	
   IF (v_ApplyAdvertising = 1) AND (v_AdvertisingDiscount > 0) then
	
      SET v_AllowanceDiscountPercent = v_AllowanceDiscountPercent+v_AdvertisingDiscount;
   end if;
	
	
   IF (v_ApplyManualAdvert = 1) AND (v_ManualAdvertising > 0) then
	
      SET v_AllowanceDiscountPercent = v_AllowanceDiscountPercent+v_ManualAdvertising;
   end if;
	
	
   IF (v_ApplyTrade = 1) AND (v_TradeDiscount > 0) then
	
      SET v_AllowanceDiscountPercent = v_AllowanceDiscountPercent+v_TradeDiscount;
   end if;
   RETURN v_AllowanceDiscountPercent;
END