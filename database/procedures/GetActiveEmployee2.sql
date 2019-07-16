CREATE PROCEDURE GetActiveEmployee2 (INOUT v_EmployeeID NATIONAL VARCHAR(36) ,INOUT SWP_Ret_Value INT) BEGIN





   DECLARE v_Context VARBINARY(128);
   DECLARE v_position INT;
   DECLARE SWV_EmployeeID_Str NATIONAL VARCHAR(36);
   select   context_info INTO v_Context FROM sysprocesses WHERE spid = CONNECTION_ID();
   SET v_EmployeeID = CAST(v_Context AS CHAR(36));
   SET v_position = 1;
   SWL_Label:
   WHILE v_position <= LENGTH(v_EmployeeID) DO
      IF ASCII(SUBSTRING(v_EmployeeID,v_position,1)) = 0 then 
         LEAVE SWL_Label;
      end if;
      SET v_position = v_position+1;
   END WHILE;
   SET SWV_EmployeeID_Str = SUBSTRING(v_EmployeeID,1,v_position -1);
   SET v_EmployeeID = SWV_EmployeeID_Str;

   SET SWP_Ret_Value = 0;
END