<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgerchartofaccountsprioryears";
public $dashboardTitle ="Prior Fiscal Year Balances";
public $breadCrumbTitle ="Prior Fiscal Year Balances";
public $idField ="GLAccountNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","GLAccountNumber","GLFiscalYear"];
public $gridFields = [

"GLAccountNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"GLFiscalYear" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"GLBudgetID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"GLAccountName" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
],
"GLAccountDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"GLAccountUse" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"GLAccountType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"GLBalanceType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"GLAccountBalance" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"GLAccountNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLFiscalYear" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"GLAccountName" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountUse" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBalanceType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLReportingAccount" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GLReportLevel" => [
"dbType" => "smallint(6)",
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
"GLAccountBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountBeginningBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLOtherNotes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearBeginningBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod1" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod2" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod3" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod4" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriortYearPeriod5" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod6" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod7" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod8" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod9" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriortYearPeriod10" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod11" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod12" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod13" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod14" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"GLAccountNumber" => "GL Account Number",
"GLFiscalYear" => "GL Fiscal Year",
"GLBudgetID" => "GL Budget ID",
"GLAccountName" => "GL Account Name",
"GLAccountDescription" => "GL Account Description",
"GLAccountUse" => "GL Account Use",
"GLAccountType" => "GL Account Type",
"GLBalanceType" => "GL Balance Type",
"GLAccountBalance" => "GL Account Balance",
"GLReportingAccount" => "GLReportingAccount",
"GLReportLevel" => "GLReportLevel",
"CurrencyID" => "CurrencyID",
"CurrencyExchangeRate" => "CurrencyExchangeRate",
"GLAccountBeginningBalance" => "GLAccountBeginningBalance",
"GLOtherNotes" => "GLOtherNotes",
"GLPriorYearBeginningBalance" => "GLPriorYearBeginningBalance",
"GLPriorYearPeriod1" => "GLPriorYearPeriod1",
"GLPriorYearPeriod2" => "GLPriorYearPeriod2",
"GLPriorYearPeriod3" => "GLPriorYearPeriod3",
"GLPriorYearPeriod4" => "GLPriorYearPeriod4",
"GLPriortYearPeriod5" => "GLPriortYearPeriod5",
"GLPriorYearPeriod6" => "GLPriorYearPeriod6",
"GLPriorYearPeriod7" => "GLPriorYearPeriod7",
"GLPriorYearPeriod8" => "GLPriorYearPeriod8",
"GLPriorYearPeriod9" => "GLPriorYearPeriod9",
"GLPriortYearPeriod10" => "GLPriortYearPeriod10",
"GLPriorYearPeriod11" => "GLPriorYearPeriod11",
"GLPriorYearPeriod12" => "GLPriorYearPeriod12",
"GLPriorYearPeriod13" => "GLPriorYearPeriod13",
"GLPriorYearPeriod14" => "GLPriorYearPeriod14"];
}?>
