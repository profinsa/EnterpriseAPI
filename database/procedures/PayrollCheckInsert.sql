CREATE PROCEDURE PayrollCheckInsert (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_PayrollCheckDate DATETIME,
	v_StartDate DATETIME,
	v_EndDate DATETIME,
	v_CheckTypeID NATIONAL VARCHAR(36),
	v_CurrencyID NATIONAL VARCHAR(3),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN










   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_EmployeeID NATIONAL VARCHAR(36);
   DECLARE v_CheckPrinted BOOLEAN;
   DECLARE v_CheckNumber NATIONAL VARCHAR(20);
   DECLARE v_GLEmployeeCreditAccount NATIONAL VARCHAR(36);


   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE PayrollEmployeecur CURSOR FOR
   SELECT 
   EmployeeID
	
   FROM PayrollEmployeesDetail
   WHERE     
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID);
			



   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION;



   OPEN PayrollEmployeecur;

   SET NO_DATA = 0;
   FETCH PayrollEmployeecur INTO v_EmployeeID;
   WHILE NO_DATA = 0 DO
      SET v_CheckPrinted = 0;
      SET @SWV_Error = 0;
      SET v_ReturnStatus = GetNextEntityID(v_CompanyID,v_DivisionID,v_DepartmentID,'NextCheckNumber',v_CheckNumber);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then

         SET v_ErrorMessage = 'Call enterprise.GetNextEntityID failed';
         ROLLBACK;


         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PayrollCheckInsert',v_ErrorMessage,
         v_ErrorID);
         SET SWP_Ret_Value = -1;
      end if;
      select   IFNULL(GLWagesPayrollAccount,0) INTO v_GLEmployeeCreditAccount FROM PayrollSetup WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID)
      AND UPPER(DivisionID) = UPPER(v_DivisionID)
      AND UPPER(DepartmentID) = UPPER(v_DepartmentID);
      INSERT INTO
      PayrollChecks(CompanyID,
	DivisionID,
	DepartmentID,
	EmployeeID,
	PayrollID,
	PayrollCheckDate,
	StartDate,
	EndDate,
	CheckPrinted,
	GLEmployeeCreditAccount,
	CurrencyID,
	CheckTypeID)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_EmployeeID,
	' ',
	v_PayrollCheckDate,
	v_StartDate,
	v_EndDate,
	v_CheckPrinted,
	v_GLEmployeeCreditAccount,
	v_CurrencyID,
	v_CheckTypeID);

      SET NO_DATA = 0;
      FETCH PayrollEmployeecur INTO v_EmployeeID;
   END WHILE;


   CLOSE PayrollEmployeecur;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;








   ROLLBACK;


   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'PayrollCheckInsert',v_ErrorMessage,
   v_ErrorID);

   SET SWP_Ret_Value = -1;
END