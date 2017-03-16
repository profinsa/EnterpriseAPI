<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgerchartofaccounts";
public $dashboardTitle ="Ledger Chart Of Accounts";
public $breadCrumbTitle ="Ledger Chart Of Accounts";
public $idField ="GLAccountNumber";
public $idFields = ["CompanyID","DivisionID","DepartmentID","GLAccountNumber"];
public $gridFields = [

"GLAccountNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"GLAccountName" => [
    "dbType" => "varchar(30)",
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
"GLAccountCode" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLSubAccountCode" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
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
"GLCurrentYearBeginningBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod1" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod2" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod3" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod4" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod5" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod6" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod7" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod8" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod9" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod10" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod11" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod12" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod13" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLCurrentYearPeriod14" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetBeginningBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod1" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod2" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod3" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod4" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod5" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod6" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod7" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod8" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod9" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod10" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod11" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod12" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod13" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod14" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLPriorFiscalYear" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
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
