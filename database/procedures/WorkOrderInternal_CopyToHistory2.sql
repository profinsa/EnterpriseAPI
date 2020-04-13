CREATE PROCEDURE WorkOrderInternal_CopyToHistory2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_WorkOrderNumber NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN



























   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);




   DECLARE v_Memorize BOOLEAN;

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   Memorize INTO v_Memorize FROM
   WorkOrderHeader WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND WorkOrderNumber = v_WorkOrderNumber
   AND IFNULL(WorkOrderCompleted,0) = 1
   AND UPPER(WorkOrderNumber) <> 'DEFAULT'
   AND UPPER(WorkOrderType) = 'INTERNAL';
   IF ROW_COUNT() = 0 then

      SET SWP_Ret_Value = -2;
      LEAVE SWL_return;
   end if;

   START TRANSACTION;

   IF NOT Exists(SELECT 	WorkOrderNumber
   FROM 	WorkOrderHeaderHistory
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND WorkOrderNumber = v_WorkOrderNumber) then

      SET @SWV_Error = 0;
      INSERT INTO
      WorkOrderDetailHistory(CompanyID,
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
		
		
      FROM
      WorkOrderDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND WorkOrderNumber = v_WorkOrderNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into WorkOrderDetailHistory failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WorkOrderInternal_CopyToHistory',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      INSERT INTO
      WorkOrderHeaderHistory
      SELECT * FROM
      WorkOrderHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND WorkOrderNumber = v_WorkOrderNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Insert into WorkOrderHeader failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WorkOrderInternal_CopyToHistory',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   end if;

   IF IFNULL(v_Memorize,0) <> 1 then

      SET @SWV_Error = 0;
      DELETE
      FROM
      WorkOrderDetail
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND WorkOrderNumber = v_WorkOrderNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from WorkOrderDetail failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WorkOrderInternal_CopyToHistory',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      DELETE
      FROM
      WorkOrderHeader
      WHERE
      CompanyID = v_CompanyID
      AND DivisionID = v_DivisionID
      AND DepartmentID = v_DepartmentID
      AND WorkOrderNumber = v_WorkOrderNumber;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Delete from WorkOrderHeader failed';
         ROLLBACK;



         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WorkOrderInternal_CopyToHistory',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   end if;	


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;



   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'WorkOrderInternal_CopyToHistory',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');

   SET SWP_Ret_Value = -1;
END