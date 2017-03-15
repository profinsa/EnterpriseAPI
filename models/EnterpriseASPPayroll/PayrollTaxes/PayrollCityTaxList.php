<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollcitytax";
public $dashboardTitle ="PayrollCityTax";
public $breadCrumbTitle ="PayrollCityTax";
public $idField ="State";
public $idFields = ["CompanyID","DivisionID","DepartmentID","State","County","City"];
public $gridFields = [

"State" => [
    "dbType" => "varchar(2)",
    "inputType" => "text"
],
"County" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"City" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"StateName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CountyName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CityName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CityRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CityWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CityUIIRate" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CityOtherWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CityUIWageBase" => [
    "dbType" => "double",
    "inputType" => "text"
],
"CityOtherRate" => [
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
"City" => [
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
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CityName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CityRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CityWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CityUIIRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CityUIWageBase" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CityOtherRate" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"CityOtherWageBase" => [
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
"City" => "City",
"StateName" => "State Name",
"CountyName" => "County Name",
"CityName" => "City Name",
"CityRate" => "City Rate",
"CityWageBase" => "City WageBase",
"CityUIIRate" => "City UIIRate",
"CityOtherWageBase" => "City Other Wage Base",
"CityUIWageBase" => "City UI Wage Base",
"CityOtherRate" => "City Other Rate",
"StandardDeductSingle" => "StandardDeductSingle",
"StandardDeductJoint" => "StandardDeductJoint",
"Exemption" => "Exemption",
"Dependents" => "Dependents",
"Notes" => "Notes"];
}?>
