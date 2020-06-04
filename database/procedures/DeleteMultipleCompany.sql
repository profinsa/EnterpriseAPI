CREATE PROCEDURE DeleteMultipleCompany (v_CompanyID NATIONAL VARCHAR(4000),
	INOUT v_Ret INT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN







   DECLARE v_ErrorMessage NATIONAL VARCHAR(4000);
   DECLARE v_Sql NATIONAL VARCHAR(4000);
   DECLARE v_TableName NATIONAL VARCHAR(4000);
   DECLARE v_sColumnName VARCHAR(4000);
   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_ParamDefinition NATIONAL VARCHAR(4000);
   DECLARE cTables CURSOR
   FOR SELECT TABLE_NAME FROM `TABLES`
   WHERE TABLE_TYPE = 'BASE TABLE'
   AND TABLE_NAME <> 'dtproperties'
   ORDER BY TABLE_NAME;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   SET v_CompanyID = 'AMR,Government';

   SET v_Ret = 0;
   
START TRANSACTION;
   OPEN cTables;
   SET NO_DATA = 0;
   FETCH cTables INTO v_TableName;
   WHILE NO_DATA = 0 DO
      IF EXISTS(SELECT * FROM syscolumns
      WHERE syscolumns.id = object_id(CONCAT(N'[dbo].',v_TableName)) AND syscolumns.name = N'CompanyID') then
	
         SET v_Sql = CONCAT('DISABLE TRIGGER ALL ON ',v_TableName,';');
         SET v_Sql = CONCAT(v_Sql,'DELETE FROM ',v_TableName,' WHERE CompanyID IN (',v_CompanyID,
         ');');
         SET v_Sql = CONCAT(v_Sql,'ENABLE TRIGGER ALL ON ',v_TableName,';');
         SET v_ParamDefinition = N'@CompanyID NVARCHAR(MAX)';
         
SET @SWV_Stmt = v_Sql;
         PREPARE SWT_Stmt FROM @SWV_Stmt;
         EXECUTE SWT_Stmt;
         DEALLOCATE PREPARE SWT_Stmt;
         IF @SWV_Error <> 0 then
		
            SET v_ErrorMessage = 'Company deleting failed';
            CLOSE cTables;
			
            ROLLBACK;

            SET v_Ret = 1;
            CALL Error_InsertError(v_CompanyID,N'',N'','DeleteCompany',v_ErrorMessage,v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,N'',N'',v_ErrorID,'','');
            SET SWP_Ret_Value = -1;
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH cTables INTO v_TableName;
   END WHILE;
   CLOSE cTables;


   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;






   ROLLBACK;

   SET v_Ret = 1;
   CALL Error_InsertError(v_CompanyID,N'',N'','DeleteCompany',v_ErrorMessage,v_ErrorID);
   CALL Error_InsertErrorDetail(v_CompanyID,N'',N'',v_ErrorID,'','');
   SET SWP_Ret_Value = -1;
END