update databaseinfo set value='2019_06_10',lastupdate=now() WHERE id='Version';

DELIMITER //
DROP FUNCTION IF EXISTS ISNUMERIC;
CREATE FUNCTION ISNUMERIC(inputValue VARCHAR(50))
  RETURNS INT
  BEGIN
    IF (inputValue REGEXP ('^[0-9]+$'))
    THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END;

//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS PaymentCheck_Run;
//
CREATE      PROCEDURE PaymentCheck_Run(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN






/*
Name of stored procedure: PaymentCheck_Run
Method: 
	This stored procedure is used to generate checks for the payments selected for printing (in PayemntChecks table)

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@EmployeeID NVARCHAR(36)	 - the ID of the employee that performs the operation

Output Parameters:

	NONE

Called From:

	PaymentCheck_Run.vb

Calls:

	GetNextCheckNumber, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

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
   PaymentID,
		VendorID,
		GLBankAccount
   FROM
   PaymentChecks
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
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

-- declare a cursor for the payments ready to be printed ordered by the vendorID
   OPEN cPaymentsPrint;
   SET NO_DATA = 0;
   FETCH cPaymentsPrint INTO v_PaymentID,v_VendorID,v_GLBankAccount;

   WHILE NO_DATA = 0 DO
      select   IFNULL(CheckNumber,N'a') INTO v_PaymentCheckNumber FROM
      PaymentsHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PaymentID = v_PaymentID;
      IF ISNUMERIC(v_PaymentCheckNumber) <> 1 then
	
		-- get the vendorID and see if this is the current vendor or it is a new one
         IF v_VendorID <> v_VendorCurrentID OR LOWER(v_GLBankAccount) <> LOWER(v_GLCurrentBankAccount) then
		
			-- set the new current vendor
            SET v_CheckNumber = 0;
            SET v_VendorCurrentID = v_VendorID;
            SET v_GLCurrentBankAccount = v_GLBankAccount;
			-- get a new check number
            SET @SWV_Error = 0;
            CALL GetNextCheckNumber(v_CompanyID,v_DivisionID,v_DepartmentID,v_GLBankAccount,v_CheckNumber, v_ReturnStatus);
			-- An error occured, go to the error handler
            IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
			
               CLOSE cPaymentsPrint;
				
               SET v_ErrorMessage = 'GetNextCheckNumber call failed';
				
               CLOSE cPaymentsPrint;

               ROLLBACK;
-- the error handler
               CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Run',v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
         IF v_CheckNumber > 0 then
		
			-- update the paymentsHeader with the check informations
            SET @SWV_Error = 0;
            UPDATE
            PaymentsHeader
            SET
            CheckNumber = CAST(v_CheckNumber AS CHAR(20)),CheckDate = now(),
            CheckPrinted = 0
            WHERE
            CompanyID = v_CompanyID AND
            DivisionID = v_DivisionID AND
            DepartmentID = v_DepartmentID AND
            PaymentID = v_PaymentID;
            IF @SWV_Error <> 0 then
			
               CLOSE cPaymentsPrint;
				
               SET v_ErrorMessage = 'Update PyamentsHeader failed';
				
               CLOSE cPaymentsPrint;

               ROLLBACK;
-- the error handler
               CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Run',v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
               SET SWP_Ret_Value = -1;
            end if;

			-- update the check_print table with the check informations	
            SET @SWV_Error = 0;
            UPDATE
            PaymentChecks
            SET
            CheckNumber = CAST(v_CheckNumber AS CHAR(20))
            WHERE
            CompanyID = v_CompanyID AND
            DivisionID = v_DivisionID AND
            DepartmentID = v_DepartmentID AND
            EmployeeID = v_EmployeeID AND
            PaymentID = v_PaymentID;

			-- if an error occured go tho error hadling area
            IF @SWV_Error <> 0 then
			
               CLOSE cPaymentsPrint;
				
               SET v_ErrorMessage = 'Update Check_Print failed';
				
               CLOSE cPaymentsPrint;

               ROLLBACK;
-- the error handler
               CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Run',v_ErrorMessage,v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
               SET SWP_Ret_Value = -1;
            end if;
         end if;
      ELSE
		-- update the check_print table with the check informations	
         SET @SWV_Error = 0;
         UPDATE
         PaymentChecks
         SET
         CheckNumber = v_PaymentCheckNumber
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         EmployeeID = v_EmployeeID AND
         PaymentID = v_PaymentID;

		-- if an error occured go tho error hadling area
         IF @SWV_Error <> 0 then
		
            CLOSE cPaymentsPrint;
			
            SET v_ErrorMessage = 'Update Check_Print failed';
			
            CLOSE cPaymentsPrint;

            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Run',v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH cPaymentsPrint INTO v_PaymentID,v_VendorID,v_GLBankAccount;
   END WHILE;

   CLOSE cPaymentsPrint;


-- Everything is OK
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).

   CLOSE cPaymentsPrint;


   ROLLBACK;
-- the error handler
   CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Run',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);


   SET SWP_Ret_Value = -1;
END;














//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS PaymentCheck_PrintInsert;
//
CREATE       PROCEDURE PaymentCheck_PrintInsert(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN


/*
Name of stored procedure: PaymentCheck_PrintInsert
Method: 
	Inserts specified payment to the PaymentChecks table for futher processing

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@EmployeeID NVARCHAR(36)	 - the ID of the employee that performs the operation
	@PaymentID NVARCHAR(36)		 - the ID of the payment

Output Parameters:

	NONE

Called From:

	PaymentCheck_PrintInsert.vb

Calls:

	Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
       SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT
   EmployeeID
   FROM
   PayrollEmployees
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   EmployeeID = v_EmployeeID) then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF NOT EXISTS(SELECT
   PaymentID
   FROM
   PaymentsHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID AND
   Posted = 1 AND
   IFNULL(Paid,0) = 0 AND
   IFNULL(CheckPrinted,0) = 0 AND
   ApprovedForPayment = 1) then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF EXISTS(SELECT
   PaymentID
   FROM
   PaymentChecks
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID AND
   EmployeeID = v_EmployeeID) then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   START TRANSACTION;

   SET @SWV_Error = 0;
   INSERT INTO PaymentChecks(CompanyID,
		DivisionID,
		DepartmentID,
		EmployeeID,
		PaymentID,
		CheckNumber,
		VendorID,
		Amount,
		GLBankAccount,
		CurrencyID)
   SELECT
   v_CompanyID,
		v_DivisionID,
		v_DepartmentID,
		v_EmployeeID,
		PaymentID,
		CheckNumber,
		VendorID,
		CASE WHEN IFNULL(CreditAmount,0) = 0 THEN IFNULL(Amount,0) ELSE CreditAmount END,
		GLBankAccount,
		CurrencyID
   FROM
   PaymentsHeader
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;	


	
   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error Inserting Data';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_PrintInsert',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;

   SET @SWV_Error = 0;
   UPDATE
   PaymentsHeader
   SET
   SelectedForPayment = 1,SelectedForPaymentDate = now()
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;	

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Error updating Data';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_PrintInsert',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
      SET SWP_Ret_Value = -1;
   end if;


-- Everything is OK
   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;


-- if an error occured in the procedure this code will be executed
-- The information about the error are entered in the ErrrorLog and ErrorLogDetail tables.
-- The company, division, department informations are inserted in the ErrorLog table
-- along with information about the name of the procedure and the error message and an errorID is obtained.
-- The aditional information about other procedure parameters are inserted along with the errorID in the ErrorLogDetail table
-- (about the other parameters the name and the value are inserted).
   ROLLBACK;
-- the error handler
   CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_PrintInsert',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);

   SET SWP_Ret_Value = -1;
END;




//

DELIMITER ;
