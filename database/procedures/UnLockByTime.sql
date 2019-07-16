CREATE PROCEDURE UnLockByTime (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_UnlockTimeMinute INT,INOUT SWP_Ret_Value INT) BEGIN

   DECLARE v_Sql VARCHAR(8000);

   DECLARE v_TableName NATIONAL VARCHAR(64);
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cTables CURSOR
   FOR SELECT TABLE_NAME FROM `TABLES` 
   WHERE TABLE_TYPE = 'BASE TABLE'
   AND TABLE_NAME <> 'LedgerStoredChartOfAccounts'
   AND TABLE_NAME <> 'Translation'
   AND TABLE_NAME <> 'dtproperties'
   AND TABLE_NAME NOT LIKE '%History'
   ORDER BY TABLE_NAME;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;


   OPEN cTables;
   SET NO_DATA = 0;
   FETCH cTables INTO v_TableName;
   WHILE NO_DATA = 0 DO
      IF EXISTS(SELECT * FROM syscolumns WHERE syscolumns.id = object_id(v_TableName) AND syscolumns.name = N'LockedBy') AND
      EXISTS(SELECT * FROM syscolumns WHERE syscolumns.id = object_id(v_TableName) AND syscolumns.name = N'LockTS') then
		
         SET v_Sql = CONCAT('UPDATE ',v_TableName,' SET ');
         SET v_Sql = CONCAT(v_Sql,'LockedBy = NULL, LockTS = NULL ');
         SET v_Sql = CONCAT(v_Sql,'WHERE CompanyID = '',v_CompanyID,'' AND ');
         SET v_Sql = CONCAT(v_Sql,'DivisionID = '',v_DivisionID,'' AND ');
         SET v_Sql = CONCAT(v_Sql,'DepartmentID = '',v_DepartmentID,'' AND ');
         SET v_Sql = CONCAT(v_Sql,'DATEDIFF(minute, LockTS, GETDATE()) > ',CAST(v_UnlockTimeMinute AS CHAR(32)),
         ' AND ');
         SET v_Sql = CONCAT(v_Sql,'(NOT LockedBy IS NULL OR NOT LockTS IS NULL) ');
         SET @SWV_Stmt = v_Sql;
         PREPARE SWT_Stmt FROM @SWV_Stmt;
         EXECUTE SWT_Stmt;
         DEALLOCATE PREPARE SWT_Stmt;
      ELSE
         
SET @SWV_Null_Var = 0;
      end if;
      SET NO_DATA = 0;
      FETCH cTables INTO v_TableName;
   END WHILE;

   CLOSE cTables;




   SET SWP_Ret_Value =(0);
END