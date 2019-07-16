CREATE PROCEDURE SplitListToTable2 (v_RowData VARCHAR(2000),  
 v_SplitOn VARCHAR(5)) SWL_return:
BEGIN



   
   DECLARE v_Cnt INT;
   DECLARE SWV_RowData_Str VARCHAR(2000);  
   DROP TEMPORARY TABLE IF EXISTS tt_RtnValue;
   CREATE TEMPORARY TABLE IF NOT EXISTS tt_RtnValue
   (  

      Data VARCHAR(50)
   );
   Set v_Cnt = 1;  
  
   While (LOCATE(v_SplitOn,v_RowData) > 0) DO
      Insert Into tt_RtnValue(data)
      Select
      ltrim(rtrim(SUBSTRING(v_RowData,1,LOCATE(v_SplitOn,v_RowData) -1))) Data;
      SET SWV_RowData_Str = SUBSTRING(v_RowData,LOCATE(v_SplitOn,v_RowData)+1,LENGTH(v_RowData));
      SET v_RowData = SWV_RowData_Str;
      Set v_Cnt = v_Cnt+1;
   END WHILE;  
   
   Insert Into tt_RtnValue(data)
   Select ltrim(rtrim(v_RowData)) Data;  
  
   LEAVE SWL_return;  
END