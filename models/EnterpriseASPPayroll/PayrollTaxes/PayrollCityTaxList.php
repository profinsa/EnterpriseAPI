<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollcitytax";
protected $gridFields =["State","County","City","StateName","CountyName","CityName","CityRate","CityWageBase","CityUIIRate","CityOtherWageBase","CityUIWageBase","CityOtherRate"];
public $dashboardTitle ="PayrollCityTax";
public $breadCrumbTitle ="PayrollCityTax";
public $idField ="State";
public $idFields = ["CompanyID","DivisionID","DepartmentID","State","County","City"];
public $editCategories = [
"Main" => [

"State" => [
"inputType" => "text",
"defaultValue" => ""
],
"County" => [
"inputType" => "text",
"defaultValue" => ""
],
"City" => [
"inputType" => "text",
"defaultValue" => ""
],
"StateName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CountyName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CityName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CityRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"CityWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"CityUIIRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"CityUIWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"CityOtherRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"CityOtherWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"StandardDeductSingle" => [
"inputType" => "text",
"defaultValue" => ""
],
"StandardDeductJoint" => [
"inputType" => "text",
"defaultValue" => ""
],
"Exemption" => [
"inputType" => "text",
"defaultValue" => ""
],
"Dependents" => [
"inputType" => "text",
"defaultValue" => ""
],
"Notes" => [
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
