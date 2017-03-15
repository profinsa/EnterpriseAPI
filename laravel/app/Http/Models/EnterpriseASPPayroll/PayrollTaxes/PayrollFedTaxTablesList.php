<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollfedtaxtables";
public $gridFields =["WithholdingStatus","TaxBracket","OverAmnt","NotOver","Cumulative","StatusType","Country","PayrollYear"];
public $dashboardTitle ="PayrollFedTaxTables";
public $breadCrumbTitle ="PayrollFedTaxTables";
public $idField ="Country";
public $idFields = ["CompanyID","DivisionID","DepartmentID","Country","WithholdingStatus","StatusType","TaxBracket"];
public $editCategories = [
"Main" => [

"Country" => [
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

"WithholdingStatus" => "Withholding Status",
"TaxBracket" => "Tax Bracket",
"OverAmnt" => "Over Amnt",
"NotOver" => "Not Over",
"Cumulative" => "Cumulative",
"StatusType" => "Status Type",
"Country" => "Country",
"PayrollYear" => "Payroll Year",
"PayFrequency" => "PayFrequency"];
}?>
