<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "bankreconciliation";
protected $gridFields =["BankID","BankRecStartDate","BankRecEndDate","GLBankAccount","BankRecEndingBalance"];
public $dashboardTitle ="Bank Reconciliation";
public $breadCrumbTitle ="Bank Reconciliation";
public $idField ="BankID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","BankID"];
public $editCategories = [
"Main" => [

"BankID" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankRecStartDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"BankRecEndDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"CurrencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyExchangeRate" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBankAccount" => [
"inputType" => "text",
"defaultValue" => ""
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
"BankRecOtherCharges" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLOtherChargesAccount" => [
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
"BankRecNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"Signature" => [
"inputType" => "text",
"defaultValue" => ""
],
"SignaturePassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorSignature" => [
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorPassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"ManagerSignature" => [
"inputType" => "text",
"defaultValue" => ""
],
"ManagerPassword" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"BankID" => "Bank ID",
"BankRecStartDate" => "Start Date",
"BankRecEndDate" => "End Date",
"GLBankAccount" => "GL Account",
"BankRecEndingBalance" => "Balance",
"CurrencyID" => "CurrencyID",
"CurrencyExchangeRate" => "CurrencyExchangeRate",
"BankRecServiceCharge" => "BankRecServiceCharge",
"GLServiceChargeAccount" => "GLServiceChargeAccount",
"BankRecIntrest" => "BankRecIntrest",
"GLInterestAccount" => "GLInterestAccount",
"BankRecOtherCharges" => "BankRecOtherCharges",
"GLOtherChargesAccount" => "GLOtherChargesAccount",
"BankRecAdjustment" => "BankRecAdjustment",
"GLAdjustmentAccount" => "GLAdjustmentAccount",
"BankRecNotes" => "BankRecNotes",
"Signature" => "Signature",
"SignaturePassword" => "SignaturePassword",
"SupervisorSignature" => "SupervisorSignature",
"SupervisorPassword" => "SupervisorPassword",
"ManagerSignature" => "ManagerSignature",
"ManagerPassword" => "ManagerPassword"];
}?>
