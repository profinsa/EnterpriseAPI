<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollitembasis";
public $dashboardTitle ="PayrollItemBasis";
public $breadCrumbTitle ="PayrollItemBasis";
public $idField ="PayrollItemBasisID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PayrollItemBasisID"];
public $gridFields = [

"PayrollItemBasisID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PayrollItemBasisDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PayrollItemBasisID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PayrollItemBasisDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PayrollItemBasisID" => "Payroll Item Basis ID",
"PayrollItemBasisDescription" => "Payroll Item Basis Description"];
}?>
