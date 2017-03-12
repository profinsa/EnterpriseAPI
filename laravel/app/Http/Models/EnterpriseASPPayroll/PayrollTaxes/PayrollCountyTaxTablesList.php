<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollcountytaxtables";
protected $gridFields =["State","County","WithholdingStatus","TaxBracket","StatusType","OverAmnt","NotOver","Cumulative","PayrollYear"];
public $dashboardTitle ="PayrollCountyTaxTables";
public $breadCrumbTitle ="PayrollCountyTaxTables";
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
"WithholdingStatus" => "Withholding Status",
"TaxBracket" => "Tax Bracket",
"StatusType" => "Status Type",
"OverAmnt" => "Over Amnt",
"NotOver" => "Not Over",
"Cumulative" => "Cumulative",
"PayrollYear" => "Payroll Year",
"PayFrequency" => "PayFrequency"];
}?>
