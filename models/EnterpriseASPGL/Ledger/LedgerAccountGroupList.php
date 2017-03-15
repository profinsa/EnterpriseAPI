<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "ledgeraccountgroup";
public $gridFields =["GLAccountGroupID","GLAccountGroupName","GLAccountGroupBalance","GLAccountUse","GLReportingAccount","GLReportLevel"];
public $dashboardTitle ="Ledger Account Group";
public $breadCrumbTitle ="Ledger Account Group";
public $idField ="GLAccountGroupID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","GLAccountGroupID"];
public $editCategories = [
"Main" => [

"GLAccountGroupID" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountGroupName" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAccountGroupBalance" => [
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
"GLReportingAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLReportLevel" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"GLAccountGroupID" => "Group Account ID",
"GLAccountGroupName" => "Group Account Name",
"GLAccountGroupBalance" => "Group Balance",
"GLAccountUse" => "Group Account Use",
"GLReportingAccount" => "Group Reporting Accounting",
"GLReportLevel" => "Group Reporting Level",
"GLAccountType" => "GLAccountType"];
}?>
