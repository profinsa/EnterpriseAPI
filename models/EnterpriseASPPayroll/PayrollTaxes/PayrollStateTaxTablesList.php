<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollstatetaxtables";
protected $gridFields =["State","WithholdingStatus","TaxBracket","StatusType","OverAmnt","NotOver","Cumulative","PayrollYear"];
public $dashboardTitle ="PayrollStateTaxTables";
public $breadCrumbTitle ="PayrollStateTaxTables";
public $idField ="State";
public $idFields = ["CompanyID","DivisionID","DepartmentID","State","WithholdingStatus","TaxBracket","OverAmnt","NotOver","Cumulative","PayrollYear","StatusType"];
public $editCategories = [
"Main" => [

"State" => [
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
"WithholdingStatus" => "Withholding Status",
"TaxBracket" => "Tax Bracket",
"StatusType" => "Status Type",
"OverAmnt" => "Over Amnt",
"NotOver" => "Not Over",
"Cumulative" => "Cumulative",
"PayrollYear" => "Payroll Year",
"PayFrequency" => "PayFrequency"];
}?>
