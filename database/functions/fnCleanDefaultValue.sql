CREATE FUNCTION fnCleanDefaultValue (v_sDefaultValue VARCHAR(4000)) BEGIN
   RETURN SUBSTRING(v_sDefaultValue,2,CASE v_sDefaultValue WHEN NULL THEN NULL WHEN '' THEN 1 ELSE LENGTH(v_sDefaultValue) END -2);
END