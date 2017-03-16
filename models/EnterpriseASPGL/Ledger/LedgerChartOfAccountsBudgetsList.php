<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgerchartofaccountsbudgets";
public $dashboardTitle ="Budgets";
public $breadCrumbTitle ="Budgets";
public $idField ="GLBudgetID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","GLBudgetID","GLAccountNumber"];
public $gridFields = [

"GLBudgetID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"GLAccountNumber" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"GLBudgetNotes" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
],
"GLFiscalYear" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"GLBudgetBeginningBalance" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
],
"GLBudgetCurrentBalance" => [
    "dbType" => "decimal(19,4)",
    "format" => "{0:n}",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"GLBudgetID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountNumber" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetNotes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetActive" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GLFiscalYear" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"GLBudgetBeginningBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetCurrentBalance" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod1" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod1Variance" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod1Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod2" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod2Variance" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod2Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod3" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod3Variance" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod3Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod4" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod4Variance" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod4Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod5" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod5Variance" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod5Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod6" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod6Variance" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod6Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod7" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod7Variance" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod7Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod8" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod8Variance" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod8Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod9" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod9Variance" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod9Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod10" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod10Variance" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod10Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod11" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod11Variance" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod11Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod12" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod12Variance" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod12Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod13" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod13Variance" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod13Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod14" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod14Variance" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod14Reason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"GLBudgetID" => "GL Budget ID",
"GLAccountNumber" => "GL Account Number",
"GLAccountName" => "GL Account Name",
"GLBudgetNotes" => "Notes",
"GLFiscalYear" => "GL Fiscal Year",
"GLBudgetBeginningBalance" => "Beginning Balance",
"GLBudgetCurrentBalance" => "Current Balance",
"GLBudgetActive" => "GLBudgetActive",
"GLBudgetPeriod1" => "GLBudgetPeriod1",
"GLBudgetPeriod1Variance" => "GLBudgetPeriod1Variance",
"GLBudgetPeriod1Reason" => "GLBudgetPeriod1Reason",
"GLBudgetPeriod2" => "GLBudgetPeriod2",
"GLBudgetPeriod2Variance" => "GLBudgetPeriod2Variance",
"GLBudgetPeriod2Reason" => "GLBudgetPeriod2Reason",
"GLBudgetPeriod3" => "GLBudgetPeriod3",
"GLBudgetPeriod3Variance" => "GLBudgetPeriod3Variance",
"GLBudgetPeriod3Reason" => "GLBudgetPeriod3Reason",
"GLBudgetPeriod4" => "GLBudgetPeriod4",
"GLBudgetPeriod4Variance" => "GLBudgetPeriod4Variance",
"GLBudgetPeriod4Reason" => "GLBudgetPeriod4Reason",
"GLBudgetPeriod5" => "GLBudgetPeriod5",
"GLBudgetPeriod5Variance" => "GLBudgetPeriod5Variance",
"GLBudgetPeriod5Reason" => "GLBudgetPeriod5Reason",
"GLBudgetPeriod6" => "GLBudgetPeriod6",
"GLBudgetPeriod6Variance" => "GLBudgetPeriod6Variance",
"GLBudgetPeriod6Reason" => "GLBudgetPeriod6Reason",
"GLBudgetPeriod7" => "GLBudgetPeriod7",
"GLBudgetPeriod7Variance" => "GLBudgetPeriod7Variance",
"GLBudgetPeriod7Reason" => "GLBudgetPeriod7Reason",
"GLBudgetPeriod8" => "GLBudgetPeriod8",
"GLBudgetPeriod8Variance" => "GLBudgetPeriod8Variance",
"GLBudgetPeriod8Reason" => "GLBudgetPeriod8Reason",
"GLBudgetPeriod9" => "GLBudgetPeriod9",
"GLBudgetPeriod9Variance" => "GLBudgetPeriod9Variance",
"GLBudgetPeriod9Reason" => "GLBudgetPeriod9Reason",
"GLBudgetPeriod10" => "GLBudgetPeriod10",
"GLBudgetPeriod10Variance" => "GLBudgetPeriod10Variance",
"GLBudgetPeriod10Reason" => "GLBudgetPeriod10Reason",
"GLBudgetPeriod11" => "GLBudgetPeriod11",
"GLBudgetPeriod11Variance" => "GLBudgetPeriod11Variance",
"GLBudgetPeriod11Reason" => "GLBudgetPeriod11Reason",
"GLBudgetPeriod12" => "GLBudgetPeriod12",
"GLBudgetPeriod12Variance" => "GLBudgetPeriod12Variance",
"GLBudgetPeriod12Reason" => "GLBudgetPeriod12Reason",
"GLBudgetPeriod13" => "GLBudgetPeriod13",
"GLBudgetPeriod13Variance" => "GLBudgetPeriod13Variance",
"GLBudgetPeriod13Reason" => "GLBudgetPeriod13Reason",
"GLBudgetPeriod14" => "GLBudgetPeriod14",
"GLBudgetPeriod14Variance" => "GLBudgetPeriod14Variance",
"GLBudgetPeriod14Reason" => "GLBudgetPeriod14Reason"];
}?>
