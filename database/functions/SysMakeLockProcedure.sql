CREATE FUNCTION SysMakeLockProcedure (v_sTableName VARCHAR(128)) BEGIN

   DECLARE v_sProcText VARCHAR(8000);
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
   DECLARE v_bHasPostedField BOOLEAN;

   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE SWV_sProcText_Str VARCHAR(8000);
   DECLARE crKeyFields cursor for
   SELECT * FROM	SWT_fnTableColumnInfo
   ORDER BY 2;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   IF fnTableHasPrimaryKey(v_sTableName) = 0 then
 
      
RETURN NULL;
   end if;

   IF NOT EXISTS(SELECT	c.name
   FROM	syscolumns c
   INNER JOIN systypes t ON c.xtype = t.xtype and c.usertype = t.usertype
   WHERE	c.id = OBJECT_ID(v_sTableName) AND LOWER(c.name) = 'lockedby') then

      
RETURN NULL;
   end if;

   IF NOT EXISTS(SELECT	c.name
   FROM	syscolumns c
   INNER JOIN systypes t ON c.xtype = t.xtype and c.usertype = t.usertype
   WHERE	c.id = OBJECT_ID(v_sTableName) AND LOWER(c.name) = 'lockts') then

      
RETURN NULL;
   end if;

   SET	v_sTAB = char(9);
   SET v_sCRLF = CONCAT(char(13),char(10));

   SET v_sProcText = '';

   SET v_bHasPostedField = 0;
   SET 	v_sProcText = CONCAT(v_sProcText,'if exists(select * from dbo.sysobjects',v_sCRLF,v_sTAB,
   'where name = 'SetLock_',v_sTableName,''',v_sCRLF,v_sTAB,'and OBJECTPROPERTY(id, N'IsProcedure') = 1)',
   v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'drop procedure [enterprise].[SetLock_',
   v_sTableName,']',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'GO',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sCRLF);
   
SET 	v_sProcText = '';
   SET 	v_sProcText = CONCAT(v_sProcText,'/*',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'Name of stored procedure: SetLock_',v_sTableName,v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'Method: ',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'	locks/unlocks the record of the table ',v_sTableName,
   v_sCRLF);

   SET 	v_sProcText = CONCAT(v_sProcText,'',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'Date Created: ',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'Input Parameters:',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'',v_sCRLF);

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 1) then
		
         SET v_sProcText = CONCAT(v_sProcText,v_sTAB,'@',v_sColumnName,' ',v_sTypeName);
         IF (v_nAlternateType = 2) then 
            SET v_sProcText =  CONCAT(v_sProcText,'(',CAST(v_nColumnPrecision AS CHAR(3)),', ',CAST(v_nColumnScale AS CHAR(3)),
            ')');
         ELSE 
            IF (v_nAlternateType = 1) then 
               SET v_sProcText =  CONCAT(v_sProcText,'(',CAST(v_nColumnLength/2 AS CHAR(4)),')');
            end if;
         end if;
         SET 	v_sProcText = CONCAT(v_sProcText,'',v_sCRLF);
      ELSE 
         IF (LOWER(v_sColumnName) = LOWER('Posted')) then
	
            SET v_bHasPostedField = 1;
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'@LockedBy NVARCHAR(36)    - the ID of employee who try to lock the record',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'@LockType BIT             - lock the record if 1',
   v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'                            or unlock if 0',
   v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'
GO
Output Parameters:',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'@RealLockedBy NVARCHAR(36) - the ID of employee who really lock the record',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'@RealLockTS DATETIME       - date and time of record locking ',
   v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'@ReadOnly INT              - readonly mode flag:',
   v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'                             1 if record is readonly and',
   v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'                             0 if the record is writable',
   v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'Called From:',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'Calls:',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'Last Modified: ',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'Last Modified By: ',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'Revision History: ',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'*/',v_sCRLF);
   
SET 	v_sProcText = '';
   SET 	v_sProcText = CONCAT(v_sProcText,'CREATE PROCEDURE enterprise.SetLock_',v_sTableName,
   v_sCRLF);


   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 1) then
		
         SET v_sProcText = CONCAT(v_sProcText,v_sTAB,'@',v_sColumnName,' ',v_sTypeName);
         IF (v_nAlternateType = 2) then 
            SET v_sProcText =  CONCAT(v_sProcText,'(',CAST(v_nColumnPrecision AS CHAR(3)),', ',CAST(v_nColumnScale AS CHAR(3)),
            ')');
         ELSE 
            IF (v_nAlternateType = 1) then 
               SET v_sProcText =  CONCAT(v_sProcText,'(',CAST(v_nColumnLength/2 AS CHAR(4)),')');
            end if;
         end if;
         SET 	v_sProcText = CONCAT(v_sProcText,',',v_sCRLF);
      ELSE 
         IF (LOWER(v_sColumnName) = LOWER('Posted')) then
	
            SET v_bHasPostedField = 1;
         end if;
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'@LockedBy NVARCHAR(36),',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'@LockType BIT,',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'@RealLockedBy NVARCHAR(36) OUTPUT,',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'@RealLockTS DATETIME OUTPUT,',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'@ReadOnly INT OUTPUT',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'AS',v_sCRLF);
   IF v_bHasPostedField = 1 then

      SET 	v_sProcText = CONCAT(v_sProcText,'DECLARE @Posted BIT',v_sCRLF);
   end if;
   SET 	v_sProcText = CONCAT(v_sProcText,'BEGIN',v_sCRLF);

   
SET 	v_sProcText = '';
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'-- default value = readonly if the record is locked by another employee',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'SET @ReadOnly = 1',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'SELECT',v_sCRLF);
   IF v_bHasPostedField = 1 then

      SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'@Posted = ISNULL(Posted,0),',v_sCRLF);
   end if;
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'@RealLockedBy = LockedBy,',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'@RealLockTS = LockTS',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'FROM',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'dbo.',v_sTableName,v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'WHERE',v_sCRLF);

   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 1) then
		
         SET v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,v_sColumnName,' = @',v_sColumnName,' AND',
         v_sCRLF);
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   SET SWV_sProcText_Str = SUBSTRING(v_sProcText,1,LENGTH(v_sProcText) -5);
   SET v_sProcText = SWV_sProcText_Str;
   SET v_sProcText = CONCAT(v_sProcText,v_sCRLF);

   
SET 	v_sProcText = '';
   SET 	v_sProcText = CONCAT(v_sProcText,v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'IF @@ERROR <> 0 OR @@ROWCOUNT <> 1',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'BEGIN',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'RETURN(-1)',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'END',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sCRLF);
   IF v_bHasPostedField = 1 then

      SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'IF @Posted= 1',v_sCRLF);
      SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'BEGIN',v_sCRLF);
      SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'RETURN(0)',v_sCRLF);
      SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'END',v_sCRLF);
      SET 	v_sProcText = CONCAT(v_sProcText,v_sCRLF);
   end if;
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'-- the record is unlocked or locked by the same employee',
   v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'IF @RealLockedBy IS NULL',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'OR RTrim(@RealLockedBy) = ''',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'OR @RealLockedBy = @LockedBy',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'BEGIN',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'UPDATE ','dbo.',v_sTableName,v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'SET ',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,v_sTAB,'LockedBy = ',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,v_sTAB,'CASE',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,v_sTAB,'WHEN @LockType = 0 THEN NULL',
   v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,v_sTAB,'ELSE @LockedBy',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,v_sTAB,'END,',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,v_sTAB,'LockTS = ',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,v_sTAB,'CASE',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,v_sTAB,'WHEN @LockType = 0 THEN NULL',
   v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,v_sTAB,'ELSE GETDATE()',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,v_sTAB,'END',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'WHERE',v_sCRLF);
   OPEN crKeyFields;
   SET NO_DATA = 0;
   FETCH 	crKeyFields
   INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
   v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
   v_sDefaultValue;
   WHILE (NO_DATA = 0) DO
      IF (v_bPrimaryKeyColumn = 1) then
		
         SET v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,v_sTAB,v_sColumnName,' = @',v_sColumnName,
         ' AND',v_sCRLF);
      end if;
      SET NO_DATA = 0;
      FETCH 	crKeyFields
      INTO 	v_sColumnName,v_nColumnID,v_bPrimaryKeyColumn,v_nAlternateType,v_nColumnLength, 
      v_nColumnPrecision,v_nColumnScale,v_IsNullable,v_IsIdentity,v_sTypeName, 
      v_sDefaultValue;
   END WHILE;
   CLOSE crKeyFields;

   SET SWV_sProcText_Str = SUBSTRING(v_sProcText,1,LENGTH(v_sProcText) -5);
   SET v_sProcText = SWV_sProcText_Str;
   SET v_sProcText = CONCAT(v_sProcText,v_sCRLF);


   
SET 	v_sProcText = '';
   SET 	v_sProcText = CONCAT(v_sProcText,v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'IF @@ERROR <> 0 OR @@ROWCOUNT <> 1',
   v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'BEGIN',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,v_sTAB,'RETURN(-1)',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'END',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'SET @RealLockedBy = @LockedBy',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'SET @RealLockTS = GETDATE()',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'SET @ReadOnly = 0',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'END',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'RETURN(0)',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'END',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,'GO',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sCRLF);


   
RETURN(0);
END