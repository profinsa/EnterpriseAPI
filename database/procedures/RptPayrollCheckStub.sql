CREATE PROCEDURE RptPayrollCheckStub (v_CompanyID NATIONAL VARCHAR(36),
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_EmployeeID NATIONAL VARCHAR(36) ,
	v_CheckNumber NATIONAL VARCHAR(20) ,INOUT SWP_Ret_Value INT) BEGIN



   SELECT
   PayrollEmployees.EmployeeName,
		PayrollEmployees.EmployeeSSNumber,
		PayrollRegister.PayPeriodStartDate,
		PayrollRegister.PayPeriodEndDate,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,PayrollRegister.Gross,N'') AS Gross,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,PayrollRegister.NetPay,N'') AS NetPay,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,PayrollRegister.FICA,N'') AS FICA,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,PayrollRegister.FIT,N'') AS FIT,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,PayrollRegister.SIT,N'') AS SIT,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,PayrollRegister.CityTax,N'') AS CityTax,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,PayrollEmployeesDetail.YearToDateGross,
   N'') AS YearToDateGross,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,PayrollEmployeesDetail.YearToDateFICA,
   N'') AS YearToDateFICA,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,PayrollEmployeesDetail.YearToDateFIT,
   N'') AS YearToDateFIT,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,PayrollEmployeesDetail.YearToDateSIT,
   N'') AS YearToDateSIt,
		fnRound(v_CompanyID,v_DivisionID,v_DepartmentID,PayrollEmployeesDetail.YearToDateLocal,
   N'') AS YearToDateLocal
   FROM
   PayrollEmployees INNER JOIN PayrollChecks AS PC ON
   PayrollEmployees.CompanyID = PC.CompanyID  AND
   PayrollEmployees.DivisionID = PC.DivisionID  AND
   PayrollEmployees.DepartmentID = PC.DepartmentID AND
   PayrollEmployees.EmployeeID = PC.EmployeeID
   INNER JOIN PayrollRegister ON
   PC.CompanyID = PayrollRegister.CompanyID AND
   PC.DivisionID = PayrollRegister.DivisionID AND
   PC.DepartmentID = PayrollRegister.DepartmentID AND
   PC.EmployeeID = PayrollRegister.EmployeeID AND
   PC.PayrollID = PayrollRegister.PayrollID
   INNER JOIN PayrollEmployeesDetail ON
   PayrollRegister.CompanyID = PayrollEmployeesDetail.CompanyID AND
   PayrollRegister.DivisionID = PayrollEmployeesDetail.DivisionID AND
   PayrollRegister.DepartmentID = PayrollEmployeesDetail.DepartmentID AND
   PayrollRegister.EmployeeID = PayrollEmployeesDetail.EmployeeID
   WHERE
   PC.CompanyID = v_CompanyID AND
   PC.DivisionID = v_DivisionID AND
   PC.DepartmentID = v_DepartmentID AND
   PC.EmployeeID = v_EmployeeID AND
   PC.CheckNumber = v_CheckNumber;



   SET SWP_Ret_Value = 0;
END