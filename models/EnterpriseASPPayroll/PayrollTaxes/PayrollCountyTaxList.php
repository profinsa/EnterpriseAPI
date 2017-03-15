<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollcountytax";
protected $gridFields =["State","County","StateName","CountyName","CountyRate","CountyWageBase","CountyUIIRate","CountyUIWageBase","CountyOtherRate","CountyOtherWageBase"];
public $dashboardTitle ="PayrollCountyTax";
public $breadCrumbTitle ="PayrollCountyTax";
public $idField ="State";
public $idFields = ["CompanyID","DivisionID","DepartmentID","State","County"];
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
"StateName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CountyName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CountyRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"CountyWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"CountyUIIRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"CountyUIWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"CountyOtherRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"CountyOtherWageBase" => [
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
