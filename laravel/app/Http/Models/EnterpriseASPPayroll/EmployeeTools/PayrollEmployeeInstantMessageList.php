<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeeinstantmessage";
protected $gridFields =["InstantMessageID","EmployeeID","EmployeeEmail"];
public $dashboardTitle ="PayrollEmployeeInstantMessage";
public $breadCrumbTitle ="PayrollEmployeeInstantMessage";
public $idField ="InstantMessageID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","InstantMessageID"];
public $editCategories = [
"Main" => [

"InstantMessageID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeEmail" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"InstantMessageID" => "Message ID",
"EmployeeID" => "Employee ID",
"EmployeeEmail" => "Employee Email"];
}?>
