<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollstatetax";
public $dashboardTitle ="PayrollStateTax";
public $breadCrumbTitle ="PayrollStateTax";
public $idField ="State";
public $idFields = ["CompanyID","DivisionID","DepartmentID","State"];
public $gridFields = [

"State" => [
    "dbType" => "varchar(2)",
    "inputType" => "text"
],
"StateName" => [
    "dbType" => "char(30)",
    "inputType" => "text"
],
"SUTARate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"SUTAWageBase" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"SITRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"SITWageBase" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"SDIRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"SDIWageBase" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"State" => [
"dbType" => "varchar(2)",
"inputType" => "text",
"defaultValue" => ""
],
"StateName" => [
"dbType" => "char(30)",
"inputType" => "text",
"defaultValue" => ""
],
"SUTARate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"SUTAWageBase" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"SITRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"SITWageBase" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"SDIRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"SDIWageBase" => [
"dbType" => "decimal(19,4)",
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
]
]];
public $columnNames = [

"State" => "State",
"StateName" => "State Name",
"SUTARate" => "SUTA Rate",
"SUTAWageBase" => "SUTA Wage Base",
"SITRate" => "SIT Rate",
"SITWageBase" => "SIT Wage Base",
"SDIRate" => "SDI Rate",
"SDIWageBase" => "SDI Wage Base",
"StandardDeductSingle" => "StandardDeductSingle",
"StandardDeductJoint" => "StandardDeductJoint",
"Exemption" => "Exemption",
"Dependents" => "Dependents",
"Notes" => "Notes"];
}?>
