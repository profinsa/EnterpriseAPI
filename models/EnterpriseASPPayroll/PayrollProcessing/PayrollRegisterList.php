<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollregister";
public $dashboardTitle ="PayrollRegister";
public $breadCrumbTitle ="PayrollRegister";
public $idField ="PayrollID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PayrollID","EmployeeID"];
public $gridFields = [

"PayrollID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PayrollDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"PayPeriodStartDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"PayPeriodEndDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"CheckTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PayrollCheckDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"CheckNumber" => [
    "dbType" => "varchar(20)",
    "inputType" => "text"
],
"NetPay" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PayrollID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PayrollDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PayPeriodStartDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PayPeriodEndDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"PaidThrough" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"CheckTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PayrollCheckDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"SystemDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"CheckNumber" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"PreTax" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"YTDGross" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Gross" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"AGI" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"FICA" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"FICAER" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"FIT" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"FUTA" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"StateTax" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"CountyTax" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"CityTax" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"FICAMed" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"SUTA" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"SIT" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"SDI" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"LUI" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Additions" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Commission" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Deductions" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"NetPay" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Voided" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Reconciled" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"Printed" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
],
"RegularHours" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"OvertimeHours" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"OvertimeRate" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"HourlyRate" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Amount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Posted" => [
"dbType" => "tinyint(1)",
"inputType" => "checkbox",
"defaultValue" => "0"
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
