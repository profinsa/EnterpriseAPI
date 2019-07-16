CREATE FUNCTION fnIsColumnPrimaryKey (v_sTableName VARCHAR(128), v_nColumnName VARCHAR(128)) BEGIN
   DECLARE v_nTableID INT;
   DECLARE v_nIndexID INT;
   DECLARE v_i INT;
	
   SET 	v_nTableID = OBJECT_ID(v_sTableName);
	
   select   indid INTO v_nIndexID FROM 	sysindexes WHERE 	id = v_nTableID
   AND 	indid BETWEEN 1 And 254
   AND(status & 2048) = 2048;
	
   IF v_nIndexID Is Null then
      RETURN 0;
   end if;
	
   IF v_nColumnName IN(SELECT sc.name
   FROM 	sysindexkeys sik
   INNER JOIN syscolumns sc ON sik.id = sc.id AND sik.colid = sc.colid
   WHERE 	sik.id = v_nTableID
   AND 	sik.indid = v_nIndexID) then
	 
      RETURN 1;
   end if;


   RETURN 0;
END