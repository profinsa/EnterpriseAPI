<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollcitytaxtables";
public $dashboardTitle ="PayrollCityTaxTables";
public $breadCrumbTitle ="PayrollCityTaxTables";
public $idField ="State";
public $idFields = ["CompanyID","DivisionID","DepartmentID","State","County","City","WithholdingStatus","TaxBracket","StatusType"];
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
"WithholdingStatus" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"TaxBracket" => [
    "dbType" => "double",
    "inputType" => "text"
],
"StatusType" => [
    "dbType" => "varchar(50)",
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
"PayrollYear" => [
    "dbType" => "int(11)",
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
