CREATE FUNCTION RMA_Control (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_DocumentNumber NATIONAL VARCHAR(36)) BEGIN




   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_DocumentTypeID NATIONAL VARCHAR(36);


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   TransactionTypeID INTO v_DocumentTypeID FROM
   PurchaseHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PurchaseNumber = v_DocumentNumber;


   IF LOWER(v_DocumentTypeID) = LOWER('RMA') then

      SET @SWV_Error = 0;
      SET v_ReturnStatus = Purchase_Post(v_CompanyID,v_DivisionID,v_DepartmentID,v_DocumentNumber);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
	
         SET v_ErrorMessage = 'RMA_Post call failed';
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Control',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DocumentNumber',v_DocumentNumber);
         RETURN -1;
      end if;
   end if;

   IF LOWER(v_DocumentTypeID) = LOWER('Debit Memo') then

      SET @SWV_Error = 0;
      SET v_ReturnStatus = DebitMemo_Post2(v_CompanyID,v_DivisionID,v_DepartmentID,v_DocumentNumber);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
	
         SET v_ErrorMessage = 'DebitMemo_Post call failed';
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Control',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DocumentNumber',v_DocumentNumber);
         RETURN -1;
      end if;
   end if;



   RETURN 0;










   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'RMA_Control',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'DocumentNumber',v_DocumentNumber);

   RETURN -1;
END