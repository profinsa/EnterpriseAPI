CREATE FUNCTION fnTableHasPrimaryKey (v_sTableName VARCHAR(128)) BEGIN
   DECLARE v_nTableID INT;
   DECLARE v_nIndexID INT;
	
   SET 	v_nTableID = OBJECT_ID(v_sTableName);
	
   select   indid INTO v_nIndexID FROM 	sysindexes WHERE 	id = v_nTableID
   AND 	indid BETWEEN 1 And 254
   AND(status & 2048) = 2048;
	
   IF v_nIndexID IS NOT Null then
      RETURN 1;
   end if;
	
   RETURN 0;
END