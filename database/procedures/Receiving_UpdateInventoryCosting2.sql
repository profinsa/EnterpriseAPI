CREATE PROCEDURE Receiving_UpdateInventoryCosting2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PurchaseNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN



   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_ItemID NATIONAL VARCHAR(36);
   DECLARE v_ReceivedQty FLOAT;
   DECLARE v_OrderQty FLOAT;
   DECLARE v_ItemUnitPrice DECIMAL(19,4);
   DECLARE v_WarehouseID NATIONAL VARCHAR(36);
   DECLARE v_ConvertedItemUnitPrice DECIMAL(19,4);
   DECLARE v_LastCost DECIMAL(19,4);
   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_PurchaseDate DATETIME;
   DECLARE v_PurchaseLineNumber NUMERIC(18,0);
   DECLARE v_Result INT;

   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_ErrorID INT;
   DECLARE C CURSOR FOR 
   SELECT  
   PurchaseLineNumber,
		ItemID, 
		IFNULL(ReceivedQty,0),
		IFNULL(OrderQty,0),
		IFNULL(ItemUnitPrice,0), 
		IFNULL(WarehouseID,N'')
   FROM  
   PurchaseDetail
   WHERE 
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber AND
   IFNULL(Received,0) = 0;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   select   CurrencyID, CurrencyExchangeRate, PurchaseDate INTO v_CurrencyID,v_CurrencyExchangeRate,v_PurchaseDate FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_PurchaseNumber;

   START TRANSACTION;

   SET @SWV_Error = 0;
   CALL VerifyCurrency2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,2,v_CompanyCurrencyID,
   v_CurrencyID,v_CurrencyExchangeRate);
   IF @SWV_Error <> 0 then

	
      SET v_ErrorMessage = 'Currency retrieving failed';
      ROLLBACK;

      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_UpdateInventoryCosting',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   OPEN C;



   SET NO_DATA = 0;
   FETCH C INTO v_PurchaseLineNumber,v_ItemID,v_ReceivedQty,v_OrderQty,v_ItemUnitPrice, 
   v_WarehouseID;
   WHILE NO_DATA = 0 DO
	
      SET v_ConvertedItemUnitPrice = v_ItemUnitPrice*v_CurrencyExchangeRate;
      SET @SWV_Error = 0;
      CALL Inventory_CreateILTransaction2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseDate,v_ItemID,'Purchase',
      v_PurchaseNumber,v_PurchaseLineNumber,v_ReceivedQty,v_ConvertedItemUnitPrice, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
	
         CLOSE C;
		
         SET v_ErrorMessage = 'Inventory_CreateILTransaction call failed';
         ROLLBACK;

         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_UpdateInventoryCosting',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
	
	
      SET @SWV_Error = 0;
      CALL Inventory_Costing2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ItemID,v_WarehouseID,v_ReceivedQty,
      v_ConvertedItemUnitPrice,1,v_Result, v_ReturnStatus);
      IF @SWV_Error <> 0 OR v_Result <> 1 OR v_ReturnStatus = -1 then
	
	
         CLOSE C;
		
         SET v_ErrorMessage = 'Inventory_Costing call failed';
         ROLLBACK;

         IF v_ErrorMessage <> '' then

	
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_UpdateInventoryCosting',
            v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
         end if;
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH C INTO v_PurchaseLineNumber,v_ItemID,v_ReceivedQty,v_OrderQty,v_ItemUnitPrice, 
      v_WarehouseID;
   END WHILE;
   CLOSE C;


   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;

   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Receiving_UpdateInventoryCosting',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseNumber',v_PurchaseNumber);
   end if;
   SET SWP_Ret_Value = -1;
END