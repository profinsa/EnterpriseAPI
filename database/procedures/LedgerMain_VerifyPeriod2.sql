CREATE PROCEDURE LedgerMain_VerifyPeriod2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_TranDate DATETIME,
	INOUT v_PeriodToPost INT  ,
	INOUT v_PeriodClosed INT  ,INOUT SWP_Ret_Value INT) SWL_return:
BEGIN







   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

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
   DECLARE v_LastPeriod INT;
   DECLARE v_FiscalEndDate DATETIME;
   DECLARE v_FiscalStartDate DATETIME;



   DECLARE v_ErrorID INT;
   SET v_TranDate = IFNULL(v_TranDate,CURRENT_TIMESTAMP);


   select   Period1Date, Period2Date, Period3Date, Period4Date, Period5Date, Period6Date, Period7Date, Period8Date, Period9Date, Period10Date, Period11Date, Period12Date, Period13Date, Period14Date, FiscalEndDate, FiscalStartDate INTO v_Period1,v_Period2,v_Period3,v_Period4,v_Period5,v_Period6,v_Period7,
   v_Period8,v_Period9,v_Period10,v_Period11,v_Period12,v_Period13,v_Period14,
   v_FiscalEndDate,v_FiscalStartDate FROM Companies WHERE CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID;





   IF (v_Period14 IS NOT NULL) then
      SET v_LastPeriod = 13;
   ELSE 
      IF (v_Period13 IS NOT NULL) then
         SET v_LastPeriod = 12;
      ELSE 
         IF (v_Period12 IS NOT NULL) then
            SET v_LastPeriod = 11;
         ELSE 
            IF v_Period11 IS NOT NULL then
               SET v_LastPeriod = 10;
            ELSE 
               IF v_Period10 IS NOT NULL then
                  SET v_LastPeriod = 9;
               ELSE 
                  IF v_Period9 IS NOT NULL then
                     SET v_LastPeriod = 8;
                  ELSE 
                     IF v_Period8 IS NOT NULL then
                        SET v_LastPeriod = 7;
                     ELSE 
                        IF v_Period7 IS NOT NULL then
                           SET v_LastPeriod = 6;
                        ELSE 
                           IF v_Period6 IS NOT NULL then
                              SET v_LastPeriod = 5;
                           ELSE 
                              IF v_Period5 IS NOT NULL then
                                 SET v_LastPeriod = 4;
                              ELSE 
                                 IF v_Period4 IS NOT NULL then
                                    SET v_LastPeriod = 3;
                                 ELSE 
                                    IF v_Period3 IS NOT NULL then
                                       SET v_LastPeriod = 2;
                                    ELSE 
                                       IF v_Period2 IS NOT NULL then
                                          SET v_LastPeriod = 1;
                                       ELSE 
                                          IF v_Period1 IS NOT NULL then
                                             SET v_LastPeriod = 0;
                                          ELSE
                                             SET v_ErrorMessage = 'Invalid period data';
                                             CALL Error_InsertError(v_CompanyID,'','','LedgerMain_VerIFyPeriod',v_ErrorMessage,v_ErrorID);
                                             CALL Error_InsertErrorDetail(v_CompanyID,'','',v_ErrorID,'TranDate',v_TranDate);
                                             SET SWP_Ret_Value = -1;
                                          end if;
                                       end if;
                                    end if;
                                 end if;
                              end if;
                           end if;
                        end if;
                     end if;
                  end if;
               end if;
            end if;
         end if;
      end if;
   end if;



   IF (v_TranDate > v_FiscalEndDate) then

      SET v_PeriodToPost = v_LastPeriod+1;
      SET v_PeriodClosed = 0;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;




   IF (v_TranDate < v_FiscalStartDate) then

      SET v_PeriodToPost = -1;
      SET v_PeriodClosed = 1;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF (0 <= v_LastPeriod) AND (v_TranDate <= v_Period1) then

      SET v_PeriodToPost = 0;
      select   IFNULL(Period1Closed,0) INTO v_PeriodClosed FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF (1 <= v_LastPeriod) AND (v_TranDate > v_Period1) AND (v_TranDate <= v_Period2) then

      SET v_PeriodToPost = 1;
      select   IFNULL(Period2Closed,0) INTO v_PeriodClosed FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF (2 <= v_LastPeriod) AND (v_TranDate > v_Period2) AND (v_TranDate <= v_Period3) then

      SET v_PeriodToPost = 2;
      select   IFNULL(Period3Closed,0) INTO v_PeriodClosed FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF (3 <= v_LastPeriod) AND (v_TranDate > v_Period3) AND (v_TranDate <= v_Period4) then

      SET v_PeriodToPost = 3;
      select   IFNULL(Period4Closed,0) INTO v_PeriodClosed FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF (4 <= v_LastPeriod) AND (v_TranDate > v_Period4) AND (v_TranDate <= v_Period5) then

      SET v_PeriodToPost = 4;
      select   IFNULL(Period5Closed,0) INTO v_PeriodClosed FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF (5 <= v_LastPeriod) AND (v_TranDate > v_Period5) AND (v_TranDate <= v_Period6) then

      SET v_PeriodToPost = 5;
      select   IFNULL(Period6Closed,0) INTO v_PeriodClosed FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF (6 <= v_LastPeriod) AND (v_TranDate > v_Period6) AND (v_TranDate <= v_Period7) then

      SET v_PeriodToPost = 6;
      select   IFNULL(Period7Closed,0) INTO v_PeriodClosed FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF (7 <= v_LastPeriod) AND (v_TranDate > v_Period7) AND (v_TranDate <= v_Period8) then

      SET v_PeriodToPost = 7;
      select   IFNULL(Period8Closed,0) INTO v_PeriodClosed FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF (8 <= v_LastPeriod) AND (v_TranDate > v_Period8) AND (v_TranDate <= v_Period9) then

      SET v_PeriodToPost = 8;
      select   IFNULL(Period9Closed,0) INTO v_PeriodClosed FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF (9 <= v_LastPeriod) AND (v_TranDate > v_Period9) AND (v_TranDate <= v_Period10) then

      SET v_PeriodToPost = 9;
      select   IFNULL(Period10Closed,0) INTO v_PeriodClosed FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF (10 <= v_LastPeriod) AND (v_TranDate > v_Period10) AND (v_TranDate <= v_Period11) then

      SET v_PeriodToPost = 10;
      select   IFNULL(Period11Closed,0) INTO v_PeriodClosed FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF (11 <= v_LastPeriod) AND (v_TranDate > v_Period11) AND (v_TranDate <= v_Period12) then

      SET v_PeriodToPost = 11;
      select   IFNULL(Period12Closed,0) INTO v_PeriodClosed FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF (12 <= v_LastPeriod) AND (v_TranDate > v_Period12) AND (v_TranDate < v_Period13) then

      SET v_PeriodToPost = 12;
      select   IFNULL(Period13Closed,0) INTO v_PeriodClosed FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;


   IF (13 <= v_LastPeriod) AND (v_TranDate > v_Period13) AND (v_TranDate <= v_Period14) then

      SET v_PeriodToPost = 13;
      select   IFNULL(Period14Closed,0) INTO v_PeriodClosed FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID;
      SET SWP_Ret_Value = 0;
      LEAVE SWL_return;
   end if;



   SET v_PeriodToPost = v_LastPeriod+1;
   SET v_PeriodClosed = 0;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;









   CALL Error_InsertError(v_CompanyID,'','','LedgerMain_VerIFyPeriod',v_ErrorMessage,v_ErrorID);


   CALL Error_InsertErrorDetail(v_CompanyID,'','',v_ErrorID,'TranDate',v_TranDate);

   SET SWP_Ret_Value = -1;
END