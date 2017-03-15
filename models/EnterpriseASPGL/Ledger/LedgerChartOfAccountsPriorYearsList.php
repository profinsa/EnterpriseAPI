<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgerchartofaccountsprioryears";
public $gridFields =["GLAccountNumber","GLFiscalYear","GLBudgetID","GLAccountName","GLAccountDescription","GLAccountUse","GLAccountType","GLBalanceType","GLAccountBalance"];
public $dashboardTitle ="Prior Fiscal Year Balances";
public $breadCrumbTitle ="Prior Fiscal Year Balances";
public $idField ="GLAccountNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","GLAccountNumber","GLFiscalYear"];
public $editCategories = [
"Main" => [

"GLAccountNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLFiscalYear" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"GLAccountName" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountUse" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountType" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBalanceType" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLReportingAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLReportLevel" => [
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
"GLAccountBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountBeginningBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLOtherNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetID" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearBeginningBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod1" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod2" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod3" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod4" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriortYearPeriod5" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod6" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod7" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod8" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod9" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriortYearPeriod10" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod11" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod12" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod13" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorYearPeriod14" => [
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
