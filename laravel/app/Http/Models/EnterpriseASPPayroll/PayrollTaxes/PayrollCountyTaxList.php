<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollcountytax";
public $dashboardTitle ="PayrollCountyTax";
public $breadCrumbTitle ="PayrollCountyTax";
public $idField ="State";
public $idFields = ["CompanyID","DivisionID","DepartmentID","State","County"];
public $gridFields = [

"State" => [
    "dbType" => "varchar(2)",
    "inputType" => "text"
],
"County" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"StateName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CountyName" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CountyRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CountyWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CountyUIIRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CountyUIWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CountyOtherRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CountyOtherWageBase" => [
    "dbType" => "double",
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
"County" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"StateName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CountyName" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CountyRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CountyWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CountyUIIRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CountyUIWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CountyOtherRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CountyOtherWageBase" => [
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
]
]];
public $columnNames = [

"State" => "State",
"County" => "County",
"StateName" => "State Name",
"CountyName" => "County Name",
"CountyRate" => "County Rate",
"CountyWageBase" => "County Wage Base",
"CountyUIIRate" => "County UII Rate",
"CountyUIWageBase" => "County UI Wage Base",
"CountyOtherRate" => "County Other Rate",
"CountyOtherWageBase" => "County Other Wage Base",
"StandardDeductSingle" => "StandardDeductSingle",
"StandardDeductJoint" => "StandardDeductJoint",
"Exemption" => "Exemption",
"Dependents" => "Dependents",
"Notes" => "Notes"];
}?>
