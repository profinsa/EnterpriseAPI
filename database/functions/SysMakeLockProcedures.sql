CREATE FUNCTION SysMakeLockProcedures () BEGIN


   DECLARE v_TableName NATIONAL VARCHAR(64);
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE cTables CURSOR
   FOR SELECT TABLE_NAME FROM `TABLES` 
   WHERE TABLE_TYPE = 'BASE TABLE'
   AND TABLE_NAME <> 'LedgerStoredChartOfAccounts'
   AND TABLE_NAME <> 'ActiveEmployee'
   AND TABLE_NAME NOT LIKE 'Tax%'
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
      SET @SWV_RetVal = SysMakeLockProcedure(v_TableName);
      SET NO_DATA = 0;
      FETCH cTables INTO v_TableName;
   END WHILE;

   CLOSE cTables;




   RETURN(0);
END