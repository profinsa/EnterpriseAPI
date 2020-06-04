CREATE PROCEDURE LedgerMain_VerifyPeriodCurrent (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodCurrent INT  ,
	INOUT v_PeriodStart DATETIME ,
	INOUT v_PeriodStop DATETIME ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN










   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_TranDate DATETIME;
   DECLARE v_Period INT;
   DECLARE v_PeriodClosed INT;

   DECLARE v_ErrorID INT;
   SET v_TranDate = CURRENT_TIMESTAMP;

   CALL LedgerMain_VerifyPeriod2(v_CompanyID,v_DivisionID,v_DepartmentID,v_TranDate,v_PeriodCurrent,v_PeriodClosed, v_ReturnStatus);

   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Procedure call LedgerMain_VerifyPeriod failed';
      CALL Error_InsertError(v_CompanyID,'','','LedgerMain_VerifyPeriodCurrent',v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;

   CALL LedgerMain_PeriodDate2(v_CompanyID,v_DivisionID,v_DepartmentID,v_PeriodCurrent,v_PeriodStart,
   v_PeriodStop, v_ReturnStatus);

   IF v_ReturnStatus = -1 then

      SET v_ErrorMessage = 'Procedure call LedgerMain_VerifyPeriod failed';
      CALL Error_InsertError(v_CompanyID,'','','LedgerMain_VerifyPeriodCurrent',v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;



   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;









   CALL Error_InsertError(v_CompanyID,'','','LedgerMain_VerifyPeriodCurrent',v_ErrorMessage,v_ErrorID);

   SET SWP_Ret_Value = -1;
END