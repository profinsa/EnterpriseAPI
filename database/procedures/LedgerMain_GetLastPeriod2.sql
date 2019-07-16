CREATE PROCEDURE LedgerMain_GetLastPeriod2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_LastPeriodDate DATETIME ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN









   DECLARE v_Period1 DATETIME;
   DECLARE v_Period2 DATETIME;
   DECLARE v_Period3 DATETIME;
   DECLARE v_Period4 DATETIME;
   DECLARE v_Period5 DATETIME;
   DECLARE v_Period6 DATETIME;
   DECLARE v_Period7 DATETIME;
   DECLARE v_Period8 DATETIME;
   DECLARE v_Period9 DATETIME;
   DECLARE v_Period10 DATETIME;
   DECLARE v_Period11 DATETIME;
   DECLARE v_Period12 DATETIME;
   DECLARE v_Period13 DATETIME;
   DECLARE v_Period14 DATETIME;
   select   Period1Date, Period2Date, Period3Date, Period4Date, Period5Date, Period6Date, Period7Date, Period8Date, Period9Date, Period10Date, Period11Date, Period12Date, Period13Date, Period14Date INTO v_Period1,v_Period2,v_Period3,v_Period4,v_Period5,v_Period6,v_Period7,
   v_Period8,v_Period9,v_Period10,v_Period11,v_Period12,v_Period13,v_Period14 FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   IF v_Period1 IS NULL OR v_Period2 IS NULL then

      SET v_LastPeriodDate = NULL;
      SET SWP_Ret_Value = -1;
      LEAVE SWL_return;
   end if;

   IF v_Period3 IS NULL then

      SET v_LastPeriodDate = v_Period2;
      SET SWP_Ret_Value = 1;
      LEAVE SWL_return;
   end if;

   IF v_Period4 IS NULL then

      SET v_LastPeriodDate = v_Period3;
      SET SWP_Ret_Value = 2;
      LEAVE SWL_return;
   end if;

   IF v_Period5 IS NULL then

      SET v_LastPeriodDate = v_Period4;
      SET SWP_Ret_Value = 3;
      LEAVE SWL_return;
   end if;

   IF v_Period6 IS NULL then

      SET v_LastPeriodDate = v_Period5;
      SET SWP_Ret_Value = 4;
      LEAVE SWL_return;
   end if;

   IF v_Period7 IS NULL then

      SET v_LastPeriodDate = v_Period6;
      SET SWP_Ret_Value = 5;
      LEAVE SWL_return;
   end if;

   IF v_Period8 IS NULL then

      SET v_LastPeriodDate = v_Period7;
      SET SWP_Ret_Value = 6;
      LEAVE SWL_return;
   end if;

   IF v_Period9 IS NULL then

      SET v_LastPeriodDate = v_Period8;
      SET SWP_Ret_Value = 7;
      LEAVE SWL_return;
   end if;

   IF v_Period10 IS NULL then

      SET v_LastPeriodDate = v_Period9;
      SET SWP_Ret_Value = 8;
      LEAVE SWL_return;
   end if;

   IF v_Period11 IS NULL then

      SET v_LastPeriodDate = v_Period10;
      SET SWP_Ret_Value = 9;
      LEAVE SWL_return;
   end if;

   IF v_Period12 IS NULL then

      SET v_LastPeriodDate = v_Period11;
      SET SWP_Ret_Value = 10;
      LEAVE SWL_return;
   end if;

   IF v_Period13 IS NULL then

      SET v_LastPeriodDate = v_Period12;
      SET SWP_Ret_Value = 11;
      LEAVE SWL_return;
   end if;

   IF v_Period14 IS NULL then

      SET v_LastPeriodDate = v_Period13;
      SET SWP_Ret_Value = 12;
      LEAVE SWL_return;
   ELSE
      SET v_LastPeriodDate = v_Period14;
      SET SWP_Ret_Value = 13;
      LEAVE SWL_return;
   end if;


   SET SWP_Ret_Value = -1;
END