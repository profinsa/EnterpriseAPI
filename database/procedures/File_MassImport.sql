CREATE PROCEDURE File_MassImport (INOUT v_Result INT  ,INOUT SWP_Ret_Value INT) BEGIN






















   DECLARE v_Ret INT;
   DECLARE v_Res INT;
   DECLARE v_ErrorID INT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(1000);
   DECLARE v_FilesPath VARCHAR(1000);
   DECLARE v_FilePathName VARCHAR(1000);
   DECLARE v_TableName VARCHAR(100);
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cTables CURSOR  FOR
   SELECT(sysobjects.name)
   FROM sysobjects
   WHERE(sysobjects.type) = 'U';
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;


   SET v_FilesPath = 'c:\enterprise\';
   SET v_Ret = 1;


   OPEN cTables;
   SET NO_DATA = 0;
   FETCH cTables INTO v_TableName;
   WHILE NO_DATA = 0 DO
      SET v_FilePathName = CONCAT(v_FilesPath,v_TableName,'.csv');
      SET v_Res = File_Import2(v_TableName,v_FilePathName);
      IF v_Res <> 1 then
         SET v_Ret = 0;
      end if;
      SET NO_DATA = 0;
      FETCH cTables INTO v_TableName;
   END WHILE;
   CLOSE cTables;



   SET SWP_Ret_Value = v_Ret;
END