<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollchecks";
protected $gridFields =["PayrollID","EmployeeID","PayrollCheckDate","StartDate","EndDate","CheckNumber","Amount"];
public $dashboardTitle ="PayrollChecks";
public $breadCrumbTitle ="PayrollChecks";
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
"PayrollCheckDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"StartDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"EndDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"CheckPrinted" => [
"inputType" => "text",
"defaultValue" => ""
],
"Amount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLEmployeeCreditAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"CheckNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"CheckTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"Apply" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PayrollID" => "Payroll ID",
"EmployeeID" => "Employee ID",
"PayrollCheckDate" => "Payroll Check Date",
"StartDate" => "Pay Period Start Date",
"EndDate" => "Pay Period End Date",
"CheckNumber" => "Check Number",
"Amount" => "Amount",
"CheckPrinted" => "CheckPrinted",
"GLEmployeeCreditAccount" => "GLEmployeeCreditAccount",
"CheckTypeID" => "CheckTypeID",
"CurrencyID" => "CurrencyID",
"Apply" => "Apply"];
}?>
