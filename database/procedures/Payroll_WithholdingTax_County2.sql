CREATE PROCEDURE Payroll_WithholdingTax_County2 (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),
	v_State NATIONAL VARCHAR(50),
	v_County NATIONAL VARCHAR(50),
	v_PayrollCheckYear INT,
	v_AnnualGrossPay DECIMAL(19,4),INOUT SWP_Ret_Value INT) SWL_return:
BEGIN





   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_WithholdingTax DECIMAL(19,4);




   DECLARE v_PayFrequency NATIONAL VARCHAR(50);
   DECLARE v_TaxBracket REAL;
   DECLARE v_CountyAllowance INT;
   DECLARE v_CountyFilingStatus NATIONAL VARCHAR(50);
   DECLARE v_Dependents INT;
   DECLARE v_StandardDeductSingle DECIMAL(19,4);
   DECLARE v_StandardDeductJoint DECIMAL(19,4);
   DECLARE v_Exemption_money DECIMAL(19,4);
   DECLARE v_Dependents_money DECIMAL(19,4);
   DECLARE v_OverAmnt DECIMAL(19,4);
   DECLARE v_NotOver DECIMAL(19,4);
   DECLARE v_NetTaxableIncome DECIMAL(19,4);
   DECLARE v_CountyFillingStatus NATIONAL VARCHAR(36);
   DECLARE v_Cumulative DECIMAL(19,4);
   DECLARE v_TotalTaxPerYear DECIMAL(19,4);
   DECLARE v_Exemption_Amount DECIMAL(19,4);
   DECLARE v_Dependents_Amount DECIMAL(19,4);
   DECLARE v_WithholdingStatus NATIONAL VARCHAR(36);
   DECLARE v_NetTAxPerYear DECIMAL(19,4);
   DECLARE v_DEDUCTIONS DECIMAL(19,4); 
   DECLARE v_Net DECIMAL(19,4); 


   DECLARE v_ErrorID INT;
   DECLARE NO_DATA INT DEFAULT 0;
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE PayrollCountyTaxTa CURSOR FOR 
   SELECT	
   OverAmnt,
	NotOver,
	TaxBracket,
	Cumulative,
	WithholdingStatus
   FROM	
   PayrollCountyTaxTables	
   WHERE	
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(State) = UPPER(v_State)
   AND UPPER(County) = UPPER(v_County)
   AND UPPER(StatusType) = UPPER(v_CountyFilingStatus)
   AND UPPER(PayrollYear) = UPPER(v_PayrollCheckYear)
   AND UPPER(PayFrequency) = UPPER(v_PayFrequency);
	



   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
      SET NO_DATA = -2;
   END;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET NO_DATA = -1;
   SET @SWV_Error = 0;
   START TRANSACTION; 

   select   IFNULL(CountyAllowance,0), CountyFilingStatus, IFNULL(Dependents,0), PayFrequency INTO v_CountyAllowance,v_CountyFilingStatus,v_Dependents,v_PayFrequency FROM PayrollEmployeesDetail WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND EmployeeID = v_EmployeeID;



	
	
   select   IFNULL(StandardDeductSingle,0), IFNULL(StandardDeductJoint,0), IFNULL(Exemption,0), IFNULL(Dependents,0) INTO v_StandardDeductSingle,v_StandardDeductJoint,v_Exemption_money,v_Dependents_money FROM PayrollCountyTax WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND UPPER(State) = UPPER(v_State)
   AND UPPER(County) = UPPER(v_County);

	

   select   IFNULL(Deductions,0), IFNULL(NetPay,0) INTO v_DEDUCTIONS,v_Net FROM PayrollRegister WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND EmployeeID = v_EmployeeID
   AND PayrollID = v_PayrollID;



   OPEN PayrollCountyTaxTa;
   SET NO_DATA = 0;
   FETCH PayrollCountyTaxTa INTO v_OverAmnt,v_NotOver,v_TaxBracket,v_Cumulative,v_WithholdingStatus;
   SWL_Label:
   WHILE NO_DATA = 0 DO

      select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID   LIMIT 1;
      IF v_WithholdingStatus = 'Single' then

         SET v_NetTaxableIncome = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_AnnualGrossPay -v_StandardDeductSingle -(v_Exemption_money*v_CountyAllowance) -(v_Dependents*v_Dependents_money), 
         v_CompanyCurrencyID);
      ELSE
         IF v_WithholdingStatus = 'Married' then
		
            SET v_NetTaxableIncome = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_AnnualGrossPay -v_StandardDeductJoint -(v_Exemption_money*v_CountyAllowance) -(v_Dependents*v_Dependents_money), 
            v_CompanyCurrencyID);
         end if;
      end if;


      IF (v_NetTaxableIncome >= v_OverAmnt) AND (v_NetTaxableIncome < v_NotOver) then
	
		
         SET v_WithholdingTax =(v_NetTaxableIncome -v_OverAmnt)*v_TaxBracket/100+v_Cumulative;
         LEAVE SWL_Label;
      ELSE 
         SET NO_DATA = 0;
         FETCH PayrollCountyTaxTa INTO v_OverAmnt,v_NotOver,v_TaxBracket,v_Cumulative,v_WithholdingStatus;
      end if;
   END WHILE;


   CLOSE PayrollCountyTaxTa;




   SET v_WithholdingTax = IFNULL(v_WithholdingTax,0);
   SET v_DEDUCTIONS = IFNULL(v_DEDUCTIONS,0)+v_WithholdingTax;
   SET v_Net = IFNULL(v_Net,0) -v_WithholdingTax;

   SET @SWV_Error = 0;
   UPDATE
   PayrollRegister
   SET
   CountyTax = v_WithholdingTax,Deductions = v_DEDUCTIONS,NetPay = v_Net
   WHERE
   CompanyID = v_CompanyID
   AND DivisionID = v_DivisionID
   AND DepartmentID = v_DepartmentID
   AND EmployeeID = v_EmployeeID
   AND PayrollID = v_PayrollID;

   IF @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Update PayrollRegister failed';
      ROLLBACK;

      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_WithholdingTax_County',
      v_ErrorMessage,v_ErrorID);
      SET SWP_Ret_Value = -1;
   end if;



   COMMIT;

   SET SWP_Ret_Value = 0;
   LEAVE SWL_return;



   ROLLBACK;

   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_WithholdingTax_County',
   v_ErrorMessage,v_ErrorID);

   SET SWP_Ret_Value = -1;
END