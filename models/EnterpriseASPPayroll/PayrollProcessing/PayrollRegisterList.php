<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollregister";
public $gridFields =["PayrollID","EmployeeID","PayrollDate","PayPeriodStartDate","PayPeriodEndDate","CheckTypeID","PayrollCheckDate","CheckNumber","NetPay"];
public $dashboardTitle ="PayrollRegister";
public $breadCrumbTitle ="PayrollRegister";
public $idField ="PayrollID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PayrollID","EmployeeID"];
public $editCategories = [
"Main" => [

"PayrollID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PayrollDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"PayPeriodStartDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"PayPeriodEndDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"PaidThrough" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"CheckTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PayrollCheckDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"SystemDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"CheckNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"PreTax" => [
"inputType" => "text",
"defaultValue" => ""
],
"YTDGross" => [
"inputType" => "text",
"defaultValue" => ""
],
"Gross" => [
"inputType" => "text",
"defaultValue" => ""
],
"AGI" => [
"inputType" => "text",
"defaultValue" => ""
],
"FICA" => [
"inputType" => "text",
"defaultValue" => ""
],
"FICAER" => [
"inputType" => "text",
"defaultValue" => ""
],
"FIT" => [
"inputType" => "text",
"defaultValue" => ""
],
"FUTA" => [
"inputType" => "text",
"defaultValue" => ""
],
"StateTax" => [
"inputType" => "text",
"defaultValue" => ""
],
"CountyTax" => [
"inputType" => "text",
"defaultValue" => ""
],
"CityTax" => [
"inputType" => "text",
"defaultValue" => ""
],
"FICAMed" => [
"inputType" => "text",
"defaultValue" => ""
],
"SUTA" => [
"inputType" => "text",
"defaultValue" => ""
],
"SIT" => [
"inputType" => "text",
"defaultValue" => ""
],
"SDI" => [
"inputType" => "text",
"defaultValue" => ""
],
"LUI" => [
"inputType" => "text",
"defaultValue" => ""
],
"Additions" => [
"inputType" => "text",
"defaultValue" => ""
],
"Commission" => [
"inputType" => "text",
"defaultValue" => ""
],
"Deductions" => [
"inputType" => "text",
"defaultValue" => ""
],
"NetPay" => [
"inputType" => "text",
"defaultValue" => ""
],
"Voided" => [
"inputType" => "text",
"defaultValue" => ""
],
"Reconciled" => [
"inputType" => "text",
"defaultValue" => ""
],
"Printed" => [
"inputType" => "text",
"defaultValue" => ""
],
"RegularHours" => [
"inputType" => "text",
"defaultValue" => ""
],
"OvertimeHours" => [
"inputType" => "text",
"defaultValue" => ""
],
"OvertimeRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"HourlyRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"Amount" => [
"inputType" => "text",
"defaultValue" => ""
],
"Posted" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PayrollID" => "Payroll ID",
"EmployeeID" => "Employee ID",
"PayrollDate" => "Payroll Date",
"PayPeriodStartDate" => "Pay Period Start Date",
"PayPeriodEndDate" => "Pay Period End Date",
"CheckTypeID" => "Check Type ID",
"PayrollCheckDate" => "Check Date",
"CheckNumber" => "Check Number",
"NetPay" => "Net Pay",
"PaidThrough" => "PaidThrough",
"SystemDate" => "SystemDate",
"PreTax" => "PreTax",
"YTDGross" => "YTDGross",
"Gross" => "Gross",
"AGI" => "AGI",
"FICA" => "FICA",
"FICAER" => "FICAER",
"FIT" => "FIT",
"FUTA" => "FUTA",
"StateTax" => "StateTax",
"CountyTax" => "CountyTax",
"CityTax" => "CityTax",
"FICAMed" => "FICAMed",
"SUTA" => "SUTA",
"SIT" => "SIT",
"SDI" => "SDI",
"LUI" => "LUI",
"Additions" => "Additions",
"Commission" => "Commission",
"Deductions" => "Deductions",
"Voided" => "Voided",
"Reconciled" => "Reconciled",
"Printed" => "Printed",
"RegularHours" => "RegularHours",
"OvertimeHours" => "OvertimeHours",
"OvertimeRate" => "OvertimeRate",
"HourlyRate" => "HourlyRate",
"Amount" => "Amount",
"Posted" => "Posted"];
}?>
