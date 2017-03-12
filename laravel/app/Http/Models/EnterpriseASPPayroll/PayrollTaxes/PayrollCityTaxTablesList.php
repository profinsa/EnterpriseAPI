<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollcitytaxtables";
protected $gridFields =["State","County","City","WithholdingStatus","TaxBracket","StatusType","OverAmnt","NotOver","Cumulative","PayrollYear"];
public $dashboardTitle ="PayrollCityTaxTables";
public $breadCrumbTitle ="PayrollCityTaxTables";
public $idField ="State";
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
"WithholdingStatus" => [
"inputType" => "text",
"defaultValue" => ""
],
"StatusType" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxBracket" => [
"inputType" => "text",
"defaultValue" => ""
],
"OverAmnt" => [
"inputType" => "text",
"defaultValue" => ""
],
"NotOver" => [
"inputType" => "text",
"defaultValue" => ""
],
"Cumulative" => [
"inputType" => "text",
"defaultValue" => ""
],
"PayrollYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"PayFrequency" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"State" => "State",
"County" => "County",
"City" => "City",
"WithholdingStatus" => "Withholding Status",
"TaxBracket" => "Tax Bracket",
"StatusType" => "Status Type",
"OverAmnt" => "Over Amnt",
"NotOver" => "Not Over",
"Cumulative" => "Cumulative",
"PayrollYear" => "Payroll Year",
"PayFrequency" => "PayFrequency"];
}?>
