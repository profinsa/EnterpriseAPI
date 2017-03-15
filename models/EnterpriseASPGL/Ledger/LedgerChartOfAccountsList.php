<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgerchartofaccounts";
protected $gridFields =["GLParentSegment","GLAccountNumber","GLAccountName","GLAccountType","GLBalanceType","GLAccountBalance"];
public $dashboardTitle ="Ledger Chart Of Accounts";
public $breadCrumbTitle ="Ledger Chart Of Accounts";
public $idField ="GLAccountNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","GLAccountNumber"];
public $editCategories = [
"Main" => [

"GLAccountNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLSubAccountCode" => [
"inputType" => "text",
"defaultValue" => ""
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
"GLCurrentYearBeginningBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod1" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod2" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod3" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod4" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod5" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod6" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod7" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod8" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod9" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod10" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod11" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod12" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod13" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod14" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetBeginningBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod1" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod2" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod3" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod4" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod5" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod6" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod7" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod8" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod9" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod10" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod11" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod12" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod13" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod14" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorFiscalYear" => [
"inputType" => "datepicker",
"defaultValue" => "now"
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

"GLParentSegment" => "Parent Segment",
"GLAccountNumber" => "Account Number",
"GLAccountName" => "Account Name",
"GLAccountType" => "Account Type",
"GLBalanceType" => "Balance Type",
"GLAccountBalance" => "Account Balance",
"GLAccountCode" => "GLAccountCode",
"GLSubAccountCode" => "GLSubAccountCode",
"GLAccountDescription" => "GLAccountDescription",
"GLAccountUse" => "GLAccountUse",
"GLReportingAccount" => "GLReportingAccount",
"GLReportLevel" => "GLReportLevel",
"CurrencyID" => "CurrencyID",
"CurrencyExchangeRate" => "CurrencyExchangeRate",
"GLAccountBeginningBalance" => "GLAccountBeginningBalance",
"GLOtherNotes" => "GLOtherNotes",
"GLBudgetID" => "GLBudgetID",
"GLCurrentYearBeginningBalance" => "GLCurrentYearBeginningBalance",
"GLCurrentYearPeriod1" => "GLCurrentYearPeriod1",
"GLCurrentYearPeriod2" => "GLCurrentYearPeriod2",
"GLCurrentYearPeriod3" => "GLCurrentYearPeriod3",
"GLCurrentYearPeriod4" => "GLCurrentYearPeriod4",
"GLCurrentYearPeriod5" => "GLCurrentYearPeriod5",
"GLCurrentYearPeriod6" => "GLCurrentYearPeriod6",
"GLCurrentYearPeriod7" => "GLCurrentYearPeriod7",
"GLCurrentYearPeriod8" => "GLCurrentYearPeriod8",
"GLCurrentYearPeriod9" => "GLCurrentYearPeriod9",
"GLCurrentYearPeriod10" => "GLCurrentYearPeriod10",
"GLCurrentYearPeriod11" => "GLCurrentYearPeriod11",
"GLCurrentYearPeriod12" => "GLCurrentYearPeriod12",
"GLCurrentYearPeriod13" => "GLCurrentYearPeriod13",
"GLCurrentYearPeriod14" => "GLCurrentYearPeriod14",
"GLBudgetBeginningBalance" => "GLBudgetBeginningBalance",
"GLBudgetPeriod1" => "GLBudgetPeriod1",
"GLBudgetPeriod2" => "GLBudgetPeriod2",
"GLBudgetPeriod3" => "GLBudgetPeriod3",
"GLBudgetPeriod4" => "GLBudgetPeriod4",
"GLBudgetPeriod5" => "GLBudgetPeriod5",
"GLBudgetPeriod6" => "GLBudgetPeriod6",
"GLBudgetPeriod7" => "GLBudgetPeriod7",
"GLBudgetPeriod8" => "GLBudgetPeriod8",
"GLBudgetPeriod9" => "GLBudgetPeriod9",
"GLBudgetPeriod10" => "GLBudgetPeriod10",
"GLBudgetPeriod11" => "GLBudgetPeriod11",
"GLBudgetPeriod12" => "GLBudgetPeriod12",
"GLBudgetPeriod13" => "GLBudgetPeriod13",
"GLBudgetPeriod14" => "GLBudgetPeriod14",
"GLPriorFiscalYear" => "GLPriorFiscalYear",
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
