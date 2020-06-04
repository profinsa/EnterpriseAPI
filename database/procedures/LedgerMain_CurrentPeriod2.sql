CREATE PROCEDURE LedgerMain_CurrentPeriod2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	INOUT v_PeriodCurrent INT  ,
	INOUT v_PeriodStart DATETIME ,
	INOUT v_PeriodStop DATETIME ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN





   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_Period1 BOOLEAN;
   DECLARE v_Period2 BOOLEAN;
   DECLARE v_Period3 BOOLEAN;
   DECLARE v_Period4 BOOLEAN;
   DECLARE v_Period5 BOOLEAN;
   DECLARE v_Period6 BOOLEAN;
   DECLARE v_Period7 BOOLEAN;
   DECLARE v_Period8 BOOLEAN;
   DECLARE v_Period9 BOOLEAN;
   DECLARE v_Period10 BOOLEAN;
   DECLARE v_Period11 BOOLEAN;
   DECLARE v_Period12 BOOLEAN;
   DECLARE v_Period13 BOOLEAN;
   DECLARE v_Period14 BOOLEAN;

   DECLARE v_ErrorID INT;
   set v_PeriodCurrent = -1;


   select   IFNULL(Period1Closed,0), FiscalStartDate, IFNULL(Period1Date,NULL) INTO v_Period1,v_PeriodStart,v_PeriodStop FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   if (v_Period1 = 0) then

      set v_PeriodCurrent = 0;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Period2Closed,0), TIMESTAMPADD(day,1,Period1Date), IFNULL(Period2Date,NULL) INTO v_Period2,v_PeriodStart,v_PeriodStop FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   if (v_Period2 = 0) then

      set v_PeriodCurrent = 1;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Period3Closed,0), TIMESTAMPADD(day,1,Period2Date), IFNULL(Period3Date,NULL) INTO v_Period3,v_PeriodStart,v_PeriodStop FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   if (v_Period3 = 0) then

      set v_PeriodCurrent = 2;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Period4Closed,0), TIMESTAMPADD(day,1,Period3Date), IFNULL(Period4Date,NULL) INTO v_Period4,v_PeriodStart,v_PeriodStop FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   if (v_Period4 = 0) then

      set v_PeriodCurrent = 3;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Period5Closed,0), TIMESTAMPADD(day,1,Period4Date), IFNULL(Period5Date,NULL) INTO v_Period5,v_PeriodStart,v_PeriodStop FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   if (v_Period5 = 0) then

      set v_PeriodCurrent = 4;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Period6Closed,0), TIMESTAMPADD(day,1,Period5Date), IFNULL(Period6Date,NULL) INTO v_Period6,v_PeriodStart,v_PeriodStop FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   if (v_Period6 = 0) then

      set v_PeriodCurrent = 5;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Period7Closed,0), TIMESTAMPADD(day,1,Period6Date), IFNULL(Period7Date,NULL) INTO v_Period7,v_PeriodStart,v_PeriodStop FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   if (v_Period7 = 0) then

      set v_PeriodCurrent = 6;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Period8Closed,0), TIMESTAMPADD(day,1,Period7Date), IFNULL(Period8Date,NULL) INTO v_Period8,v_PeriodStart,v_PeriodStop FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   if (v_Period8 = 0) then

      set v_PeriodCurrent = 7;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Period9Closed,0), TIMESTAMPADD(day,1,Period8Date), IFNULL(Period9Date,NULL) INTO v_Period9,v_PeriodStart,v_PeriodStop FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   if (v_Period9 = 0) then

      set v_PeriodCurrent = 8;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Period10Closed,0), TIMESTAMPADD(day,1,Period9Date), IFNULL(Period10Date,NULL) INTO v_Period10,v_PeriodStart,v_PeriodStop FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   if (v_Period10 = 0) then

      set v_PeriodCurrent = 9;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Period11Closed,0), TIMESTAMPADD(day,1,Period10Date), IFNULL(Period11Date,NULL) INTO v_Period11,v_PeriodStart,v_PeriodStop FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   if (v_Period11 = 0) then

      set v_PeriodCurrent = 10;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Period12Closed,0), TIMESTAMPADD(day,1,Period11Date), IFNULL(Period12Date,NULL) INTO v_Period12,v_PeriodStart,v_PeriodStop FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   if (v_Period12 = 0) then

      set v_PeriodCurrent = 11;	
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Period13Closed,0), TIMESTAMPADD(day,1,Period12Date), IFNULL(Period13Date,NULL) INTO v_Period13,v_PeriodStart,v_PeriodStop FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   if (v_Period13 = 0) then

      set v_PeriodCurrent = 12;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;

   select   IFNULL(Period14Closed,0), TIMESTAMPADD(day,1,Period13Date), IFNULL(Period14Date,NULL) INTO v_Period14,v_PeriodStart,v_PeriodStop FROM
   Companies WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;

   if (v_Period14 = 0) then

      set v_PeriodCurrent = 13;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;
   SET SWP_Ret_Value = -1;
   LEAVE SWL_return;








   CALL Error_InsertError(v_CompanyID,'','','LedgerMain_CurrentPeriod',v_ErrorMessage,v_ErrorID);

   SET SWP_Ret_Value = -1;
END