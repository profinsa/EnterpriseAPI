CREATE FUNCTION Payroll_Basis_GROSS_PayrollRegisterDetail (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36),
	v_PayrollID NATIONAL VARCHAR(36),
	v_PayrollItemID NATIONAL VARCHAR(36),
	v_Check NATIONAL VARCHAR(36)) BEGIN








   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);

   DECLARE v_GROSS REAL; 
   DECLARE v_AGI REAL; 
   DECLARE v_Net REAL; 
   DECLARE v_Basis NATIONAL VARCHAR(36);
   DECLARE v_TotalAmount DECIMAL(19,4);
   DECLARE v_PercentAmount FLOAT; 
   DECLARE v_EmployerPercentAmount FLOAT; 
   DECLARE v_EmployerTotalAmount DECIMAL(19,4);
   DECLARE v_MinMax DECIMAL(19,4);
   DECLARE v_HighLow INT;
   DECLARE v_MaxValue DECIMAL(19,4);
   DECLARE v_ItemTotalAmount DECIMAL(19,4);
   DECLARE v_ItemPercent FLOAT;
   DECLARE v_EmployerItemPercent FLOAT;
   DECLARE v_EmployerItemAmount DECIMAL(19,4);
   DECLARE v_Type NATIONAL VARCHAR(36);

   DECLARE v_Description NATIONAL VARCHAR(80);
   DECLARE v_YTDMax DECIMAL(19,4);
   DECLARE v_Minimum DECIMAL(19,4);
   DECLARE v_WageHigh DECIMAL(19,4);
   DECLARE v_WageLow DECIMAL(19,4);
   DECLARE v_ItemAmount DECIMAL(19,4);
   DECLARE v_ApplyItem BOOLEAN;
   DECLARE v_GLEmployeeCreditAccount NATIONAL VARCHAR(36);
   DECLARE v_GLEmployerDebitAccount NATIONAL VARCHAR(36);
   DECLARE v_GLEmployerCreditAccount NATIONAL VARCHAR(36);
   DECLARE v_Employer BOOLEAN;


   DECLARE v_ErrorID INT;
   DECLARE v_CompanyCurrencyID NATIONAL VARCHAR(3);
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   SET @SWV_Error = 0;
   SET v_ApplyItem = 1;

   select   IFNULL(PayrollItemDescription,0), IFNULL(YTDMaximum,0), IFNULL(Minimum,0), IFNULL(WageHigh,0), IFNULL(WageLow,0), IFNULL(ItemAmount,0), IFNULL(GLEmployeeCreditAccount,0), IFNULL(GLEmployerDebitAccount,0), IFNULL(GLEmployerCreditAccount,0), IFNULL(Employer,0), IFNULL(ItemPercent,0), IFNULL(EmployerItemPercent,0), IFNULL(EmployerItemAmount,0), IFNULL(PayrollItemTypeID,0), IFNULL(Basis,0) INTO v_Description,v_YTDMax,v_Minimum,v_WageHigh,v_WageLow,v_ItemAmount,v_GLEmployeeCreditAccount,
   v_GLEmployerDebitAccount,v_GLEmployerCreditAccount,
   v_Employer,v_ItemPercent,v_EmployerItemPercent,v_EmployerItemAmount,
   v_Type,v_Basis FROM PayrollItems WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
   AND UPPER(PayrollItemID) = UPPER(v_PayrollItemID);



   select   IFNULL(Gross,0), IFNULL(AGI,0), IFNULL(NetPay,0) INTO v_GROSS,v_AGI,v_Net FROM PayrollRegister WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
   AND UPPER(PayrollID) = UPPER(v_PayrollID); 	

   INSERT INTO PayrollRegisterDetail(CompanyID,
	DivisionID,
	DepartmentID,
	PayrollID,
	PayrollItemID,
	EmployeeID)
VALUES(v_CompanyID,
	v_DivisionID,
	v_DepartmentID,
	v_PayrollID,
	v_PayrollItemID,
	v_EmployeeID);




   IF v_Basis = UPPER('Gross') then

      SET @SWV_Error = 0;
      SET v_ReturnStatus = Payroll_ItemTotalAmount(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_PayrollItemID,
      v_Check,v_ItemTotalAmount);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Call enterprise.Payroll_ItemTotalAmount failed';
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
         v_ErrorMessage,v_ErrorID);
         RETURN -1;
      end if;

	
	

      SET @SWV_Error = 0;
      SET v_ReturnStatus = Payroll_TestMinMax(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_PayrollItemID,
      v_Check,v_MinMax);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Call enterprise.Payroll_TestMinMax failed';
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
         v_ErrorMessage,v_ErrorID);
         RETURN -1;
      end if;
	
	
      SET @SWV_Error = 0;
      SET v_ReturnStatus = Payroll_TestHighLow(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_HighLow);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Call enterprise.Payroll_TestHighLow failed';
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
         v_ErrorMessage,v_ErrorID);
         RETURN -1;
      end if;
      SET @SWV_Error = 0;
      SET v_ReturnStatus = Payroll_ItemTotalAmount(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_PayrollItemID,
      v_Check,v_MaxValue);
      IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
         SET v_ErrorMessage = 'Call enterprise.Payroll_ItemTotalAmount failed';
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
         v_ErrorMessage,v_ErrorID);
         RETURN -1;
      end if;
      IF v_HighLow = 0 then

         SET @SWV_Error = 0;
         UPDATE PayrollItems
         SET
         TotalAmount = 0,PercentAmount = 0,EmployerPercentAmount = 0,EmployerTotalAmount = 0
         WHERE
         UPPER(CompanyID) = UPPER(v_CompanyID)
         AND UPPER(DivisionID) = UPPER(v_DivisionID)
         AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
         AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
         AND UPPER(PayrollItemID) = UPPER(v_PayrollItemID);
         IF @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'UPDATE PayrollItems failed';
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
            v_ErrorMessage,v_ErrorID);
            RETURN -1;
         end if;
      end if;
      IF v_MaxValue > 0 then 
         SET v_ItemTotalAmount = v_MaxValue;
      ELSE
         IF v_MaxValue = -1 then
	
            SET @SWV_Error = 0;
            UPDATE PayrollItems
            SET
            TotalAmount = 0,PercentAmount = 0,EmployerPercentAmount = 0,EmployerTotalAmount = 0
            WHERE
            UPPER(CompanyID) = UPPER(v_CompanyID)
            AND UPPER(DivisionID) = UPPER(v_DivisionID)
            AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
            AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
            AND UPPER(PayrollItemID) = UPPER(v_PayrollItemID);
            IF @SWV_Error <> 0 then
		
               SET v_ErrorMessage = 'UPDATE PayrollItems failed';
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
               v_ErrorMessage,v_ErrorID);
               RETURN -1;
            end if;
         end if;
      end if;
      select   IFNULL(CurrencyID,N'') INTO v_CompanyCurrencyID FROM Companies WHERE CompanyID = v_CompanyID AND
      DivisionID = v_DivisionID AND
      DepartmentID = v_DepartmentID   LIMIT 1;
      SET v_TotalAmount = IFNULL(v_ItemTotalAmount,0);
      SET v_PercentAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_GROSS*(v_ItemPercent/100),v_CompanyCurrencyID);
      SET v_EmployerPercentAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_GROSS*(v_EmployerItemPercent/100), 
      v_CompanyCurrencyID);
      SET v_EmployerTotalAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployerItemAmount+v_GROSS*(v_EmployerItemPercent/100), 
      v_CompanyCurrencyID);
      SET @SWV_Error = 0;
      UPDATE PayrollItems
      SET
      TotalAmount = v_TotalAmount,PercentAmount = v_PercentAmount,EmployerPercentAmount = v_EmployerPercentAmount,
      EmployerTotalAmount = v_EmployerTotalAmount
      WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID)
      AND UPPER(DivisionID) = UPPER(v_DivisionID)
      AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
      AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
      AND UPPER(PayrollItemID) = UPPER(v_PayrollItemID);
      IF @SWV_Error <> 0 then

         SET v_ErrorMessage = 'UPDATE PayrollItems failed';
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
         v_ErrorMessage,v_ErrorID);
         RETURN -1;
      end if;
      SET @SWV_Error = 0;
      UPDATE PayrollRegisterDetail
      SET
      TotalAmount = v_TotalAmount,PercentAmount = v_PercentAmount,EmployerPercentAmount = v_EmployerPercentAmount,
      EmployerTotalAmount = v_EmployerTotalAmount
      WHERE
      UPPER(CompanyID) = UPPER(v_CompanyID)
      AND UPPER(DivisionID) = UPPER(v_DivisionID)
      AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
      AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
      AND UPPER(PayrollItemID) = UPPER(v_PayrollItemID);
      IF @SWV_Error <> 0 then

         SET v_ErrorMessage = 'UPDATE PayrollRegisterDetail failed';
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
         v_ErrorMessage,v_ErrorID);
         RETURN -1;
      end if;
   ELSE
      IF v_Basis = UPPER('AGI') then

         SET @SWV_Error = 0;
         SET v_ReturnStatus = Payroll_ItemTotalAmount(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_PayrollItemID,
         v_Check,v_ItemTotalAmount);
         IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'Call enterprise.Payroll_ItemTotalAmount failed';
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
            v_ErrorMessage,v_ErrorID);
            RETURN -1;
         end if;

	
	

         SET @SWV_Error = 0;
         SET v_ReturnStatus = Payroll_TestMinMax(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_PayrollItemID,
         v_Check,v_MinMax);
         IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'Call enterprise.Payroll_TestMinMax failed';
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
            v_ErrorMessage,v_ErrorID);
            RETURN -1;
         end if;

	
	

         SET @SWV_Error = 0;
         SET v_ReturnStatus = Payroll_TestHighLow(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_HighLow);
         IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'Call enterprise.Payroll_TestHighLow failed';
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
            v_ErrorMessage,v_ErrorID);
            RETURN -1;
         end if;
         SET @SWV_Error = 0;
         SET v_ReturnStatus = Payroll_ItemTotalAmount(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_PayrollItemID,
         v_Check,v_MaxValue);
         IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
            SET v_ErrorMessage = 'Call enterprise.Payroll_ItemTotalAmoun failed';
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
            v_ErrorMessage,v_ErrorID);
            RETURN -1;
         end if;
         IF v_HighLow = 0 then

            SET @SWV_Error = 0;
            UPDATE PayrollItems
            SET
            TotalAmount = 0,PercentAmount = 0,EmployerPercentAmount = 0,EmployerTotalAmount = 0
            WHERE
            UPPER(CompanyID) = UPPER(v_CompanyID)
            AND UPPER(DivisionID) = UPPER(v_DivisionID)
            AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
            AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
            AND UPPER(PayrollItemID) = UPPER(v_PayrollItemID);
            IF @SWV_Error <> 0 then
	
               SET v_ErrorMessage = 'UPDATE PayrollItems failed';
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
               v_ErrorMessage,v_ErrorID);
               RETURN -1;
            end if;
         end if;
         IF v_MaxValue > 0 then 
            SET v_ItemTotalAmount = v_MaxValue;
         ELSE
            IF v_MaxValue = -1 then
	
               SET @SWV_Error = 0;
               UPDATE PayrollItems
               SET
               TotalAmount = 0,PercentAmount = 0,EmployerPercentAmount = 0,EmployerTotalAmount = 0
               WHERE
               UPPER(CompanyID) = UPPER(v_CompanyID)
               AND UPPER(DivisionID) = UPPER(v_DivisionID)
               AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
               AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
               AND UPPER(PayrollItemID) = UPPER(v_PayrollItemID);
               IF @SWV_Error <> 0 then
		
                  SET v_ErrorMessage = 'UPDATE PayrollItems failed';
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
                  v_ErrorMessage,v_ErrorID);
                  RETURN -1;
               end if;
            end if;
         end if;
         SET v_TotalAmount = IFNULL(v_ItemTotalAmount,0);
         SET v_PercentAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_AGI*(v_ItemPercent/100),v_CompanyCurrencyID);
         SET v_EmployerPercentAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_AGI*(v_EmployerItemPercent/100), 
         v_CompanyCurrencyID);
         SET v_EmployerTotalAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployerItemAmount+v_AGI*(v_EmployerItemPercent/100), 
         v_CompanyCurrencyID);
         SET @SWV_Error = 0;
         UPDATE PayrollItems
         SET
         TotalAmount = v_TotalAmount,PercentAmount = v_PercentAmount,EmployerPercentAmount = v_EmployerPercentAmount,
         EmployerTotalAmount = v_EmployerTotalAmount
         WHERE
         UPPER(CompanyID) = UPPER(v_CompanyID)
         AND UPPER(DivisionID) = UPPER(v_DivisionID)
         AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
         AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
         AND UPPER(PayrollItemID) = UPPER(v_PayrollItemID);
         IF @SWV_Error <> 0 then

            SET v_ErrorMessage = 'UPDATE PayrollItems failed';
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
            v_ErrorMessage,v_ErrorID);
            RETURN -1;
         end if;
      ELSE
         IF v_Basis = UPPER('Net') then

            SET @SWV_Error = 0;
            SET v_ReturnStatus = Payroll_ItemTotalAmount(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_PayrollItemID,
            v_Check,v_ItemTotalAmount);
            IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
               SET v_ErrorMessage = 'Call enterprise.Payroll_ItemTotalAmount failed';
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
               v_ErrorMessage,v_ErrorID);
               RETURN -1;
            end if;

	
	

            SET @SWV_Error = 0;
            SET v_ReturnStatus = Payroll_TestMinMax(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_PayrollItemID,
            v_Check,v_MinMax);
            IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
               SET v_ErrorMessage = 'Call enterprise.Payroll_TestMinMax failed';
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
               v_ErrorMessage,v_ErrorID);
               RETURN -1;
            end if;


	
	

            SET @SWV_Error = 0;
            SET v_ReturnStatus = Payroll_TestHighLow(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_HighLow);
            IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
               SET v_ErrorMessage = 'Call enterprise.Payroll_TestHighLow failed';
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
               v_ErrorMessage,v_ErrorID);
               RETURN -1;
            end if;
            SET @SWV_Error = 0;
            SET v_ReturnStatus = Payroll_ItemTotalAmount(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployeeID,v_PayrollID,v_PayrollItemID,
            v_Check,v_MaxValue);
            IF v_ReturnStatus <> 0 OR @SWV_Error <> 0 then
	
               SET v_ErrorMessage = 'Call enterprise.Payroll_ItemTotalAmount failed';
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
               v_ErrorMessage,v_ErrorID);
               RETURN -1;
            end if;
            IF v_HighLow = 0 then

               SET @SWV_Error = 0;
               UPDATE PayrollItems
               SET
               TotalAmount = 0,PercentAmount = 0,EmployerPercentAmount = 0,EmployerTotalAmount = 0
               WHERE
               UPPER(CompanyID) = UPPER(v_CompanyID)
               AND UPPER(DivisionID) = UPPER(v_DivisionID)
               AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
               AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
               AND UPPER(PayrollItemID) = UPPER(v_PayrollItemID);
               IF  @SWV_Error <> 0 then
	
                  SET v_ErrorMessage = 'UPDATE PayrollItems failed';
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
                  v_ErrorMessage,v_ErrorID);
                  RETURN -1;
               end if;
            end if;
            IF v_MaxValue > 0 then 
               SET v_ItemTotalAmount = v_MaxValue;
            ELSE
               IF v_MaxValue = -1 then
	
                  SET @SWV_Error = 0;
                  UPDATE PayrollItems
                  SET
                  TotalAmount = 0,PercentAmount = 0,EmployerPercentAmount = 0,EmployerTotalAmount = 0
                  WHERE
                  UPPER(CompanyID) = UPPER(v_CompanyID)
                  AND UPPER(DivisionID) = UPPER(v_DivisionID)
                  AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
                  AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
                  AND UPPER(PayrollItemID) = UPPER(v_PayrollItemID);
                  IF  @SWV_Error <> 0 then
		
                     SET v_ErrorMessage = 'UPDATE PayrollItems failed';
                     CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
                     v_ErrorMessage,v_ErrorID);
                     RETURN -1;
                  end if;
               end if;
            end if;
            SET v_TotalAmount = IFNULL(v_ItemTotalAmount,0);
            SET v_PercentAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Net*(v_ItemPercent/100),v_CompanyCurrencyID);
            SET v_EmployerPercentAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_Net*(v_EmployerItemPercent/100), 
            v_CompanyCurrencyID);
            SET v_EmployerTotalAmount = fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,v_EmployerItemAmount+v_Net*(v_EmployerItemPercent/100), 
            v_CompanyCurrencyID);
            SET @SWV_Error = 0;
            UPDATE PayrollItems
            SET
            TotalAmount = v_TotalAmount,PercentAmount = v_PercentAmount,EmployerPercentAmount = v_EmployerPercentAmount,
            EmployerTotalAmount = v_EmployerTotalAmount
            WHERE
            UPPER(CompanyID) = UPPER(v_CompanyID)
            AND UPPER(DivisionID) = UPPER(v_DivisionID)
            AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
            AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
            AND UPPER(PayrollItemID) = UPPER(v_PayrollItemID);
            IF  @SWV_Error <> 0 then

               SET v_ErrorMessage = 'UPDATE PayrollItems failed';
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
               v_ErrorMessage,v_ErrorID);
               RETURN -1;
            end if;
         end if;
      end if;
   end if;


   SET @SWV_Error = 0;
   UPDATE PayrollRegisterDetail
   SET
   CompanyID = v_CompanyID,DivisionID = v_DivisionID,DepartmentID = v_DepartmentID,
   PayrollID = v_PayrollID,PayrollItemID = v_PayrollItemID,EmployeeID = v_EmployeeID,
   Description = v_Description,Basis = v_Basis,Type = v_Type,YTDMax = v_YTDMax,
   Minimum = v_Minimum,WageHigh = v_WageHigh,WageLow = v_WageLow,ItemAmount = v_ItemAmount,
   ItemPercent = v_ItemPercent,PercentAmount = v_PercentAmount,
   TotalAmount = v_ItemTotalAmount,ApplyItem = v_ApplyItem,GLEmployeeCreditAccount = v_GLEmployeeCreditAccount,
   GLEmployerDebitAccount = v_GLEmployerDebitAccount,
   GLEmployerCreditAccount = v_GLEmployerCreditAccount,EmployerItemAmount = v_EmployerItemAmount,
   EmployerItemPercent = v_EmployerItemPercent,
   EmployerPercentAmount = v_EmployerPercentAmount,EmployerTotalAmount = v_EmployerTotalAmount,
   Employer = v_Employer
   WHERE
   UPPER(CompanyID) = UPPER(v_CompanyID)
   AND UPPER(DivisionID) = UPPER(v_DivisionID)
   AND UPPER(DepartmentID) = UPPER(v_DepartmentID)
   AND UPPER(EmployeeID) = UPPER(v_EmployeeID)
   AND UPPER(PayrollID) = UPPER(v_PayrollID)
   AND UPPER(PayrollItemID) = UPPER(v_PayrollItemID);

   IF  @SWV_Error <> 0 then

      SET v_ErrorMessage = 'Insert into PayrollRegisterDetail failed';
      CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
      v_ErrorMessage,v_ErrorID);
      RETURN -1;
   end if;
   RETURN 0;












   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'Payroll_Basis_GROSS_PayrollRegisterDetail',
   v_ErrorMessage,v_ErrorID);

   RETURN -1;
END