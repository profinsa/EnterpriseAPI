<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollw3detail";
public $dashboardTitle ="PayrollW3Detail";
public $breadCrumbTitle ="PayrollW3Detail";
public $idField ="ControlNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ControlNumber"];
public $gridFields = [

"ControlNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TotalNoStatements" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"EstablishmentNo" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"EmployerIdentifyicationNumber" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ControlNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TotalNoStatements" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"EstablishmentNo" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployerIdentifyicationNumber" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"OtherEmployerIdentifyicationNumber" => [
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
"Box15" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"_941" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Military" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"_943" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"CT1" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"Hshld" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"MedicareGovtEmp" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ControlNumber" => "Control Number",
"TotalNoStatements" => "Total No Statements",
"EstablishmentNo" => "Establishment No",
"EmployerIdentifyicationNumber" => "Employer Identifyication Number",
"OtherEmployerIdentifyicationNumber" => "OtherEmployerIdentifyicationNumber",
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
"Box15" => "Box15",
"_941" => "_941",
"Military" => "Military",
"_943" => "_943",
"CT1" => "CT1",
"Hshld" => "Hshld",
"MedicareGovtEmp" => "MedicareGovtEmp"];
}?>
