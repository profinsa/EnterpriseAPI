<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "errorlog";
public $dashboardTitle ="Error Log";
public $breadCrumbTitle ="Error Log";
public $idField ="ErrorID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ErrorID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ErrorDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"ErrorTime" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"ErrorCode" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"ErrorMessage" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ErrorID" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ErrorDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ErrorTime" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"ScreenName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ModuleName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ErrorCode" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"ErrorMessage" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"ProcedureName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CallTime" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Error" => [
"dbType" => "varchar(200)",
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
