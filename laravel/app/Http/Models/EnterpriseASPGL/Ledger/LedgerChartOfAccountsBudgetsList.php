<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgerchartofaccountsbudgets";
protected $gridFields =["GLBudgetID","GLAccountNumber","GLAccountName","GLBudgetNotes","GLFiscalYear","GLBudgetBeginningBalance","GLBudgetCurrentBalance"];
public $dashboardTitle ="Budgets";
public $breadCrumbTitle ="Budgets";
public $idField ="GLBudgetID";
public $editCategories = [
"Main" => [

"GLBudgetID" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetActive" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLFiscalYear" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"GLBudgetBeginningBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetCurrentBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod1" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod1Variance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod1Reason" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod2" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod2Variance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod2Reason" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod3" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod3Variance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod3Reason" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod4" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod4Variance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod4Reason" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod5" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod5Variance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod5Reason" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod6" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod6Variance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod6Reason" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod7" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod7Variance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod7Reason" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod8" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod8Variance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod8Reason" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod9" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod9Variance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod9Reason" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod10" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod10Variance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod10Reason" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod11" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod11Variance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod11Reason" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod12" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod12Variance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod12Reason" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod13" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod13Variance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod13Reason" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod14" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod14Variance" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLBudgetPeriod14Reason" => [
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
