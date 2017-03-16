<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "currencytypes";
public $dashboardTitle ="Currencies";
public $breadCrumbTitle ="Currencies";
public $idField ="CurrencyID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CurrencyID"];
public $gridFields = [

"CurrencyID" => [
    "dbType" => "varchar(3)",
    "inputType" => "text"
],
"CurrencyType" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CurrenycySymbol" => [
    "dbType" => "varchar(1)",
    "inputType" => "text"
],
"CurrencyExchangeRate" => [
    "dbType" => "float",
    "format" => "{0:n}",
    "inputType" => "text"
],
"CurrencyRateLastUpdate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"CurrencyID" => [
"dbType" => "varchar(3)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyType" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrenycySymbol" => [
"dbType" => "varchar(1)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyExchangeRate" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyRateLastUpdate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"CurrencyPrecision" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"MajorUnits" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"MinorUnits" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CurrencyID" => "Currency ID",
"CurrencyType" => "Currency Type",
"CurrenycySymbol" => "Currenycy Symbol",
"CurrencyExchangeRate" => "Exchange Rate",
"CurrencyRateLastUpdate" => "Rate Last Updated",
"CurrencyPrecision" => "CurrencyPrecision",
"MajorUnits" => "MajorUnits",
"MinorUnits" => "MinorUnits"];
}?>
