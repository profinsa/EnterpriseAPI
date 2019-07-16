CREATE PROCEDURE Purchase_CopyAllToHistory (v_CompanyID 	NATIONAL VARCHAR(36),
	v_DivisionID 	NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN




























   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_PurchaseNumber NATIONAL VARCHAR(36);


   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;
   DECLARE v_PeriodEnd DATETIME;



   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cPurchaseHeader CURSOR 
   FOR SELECT
   PurchaseNumber
   FROM
   PurchaseHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND LOWER(IFNULL(TransactionTypeID,N'')) NOT IN('rma','debit memo')
   AND (IFNULL(Received,0) = 1) 
   AND (IFNULL(Paid,0) = 1);
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;
   OPEN cPurchaseHeader;

   SET @SWV_Error = 0;
   SET NO_DATA = 0;
   FETCH cPurchaseHeader INTO v_PurchaseNumber;

   IF @SWV_Error <> 0 then
	
      CLOSE cPurchaseHeader;
		
      SET v_ErrorMessage = 'Fetching from the PurchaseHeader cursor failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CopyAllToHistory',v_ErrorMessage,
      v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
      SET SWP_Ret_Value = -1;
   end if;


   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      SET v_ReturnStatus = Purchase_CopyToHistory(v_CompanyID,v_DivisionID,v_DepartmentID,v_PurchaseNumber);
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
		
		
         CLOSE cPurchaseHeader;
			
         SET v_ErrorMessage = 'Purchase_CopyToHistory call failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CopyAllToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      SET NO_DATA = 0;
      FETCH cPurchaseHeader INTO v_PurchaseNumber;
      IF @SWV_Error <> 0 then
		
         CLOSE cPurchaseHeader;
			
         SET v_ErrorMessage = 'Fetching from the PurchaseHeader cursor failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CopyAllToHistory',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   END WHILE;

   CLOSE cPurchaseHeader;





   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Purchase_CopyAllToHistory',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');

   SET SWP_Ret_Value = -1;
END