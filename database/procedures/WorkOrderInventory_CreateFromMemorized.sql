CREATE PROCEDURE WorkOrderInventory_CreateFromMemorized (v_CompanyID NATIONAL VARCHAR(36),    
 v_DivisionID NATIONAL VARCHAR(36),    
 v_DepartmentID NATIONAL VARCHAR(36),    
 v_WorkOrderNumber NATIONAL VARCHAR(36),    
 INOUT v_NewWorkOrderNumber NATIONAL VARCHAR(72),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN
              
  
    
   DECLARE v_ReturnStatus SMALLINT;    
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);    
    
   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;    
    

   SET @SWV_Error = 0;
   SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextWorkOrderNumber',v_NewWorkOrderNumber);    
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

      SET v_NewWorkOrderNumber = N'';
      SET v_ErrorMessage = 'GetNextEntityID call failed';
      ROLLBACK;    

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WorkOrderInventory_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WorkOrderNumber',v_WorkOrderNumber);
      SET SWP_Ret_Value = -1;
   end if;    
    
    

   SET @SWV_Error = 0;
   INSERT INTO WorkOrderHeader(CompanyID,
 DivisionID,
 DepartmentID,
 WorkOrderNumber,
 WorkOrderType,
 WorkOrderDate,
 WorkOrderStartDate,
 WorkOrderExpectedDate,
 WorkOrderCompleted,
 WorkOrderCompletedDate,
 WorkOrderCancelDate,
 WorkOrderReference,
 WorkOrderReferenceDate,
 WorkOrderRequestedBy,
 WorkOrderManager,
 WorkOrderAssignedTo,
 WorkOrderApprovedBy,
 WorkOrderApprovedByDate,
 WorkOrderForCompanyID,
 WorkOrderForDivisionID,
 WorkOrderForDepartmentID,
 WorkOrderReason,
 WorkOrderDescription,
 WorkOrderStatus,
 WorkOrderPriority,
 WorkOrderInProgress,
 WorkOrderProgressNotes,
 WorkOrderTotalCost,
 WorkOrderMemo1,
 WorkOrderMemo2,
 WorkOrderMemo3,
 WorkOrderMemo4,
 WorkOrderMemo5,
 WorkOrderMemo6,
 WorkOrderMemo7,
 WorkOrderMemo8,
 WorkOrderMemo9,
 Memorize,
 Signature,
 SignaturePassword,
 SupervisorSignature,
 SupervisorSignaturePassword,
 ManagerSignature,
 ManagerSignaturePassword,
 LockedBy,
 LockTS)
   SELECT
   CompanyID,
  DivisionID,
  DepartmentID,
  v_NewWorkOrderNumber,
  WorkOrderType,
  CURRENT_TIMESTAMP, 
  CURRENT_TIMESTAMP, 
  NULL, 
  0,
  NULL, 
  NULL, 
  WorkOrderReference,
  NULL,
  WorkOrderRequestedBy,
  WorkOrderManager,
  WorkOrderAssignedTo,
  WorkOrderApprovedBy,
  WorkOrderApprovedByDate,
  WorkOrderForCompanyID,
  WorkOrderForDivisionID,
  WorkOrderForDepartmentID,
  WorkOrderReason,
  WorkOrderDescription,
  WorkOrderStatus,
  WorkOrderPriority,
  WorkOrderInProgress,
  WorkOrderProgressNotes,
  WorkOrderTotalCost,
  WorkOrderMemo1,
  WorkOrderMemo2,
  WorkOrderMemo3,
  WorkOrderMemo4,
  WorkOrderMemo5,
  WorkOrderMemo6,
  WorkOrderMemo7,
  WorkOrderMemo8,
  WorkOrderMemo9,
  0, 
  Signature,
  SignaturePassword,
  SupervisorSignature,
  SupervisorSignaturePassword,
  ManagerSignature,
  ManagerSignaturePassword,
  NULL, 
  NULL 
   FROM
   WorkOrderHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND WorkOrderNumber = v_WorkOrderNumber;    
    
   IF @SWV_Error <> 0 then    


      SET v_ErrorMessage = 'Insert into WorkOrderHeader failed';
      ROLLBACK;    

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WorkOrderInventory_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WorkOrderNumber',v_WorkOrderNumber);
      SET SWP_Ret_Value = -1;
   end if;    
    
    
   SET @SWV_Error = 0;
   INSERT INTO
   WorkOrderDetail(CompanyID,
  DivisionID,
  DepartmentID,
  WorkOrderNumber,     
  
  WorkOrderStartDate,
  WorkOrderExpectedDate,
  WorkOrderCompleted,
  WorkOrderCompletedDate,
  WorkOrderBOMNumber,
  WorkOrderBOMDescription,
  WorkOrderBOMQuantity,
  WorkOrderBOMUnitCost,
  WorkOrderBOMUnitLabor,
  WorkOrderBOMOtherCost,
  WorkOrderTotalCost,
  WorkOrderSerialNumber,
  WorkOrderDescription,
  WorkOrderStatus,
  WorkOrderPriority,
  WorkOrderInProgress,
  WorkOrderProgressNotes,
  WorkOrderDetailMemo1,
  WorkOrderDetailMemo2,
  WorkOrderDetailMemo3,
  WorkOrderDetailMemo4,
  WorkOrderDetailMemo5,
  WorkOrderDetailMemo6,
  WorkOrderDetailMemo7,
  WorkOrderDetailMemo8,
  WorkOrderDetailMemo9,
  Signature,
  SignaturePassword,
  SupervisorSignature,
  SupervisorSignaturePassword,
  ManagerSignature,
  ManagerSignaturePassword
  
  
 )
   SELECT
   CompanyID,
  DivisionID,
  DepartmentID,
  v_NewWorkOrderNumber,     
  
  CURRENT_TIMESTAMP, 
  NULL, 
  0, 
  NULL, 
  WorkOrderBOMNumber,
  WorkOrderBOMDescription,
  WorkOrderBOMQuantity,
  WorkOrderBOMUnitCost,
  WorkOrderBOMUnitLabor,
  WorkOrderBOMOtherCost,
  WorkOrderTotalCost,
  WorkOrderSerialNumber,
  WorkOrderDescription,
  WorkOrderStatus,
  WorkOrderPriority,
  WorkOrderInProgress,
  WorkOrderProgressNotes,
  WorkOrderDetailMemo1,
  WorkOrderDetailMemo2,
  WorkOrderDetailMemo3,
  WorkOrderDetailMemo4,
  WorkOrderDetailMemo5,
  WorkOrderDetailMemo6,
  WorkOrderDetailMemo7,
  WorkOrderDetailMemo8,
  WorkOrderDetailMemo9,
  Signature,
  SignaturePassword,
  SupervisorSignature,
  SupervisorSignaturePassword,
  ManagerSignature,
  ManagerSignaturePassword
  
  
   FROM
   WorkOrderDetail
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND WorkOrderNumber = v_WorkOrderNumber;     
  
   IF @SWV_Error <> 0 then    


      SET v_ErrorMessage = 'Insert into WorkOrderDetail failed';
      ROLLBACK;    

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WorkOrderInventory_CreateFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WorkOrderNumber',v_WorkOrderNumber);
      SET SWP_Ret_Value = -1;
   end if;    
    
   SET v_NewWorkOrderNumber = CONCAT('New Work Order Created With Work Order Number:',v_NewWorkOrderNumber);    
    
   COMMIT;    
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;    
    






   ROLLBACK;    

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WorkOrderInventory_CreateFromMemorized',
   v_ErrorMessage,v_ErrorID);    
    
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'WorkOrderNumber',v_WorkOrderNumber);    
    
   SET SWP_Ret_Value = -1;
END