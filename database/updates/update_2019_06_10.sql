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

DELIMITER //
DROP PROCEDURE IF EXISTS PaymentCheck_PostAllChecks;
//
CREATE      PROCEDURE PaymentCheck_PostAllChecks(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN











/*
Name of stored procedure: PaymentCheck_PostAllChecks
Method: 
	Posts all payment checks prepared for posting

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@EmployeeID NVARCHAR(36)	 - the ID of the employee that performs the operation

Output Parameters:

	NONE

Called From:

	PaymentsCheck_PostAllChecks.vb

Calls:

	PaymentCheck_Post, PaymentCheck_Printed, PaymentCheck_PrintDelete, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_PaymentID NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cPaymentsPrint CURSOR FOR
   SELECT DISTINCT
   PaymentID
   FROM
   PaymentChecks
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   EmployeeID = v_EmployeeID;

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;

-- declare a cursor for the payments ready to be printed ordered by the vendorID
   OPEN cPaymentsPrint;
   SET NO_DATA = 0;
   FETCH cPaymentsPrint INTO v_PaymentID;

   WHILE NO_DATA = 0 DO
      SET @SWV_Error = 0;
      CALL PaymentCheck_Post2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentID, v_ReturnStatus);
	-- An error occured, go to the error handler
      IF @SWV_Error <> 0 OR v_ReturnStatus <> 0 then
	
         CLOSE cPaymentsPrint;
		
         SET v_ErrorMessage = 'PaymentCheck_Post call failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,'','','PaymentsCheck_PostAllChecks',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
         SET SWP_Ret_Value = -1;
      end if;
      SET @SWV_Error = 0;
      CALL PaymentCheck_Printed2(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PaymentID, v_ReturnStatus);
	-- An error occured, go to the error handler
      IF @SWV_Error <> 0 OR v_ReturnStatus <> 0 then
	
         CLOSE cPaymentsPrint;
		
         SET v_ErrorMessage = 'PaymentCheck_Printed call failed';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,'','','PaymentsCheck_PostAllChecks',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cPaymentsPrint INTO v_PaymentID;
   END WHILE;

   CLOSE cPaymentsPrint;



   SET @SWV_Error = 0;
   CALL PaymentCheck_PrintDelete2(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID, v_ReturnStatus);
-- An error occured, go to the error handler
   IF @SWV_Error <> 0 OR v_ReturnStatus <> 0 then

      SET v_ErrorMessage = 'PaymentCheck_Delete call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,'','','PaymentsCheck_PostAllChecks',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
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
   CALL Error_InsertError(v_CompanyID,'','','PaymentsCheck_PostAllChecks',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);


   SET SWP_Ret_Value = -1;
END;










//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS PaymentCheck_Post2;
//
CREATE            PROCEDURE PaymentCheck_Post2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN
















/*
Name of stored procedure: PaymentCheck_Post
Method: 
	Posts payment to General Ledger and 
	performs all other needed action to register payment in the proper way

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of the company
	@DivisionID NVARCHAR(36)	 - the ID of the division
	@DepartmentID NVARCHAR(36)	 - the ID of the department
	@PaymentID NVARCHAR(36)		 - the ID of the payment

Output Parameters:

	NONE

Called From:

	PaymentCheck_PostAllChecks

Calls:

	PaymentCheck_CreateGLTransaction, VendorFinancials_Recalc, Project_Recalc, Payment_AdjustVendorFinancials, VendorFinancials_UpdateAging, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ReturnStatus SMALLINT;

   DECLARE v_CurrencyID NATIONAL VARCHAR(3);
   DECLARE v_CurrencyExchangeRate FLOAT;
   DECLARE v_AppliedAmount DECIMAL(19,4);
   DECLARE v_DocumentNumber NATIONAL VARCHAR(36);
   DECLARE v_CheckDate DATETIME;
   DECLARE v_PostDate NATIONAL VARCHAR(1);
   DECLARE v_CheckNumber NATIONAL VARCHAR(20);
   DECLARE v_VendorID NATIONAL VARCHAR(36);
   DECLARE v_PurchaseCurrencyExchangeRate FLOAT;
   DECLARE v_BalanceDue DECIMAL(19,4);
   DECLARE v_PurchaseCurrencyID NATIONAL VARCHAR(3);


   DECLARE v_ProjectID NATIONAL VARCHAR(36);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cPayment CURSOR FOR
   SELECT
   IFNULL(PaymentsHeader.CurrencyID,N''),
		IFNULL(PaymentsHeader.CurrencyExchangeRate,1),
		PaymentsDetail.DocumentNumber,
		IFNULL(PaymentsDetail.AppliedAmount,0)
   FROM
   PaymentsDetail INNER JOIN PaymentChecks ON
   PaymentsDetail.CompanyID = PaymentChecks.CompanyID AND
   PaymentsDetail.DivisionID = PaymentChecks.DivisionID AND
   PaymentsDetail.DepartmentID = PaymentChecks.DepartmentID AND
   PaymentsDetail.PaymentID = PaymentChecks.PaymentID 
   LEFT JOIN PaymentsHeader ON
   PaymentsDetail.PaymentID = PaymentsHeader.PaymentID AND
   PaymentsDetail.CompanyID = PaymentsHeader.CompanyID AND
   PaymentsDetail.DivisionID = PaymentsHeader.DivisionID AND
   PaymentsDetail.DepartmentID = PaymentsHeader.DepartmentID AND
   PaymentsHeader.CheckDate = v_CheckDate
   WHERE
   PaymentsHeader.CompanyID = v_CompanyID AND
   PaymentsHeader.DivisionID = v_DivisionID AND
   PaymentsHeader.DepartmentID = v_DepartmentID AND
   PaymentsHeader.PaymentID = v_PaymentID;			





   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   IF NOT EXISTS(SELECT
   PaymentsHeader.PaymentID
   FROM
   PaymentsHeader
   INNER JOIN PaymentsDetail ON
   PaymentsHeader.CompanyID = PaymentsDetail.CompanyID AND
   PaymentsHeader.DivisionID = PaymentsDetail.DivisionID AND
   PaymentsHeader.DepartmentID = PaymentsDetail.DepartmentID AND
   PaymentsHeader.PaymentID = PaymentsDetail.PaymentID
   WHERE
   PaymentsHeader.CompanyID = v_CompanyID AND
   PaymentsHeader.DivisionID = v_DivisionID AND
   PaymentsHeader.DepartmentID = v_DepartmentID AND
   PaymentsHeader.PaymentID = v_PaymentID AND
   IFNULL(PaymentsHeader.CheckNumber,N'') <> N'' AND
   IFNULL(PaymentsHeader.CheckPrinted,0) = 0 AND
   IFNULL(PaymentsHeader.Paid,0) = 0 AND
   IFNULL(PaymentsDetail.AppliedAmount,0) > 0) then

      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(DefaultGLPostingDate,'1') INTO v_PostDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   START TRANSACTION;

	-- post payment to LedgerTransactions table
   SET @SWV_Error = 0;
   CALL PaymentCheck_CreateGLTransaction(v_CompanyID,v_DivisionID,v_DepartmentID,v_PaymentID,v_PostDate, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then
	
      SET v_ErrorMessage = 'PaymentCheck_CreateGLTransaction call failed';
      ROLLBACK;


-- the error handler
      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CheckNumber',v_CheckNumber);
      SET SWP_Ret_Value = -1;
   end if; 


   select   CheckDate, CheckNumber, VendorID INTO v_CheckDate,v_CheckNumber,v_VendorID FROM
   PaymentsHeader WHERE
   PaymentsHeader.CompanyID = v_CompanyID AND
   PaymentsHeader.DivisionID = v_DivisionID AND
   PaymentsHeader.DepartmentID = v_DepartmentID AND
   PaymentsHeader.PaymentID = v_PaymentID;			


   OPEN cPayment;

   SET NO_DATA = 0;
   FETCH cPayment INTO v_CurrencyID,v_CurrencyExchangeRate,v_DocumentNumber,v_AppliedAmount;


   WHILE NO_DATA = 0 DO
      select   IFNULL(CurrencyID,N''), IFNULL(CurrencyExchangeRate,1), IFNULL(BalanceDue,0) INTO v_PurchaseCurrencyID,v_PurchaseCurrencyExchangeRate,v_BalanceDue FROM
      PurchaseHeader WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PurchaseNumber = v_DocumentNumber;
      SET @SWV_Error = 0;
      IF ROW_COUNT() <> 0 then
	
         IF v_PurchaseCurrencyID <> v_CurrencyID then
            SET v_AppliedAmount =  fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,(v_PurchaseCurrencyExchangeRate/v_CurrencyExchangeRate)*v_AppliedAmount,v_CurrencyID);
         end if;
         SET v_BalanceDue = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_BalanceDue -v_AppliedAmount,v_CurrencyID);
         UPDATE
         PurchaseHeader
         SET
         AmountPaid = IFNULL(AmountPaid,0)+v_AppliedAmount,BalanceDue = v_BalanceDue,
         CheckNumber = v_CheckNumber,CheckDate = v_CheckDate,PaidDate = CURRENT_TIMESTAMP,
         Paid =(CASE
         WHEN ABS(v_BalanceDue) <= 0.005 THEN 1
         ELSE 0
         END)
         WHERE
         CompanyID = v_CompanyID AND
         DivisionID = v_DivisionID AND
         DepartmentID = v_DepartmentID AND
         PurchaseNumber = v_DocumentNumber;
      end if;
      IF @SWV_Error <> 0 then
	
         CLOSE cPayment;
		
         SET v_ErrorMessage = 'Update PurchaseHeader failed';
         ROLLBACK;


-- the error handler
         CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Post',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CheckNumber',v_CheckNumber);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH cPayment INTO v_CurrencyID,v_CurrencyExchangeRate,v_DocumentNumber,v_AppliedAmount;
   END WHILE;

   CLOSE cPayment;


   SET @SWV_Error = 0;
   SET v_ReturnStatus = VendorFinancials_ReCalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_VendorID);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'VendorFinancials_Recalc call failed';
      ROLLBACK;


-- the error handler
      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CheckNumber',v_CheckNumber);
      SET SWP_Ret_Value = -1;
   end if;

   select   ProjectID INTO v_ProjectID FROM PaymentsDetail WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID AND
   NOT ProjectID IS NULL   LIMIT 1;

-- Update fields in Projects table
   SET @SWV_Error = 0;
   CALL Project_Recalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_ProjectID, v_ReturnStatus);
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'Project_ReCalc call failed';
      ROLLBACK;


-- the error handler
      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Post',v_ErrorMessage,v_ErrorID);
      CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CheckNumber',v_CheckNumber);
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
   CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Post',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'CheckNumber',v_CheckNumber);

   SET SWP_Ret_Value = -1;
END;

































//

DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS PaymentCheck_Printed2;
//
CREATE              PROCEDURE PaymentCheck_Printed2(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PaymentID NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT)
   SWL_return:
BEGIN






/*
Name of stored procedure: PaymentCheck_Printed
Method: 
	Markes payment check as printed

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

	PaymentCheck_PostAllChecks

Calls:

	VendorFinancials_Recalc, Error_InsertError, Error_InsertErrorDetail

Last Modified: 

Last Modified By: 

Revision History: 

*/

   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_VendorID NATIONAL VARCHAR(36);

   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   START TRANSACTION;

   UPDATE
   PaymentChecks
   SET
   Printed = 1
   WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   EmployeeID = v_EmployeeID AND
   PaymentID = v_PaymentID;

-- update Payments header only if PayemntChecks was updated	
   IF ROW_COUNT() <> 0 then
	
      SET @SWV_Error = 0;
      UPDATE
      PaymentsHeader
      SET
      CheckPrinted = 1,Paid = 1
      WHERE
      CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID AND
      PaymentID = v_PaymentID;
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Error Updating Data in PaymentsHeader';
         ROLLBACK;
-- the error handler
         CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Printed',v_ErrorMessage,v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
         SET SWP_Ret_Value = -1;
      ELSE
         IF @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'Error Updating Data in PaymentsHeader';
            ROLLBACK;
-- the error handler
            CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Printed',v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);
            SET SWP_Ret_Value = -1;
         end if;
      end if;
   end if;

   select   VendorID INTO v_VendorID FROM
   PaymentsHeader WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   PaymentID = v_PaymentID;			

   SET v_ReturnStatus = VendorFinancials_ReCalc2(v_CompanyID,v_DivisionID,v_DepartmentID,v_VendorID);
   Set v_ReturnStatus = 1;
   IF @SWV_Error <> 0 OR v_ReturnStatus = -1 then

	-- the procedure will return an error code
      SET v_ErrorMessage = 'VendorFinancials_Recalc call failed';
      ROLLBACK;
-- the error handler
      CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Printed',v_ErrorMessage,v_ErrorID);
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
   CALL Error_InsertError(v_CompanyID,'','','PaymentCheck_Printed',v_ErrorMessage,v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PaymentID',v_PaymentID);

   SET SWP_Ret_Value = -1;
END;

















//

DELIMITER ;
