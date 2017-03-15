<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollstatetax";
public $gridFields =["State","StateName","SUTARate","SUTAWageBase","SITRate","SITWageBase","SDIRate","SDIWageBase"];
public $dashboardTitle ="PayrollStateTax";
public $breadCrumbTitle ="PayrollStateTax";
public $idField ="State";
public $idFields = ["CompanyID","DivisionID","DepartmentID","State"];
public $editCategories = [
"Main" => [

"State" => [
"inputType" => "text",
"defaultValue" => ""
],
"StateName" => [
"inputType" => "text",
"defaultValue" => ""
],
"SUTARate" => [
"inputType" => "text",
"defaultValue" => ""
],
"SUTAWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"SITRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"SITWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"SDIRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"SDIWageBase" => [
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
