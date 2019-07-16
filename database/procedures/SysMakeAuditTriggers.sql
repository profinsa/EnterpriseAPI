CREATE PROCEDURE SysMakeAuditTriggers (v_sTableName VARCHAR(128),
	v_DocumentType VARCHAR(128),
	v_TransactionNumberField VARCHAR(128),
	v_TransactionLineNumberField VARCHAR(128),
	v_ComplexObject BOOLEAN,
	v_IsGenerate BOOLEAN) SWL_return:
BEGIN
   DECLARE v_Count INT;
   DECLARE v_Count_a INT;
   DECLARE v_Count_b INT;
   DECLARE v_Count_c INT;
	
   DECLARE v_sProcText1 VARCHAR(8000);
   DECLARE v_sProcText2 VARCHAR(8000);
   DECLARE v_sProcText3 VARCHAR(8000);
   DECLARE v_sProcText4 VARCHAR(8000);
   DECLARE v_sProcText5 VARCHAR(8000);
   DECLARE v_sProcText6 VARCHAR(8000);
   DECLARE v_sProcText6a VARCHAR(8000);
   DECLARE v_sProcText7 VARCHAR(8000);
   DECLARE v_sProcText8 VARCHAR(8000);
   DECLARE v_sProcText8a VARCHAR(8000);
   DECLARE v_sProcText9 VARCHAR(8000);
   DECLARE v_sProcText10 VARCHAR(8000);
   DECLARE v_sProcText11 VARCHAR(8000);
   DECLARE v_sProcText12 VARCHAR(8000);
   DECLARE v_sProcText13 VARCHAR(8000);
   DECLARE v_sProcText13a VARCHAR(8000);
   DECLARE v_sProcText14 VARCHAR(8000);
   DECLARE v_sProcText15 VARCHAR(8000);
   DECLARE v_sProcText15a VARCHAR(8000);
   DECLARE v_sProcText15b VARCHAR(8000);
   DECLARE v_sProcText15c VARCHAR(8000);
   DECLARE v_sProcText16 VARCHAR(8000);
   DECLARE v_sProcText17 VARCHAR(8000);
   DECLARE v_sProcText18 VARCHAR(8000);
   DECLARE v_sProcText18a VARCHAR(8000);
   DECLARE v_sProcText19 VARCHAR(8000);

   DECLARE v_sKeyFields VARCHAR(2000);
   DECLARE v_sSetClause VARCHAR(2000);
   DECLARE v_sWhereClause VARCHAR(2000);
   DECLARE v_sColumnName VARCHAR(128);
   DECLARE v_nColumnID SMALLINT;
   DECLARE v_bPrimaryKeyColumn BOOLEAN;
   DECLARE v_nAlternateType INT;
   DECLARE v_nColumnLength INT;
   DECLARE v_nColumnPrecision INT;
   DECLARE v_nColumnScale INT;
   DECLARE v_IsNullable BOOLEAN; 
   DECLARE v_IsIdentity INT;
   DECLARE v_sTypeName VARCHAR(128);
   DECLARE v_sDefaultValue VARCHAR(4000);
   DECLARE v_sCRLF CHAR(2);
   DECLARE v_sTAB CHAR(1);

   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE crKeyFields cursor for
   SELECT * FROM	SWT_fnTableColumnInfo
   WHERE sColumnName <> 'LockedBy' AND sColumnName <> 'LockTS'
   ORDER BY 2;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   IF v_IsGenerate is null then
      set v_IsGenerate = 0;
   END IF;
   IF fnTableHasPrimaryKey(v_sTableName) = 0 then
 
      CALL SWP_RaiseError(20000,'Trigger cannot be created on a table with no primary key.');
      LEAVE SWL_return;
   end if;

   SET	v_sTAB = char(9);
   SET v_sCRLF = CONCAT(char(13),char(10));


   SET v_sProcText1 = '';
   SET v_sProcText2 = '';
   SET v_sProcText3 = '';
   SET v_sProcText4 = '';
   SET v_sProcText5 = '';
   SET v_sProcText6 = '';
   SET v_sProcText6a = '';
   SET v_sProcText7 = '';
   SET v_sProcText8 = '';
   SET v_sProcText8a = '';
   SET v_sProcText9 = '';
   SET v_sProcText10 = '';
   SET v_sProcText11 = '';
   SET v_sProcText12 = '';
   SET v_sProcText13 = '';
   SET v_sProcText13a = '';
   SET v_sProcText14 = '';
   SET v_sProcText15 = '';
   SET v_sProcText15a = '';
   SET v_sProcText15b = '';
   SET v_sProcText15c = '';
   SET v_sProcText16 = '';
   SET v_sProcText17 = '';
   SET v_sProcText18 = '';
   SET v_sProcText18a = '';
   SET v_sProcText19 = '';

   SET v_sKeyFields = '';
   SET	v_sSetClause = '';
   SET	v_sWhereClause = '';









   SET 	v_sProcText1 = CONCAT(v_sProcText1,'IF EXISTS (SELECT * FROM sys.triggers ',v_sCRLF); 
   SET 	v_sProcText1 = CONCAT(v_sProcText1,'WHERE object_id = OBJECT_ID(N'[dbo].[',v_sTableName,
   '_Audit_Update]'))',v_sCRLF);
   SET @SWV_Stmt = v_sProcText1;
   PREPARE SWT_Stmt FROM @SWV_Stmt;
   EXECUTE SWT_Stmt;
   DEALLOCATE PREPARE SWT_Stmt;
   SET 	v_sProcText1 = CONCAT('DROP TRIGGER `ISPIRER_HOLE(@sTableName)_Audit_Update` ',v_sCRLF);
   IF v_IsGenerate = 0 then
      SET @SWV_Stmt = v_sProcText1;
      PREPARE SWT_Stmt FROM @SWV_Stmt;
      EXECUTE SWT_Stmt;
      DEALLOCATE PREPARE SWT_Stmt;
      SET 	v_sProcText1 = 'CALL GOISPIRER_HOLE(v_sCRLF);';
   end if;
   SET 	v_sProcText1 = CONCAT(v_sProcText1,v_sCRLF);
   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;

   IF v_IsGenerate = 1 then
      SET @SWV_Stmt = v_sProcText1;
      PREPARE SWT_Stmt FROM @SWV_Stmt;
      EXECUTE SWT_Stmt;
      DEALLOCATE PREPARE SWT_Stmt;
   end if;


   SET 	v_sProcText2 = '';
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'/*',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Name of trigger: ',v_sTableName,'_Audit_Update',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Method:',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'	Trigger is used for logging of update ',v_sTableName,
   ' table',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'	It inserts log records to AuditTrail table',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Date Created: ',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Input Parameters:',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Output Parameters:',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Called From:',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Calls:',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'	AuditInsert',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Last Modified: ',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Last Modified By: ',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Revision History: ',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'*/',v_sCRLF);
   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET 	v_sProcText3 = '';
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'CREATE TRIGGER ',v_sTableName,'_Audit_Update ON ',
   v_sTableName,' FOR UPDATE',v_sCRLF);
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'AS',v_sCRLF);
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'BEGIN',v_sCRLF);
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'-- check for audit triggers switch off',v_sCRLF);
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'DECLARE @Context VARBINARY(128)',v_sCRLF);
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'SELECT @Context = context_info FROM master.dbo.sysprocesses',
   v_sCRLF);
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'WHERE spid = @@SPID',v_sCRLF);
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'IF CAST(@Context AS NVARCHAR(36)) = N'$$AuditSwitchOff$$' RETURN',
   v_sCRLF);

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET 	v_sProcText4 = '';
   SET 	v_sProcText4 = CONCAT(v_sProcText4,v_sCRLF);
   SET 	v_sProcText4 = CONCAT(v_sProcText4,'-- declarations',v_sCRLF);
   SET 	v_sProcText4 = CONCAT(v_sProcText4,'DECLARE @TransactionNumber_O NVARCHAR(50)',v_sCRLF);
   SET 	v_sProcText4 = CONCAT(v_sProcText4,'DECLARE @TransactionNumber_N NVARCHAR(50)',v_sCRLF);
   SET 	v_sProcText4 = CONCAT(v_sProcText4,'DECLARE @TransactionLineNumber NVARCHAR(50)',v_sCRLF);

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;



   SET 	v_sProcText5 = '';
   SET 	v_sProcText5 = CONCAT(v_sProcText5,v_sCRLF);

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 1) then
		
         SET v_sProcText5 = CONCAT(v_sProcText5,'DECLARE @',v_sColumnName,' ',v_sTypeName);
         IF (v_nAlternateType = 2) then 
            SET v_sProcText5 =  CONCAT(v_sProcText5,'(',CAST(v_nColumnPrecision AS CHAR(3)),', ',CAST(v_nColumnScale AS CHAR(3)),
            ')');
         ELSE 
            IF (v_nAlternateType = 1) then 
               SET v_sProcText5 =  CONCAT(v_sProcText5,'(',CAST(v_nColumnLength/2 AS CHAR(4)),')');
            end if;
         end if;
         SET 	v_sProcText5 = CONCAT(v_sProcText5,v_sCRLF);
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET		v_Count = 0;
   SET 	v_sProcText6 = '';
   SET 	v_sProcText6 = CONCAT(v_sProcText6,v_sCRLF);



   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   SWL_Label2:
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 0 AND v_sTypeName <> 'text' AND v_sTypeName <> 'ntext') then
		
         IF LENGTH(v_sProcText6) > 7900 then
            LEAVE SWL_Label2;
         end if;

			
         SET v_sProcText6 = CONCAT(v_sProcText6,'DECLARE @',v_sColumnName,'_O NVARCHAR(80)',v_sCRLF);
         SET v_sProcText6 = CONCAT(v_sProcText6,'DECLARE @',v_sColumnName,'_N NVARCHAR(80)',v_sCRLF);
			
			
         SET v_Count = v_Count+1;
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET		v_Count_a = 0;
   SET 	v_sProcText6a = '';
   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 0 AND v_sTypeName <> 'text' AND v_sTypeName <> 'ntext') then
		
         IF v_Count_a >= v_Count then
				
            SET v_sProcText6a = CONCAT(v_sProcText6a,'DECLARE @',v_sColumnName,'_O NVARCHAR(80)',v_sCRLF);
            SET v_sProcText6a = CONCAT(v_sProcText6a,'DECLARE @',v_sColumnName,'_N NVARCHAR(80)',v_sCRLF);
         end if;
         SET v_Count_a = v_Count_a+1;
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;





   SET 	v_sProcText7 = '';
   SET 	v_sProcText7 = CONCAT(v_sProcText7,v_sCRLF);
   SET 	v_sProcText7 = CONCAT(v_sProcText7,'-- updating records cursor declaration',v_sCRLF);
   SET 	v_sProcText7 = CONCAT(v_sProcText7,'DECLARE cUpdate CURSOR',v_sCRLF);
   SET 	v_sProcText7 = CONCAT(v_sProcText7,v_sTAB,'FOR SELECT',v_sCRLF);

   IF v_TransactionNumberField IS NULL then
	
      SET 	v_sProcText7 = CONCAT(v_sProcText7,v_sTAB,v_sTAB,' ''',v_sCRLF);
      SET 	v_sProcText7 = CONCAT(v_sProcText7,v_sTAB,v_sTAB,',''',v_sCRLF);
   ELSE
      SET 	v_sProcText7 = CONCAT(v_sProcText7,v_sTAB,v_sTAB,' d.',v_TransactionNumberField,v_sCRLF);
      SET 	v_sProcText7 = CONCAT(v_sProcText7,v_sTAB,v_sTAB,',i.',v_TransactionNumberField,v_sCRLF);
   end if;
   SET 	v_sProcText7 = CONCAT(v_sProcText7,v_sTAB,v_sTAB,IFNULL(CONCAT(',i.',v_TransactionLineNumberField),','''),
   v_sCRLF);
   SET 	v_sProcText7 = CONCAT(v_sProcText7,v_sCRLF);

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 1) then
		
         SET v_sProcText7 = CONCAT(v_sProcText7,v_sTAB,v_sTAB,',i.',v_sColumnName,v_sCRLF);
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET		v_Count = 0;
   SET 	v_sProcText8 = '';
   SET 	v_sProcText8 = CONCAT(v_sProcText8,v_sCRLF);



   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   SWL_Label5:
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 0 AND v_sTypeName <> 'text' AND v_sTypeName <> 'ntext') then
		
         IF LENGTH(v_sProcText8) > 7900 then
            LEAVE SWL_Label5;
         end if;

			
			  
         SET v_sProcText8 = CONCAT(v_sProcText8,',CAST(d.',v_sColumnName,' AS NVARCHAR(80))',v_sCRLF);
			  
         SET v_sProcText8 = CONCAT(v_sProcText8,',CAST(i.',v_sColumnName,' AS NVARCHAR(80))',v_sCRLF);
			
			
         SET v_Count = v_Count+1;
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;




   SET		v_Count_a = 0;
   SET 	v_sProcText8a = '';

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 0 AND v_sTypeName <> 'text' AND v_sTypeName <> 'ntext') then
		
         IF v_Count_a >= v_Count then
				
					  
            SET v_sProcText8a = CONCAT(v_sProcText8a,',CAST(d.',v_sColumnName,' AS NVARCHAR(80))',v_sCRLF);
					  
            SET v_sProcText8a = CONCAT(v_sProcText8a,',CAST(i.',v_sColumnName,' AS NVARCHAR(80))',v_sCRLF);
         end if;
         SET v_Count_a = v_Count_a+1;
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;



   SET 	v_sProcText9 = '';
   SET 	v_sProcText9 = CONCAT(v_sProcText9,v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,v_sTAB,'FROM',v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,v_sTAB,v_sTAB,'inserted i',v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,v_sTAB,v_sTAB,'LEFT OUTER JOIN deleted d ON',v_sCRLF);

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET 	v_sProcText10 = '';

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 1) then
		
         IF v_sProcText10 = '' then
            SET v_sProcText10 = CONCAT(v_sProcText10,v_sTAB,v_sTAB,v_sTAB,'    d.',v_sColumnName,' = i.',
            v_sColumnName,v_sCRLF);
         ELSE
            SET v_sProcText10 = CONCAT(v_sProcText10,v_sTAB,v_sTAB,v_sTAB,'AND d.',v_sColumnName,' = i.',
            v_sColumnName,v_sCRLF);
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;



   SET 	v_sProcText11 = '';
   SET 	v_sProcText11 = CONCAT(v_sProcText11,v_sCRLF);
   SET 	v_sProcText11 = CONCAT(v_sProcText11,'OPEN cUpdate',v_sCRLF);
   SET 	v_sProcText11 = CONCAT(v_sProcText11,'-- fetch from each updating record',v_sCRLF);
   SET 	v_sProcText11 = CONCAT(v_sProcText11,'FETCH NEXT FROM cUpdate INTO',v_sCRLF);
   SET 	v_sProcText11 = CONCAT(v_sProcText11,v_sTAB,' @TransactionNumber_O',v_sCRLF);
   SET 	v_sProcText11 = CONCAT(v_sProcText11,v_sTAB,',@TransactionNumber_N',v_sCRLF);
   SET 	v_sProcText11 = CONCAT(v_sProcText11,v_sTAB,',@TransactionLineNumber',v_sCRLF);
   SET 	v_sProcText11 = CONCAT(v_sProcText11,v_sCRLF);

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET v_sProcText12 = '';

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 1) then
		
			
         SET v_sProcText12 = CONCAT(v_sProcText12,v_sTAB,',@',v_sColumnName,v_sCRLF);
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;



   SET		v_Count = 0;
   SET 	v_sProcText13 = '';
   SET 	v_sProcText13 = CONCAT(v_sProcText13,v_sCRLF);



   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   SWL_Label9:
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 0 AND v_sTypeName <> 'text' AND v_sTypeName <> 'ntext') then
		
         IF LENGTH(v_sProcText13) > 7900 then
            LEAVE SWL_Label9;
         end if;

			
			  
         SET v_sProcText13 = CONCAT(v_sProcText13,',@',v_sColumnName,'_O',v_sCRLF);
			  
         SET v_sProcText13 = CONCAT(v_sProcText13,',@',v_sColumnName,'_N',v_sCRLF);
			
			
         SET v_Count = v_Count+1;
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET		v_Count_a = 0;
   SET 	v_sProcText13a = '';

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 0 AND v_sTypeName <> 'text' AND v_sTypeName <> 'ntext') then
		
         IF v_Count_a >= v_Count then
				
					  
            SET v_sProcText13a = CONCAT(v_sProcText13a,',@',v_sColumnName,'_O',v_sCRLF);
					  
            SET v_sProcText13a = CONCAT(v_sProcText13a,',@',v_sColumnName,'_N',v_sCRLF);
         end if;
         SET v_Count_a = v_Count_a+1;
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;





   SET 	v_sProcText14 = '';
   SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sCRLF);
   SET 	v_sProcText14 = CONCAT(v_sProcText14,'WHILE @@FETCH_STATUS = 0',v_sCRLF);
   SET 	v_sProcText14 = CONCAT(v_sProcText14,'BEGIN',v_sCRLF);
   SET 	v_sProcText14 = CONCAT(v_sProcText14,'-- insert audit records for each changed field',
   v_sCRLF);
   IF v_ComplexObject = 1 then
	
      SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sTAB,'IF dbo.IsGuid(@TransactionNumber_N) = 0',
      v_sCRLF);
      SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sTAB,v_sTAB,'BEGIN',v_sCRLF);
      SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sTAB,v_sTAB,v_sTAB,'IF @TransactionNumber_O IS NULL',
      v_sCRLF);
      SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sTAB,v_sTAB,v_sTAB,v_sTAB,'BEGIN',v_sCRLF);
      SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sTAB,v_sTAB,v_sTAB,v_sTAB,'EXEC enterprise.AuditInsert',
      v_sCRLF);
      SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sTAB,v_sTAB,v_sTAB,v_sTAB,'@CompanyID, @DivisionID, @DepartmentID,',
      v_sCRLF);
      SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sTAB,v_sTAB,v_sTAB,v_sTAB,''',v_DocumentType,'',',
      v_sCRLF);
      SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sTAB,v_sTAB,v_sTAB,v_sTAB,'@TransactionNumber_N,',
      v_sCRLF);
      SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sTAB,v_sTAB,v_sTAB,v_sTAB,'@TransactionLineNumber,',
      v_sCRLF);
      SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sTAB,v_sTAB,v_sTAB,v_sTAB,''',v_sTableName,'', 'New Record',',
      v_sCRLF);
      SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sTAB,v_sTAB,v_sTAB,v_sTAB,''', 'New Record'',
      v_sCRLF);
      SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sTAB,v_sTAB,v_sTAB,v_sTAB,'END',v_sCRLF);
      SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sTAB,v_sTAB,v_sTAB,'ELSE',v_sCRLF);
      SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sTAB,v_sTAB,v_sTAB,v_sTAB,'BEGIN',v_sCRLF);
      SET 	v_sProcText14 = CONCAT(v_sProcText14,v_sCRLF);
   end if;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET		v_Count = 0;
   SET v_sProcText15 = '';

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   SWL_Label11:
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 0 AND v_sTypeName <> 'text' AND v_sTypeName <> 'ntext') then
		
         IF LENGTH(v_sProcText15) > 7750 then
            LEAVE SWL_Label11;
         end if;

			
         SET v_sProcText15 = CONCAT(v_sProcText15,v_sCRLF);
         SET v_sProcText15 = CONCAT(v_sProcText15,'EXEC enterprise.AuditInsert',v_sCRLF);
         SET v_sProcText15 = CONCAT(v_sProcText15,'@CompanyID,@DivisionID,@DepartmentID,',v_sCRLF);
         SET v_sProcText15 = CONCAT(v_sProcText15,''',v_DocumentType,'',',v_sCRLF);
         SET v_sProcText15 = CONCAT(v_sProcText15,'@TransactionNumber_N,',v_sCRLF);
         SET v_sProcText15 = CONCAT(v_sProcText15,'@TransactionLineNumber,',v_sCRLF);
         SET v_sProcText15 = CONCAT(v_sProcText15,''',v_sTableName,'','',v_sColumnName,'',',v_sCRLF);
         SET v_sProcText15 = CONCAT(v_sProcText15,'@',v_sColumnName,'_O,',v_sCRLF);
         SET v_sProcText15 = CONCAT(v_sProcText15,'@',v_sColumnName,'_N',v_sCRLF);
			
			
         SET v_Count = v_Count+1;
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET		v_Count_a = 0;
   SET v_sProcText15a = '';

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   SWL_Label12:
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 0 AND v_sTypeName <> 'text' AND v_sTypeName <> 'ntext') then
		
         IF LENGTH(v_sProcText15a) > 7750 then
            LEAVE SWL_Label12;
         end if;
         IF v_Count_a >= v_Count then
				
            SET v_sProcText15a = CONCAT(v_sProcText15a,v_sCRLF);
            SET v_sProcText15a = CONCAT(v_sProcText15a,'EXEC enterprise.AuditInsert',v_sCRLF);
            SET v_sProcText15a = CONCAT(v_sProcText15a,'@CompanyID,@DivisionID,@DepartmentID,',v_sCRLF);
            SET v_sProcText15a = CONCAT(v_sProcText15a,''',v_DocumentType,'',',v_sCRLF);
            SET v_sProcText15a = CONCAT(v_sProcText15a,'@TransactionNumber_N,',v_sCRLF);
            SET v_sProcText15a = CONCAT(v_sProcText15a,'@TransactionLineNumber,',v_sCRLF);
            SET v_sProcText15a = CONCAT(v_sProcText15a,''',v_sTableName,'','',v_sColumnName,'',',v_sCRLF);
            SET v_sProcText15a = CONCAT(v_sProcText15a,'@',v_sColumnName,'_O,',v_sCRLF);
            SET v_sProcText15a = CONCAT(v_sProcText15a,'@',v_sColumnName,'_N',v_sCRLF);
         end if;
         SET v_Count_a = v_Count_a+1;
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;



   SET		v_Count_b = 0;
   SET v_sProcText15b = '';

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   SWL_Label13:
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 0 AND v_sTypeName <> 'text' AND v_sTypeName <> 'ntext') then
		
         IF LENGTH(v_sProcText15b) > 7750 then
            LEAVE SWL_Label13;
         end if;
         IF v_Count_b >= v_Count_a then
				
            SET v_sProcText15b = CONCAT(v_sProcText15b,v_sCRLF);
            SET v_sProcText15b = CONCAT(v_sProcText15b,'EXEC enterprise.AuditInsert',v_sCRLF);
            SET v_sProcText15b = CONCAT(v_sProcText15b,'@CompanyID,@DivisionID,@DepartmentID,',v_sCRLF);
            SET v_sProcText15b = CONCAT(v_sProcText15b,''',v_DocumentType,'',',v_sCRLF);
            SET v_sProcText15b = CONCAT(v_sProcText15b,'@TransactionNumber_N,',v_sCRLF);
            SET v_sProcText15b = CONCAT(v_sProcText15b,'@TransactionLineNumber,',v_sCRLF);
            SET v_sProcText15b = CONCAT(v_sProcText15b,''',v_sTableName,'','',v_sColumnName,'',',v_sCRLF);
            SET v_sProcText15b = CONCAT(v_sProcText15b,'@',v_sColumnName,'_O,',v_sCRLF);
            SET v_sProcText15b = CONCAT(v_sProcText15b,'@',v_sColumnName,'_N',v_sCRLF);
         end if;
         SET v_Count_b = v_Count_b+1;
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;



   SET		v_Count_c = 0;
   SET v_sProcText15c = '';

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 0 AND v_sTypeName <> 'text' AND v_sTypeName <> 'ntext') then
		
         IF v_Count_c >= v_Count_b then
				
            SET v_sProcText15c = CONCAT(v_sProcText15c,v_sCRLF);
            SET v_sProcText15c = CONCAT(v_sProcText15c,'EXEC enterprise.AuditInsert',v_sCRLF);
            SET v_sProcText15c = CONCAT(v_sProcText15c,'@CompanyID,@DivisionID,@DepartmentID,',v_sCRLF);
            SET v_sProcText15c = CONCAT(v_sProcText15c,''',v_DocumentType,'',',v_sCRLF);
            SET v_sProcText15c = CONCAT(v_sProcText15c,'@TransactionNumber_N,',v_sCRLF);
            SET v_sProcText15c = CONCAT(v_sProcText15c,'@TransactionLineNumber,',v_sCRLF);
            SET v_sProcText15c = CONCAT(v_sProcText15c,''',v_sTableName,'','',v_sColumnName,'',',v_sCRLF);
            SET v_sProcText15c = CONCAT(v_sProcText15c,'@',v_sColumnName,'_O,',v_sCRLF);
            SET v_sProcText15c = CONCAT(v_sProcText15c,'@',v_sColumnName,'_N',v_sCRLF);
         end if;
         SET v_Count_c = v_Count_c+1;
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;






   SET 	v_sProcText16 = '';
   SET 	v_sProcText16 = CONCAT(v_sProcText16,v_sCRLF);
   IF v_ComplexObject = 1 then
	
      SET 	v_sProcText16 = CONCAT(v_sProcText16,v_sTAB,v_sTAB,v_sTAB,v_sTAB,'END',v_sCRLF);
      SET 	v_sProcText16 = CONCAT(v_sProcText16,v_sTAB,v_sTAB,'END',v_sCRLF);
   end if;

   SET 	v_sProcText16 = CONCAT(v_sProcText16,'FETCH NEXT FROM cUpdate INTO',v_sCRLF);
   SET 	v_sProcText16 = CONCAT(v_sProcText16,v_sTAB,' @TransactionNumber_O',v_sCRLF);
   SET 	v_sProcText16 = CONCAT(v_sProcText16,v_sTAB,',@TransactionNumber_N',v_sCRLF);
   SET 	v_sProcText16 = CONCAT(v_sProcText16,v_sTAB,',@TransactionLineNumber',v_sCRLF);
   SET 	v_sProcText16 = CONCAT(v_sProcText16,v_sCRLF);

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET v_sProcText17 = '';

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 1) then
		
			
         SET v_sProcText17 = CONCAT(v_sProcText17,v_sTAB,',@',v_sColumnName,v_sCRLF);
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET		v_Count = 0;
   SET 	v_sProcText18 = '';
   SET 	v_sProcText18 = CONCAT(v_sProcText18,v_sCRLF);



   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   SWL_Label16:
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 0 AND v_sTypeName <> 'text' AND v_sTypeName <> 'ntext') then
		
         IF LENGTH(v_sProcText18) > 7900 then
            LEAVE SWL_Label16;
         end if;

			
         SET v_sProcText18 = CONCAT(v_sProcText18,v_sTAB,',@',v_sColumnName,'_O',v_sCRLF);
         SET v_sProcText18 = CONCAT(v_sProcText18,v_sTAB,',@',v_sColumnName,'_N',v_sCRLF);
			
			
         SET v_Count = v_Count+1;
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET		v_Count_a = 0;
   SET 	v_sProcText18a = '';

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 0 AND v_sTypeName <> 'text' AND v_sTypeName <> 'ntext') then
		
         IF v_Count_a >= v_Count then
				
            SET v_sProcText18a = CONCAT(v_sProcText18a,v_sTAB,',@',v_sColumnName,'_O',v_sCRLF);
            SET v_sProcText18a = CONCAT(v_sProcText18a,v_sTAB,',@',v_sColumnName,'_N',v_sCRLF);
         end if;
         SET v_Count_a = v_Count_a+1;
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;





   SET 	v_sProcText19 = '';
   SET 	v_sProcText19 = CONCAT(v_sProcText19,v_sCRLF);
   SET 	v_sProcText19 = CONCAT(v_sProcText19,'END',v_sCRLF);
   SET 	v_sProcText19 = CONCAT(v_sProcText19,v_sCRLF);
   SET 	v_sProcText19 = CONCAT(v_sProcText19,'CLOSE cUpdate',v_sCRLF);
   SET 	v_sProcText19 = CONCAT(v_sProcText19,'DEALLOCATE cUpdate',v_sCRLF);
   SET 	v_sProcText19 = CONCAT(v_sProcText19,v_sCRLF);
   SET 	v_sProcText19 = CONCAT(v_sProcText19,'END',v_sCRLF);
   SET 	v_sProcText19 = CONCAT(v_sProcText19,v_sCRLF);
   IF v_IsGenerate = 0 then
      SET 	v_sProcText19 = CONCAT(v_sProcText19,'GO',v_sCRLF);
   end if;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   IF v_IsGenerate = 1 then
      SET @SWV_Stmt = CONCAT(v_sProcText2,v_sProcText3,v_sProcText4,v_sProcText5,v_sProcText6,
      v_sProcText6a,v_sProcText7,v_sProcText8,v_sProcText8a,v_sProcText9,v_sProcText10,
      v_sProcText11,v_sProcText12,v_sProcText13,v_sProcText13a,
      v_sProcText14,v_sProcText15,v_sProcText15a,v_sProcText15b,v_sProcText15c,
      v_sProcText16,v_sProcText17,v_sProcText18,v_sProcText18a,v_sProcText19);
      PREPARE SWT_Stmt FROM @SWV_Stmt;
      EXECUTE SWT_Stmt;
      DEALLOCATE PREPARE SWT_Stmt;
   end if;







   SET 	v_sProcText1 = '';
   SET 	v_sProcText1 = CONCAT(v_sProcText1,v_sCRLF);

   SET 	v_sProcText1 = CONCAT(replace(v_sProcText1,';',' '),'IF EXISTS (SELECT * FROM sys.triggers ',
   v_sCRLF); 
   SET 	v_sProcText1 = CONCAT(replace(v_sProcText1,';',' '),'WHERE object_id = OBJECT_ID(N'[dbo].[',
   v_sTableName,'_Audit_Insert]'))',v_sCRLF);
   SET @SWV_Stmt = v_sProcText1;
   PREPARE SWT_Stmt FROM @SWV_Stmt;
   EXECUTE SWT_Stmt;
   DEALLOCATE PREPARE SWT_Stmt;
   SET 	v_sProcText1 = CONCAT('DROP TRIGGER `ISPIRER_HOLE(@sTableName)_Audit_Insert` ',v_sCRLF);

   IF v_IsGenerate = 0 then
      SET @SWV_Stmt = v_sProcText1;
      PREPARE SWT_Stmt FROM @SWV_Stmt;
      EXECUTE SWT_Stmt;
      DEALLOCATE PREPARE SWT_Stmt;
      SET 	v_sProcText1 = 'CALL GOISPIRER_HOLE(v_sCRLF);';
   end if;
   SET 	v_sProcText1 = CONCAT(v_sProcText1,v_sCRLF);
   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;

   IF v_IsGenerate = 1 then
      SET @SWV_Stmt = v_sProcText1;
      PREPARE SWT_Stmt FROM @SWV_Stmt;
      EXECUTE SWT_Stmt;
      DEALLOCATE PREPARE SWT_Stmt;
   end if;



   SET 	v_sProcText2 = '';
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'/*',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Name of trigger: ',v_sTableName,'_Audit_Insert',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Method: ',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'	Trigger is used for logging of insert to ',v_sTableName,
   ' table',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'	It inserts log records to AuditTrail table',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Date Created: ',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Input Parameters:',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Output Parameters:',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Called From:',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Calls:',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'	AuditInsert',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Last Modified: ',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Last Modified By: ',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'Revision History: ',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'',v_sCRLF);
   SET 	v_sProcText2 = CONCAT(v_sProcText2,'*/',v_sCRLF);
   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;

   SET 	v_sProcText3 = '';
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'CREATE TRIGGER ',v_sTableName,'_Audit_Insert ON ',
   v_sTableName,' FOR INSERT',v_sCRLF);
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'AS',v_sCRLF);
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'BEGIN',v_sCRLF);
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'-- check for audit triggers switch off',v_sCRLF);
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'DECLARE @Context VARBINARY(128)',v_sCRLF);
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'SELECT @Context = context_info FROM master.dbo.sysprocesses',
   v_sCRLF);
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'WHERE spid = @@SPID',v_sCRLF);
   SET 	v_sProcText3 = CONCAT(v_sProcText3,'IF CAST(@Context AS NVARCHAR(36)) = N'$$AuditSwitchOff$$' RETURN',
   v_sCRLF);

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET 	v_sProcText4 = '';
   SET 	v_sProcText4 = CONCAT(v_sProcText4,v_sCRLF);
   SET 	v_sProcText4 = CONCAT(v_sProcText4,'-- declarations',v_sCRLF);
   SET 	v_sProcText4 = CONCAT(v_sProcText4,'DECLARE @TransactionNumber NVARCHAR(50)',v_sCRLF);
   SET 	v_sProcText4 = CONCAT(v_sProcText4,'DECLARE @TransactionLineNumber NVARCHAR(50)',v_sCRLF);

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET 	v_sProcText5 = '';
   SET 	v_sProcText5 = CONCAT(v_sProcText5,v_sCRLF);

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 1) then
		
         SET v_sProcText5 = CONCAT(v_sProcText5,'DECLARE @',v_sColumnName,' ',v_sTypeName);
         IF (v_nAlternateType = 2) then 
            SET v_sProcText5 =  CONCAT(v_sProcText5,'(',CAST(v_nColumnPrecision AS CHAR(3)),', ',CAST(v_nColumnScale AS CHAR(3)),
            ')');
         ELSE 
            IF (v_nAlternateType = 1) then 
               SET v_sProcText5 =  CONCAT(v_sProcText5,'(',CAST(v_nColumnLength/2 AS CHAR(4)),')');
            end if;
         end if;
         SET 	v_sProcText5 = CONCAT(v_sProcText5,v_sCRLF);
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET 	v_sProcText6 = '';
   SET 	v_sProcText6 = CONCAT(v_sProcText6,v_sCRLF);
   SET 	v_sProcText6 = CONCAT(v_sProcText6,'-- inserting records cursor declaration',v_sCRLF);
   SET 	v_sProcText6 = CONCAT(v_sProcText6,'DECLARE cInsert CURSOR',v_sCRLF);
   SET 	v_sProcText6 = CONCAT(v_sProcText6,v_sTAB,'FOR SELECT',v_sCRLF);

   IF v_TransactionNumberField IS NULL then
	
      SET 	v_sProcText6 = CONCAT(v_sProcText6,v_sTAB,v_sTAB,' ''',v_sCRLF);
   ELSE
      SET 	v_sProcText6 = CONCAT(v_sProcText6,v_sTAB,v_sTAB,' i.',v_TransactionNumberField,v_sCRLF);
   end if;
   SET 	v_sProcText6 = CONCAT(v_sProcText6,v_sTAB,v_sTAB,IFNULL(CONCAT(',i.',v_TransactionLineNumberField),','''),
   v_sCRLF);
   SET 	v_sProcText6 = CONCAT(v_sProcText6,v_sCRLF);

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 1) then
		
         SET v_sProcText6 = CONCAT(v_sProcText6,v_sTAB,v_sTAB,',i.',v_sColumnName,v_sCRLF);
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;

   SET 	v_sProcText7 = '';
   SET 	v_sProcText7 = CONCAT(v_sProcText7,v_sCRLF);
   SET 	v_sProcText7 = CONCAT(v_sProcText7,v_sTAB,'FROM',v_sCRLF);
   SET 	v_sProcText7 = CONCAT(v_sProcText7,v_sTAB,v_sTAB,'inserted i',v_sCRLF);

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;



   SET 	v_sProcText8 = '';
   SET 	v_sProcText8 = CONCAT(v_sProcText8,v_sCRLF);
   SET 	v_sProcText8 = CONCAT(v_sProcText8,'OPEN cInsert',v_sCRLF);
   SET 	v_sProcText8 = CONCAT(v_sProcText8,'-- fetch from each inserting record',v_sCRLF);
   SET 	v_sProcText8 = CONCAT(v_sProcText8,'FETCH NEXT FROM cInsert INTO',v_sCRLF);
   SET 	v_sProcText8 = CONCAT(v_sProcText8,v_sTAB,' @TransactionNumber',v_sCRLF);
   SET 	v_sProcText8 = CONCAT(v_sProcText8,v_sTAB,',@TransactionLineNumber',v_sCRLF);
   SET 	v_sProcText8 = CONCAT(v_sProcText8,v_sCRLF);

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 1) then
		
         SET v_sProcText8 = CONCAT(v_sProcText8,v_sTAB,',@',v_sColumnName,v_sCRLF);
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET 	v_sProcText9 = '';
   SET 	v_sProcText9 = CONCAT(v_sProcText9,v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,'WHILE @@FETCH_STATUS = 0',v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,'BEGIN',v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,'-- insert audit record for each inserting record',
   v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,v_sTAB,'IF dbo.IsGuid(@TransactionNumber) = 0',v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,v_sTAB,v_sTAB,'BEGIN',v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,v_sTAB,v_sTAB,v_sTAB,'EXEC enterprise.AuditInsert',
   v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,v_sTAB,v_sTAB,v_sTAB,v_sTAB,'@CompanyID, @DivisionID, @DepartmentID,',
   v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,v_sTAB,v_sTAB,v_sTAB,v_sTAB,''',v_DocumentType,'',',
   v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,v_sTAB,v_sTAB,v_sTAB,v_sTAB,'@TransactionNumber,',
   v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,v_sTAB,v_sTAB,v_sTAB,v_sTAB,'@TransactionLineNumber,',
   v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,v_sTAB,v_sTAB,v_sTAB,v_sTAB,''',v_sTableName,'', 'New Record',',
   v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,v_sTAB,v_sTAB,v_sTAB,v_sTAB,''', 'New Record'',
   v_sCRLF);
   SET 	v_sProcText9 = CONCAT(v_sProcText9,v_sTAB,v_sTAB,'END',v_sCRLF);

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   SET 	v_sProcText10 = '';
   SET 	v_sProcText10 = CONCAT(v_sProcText10,v_sCRLF);
   SET 	v_sProcText10 = CONCAT(v_sProcText10,'FETCH NEXT FROM cInsert INTO',v_sCRLF);
   SET 	v_sProcText10 = CONCAT(v_sProcText10,v_sTAB,' @TransactionNumber',v_sCRLF);
   SET 	v_sProcText10 = CONCAT(v_sProcText10,v_sTAB,',@TransactionLineNumber',v_sCRLF);
   SET 	v_sProcText10 = CONCAT(v_sProcText10,v_sCRLF);

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 1) then
		
         SET v_sProcText10 = CONCAT(v_sProcText10,v_sTAB,',@',v_sColumnName,v_sCRLF);
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;



   SET 	v_sProcText11 = '';
   SET 	v_sProcText11 = CONCAT(v_sProcText11,'END',v_sCRLF);
   SET 	v_sProcText11 = CONCAT(v_sProcText11,v_sCRLF);
   SET 	v_sProcText11 = CONCAT(v_sProcText11,'CLOSE cInsert',v_sCRLF);
   SET 	v_sProcText11 = CONCAT(v_sProcText11,'DEALLOCATE cInsert',v_sCRLF);
   SET 	v_sProcText11 = CONCAT(v_sProcText11,v_sCRLF);
   SET 	v_sProcText11 = CONCAT(v_sProcText11,'END',v_sCRLF);
   SET 	v_sProcText11 = CONCAT(v_sProcText11,v_sCRLF);
   IF v_IsGenerate = 0 then
      SET 	v_sProcText11 = CONCAT(v_sProcText11,'GO',v_sCRLF);
   end if;

   IF v_IsGenerate = 0 then
      
SET @SWV_Null_Var = 0;
   end if;


   IF v_IsGenerate = 1 then
      SET @SWV_Stmt = CONCAT(v_sProcText2,v_sProcText3,v_sProcText4,v_sProcText5,v_sProcText6,
      v_sProcText7,v_sProcText8,v_sProcText9,v_sProcText10,v_sProcText11);
      PREPARE SWT_Stmt FROM @SWV_Stmt;
      EXECUTE SWT_Stmt;
      DEALLOCATE PREPARE SWT_Stmt;
   end if;


END