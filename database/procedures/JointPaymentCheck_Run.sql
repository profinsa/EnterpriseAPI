CREATE PROCEDURE JointPaymentCheck_Run (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	INOUT v_ResultMessage NATIONAL VARCHAR(500) ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN





   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_PaymentCompanyID NATIONAL VARCHAR(36);
   DECLARE v_PaymentDivisionID NATIONAL VARCHAR(36);
   DECLARE v_PaymentDepartmentID NATIONAL VARCHAR(36);
   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_CheckNumber INT;
   DECLARE v_PaymentCheckNumber NATIONAL VARCHAR(20);
   DECLARE v_VendorID NATIONAL VARCHAR(36);
   DECLARE v_VendorCurrentID NATIONAL VARCHAR(50);
   DECLARE v_GLBankAccount NATIONAL VARCHAR(36);
   DECLARE v_GLCurrentBankAccount NATIONAL VARCHAR(36);


   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cPaymentsPrint CURSOR FOR
   SELECT
   CompanyID,
		DivisionID,
		DepartmentID,
		PaymentID,
		VendorID,
		GLBankAccount
   FROM
   PaymentChecks
   WHERE
		(CompanyID <> v_CompanyID OR
   DivisionID <> v_DivisionID OR
   DepartmentID <> v_DepartmentID) AND
   EmployeeID = v_EmployeeID
   ORDER BY
   VendorID,GLBankAccount;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   SET v_VendorCurrentID = N'';
   SET v_GLCurrentBankAccount = N'';
   SET v_CheckNumber = 0;

   START TRANSACTION;


   OPEN cPaymentsPrint;
   SET NO_DATA = 0;
   FETCH cPaymentsPrint INTO v_PaymentCompanyID,v_PaymentDivisionID,v_PaymentDepartmentID,v_PaymentID, 
   v_VendorID,v_GLBankAccount;

   WHILE NO_DATA = 0 DO
      select   IFNULL(CheckNumber,N'a') INTO v_PaymentCheckNumber FROM
      PaymentsHeader WHERE
      CompanyID = v_PaymentCompanyID AND
      DivisionID = v_PaymentDivisionID AND
      DepartmentID = v_PaymentDepartmentID AND
      PaymentID = v_PaymentID;
      IF ISNUMERIC(v_PaymentCheckNumber) <> 1 then
	
		
         IF v_VendorID <> v_VendorCurrentID OR LOWER(v_GLBankAccount) <> LOWER(v_GLCurrentBankAccount) then
		
			
            SET v_CheckNumber = 0;
            SET v_VendorCurrentID = v_VendorID;
            SET v_GLCurrentBankAccount = v_GLBankAccount;
			
            SET @SWV_Error = 0;
            SET v_ReturnStatus = GetNextCheckNumber2(v_PaymentCompanyID,v_PaymentDivisionID,v_PaymentDepartmentID,v_GLBankAccount,
            v_CheckNumber);
			
            IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
               CLOSE cPaymentsPrint;
				
               SET v_ErrorMessage = 'GetNextCheckNumber call failed';
				
               CLOSE cPaymentsPrint;

               ROLLBACK;

               CALL Error_InsertError(v_CompanyID,'','','JointPaymentCheck_Run',v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
         IF v_CheckNumber > 0 then
		
			
            SET @SWV_Error = 0;
            UPDATE
            PaymentsHeader
            SET
            CheckNumber = CAST(v_CheckNumber AS CHAR(20)),CheckDate = CURRENT_TIMESTAMP,
            CheckPrinted = 0
            WHERE
            CompanyID = v_PaymentCompanyID AND
            DivisionID = v_PaymentDivisionID AND
            DepartmentID = v_PaymentDepartmentID AND
            PaymentID = v_PaymentID;
            IF @SWV_Error <> 0 then
			
               CLOSE cPaymentsPrint;
				
               SET v_ErrorMessage = 'Update PyamentsHeader failed';
				
               CLOSE cPaymentsPrint;

               ROLLBACK;

               CALL Error_InsertError(v_CompanyID,'','','JointPaymentCheck_Run',v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
               SET SWP_Ret_Value = -1;
            end if;

			
            SET @SWV_Error = 0;
            UPDATE
            PaymentChecks
            SET
            CheckNumber = CAST(v_CheckNumber AS CHAR(20))
            WHERE
            CompanyID = v_PaymentCompanyID AND
            DivisionID = v_PaymentDivisionID AND
            DepartmentID = v_PaymentDepartmentID AND
            EmployeeID = v_EmployeeID AND
            PaymentID = v_PaymentID;

			
            IF @SWV_Error <> 0 then
			
               CLOSE cPaymentsPrint;
				
               SET v_ErrorMessage = 'Update Check_Print failed';
				
               CLOSE cPaymentsPrint;

               ROLLBACK;

               CALL Error_InsertError(v_CompanyID,'','','JointPaymentCheck_Run',v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
               SET SWP_Ret_Value = -1;
            end if;
         ELSE
            SET v_ResultMessage = N'Some payments was not processed because there is not Bank with the Payment bank account. The check number was not assingned to these payments.';
         end if;
      ELSE
		
         SET @SWV_Error = 0;
         UPDATE
         PaymentChecks
         SET
         CheckNumber = v_PaymentCheckNumber
         WHERE
         CompanyID = v_PaymentCompanyID AND
         DivisionID = v_PaymentDivisionID AND
         DepartmentID = v_PaymentDepartmentID AND
         EmployeeID = v_EmployeeID AND
         PaymentID = v_PaymentID;

		
         IF @SWV_Error <> 0 then
		
            CLOSE cPaymentsPrint;
			
            SET v_ErrorMessage = 'Update Check_Print failed';
			
            CLOSE cPaymentsPrint;

            ROLLBACK;

            CALL Error_InsertError(v_CompanyID,'','','JointPaymentCheck_Run',v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH cPaymentsPrint INTO v_PaymentCompanyID,v_PaymentDivisionID,v_PaymentDepartmentID,v_PaymentID, 
      v_VendorID,v_GLBankAccount;
   END WHILE;

   CLOSE cPaymentsPrint;



   COMMIT;
   if IFNULL(v_ResultMessage,N'') = N'' then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   else
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;









   CLOSE cPaymentsPrint;


   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,'','','JointPaymentCheck_Run',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);


   SET SWP_Ret_Value = -1;
END