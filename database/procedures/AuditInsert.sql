CREATE PROCEDURE AuditInsert (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_DocumentType NATIONAL VARCHAR(50),
	v_TransactionNumber NATIONAL VARCHAR(50),
	v_TransactionLineNumber NATIONAL VARCHAR(50),
	v_TableAffected NATIONAL VARCHAR(50),
	v_FieldChanged NATIONAL VARCHAR(50),
	v_OldValue NATIONAL VARCHAR(250),
	v_NewValue NATIONAL VARCHAR(250)) BEGIN






   DECLARE v_EmployeeID NATIONAL VARCHAR(36);
   DECLARE v_EntryDate DATETIME;

   IF v_OldValue <> v_NewValue then
	
      SET v_EntryDate = CURRENT_TIMESTAMP;

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


END