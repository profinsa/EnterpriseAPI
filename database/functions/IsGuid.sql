CREATE FUNCTION IsGuid (v_id NATIONAL VARCHAR(36)) BEGIN

   DECLARE v_Ret BOOLEAN;
   DECLARE v_position INT;
   DECLARE v_ascii INT;

   SET v_Ret = 0;
   SET v_id = lower(v_id);

   IF LENGTH(v_id) < 36 then
      RETURN v_Ret;
   end if;

   SET v_position = 1;
   WHILE v_position <= CASE v_id WHEN NULL THEN NULL WHEN '' THEN 1 ELSE LENGTH(v_id) END DO
      SET v_ascii = ASCII(SUBSTRING(v_id,v_position,1));
      IF NOT ((v_ascii >= ASCII('0') AND v_ascii <= ASCII('9')) OR
					 (v_ascii >= ASCII('a') AND v_ascii <= ASCII('f')) OR
					 (v_ascii = ASCII('-'))) then
         RETURN v_Ret;
      end if;
      SET v_position = v_position+1;
   END WHILE;

   SET v_Ret = 1;

   RETURN v_Ret;
END