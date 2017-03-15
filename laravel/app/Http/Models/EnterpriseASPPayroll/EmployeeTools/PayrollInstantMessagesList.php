<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollinstantmessages";
protected $gridFields =["InstantMessageID","InstantMessageText","EmployeeID","EmployeeEmail","TimeSent"];
public $dashboardTitle ="PayrollInstantMessages";
public $breadCrumbTitle ="PayrollInstantMessages";
public $idField ="InstantMessageID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","InstantMessageID"];
public $editCategories = [
"Main" => [

"InstantMessageID" => [
"inputType" => "text",
"defaultValue" => ""
],
"InstantMessageText" => [
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
],
"TimeSent" => [
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"InstantMessageID" => "Message ID",
"InstantMessageText" => "Message Text",
"EmployeeID" => "Employee ID",
"EmployeeEmail" => "Employee Email",
"TimeSent" => "Time Sent"];
}?>
