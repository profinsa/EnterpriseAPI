<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollfedtaxtables";
public $dashboardTitle ="PayrollFedTaxTables";
public $breadCrumbTitle ="PayrollFedTaxTables";
public $idField ="Country";
public $idFields = ["CompanyID","DivisionID","DepartmentID","Country","WithholdingStatus","StatusType","TaxBracket"];
public $gridFields = [

"WithholdingStatus" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TaxBracket" => [
    "dbType" => "double",
    "inputType" => "text"
],
"OverAmnt" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"NotOver" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"Cumulative" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"StatusType" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"Country" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PayrollYear" => [
    "dbType" => "int(11)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"Country" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"WithholdingStatus" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"StatusType" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"TaxBracket" => [
"dbType" => "double",
"inputType" => "text",
"defaultValue" => ""
],
"OverAmnt" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"NotOver" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Cumulative" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"PayrollYear" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"PayFrequency" => [
"dbType" => "varchar(20)",
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
