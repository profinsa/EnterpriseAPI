CREATE PROCEDURE RMAReceiving_Post (v_CompanyID NATIONAL VARCHAR(36)
	,v_DivisionID NATIONAL VARCHAR(36)
	,v_DepartmentID NATIONAL VARCHAR(36)
	,v_PurchaseNumber NATIONAL VARCHAR(36)
	,INOUT v_Success INT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_TranDate DATETIME;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_PeriodToPost INT;
   DECLARE v_PeriodClosed INT;
   DECLARE v_CustomerID NATIONAL VARCHAR(50);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_NewPaymentID NATIONAL VARCHAR(36);
   DECLARE v_AmountPaid DECIMAL(19,4);
   DECLARE v_Total DECIMAL(19,4);
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;



   SET @SWV_Error = 0;
   SET v_Success = 1;
   SET v_ErrorMessage = '';


   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM Companies WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID;


   IF v_PostDate = '1' then
	
	
      SET v_TranDate = CURRENT_TIMESTAMP;
   ELSE
	
	
      select   PurchaseDate INTO v_TranDate FROM PurchaseHeader WHERE CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND PurchaseNumber = v_PurchaseNumber;
   end if;



   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodToPost,v_PeriodClosed, v_ReturnStatus);


   IF v_PeriodClosed <> 0
   OR v_ReturnStatus = -1 then
	



      SET v_Success = 2;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;







   end if;

   START TRANSACTION;


   CALL RMA_Recalc(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);

   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'RMA_Recalc call failed';
      ROLLBACK;


      IF v_Success = 1 then

         SET v_Success = 0;
      end if;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   select   IFNULL(AmountPaid,0), IFNULL(Total,0), VendorID INTO v_AmountPaid,v_Total,v_CustomerID FROM PurchaseHeader WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   UPDATE PurchaseDetail
   SET ReceivedQty = IFNULL(OrderQty,0),ReceivedDate = IFNULL(ReceivedDate,CURRENT_TIMESTAMP)
   WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;


   SET @SWV_Error = 0;
   CALL Receiving_AdjustInventory(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);

   IF @SWV_Error <> 0
   OR v_ReturnStatus = -1 then
	

      SET v_ErrorMessage = 'Receiving_AdjustInventory call failed';
      ROLLBACK;


      IF v_Success = 1 then

         SET v_Success = 0;
      end if;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   CALL Receiving_UpdateInventoryCosting2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);

   IF @SWV_Error <> 0
   OR v_ReturnStatus = -1 then
	

      SET v_ErrorMessage = 'Receiving_UpdateInventoryCosting call failed';
      ROLLBACK;


      IF v_Success = 1 then

         SET v_Success = 0;
      end if;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;


   SET @SWV_Error = 0;
   CALL RMAReceiving_AdjustCustomerFinancials(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber, v_ReturnStatus);

   IF @SWV_Error <> 0
   OR v_ReturnStatus = -1 then
	

      SET v_ErrorMessage = 'Receiving_AdjustVendorFinancials call failed';
      ROLLBACK;


      IF v_Success = 1 then

         SET v_Success = 0;
      end if;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;



   SET @SWV_Error = 0;
   CALL Payment_CreateFromRMA(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_NewPaymentID, v_ReturnStatus);

   IF v_ReturnStatus = -1 then

	
      SET v_ErrorMessage = 'Payment_CreateFromRMA call failed';
      ROLLBACK;


      IF v_Success = 1 then

         SET v_Success = 0;
      end if;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   SET v_PaymentID = v_NewPaymentID;

   SET @SWV_Error = 0;
   CALL Payment_CreateCreditMemo(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentID, v_ReturnStatus);

   IF v_ReturnStatus = -1 then

	
      SET v_ErrorMessage = 'Payment_CreateCreditMemo call failed';
      ROLLBACK;


      IF v_Success = 1 then

         SET v_Success = 0;
      end if;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   UPDATE PurchaseHeader
   SET Received = 1,ReceivedDate = CURRENT_TIMESTAMP
   WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;

   UPDATE PurchaseDetail
   SET Received = 1
   WHERE CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PurchaseNumber = v_PurchaseNumber;


   SET @SWV_Error = 0;
   CALL RMAReceiving_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber,v_PostDate, v_ReturnStatus);

   IF @SWV_Error <> 0
   OR v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'RMAReceiving_CreateGLTransaction call failed';
      ROLLBACK;


      IF v_Success = 1 then

         SET v_Success = 0;
      end if;


      IF v_ErrorMessage <> '' then

	
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
         v_PurchaseNumber);
      end if;
      SET SWP_Ret_Value = -1;
   end if;

   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;





   SET v_Success = 2;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;


   IF v_Success = 1 then

      SET v_Success = 0;
   end if;


   IF v_ErrorMessage <> '' then

	
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMAReceiving_Post',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PurchaseOrderNumber',
      v_PurchaseNumber);
   end if;

   SET SWP_Ret_Value = -1;
END