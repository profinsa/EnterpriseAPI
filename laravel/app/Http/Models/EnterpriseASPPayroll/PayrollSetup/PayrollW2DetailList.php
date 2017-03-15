<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollw2detail";
public $dashboardTitle ="PayrollW2Detail";
public $breadCrumbTitle ="PayrollW2Detail";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"W2Year" => [
    "dbType" => "varchar(4)",
    "inputType" => "text"
],
"W2ControlNumber" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"EmployeeName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"EmployeeSSNumber" => [
    "dbType" => "varchar(15)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Year" => [
"dbType" => "varchar(4)",
"inputType" => "text",
"defaultValue" => ""
],
"W2ControlNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeSSNumber" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeAddress1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeAddress2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeCity" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeState" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeZip" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeCountry" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Box1" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box2" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box3" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box4" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box5" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box6" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box7" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box8" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box9" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box10" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box11" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box12" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box13" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box13b" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Box14" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box15" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Box15Check1" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Box15Check2" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Box15Check3" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Box15Check4" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Box15Check5" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Box15Check6" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Box15Check7" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Box17" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box18" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box19" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box20" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Box21" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"W2Year" => "W2 Year",
"W2ControlNumber" => "W2 Control Number",
"EmployeeName" => "Employee Name",
"EmployeeSSNumber" => "Employee SS Number",
"EmployeeAddress1" => "EmployeeAddress1",
"EmployeeAddress2" => "EmployeeAddress2",
"EmployeeCity" => "EmployeeCity",
"EmployeeState" => "EmployeeState",
"EmployeeZip" => "EmployeeZip",
"EmployeeCountry" => "EmployeeCountry",
"Box1" => "Box1",
"Box2" => "Box2",
"Box3" => "Box3",
"Box4" => "Box4",
"Box5" => "Box5",
"Box6" => "Box6",
"Box7" => "Box7",
"Box8" => "Box8",
"Box9" => "Box9",
"Box10" => "Box10",
"Box11" => "Box11",
"Box12" => "Box12",
"Box13" => "Box13",
"Box13b" => "Box13b",
"Box14" => "Box14",
"Box15" => "Box15",
"Box15Check1" => "Box15Check1",
"Box15Check2" => "Box15Check2",
"Box15Check3" => "Box15Check3",
"Box15Check4" => "Box15Check4",
"Box15Check5" => "Box15Check5",
"Box15Check6" => "Box15Check6",
"Box15Check7" => "Box15Check7",
"Box17" => "Box17",
"Box18" => "Box18",
"Box19" => "Box19",
"Box20" => "Box20",
"Box21" => "Box21"];
}?>
