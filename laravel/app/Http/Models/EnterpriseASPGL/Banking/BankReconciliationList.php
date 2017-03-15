<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "bankreconciliation";
public $dashboardTitle ="Bank Reconciliation";
public $breadCrumbTitle ="Bank Reconciliation";
public $idField ="BankID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","BankID"];
public $gridFields = [

"BankID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"BankRecStartDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"BankRecEndDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"GLBankAccount" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"BankRecEndingBalance" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"BankID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"BankRecStartDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"BankRecEndDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
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
"GLBankAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
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
"BankRecNotes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"Signature" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SignaturePassword" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorSignature" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SupervisorPassword" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ManagerSignature" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ManagerPassword" => [
"dbType" => "varchar(36)",
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
