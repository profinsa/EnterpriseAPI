CREATE FUNCTION fnColumnDefault (v_sTableName VARCHAR(128), v_sColumnName VARCHAR(128)) BEGIN
   DECLARE v_sDefaultValue VARCHAR(4000);

   select   fnCleanDefaultValue(COLUMN_DEFAULT) INTO v_sDefaultValue FROM	`columns` WHERE	table_name = v_sTableName
   AND 	column_name = v_sColumnName;

   RETURN 	v_sDefaultValue;

END