CREATE PROCEDURE Payment_CreateCreditMemoForAll (v_CompanyID 	NATIONAL VARCHAR(36),
	v_DivisionID 	NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN







   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);


   DECLARE v_Period INT;
   DECLARE v_PeriodStart DATETIME;
   DECLARE v_PeriodEnd DATETIME;



   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cPaymentsHeader CURSOR 
   FOR SELECT
   PaymentID
   FROM
   PaymentsHeader
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND PaymentID <> 'DEFAULT'
   AND (IFNULL(Posted,0) = 0 OR IFNULL(Paid,0) = 0)
   AND ApprovedForPayment = 1
   AND IFNULL(Void,0) = 0;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;
   OPEN cPaymentsHeader;

   SET @SWV_Error = 0;
   SET NO_DATA = 0;
   FETCH cPaymentsHeader INTO v_PaymentID;

   IF @SWV_Error <> 0 then
	
      CLOSE cPaymentsHeader;
		
      SET v_ErrorMessage = 'Fetching from the PaymentsHeader cursor failed';
      ROLLBACK;
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateCreditMemoForAll',
      v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
      SET SWP_Ret_Value = -1;
   end if;


   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      SET v_ReturnStatus = Payment_CreateCreditMemo2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentID);
      IF @SWV_Error <> 0 OR v_ReturnStatus <= 0 then
		
		
         CLOSE cPaymentsHeader;
			
         IF v_ReturnStatus = -4 then
            SET v_ErrorMessage = CONCAT('The payment is void for PaymentID:',v_PaymentID);
         ELSE 
            IF v_ReturnStatus = -5 then
               SET v_ErrorMessage = CONCAT('The credit amount is 0 or less than 0 for PaymentID:',v_PaymentID);
            ELSE 
               IF v_ReturnStatus = -6 then
                  SET v_ErrorMessage = CONCAT('The payment is not yet posted for PaymentID:',v_PaymentID);
               ELSE
                  SET v_ErrorMessage = 'Payment_CopyToHistory call failed';
               end if;
            end if;
         end if;
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateCreditMemoForAll',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      SET NO_DATA = 0;
      FETCH cPaymentsHeader INTO v_PaymentID;
      IF @SWV_Error <> 0 then
		
         CLOSE cPaymentsHeader;
			
         SET v_ErrorMessage = 'Fetching from the PaymentsHeader cursor failed';
         ROLLBACK;
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateCreditMemoForAll',
         v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');
         SET SWP_Ret_Value = -1;
      end if;
   END WHILE;

   CLOSE cPaymentsHeader;





   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;







   ROLLBACK;
   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payment_CreateCreditMemoForAll',
   v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'','');

   SET SWP_Ret_Value = -1;
END