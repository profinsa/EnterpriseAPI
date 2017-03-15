<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "bankaccounts";
public $gridFields =["BankID","BankAccountNumber","BankName","BankPhone","GLBankAccount","GLBankAccount"];
public $dashboardTitle ="Bank Accounts";
public $breadCrumbTitle ="Bank Accounts";
public $idField ="BankID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","BankID"];
public $editCategories = [
"Main" => [

"BankID" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankAccountNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankName" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankState" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankPhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankFax" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankContactName" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankEmail" => [
"inputType" => "text",
"defaultValue" => ""
],
"BankWebsite" => [
"inputType" => "text",
"defaultValue" => ""
],
"SwiftCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"RoutingCode" => [
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
"NextCheckNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"NextDepositNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"Balance" => [
"inputType" => "text",
"defaultValue" => ""
],
"UnpostedDeposits" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBankAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"Notes" => [
"inputType" => "text",
"defaultValue" => ""
],
"CorrespondentBankID" => [
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"BankID" => "Bank ID",
"BankAccountNumber" => "Bank Account Number",
"BankName" => "Bank Name",
"BankPhone" => "Bank Phone",
"GLBankAccount" => "GL Account Name",
"BankAddress1" => "BankAddress1",
"BankAddress2" => "BankAddress2",
"BankCity" => "BankCity",
"BankState" => "BankState",
"BankZip" => "BankZip",
"BankCountry" => "BankCountry",
"BankFax" => "BankFax",
"BankContactName" => "BankContactName",
"BankEmail" => "BankEmail",
"BankWebsite" => "BankWebsite",
"SwiftCode" => "SwiftCode",
"RoutingCode" => "RoutingCode",
"CurrencyID" => "CurrencyID",
"CurrencyExchangeRate" => "CurrencyExchangeRate",
"NextCheckNumber" => "NextCheckNumber",
"NextDepositNumber" => "NextDepositNumber",
"Balance" => "Balance",
"UnpostedDeposits" => "UnpostedDeposits",
"Notes" => "Notes",
"CorrespondentBankID" => "CorrespondentBankID",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate",
"EnteredBy" => "EnteredBy"];
}?>
