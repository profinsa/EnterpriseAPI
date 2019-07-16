CREATE PROCEDURE LedgerMain_PeriodEndDate (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_Period INT,
	INOUT v_PeriodEndDate DATETIME  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN











   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);


   DECLARE v_ErrorID INT;
   select   CASE
   WHEN v_Period = 0 THEN Period1Date
   WHEN v_Period = 1 THEN Period2Date
   WHEN v_Period = 2 THEN Period3Date
   WHEN v_Period = 3 THEN Period4Date
   WHEN v_Period = 4 THEN Period5Date
   WHEN v_Period = 5 THEN Period6Date
   WHEN v_Period = 6 THEN Period7Date
   WHEN v_Period = 7 THEN Period8Date
   WHEN v_Period = 8 THEN Period9Date
   WHEN v_Period = 9 THEN Period10Date
   WHEN v_Period = 10 THEN Period11Date
   WHEN v_Period = 11 THEN Period12Date
   WHEN v_Period = 12 THEN Period13Date
   WHEN v_Period = 13 THEN Period14Date
   END INTO v_PeriodEndDate FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   CALL Error_InsertError(v_CompanyID,'','','LedgerMain_PeriodEndDate',v_ErrorMessage,v_ErrorID);


   SET SWP_Ret_Value = -1;
END