CREATE PROCEDURE generate_inserts (v_table VARCHAR(20)



) BEGIN
   DECLARE v_cols VARCHAR(1000);

   DECLARE v_col VARCHAR(50);

   DECLARE v_sql VARCHAR(4000);

   DECLARE v_colname VARCHAR(100);

   DECLARE v_coltype VARCHAR(30);

   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE SWV_cols_Str VARCHAR(1000);
   DECLARE SWV_sql_Str VARCHAR(4000);
   declare colcur

   cursor for

   select column_name

   from `columns`

   where table_name = v_table; 

   declare ccur

   cursor for

   select column_name, data_type

   from `columns`

   where table_name = v_table;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   set v_cols = '';

   open colcur;

   SET NO_DATA = 0;
   fetch colcur into v_col;

   while NO_DATA = 0 DO
      SET v_cols = CONCAT(v_cols,', ',v_col);
      SET NO_DATA = 0;
      fetch colcur into v_col;
   END WHILE;

   close colcur;



   SET SWV_cols_Str = SUBSTRING(v_cols,3,CASE v_cols WHEN NULL THEN NULL WHEN '' THEN 1 ELSE LENGTH(v_cols) END);
   SET v_cols = SWV_cols_Str;



   SET v_sql = CONCAT('select replace('insert ',v_table,' (',v_cols,') ');

   SET v_sql = CONCAT(v_sql,'values ('');

   open ccur;

   SET NO_DATA = 0;
   fetch ccur into v_colname,v_coltype;

   while NO_DATA = 0 DO
      if v_coltype in('varchar','char','datetime') then
         SET v_sql = CONCAT(v_sql,'''');
      end if;
      SET v_sql = CONCAT(v_sql,' + coalesce(convert(varchar, ',v_colname,'), 'null') + ');
      if v_coltype in('varchar','char','datetime') then
         SET v_sql = CONCAT(v_sql,'''');
      end if;
      SET v_sql = CONCAT(v_sql,'', '');
      SET NO_DATA = 0;
      fetch ccur into v_colname,v_coltype;
   END WHILE;

   close ccur;



   SET SWV_sql_Str = SUBSTRING(v_sql,1,CASE v_sql WHEN NULL THEN NULL WHEN '' THEN 1 ELSE LENGTH(v_sql) END -3);
   SET v_sql = SWV_sql_Str;

   SET v_sql = CONCAT(v_sql,')', '''null''', 'null') from ',v_table);

   SET @SWV_Stmt = v_sql;
   PREPARE SWT_Stmt FROM @SWV_Stmt;
   EXECUTE SWT_Stmt;
   DEALLOCATE PREPARE SWT_Stmt;
END