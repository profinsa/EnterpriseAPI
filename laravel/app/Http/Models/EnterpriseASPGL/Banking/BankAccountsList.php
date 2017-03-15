<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "bankaccounts";
public $dashboardTitle ="Bank Accounts";
public $breadCrumbTitle ="Bank Accounts";
public $idField ="BankID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","BankID"];
public $gridFields = [

"BankID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"BankAccountNumber" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
],
"BankName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"BankPhone" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
],
"GLBankAccount" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"GLBankAccount" => [
    "dbType" => "varchar(36)",
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
"BankAccountNumber" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"BankName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"BankAddress1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"BankAddress2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"BankCity" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"BankState" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"BankZip" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"BankCountry" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"BankPhone" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"BankFax" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"BankContactName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"BankEmail" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"BankWebsite" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"SwiftCode" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"RoutingCode" => [
"dbType" => "varchar(20)",
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
"NextCheckNumber" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"NextDepositNumber" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"Balance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"UnpostedDeposits" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBankAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Notes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"CorrespondentBankID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
"dbType" => "varchar(36)",
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
