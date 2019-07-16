CREATE PROCEDURE LedgerMain_PeriodsCount (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodCount INT  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN











   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Period1Date DATETIME;
   DECLARE v_Period2Date DATETIME;
   DECLARE v_Period3Date DATETIME;
   DECLARE v_Period4Date DATETIME;
   DECLARE v_Period5Date DATETIME;
   DECLARE v_Period6Date DATETIME;
   DECLARE v_Period7Date DATETIME;
   DECLARE v_Period8Date DATETIME;
   DECLARE v_Period9Date DATETIME;
   DECLARE v_Period10Date DATETIME;
   DECLARE v_Period11Date DATETIME;
   DECLARE v_Period12Date DATETIME;
   DECLARE v_Period13Date DATETIME;
   DECLARE v_Period14Date DATETIME;

   DECLARE v_ErrorID INT;
   SET v_PeriodCount = 0;

   select   Period1Date, Period2Date, Period3Date, Period4Date, Period5Date, Period6Date, Period7Date, Period8Date, Period9Date, Period10Date, Period11Date, Period12Date, Period13Date, Period14Date INTO v_Period1Date,v_Period2Date,v_Period3Date,v_Period4Date,v_Period5Date,
   v_Period6Date,v_Period7Date,v_Period8Date,v_Period9Date,v_Period10Date,
   v_Period11Date,v_Period12Date,v_Period13Date,v_Period14Date FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   IF v_Period1Date IS NULL then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   IF v_Period2Date IS NULL then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   SET v_PeriodCount = 2;

   IF v_Period3Date IS NULL then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   SET v_PeriodCount = 3;

   IF v_Period4Date IS NULL then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   SET v_PeriodCount = 4;

   IF v_Period5Date IS NULL then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   SET v_PeriodCount = 5;

   IF v_Period6Date IS NULL then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   SET v_PeriodCount = 6;

   IF v_Period7Date IS NULL then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   SET v_PeriodCount = 7;

   IF v_Period8Date IS NULL then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   SET v_PeriodCount = 8;

   IF v_Period9Date IS NULL then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   SET v_PeriodCount = 9;

   IF v_Period10Date IS NULL then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   SET v_PeriodCount = 10;

   IF v_Period11Date IS NULL then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   SET v_PeriodCount = 11;

   IF v_Period12Date IS NULL then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   SET v_PeriodCount = 12;

   IF v_Period13Date IS NULL then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   SET v_PeriodCount = 13;

   IF v_Period14Date IS NULL then
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   SET v_PeriodCount = 14;


   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   CALL Error_InsertError(v_CompanyID,'','','LedgerMain_PeriodsCount',v_ErrorMessage,v_ErrorID);


   SET SWP_Ret_Value = -1;
END