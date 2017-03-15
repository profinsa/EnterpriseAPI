<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollfedtax";
public $gridFields =["Country","FITRate","FITWageBase","FICARate","FICAWageBase","FUTARate","FUTAWageBase","FICAMedRate","FICAMedWageBase"];
public $dashboardTitle ="PayrollFedTax";
public $breadCrumbTitle ="PayrollFedTax";
public $idField ="Country";
public $idFields = ["CompanyID","DivisionID","DepartmentID","Country"];
public $editCategories = [
"Main" => [

"Country" => [
"inputType" => "text",
"defaultValue" => ""
],
"FITRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"FITWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"FICARate" => [
"inputType" => "text",
"defaultValue" => ""
],
"FICAWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"FUTARate" => [
"inputType" => "text",
"defaultValue" => ""
],
"FUTAWageBase" => [
"inputType" => "text",
"defaultValue" => ""
],
"FICAMedRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"FICAMedWageBase" => [
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
],
"CountryName" => [
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
