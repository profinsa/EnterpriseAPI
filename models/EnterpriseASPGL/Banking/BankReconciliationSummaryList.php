<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "bankreconciliationsummary";
public $gridFields =["BankRecID","GLBankAccount","BankRecCutoffDate","BankRecEndingBalance"];
public $dashboardTitle ="Reconciliation Summary";
public $breadCrumbTitle ="Reconciliation Summary";
public $idField ="BankRecID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","BankRecID"];
public $editCategories = [
"Main" => [

"BankRecID" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBankAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyExchangeRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankRecCutoffDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"BankRecEndingBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankRecServiceCharge" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLServiceChargeAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankRecIntrest" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLInterestAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankRecAdjustment" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAdjustmentAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankRecOtherCharges" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLOtherChargesAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankRecCreditTotal" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankRecDebitTotal" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankRecCreditOS" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankRecDebitOS" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankRecStartingBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankRecBookBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankRecDifference" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankRecEndingBookBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankRecStartingBookBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"Notes" => [
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
