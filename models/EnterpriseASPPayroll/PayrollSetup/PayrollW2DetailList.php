<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollw2detail";
public $gridFields =["EmployeeID","W2Year","W2ControlNumber","EmployeeName","EmployeeSSNumber"];
public $dashboardTitle ="PayrollW2Detail";
public $breadCrumbTitle ="PayrollW2Detail";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID"];
public $editCategories = [
"Main" => [

"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Year" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2ControlNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeName" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeSSNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeState" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box1" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box2" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box3" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box4" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box5" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box6" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box7" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box8" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box9" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box10" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box11" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box12" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box13" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box13b" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box14" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box15" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box15Check1" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box15Check2" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box15Check3" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box15Check4" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box15Check5" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box15Check6" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box15Check7" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box17" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box18" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box19" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box20" => [
"inputType" => "text",
"defaultValue" => ""
],
"Box21" => [
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
