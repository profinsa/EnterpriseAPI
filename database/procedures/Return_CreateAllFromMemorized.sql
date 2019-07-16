CREATE PROCEDURE Return_CreateAllFromMemorized (v_CompanyID 	NATIONAL VARCHAR(36),
	v_DivisionID 	NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN








   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_OrderNumber NATIONAL VARCHAR(36);


   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cOrder CURSOR 
   FOR SELECT
   OrderNumber
   FROM
   OrderHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND Posted = 1 
   AND IFNULL(Backordered,0) = 0 
   AND Memorize = 1 
   AND LOWER(TransactionTypeID) = LOWER('Return');

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;



   OPEN cOrder;

   SET @SWV_Error = 0;
   SET NO_DATA = 0;
   FETCH cOrder INTO v_OrderNumber;

   IF @SWV_Error <> 0 then
	
      CLOSE cOrder;
		
      SET v_ErrorMessage = 'Fetching from the order cursor failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_CreateAllFromMemorized',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
      SET SWP_Ret_Value = -1;
   end if;


   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      SET v_ReturnStatus = Return_CreateFromMemorized(v_CompanyID,v_DivisionID,v_DepartmentID,v_OrderNumber);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
		
         CLOSE cOrder;
			
         SET v_ErrorMessage = 'Return_CopyMemorized call failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_CreateAllFromMemorized',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      SET NO_DATA = 0;
      FETCH cOrder INTO v_OrderNumber;
      IF @SWV_Error <> 0 then
		
         CLOSE cOrder;
			
         SET v_ErrorMessage = 'Fetching from the order cursor failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_CreateAllFromMemorized',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   END WHILE;

   CLOSE cOrder;





   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Return_CreateAllFromMemorized',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');

   SET SWP_Ret_Value = -1;
END