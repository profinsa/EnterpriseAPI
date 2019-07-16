CREATE PROCEDURE Payroll_Gross_Calc2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),
	v_Check NATIONAL VARCHAR(36),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN








   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_GROSSDED DECIMAL(19,4);
   DECLARE v_AGIDED DECIMAL(19,4); 
   DECLARE v_PRETAXDED DECIMAL(19,4); 
   DECLARE v_FIT DECIMAL(19,4); 
   DECLARE v_STATETAX DECIMAL(19,4); 
   DECLARE v_LocalTax DECIMAL(19,4); 
   DECLARE v_FICAEE DECIMAL(19,4); 
   DECLARE v_FICAER DECIMAL(19,4); 
   DECLARE v_FUTA DECIMAL(19,4); 
   DECLARE v_SUI DECIMAL(19,4); 
   DECLARE v_ADDITIONS DECIMAL(19,4); 
   DECLARE v_NETADDITIONS DECIMAL(19,4); 
   DECLARE v_DEDUCTIONS DECIMAL(19,4); 
   DECLARE v_AGI REAL; 
   DECLARE v_GROSS REAL; 
   DECLARE v_Net REAL; 

   DECLARE v_PayrollItemID NATIONAL VARCHAR(36);
   DECLARE v_Basis NATIONAL VARCHAR(20);
   DECLARE v_TotalAmount DECIMAL(19,4);
   DECLARE v_PercentAmount FLOAT; 
   DECLARE v_EmployerPercentAmount FLOAT; 
   DECLARE v_EmployerTotalAmount DECIMAL(19,4);
   DECLARE v_HighLow INT;
   DECLARE v_ItemTotalAmount DECIMAL(19,4);
   DECLARE v_ItemPercent FLOAT;
   DECLARE v_EmployerItemPercent FLOAT;
   DECLARE v_EmployerItemAmount DECIMAL(19,4);
   DECLARE v_Type NATIONAL VARCHAR(36);
   DECLARE v_LastFIT DECIMAL(19,4);
   DECLARE v_YearToDateGross DECIMAL(19,4);
   DECLARE v_Medi DECIMAL(19,4);


   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE RegisterDetailcurs CURSOR FOR
   SELECT 
   PayrollItemID,
	Basis,
	Type,
	PercentAmount,
	TotalAmount,
	EmployerItemPercent,
	EmployerItemAmount
			
		
   FROM PayrollRegisterDetail
   WHERE     
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID) 	
   AND UPPER(PayrollID) = UPPER(v_PayrollID) 	
   AND UPPER(Basis) = 'GROSS'
   AND ApplyItem = 1
   ORDER BY Type;


   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   SET v_AGIDED = 0;
   SET v_GROSSDED = 0;
   SET v_NETADDITIONS = 0;


   select   IFNULL(PreTax,0), IFNULL(Gross,0), IFNULL(AGI,0), IFNULL(StateTax,0), IFNULL(CityTax,0), IFNULL(Additions,0), IFNULL(Deductions,0), IFNULL(NetPay,0), IFNULL(FICA,0), IFNULL(FICAER,0), IFNULL(FIT,0), IFNULL(FUTA,0), IFNULL(SUTA,0) INTO v_PRETAXDED,v_GROSS,v_AGI,v_STATETAX,v_LocalTax,v_ADDITIONS,v_DEDUCTIONS,
   v_Net,v_FICAEE,v_FICAER,v_FIT,v_FUTA,v_SUI FROM PayrollRegister WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
   AND UPPER(PayrollID) = UPPER(v_PayrollID); 	

   select   IFNULL(LastFIT,0) INTO v_LastFIT FROM PayrollEmployeesDetail WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID); 	
	
   START TRANSACTION;

   OPEN RegisterDetailcurs;

   SET NO_DATA = 0;
   FETCH RegisterDetailcurs INTO v_PayrollItemID,v_Basis,v_Type,v_PercentAmount,v_ItemTotalAmount,v_EmployerItemPercent,
   v_EmployerItemAmount;
   WHILE NO_DATA = 0 DO
      IF UPPER(v_Basis) = UPPER('Gross') then

         IF UPPER(v_Type) = UPPER('Addition') then
		
            SET v_GROSS = v_GROSS+v_ItemTotalAmount;
            SET v_AGI = v_AGI+v_ItemTotalAmount;
            SET v_ADDITIONS = v_ADDITIONS+v_ItemTotalAmount;
         ELSE 
            IF UPPER(v_Type) = UPPER('Deduction') then
		
               SET v_GROSSDED = v_GROSSDED+v_ItemTotalAmount;
               SET v_AGI = v_AGI -v_ItemTotalAmount;
               SET v_DEDUCTIONS = v_DEDUCTIONS+v_ItemTotalAmount;
            end if;
         end if;
         IF v_GROSS <= 0 then
		
            SET v_GROSSDED = 0;
            SET v_GROSS = 0;
            SET v_AGI = 0;
            SET v_FIT = 0;
         ELSE 
            If v_GROSSDED > v_GROSS then
		
               SET v_GROSSDED = 0;
               SET v_DEDUCTIONS = v_DEDUCTIONS -v_GROSSDED;
               SET v_AGI = v_GROSS;
            end if;
         end if;
         IF v_AGI > 0 then
		
			
		
            SET @SWV_Error = 0;
            SET v_ReturnStatus = Payroll_FICA(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_PayrollItemID,
            v_Check,v_FICAEE,v_FICAER,v_Medi);
            IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
			
               SET v_ErrorMessage = 'Call enterprise.Payroll_FICA failed';
				
               CLOSE RegisterDetailcurs;

               ROLLBACK;

               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Gross_Calc',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollID',v_PayrollID);
               SET SWP_Ret_Value = -1;
            end if;
            SET v_DEDUCTIONS = v_DEDUCTIONS+v_FICAEE+v_FICAER+v_Medi;
            IF UPPER(v_Check) = UPPER('Manual') then
			
               SET @SWV_Error = 0;
               SET v_ReturnStatus = Payroll_FUTA(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_GROSS,
               v_Check,v_FUTA);
               IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
				
                  SET v_ErrorMessage = 'Call enterprise.Payroll_FUTA failed';
					
                  CLOSE RegisterDetailcurs;

                  ROLLBACK;

                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Gross_Calc',v_ErrorMessage,
                  v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollID',v_PayrollID);
                  SET SWP_Ret_Value = -1;
               end if;
            ELSE
               SET v_FUTA = 0;
            end if;
            SET v_SUI = 0;
         end if;
      end if;	



      SET v_Net = v_GROSS -v_DEDUCTIONS+v_NETADDITIONS;
      SET v_PRETAXDED = v_GROSSDED+v_AGIDED;
      SET @SWV_Error = 0;
      UPDATE PayrollRegister
      SET
      PreTax = v_PRETAXDED,Gross = v_GROSS,AGI = v_AGI,
		
		
		Additions = v_ADDITIONS,Deductions = v_DEDUCTIONS,
      NetPay = v_Net
      WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID)
      AND UPPER(DivisionID) = UPPER(v_DivisionID)
      AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
      AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
      AND UPPER(PayrollID) = UPPER(v_PayrollID);
      IF @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'UPDATE PayrollRegister failed';
		
         CLOSE RegisterDetailcurs;

         ROLLBACK;

         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Gross_Calc',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollID',v_PayrollID);
         SET SWP_Ret_Value = -1;
      end if;
      SET NO_DATA = 0;
      FETCH RegisterDetailcurs INTO v_PayrollItemID,v_Basis,v_Type,v_PercentAmount,v_ItemTotalAmount,v_EmployerItemPercent,
      v_EmployerItemAmount;
   END WHILE;

   CLOSE RegisterDetailcurs;



   COMMIT;
   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;









   CLOSE RegisterDetailcurs;


   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Gross_Calc',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'EmployeeID',v_EmployeeID);
   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'PayrollID',v_PayrollID);

   SET SWP_Ret_Value = -1;
END