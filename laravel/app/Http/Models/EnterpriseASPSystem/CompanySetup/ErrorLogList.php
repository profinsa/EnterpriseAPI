<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "errorlog";
protected $gridFields =["EmployeeID","ErrorDate","ErrorTime","ErrorCode","ErrorMessage"];
public $dashboardTitle ="Error Log";
public $breadCrumbTitle ="Error Log";
public $idField ="ErrorID";
public $editCategories = [
"Main" => [

"ErrorID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ErrorDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"ErrorTime" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"ScreenName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ModuleName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ErrorCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"ErrorMessage" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProcedureName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CallTime" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"Error" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"ErrorDate" => "Error Date",
"ErrorTime" => "Error Time",
"ErrorCode" => "Error Code",
"ErrorMessage" => "Error Message",
"ErrorID" => "ErrorID",
"ScreenName" => "ScreenName",
"ModuleName" => "ModuleName",
"ProcedureName" => "ProcedureName",
"CallTime" => "CallTime",
"Error" => "Error"];
}?>
