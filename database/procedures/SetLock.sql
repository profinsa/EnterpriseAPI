CREATE PROCEDURE SetLock (v_sTableName VARCHAR(128),
	v_WhereCondition NATIONAL VARCHAR(1000),
	v_LockedBy NATIONAL VARCHAR(36),
	v_LockType BOOLEAN,
	INOUT v_RealLockedBy NATIONAL VARCHAR(36) ,
	INOUT v_RealLockTS DATETIME ,
	INOUT v_ReadOnly INT ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN







   DECLARE v_sProcText NATIONAL VARCHAR(4000);
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

   DECLARE v_ParamDefinition NATIONAL VARCHAR(200);
   IF fnTableHasPrimaryKey(v_sTableName) = 0 then
 
      
LEAVE SWL_return;
   end if;

   IF NOT EXISTS(SELECT	c.name
   FROM	syscolumns c
   INNER JOIN systypes t ON c.xtype = t.xtype and c.usertype = t.usertype
   WHERE	c.id = OBJECT_ID(v_sTableName) AND LOWER(c.name) = 'lockedby') then

      
LEAVE SWL_return;
   end if;

   IF NOT EXISTS(SELECT	c.name
   FROM	syscolumns c
   INNER JOIN systypes t ON c.xtype = t.xtype and c.usertype = t.usertype
   WHERE	c.id = OBJECT_ID(v_sTableName) AND LOWER(c.name) = 'lockts') then

      
LEAVE SWL_return;
   end if;

   SET	v_sTAB = char(9);
   SET v_sCRLF = CONCAT(char(13),char(10));

   SET v_sProcText = '';

   SET v_bHasPostedField = 0;
   CALL fnTableColumnInfo(v_sTableName);
   IF EXISTS(SELECT * FROM SWT_fnTableColumnInfo WHERE sColumnName = 'Posted') then
      SET v_bHasPostedField = 1;
   end if;
   SET 	v_sProcText = '';
   IF v_bHasPostedField = 1 then

      SET 	v_sProcText = CONCAT(v_sProcText,'DECLARE @Posted BIT',v_sCRLF);
   end if;

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
   SET	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_WhereCondition,v_sCRLF);


   SET 	v_sProcText = CONCAT(v_sProcText,v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'IF @@ERROR <> 0 OR @@ROWCOUNT <> 1',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'BEGIN',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'SET @ReadOnly = 0',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'RETURN',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'END',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sCRLF);

   IF v_bHasPostedField = 1 then

      SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'IF @Posted= 1',v_sCRLF);
      SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'BEGIN',v_sCRLF);
      SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'RETURN',v_sCRLF);
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
   SET	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_WhereCondition,v_sCRLF);

   SET v_sProcText = CONCAT(v_sProcText,v_sCRLF);


   SET 	v_sProcText = CONCAT(v_sProcText,v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'IF @@ERROR <> 0 OR @@ROWCOUNT <> 1',
   v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'BEGIN',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,v_sTAB,'RETURN',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'END',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'SET @RealLockedBy = @LockedBy',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'SET @RealLockTS = GETDATE()',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,v_sTAB,'SET @ReadOnly = 0',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sTAB,'END',v_sCRLF);
   SET 	v_sProcText = CONCAT(v_sProcText,v_sCRLF);

   SET v_ParamDefinition = N'@LockedBy NVARCHAR(36),@LockType BIT,@RealLockedBy NVARCHAR(36) OUTPUT, @RealLockTS DATETIME OUTPUT,@ReadOnly INT OUTPUT';
   
SET @SWV_Stmt = v_sProcText;
   PREPARE SWT_Stmt FROM @SWV_Stmt;
   EXECUTE SWT_Stmt;
   DEALLOCATE PREPARE SWT_Stmt;




   SET SWP_Ret_Value =(0);
END