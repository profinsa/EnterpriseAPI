<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollfedtax";
public $dashboardTitle ="PayrollFedTax";
public $breadCrumbTitle ="PayrollFedTax";
public $idField ="Country";
public $idFields = ["CompanyID","DivisionID","DepartmentID","Country"];
public $gridFields = [

"Country" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"FITRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"FITWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"FICARate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"FICAWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"FUTARate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"FUTAWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"FICAMedRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"FICAMedWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"Country" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"FITRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FITWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FICARate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FICAWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FUTARate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FUTAWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FICAMedRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"FICAMedWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"StandardDeductSingle" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"StandardDeductJoint" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Exemption" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Dependents" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Notes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"CountryName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"Country" => "Country",
"FITRate" => "FIT Rate",
"FITWageBase" => "FIT Wage Base",
"FICARate" => "FICA Rate",
"FICAWageBase" => "FICA Wage Base",
"FUTARate" => "FUTA Rate",
"FUTAWageBase" => "FUTA Wage Base",
"FICAMedRate" => "FICA Med Rate",
"FICAMedWageBase" => "FICA Med Wage Base",
"StandardDeductSingle" => "StandardDeductSingle",
"StandardDeductJoint" => "StandardDeductJoint",
"Exemption" => "Exemption",
"Dependents" => "Dependents",
"Notes" => "Notes",
"CountryName" => "CountryName"];
}?>
