update databaseinfo set value='2019_06_06',lastupdate=now() WHERE id='Version';
DELIMITER //
DROP PROCEDURE IF EXISTS AuditInsert;
//
CREATE  PROCEDURE AuditInsert(v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_DocumentType NATIONAL VARCHAR(50),
	v_TransactionNumber NATIONAL VARCHAR(50),
	v_TransactionLineNumber NATIONAL VARCHAR(50),
	v_TableAffected NATIONAL VARCHAR(50),
	v_FieldChanged NATIONAL VARCHAR(50),
	v_OldValue NATIONAL VARCHAR(250),
	v_NewValue NATIONAL VARCHAR(250))
BEGIN


/*
Name of stored procedure: AuditInsert
Method: 
	Insert record to AuditTrail table

Date Created: EDE - 07/28/2015

Input Parameters:

	@CompanyID NVARCHAR(36)		 - the ID of company
	@DivisionID NVARCHAR(36)	 - the ID of division
	@DepartmentID NVARCHAR(36)	 - the ID of department
	@DocumentType NVARCHAR(50)
	@TransactionNumber NVARCHAR(50)
	@TransactionLineNumber NVARCHAR(50)
	@TableAffected NVARCHAR(50)
	@FieldChanged NVARCHAR(50)
	@OldValue NVARCHAR(250)
	@NewValue NVARCHAR(250)

Output Parameters:

	NONE

Called From:

	NONE

Calls:

	NONE

Last Modified: 

Last Modified By: 

Revision History: 

*/



   DECLARE v_EmployeeID NATIONAL VARCHAR(36);
   DECLARE v_EntryDate DATETIME;

   IF v_OldValue <> v_NewValue then
	
      SET v_EntryDate = CURRENT_TIMESTAMP;
/*      CALL GetActiveEmployee(v_EmployeeID);*/
      SET v_EmployeeID = @EmployeeID;
      IF v_EmployeeID IS NULL OR v_EmployeeID = '' then
         SET v_EmployeeID = '?';
      end if;
      INSERT INTO AuditTrail(CompanyID,
			DivisionID,
			DepartmentID,
			EmployeeID,
			EntryDate,
			EntryTime,
			DocumentType,
			TransactionNumber,
			TransactionLineNumber,
			TableAffected,
			FieldChanged,
			OldValue,
			NewValue)
		VALUES(v_CompanyID,
			v_DivisionID,
			v_DepartmentID,
			v_EmployeeID,
			v_EntryDate,
			v_EntryDate,
			v_DocumentType,
			v_TransactionNumber,
			v_TransactionLineNumber,
			v_TableAffected,
			v_FieldChanged,
			v_OldValue,
			v_NewValue);
   end if;


END;



//

DELIMITER ;