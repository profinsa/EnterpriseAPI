<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "bankreconciliationsummary";
public $dashboardTitle ="Reconciliation Summary";
public $breadCrumbTitle ="Reconciliation Summary";
public $idField ="BankRecID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","BankRecID"];
public $gridFields = [

"BankRecID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"GLBankAccount" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"BankRecCutoffDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"BankRecEndingBalance" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"BankRecID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBankAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"dbType" => "varchar(3)",
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyExchangeRate" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"BankRecCutoffDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"BankRecEndingBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"BankRecServiceCharge" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLServiceChargeAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"BankRecIntrest" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLInterestAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"BankRecAdjustment" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAdjustmentAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"BankRecOtherCharges" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLOtherChargesAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"BankRecCreditTotal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"BankRecDebitTotal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"BankRecCreditOS" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"BankRecDebitOS" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"BankRecStartingBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"BankRecBookBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"BankRecDifference" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"BankRecEndingBookBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"BankRecStartingBookBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Notes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"BankRecID" => "Reconciliation ID",
"GLBankAccount" => "GL Account",
"BankRecCutoffDate" => "End Date",
"BankRecEndingBalance" => "End Balance",
"CurrencyID" => "CurrencyID",
"CurrencyExchangeRate" => "CurrencyExchangeRate",
"BankRecServiceCharge" => "BankRecServiceCharge",
"GLServiceChargeAccount" => "GLServiceChargeAccount",
"BankRecIntrest" => "BankRecIntrest",
"GLInterestAccount" => "GLInterestAccount",
"BankRecAdjustment" => "BankRecAdjustment",
"GLAdjustmentAccount" => "GLAdjustmentAccount",
"BankRecOtherCharges" => "BankRecOtherCharges",
"GLOtherChargesAccount" => "GLOtherChargesAccount",
"BankRecCreditTotal" => "BankRecCreditTotal",
"BankRecDebitTotal" => "BankRecDebitTotal",
"BankRecCreditOS" => "BankRecCreditOS",
"BankRecDebitOS" => "BankRecDebitOS",
"BankRecStartingBalance" => "BankRecStartingBalance",
"BankRecBookBalance" => "BankRecBookBalance",
"BankRecDifference" => "BankRecDifference",
"BankRecEndingBookBalance" => "BankRecEndingBookBalance",
"BankRecStartingBookBalance" => "BankRecStartingBookBalance",
"Notes" => "Notes"];
}?>
