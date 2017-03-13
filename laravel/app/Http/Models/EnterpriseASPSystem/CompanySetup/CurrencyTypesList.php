<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "currencytypes";
protected $gridFields =["CurrencyID","CurrencyType","CurrenycySymbol","CurrencyExchangeRate","CurrencyRateLastUpdate"];
public $dashboardTitle ="Currencies";
public $breadCrumbTitle ="Currencies";
public $idField ="CurrencyID";
public $editCategories = [
"Main" => [

"CurrencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyType" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrenycySymbol" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyExchangeRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyRateLastUpdate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"CurrencyPrecision" => [
"inputType" => "text",
"defaultValue" => ""
],
"MajorUnits" => [
"inputType" => "text",
"defaultValue" => ""
],
"MinorUnits" => [
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