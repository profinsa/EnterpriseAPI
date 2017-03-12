<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeesaccrual";
protected $gridFields =["EmployeeID","AmountAccrued","AmountUsed","LastAccrued"];
public $dashboardTitle ="PayrollEmployeesAccrual";
public $breadCrumbTitle ="PayrollEmployeesAccrual";
public $idField ="EmployeeID";
public $editCategories = [
"Main" => [

"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AmountAccrued" => [
"inputType" => "text",
"defaultValue" => ""
],
"AmountUsed" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastAccrued" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"Active" => [
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"AccrualID" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"AmountAccrued" => "Amount Accrued",
"AmountUsed" => "Amount Used",
"LastAccrued" => "Last Accrued",
"Active" => "Active",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate",
"AccrualID" => "AccrualID"];
}?>
