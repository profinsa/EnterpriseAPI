CREATE PROCEDURE TranslatePhrase (v_ObjID NATIONAL VARCHAR(100),
	v_LangID NATIONAL VARCHAR(36),
	INOUT v_TranslatedPhrase NATIONAL VARCHAR(100)) BEGIN
   START TRANSACTION;
   select   CASE v_LangID
   WHEN 'Arabic' THEN IFNULL(Arabic,English)
   WHEN 'ChineseSimple' THEN IFNULL(ChineseSimple,English)
   WHEN 'ChineseTrad' THEN IFNULL(ChineseTrad,English)
   WHEN 'Dutch' THEN IFNULL(Dutch,English)
   WHEN 'French' THEN IFNULL(French,English)
   WHEN 'English' THEN IFNULL(English,English)
   WHEN 'German' THEN IFNULL(German,English)
   WHEN 'Italian' THEN IFNULL(Italian,English)
   WHEN 'Japanese' THEN IFNULL(Japanese,English)
   WHEN 'Korean' THEN IFNULL(Korean,English)
   WHEN 'Portuguese' THEN IFNULL(Portuguese,English)
   WHEN 'Russian' THEN IFNULL(Russian,English)
   WHEN 'Spanish' THEN IFNULL(Spanish,English)
   WHEN 'Swedish' THEN IFNULL(Swedish,English)
   WHEN 'Thai' THEN IFNULL(Thai,English)
   WHEN 'Fund' THEN IFNULL(Fund,English)
   WHEN 'Hindi' THEN IFNULL(Hindi,English)
   ELSE ObjID END INTO v_TranslatedPhrase FROM
   `Translation` WHERE
   ObjID = v_ObjID;

   IF ROW_COUNT() = 0 then
      BEGIN
         DECLARE EXIT HANDLER FOR NOT FOUND,SQLEXCEPTION
         begin
            SET @SWV_Null_Var = 0;
         end;
         IF v_TranslatedPhrase IS NULL then
            SET v_TranslatedPhrase = v_ObjID;
         end if;
         INSERT INTO `Translation`(ObjID,
				English)
		 VALUES(v_ObjID
			   ,v_TranslatedPhrase);
      END;
   end if;
 
   COMMIT;
END