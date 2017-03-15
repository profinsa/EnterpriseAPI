<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollitemtypes";
public $gridFields =["PayrollItemTypeID","PayrollItemTypeDescription"];
public $dashboardTitle ="PayrollItemTypes";
public $breadCrumbTitle ="PayrollItemTypes";
public $idField ="PayrollItemTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PayrollItemTypeID"];
public $editCategories = [
"Main" => [

"PayrollItemTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PayrollItemTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PayrollItemTypeID" => "Payroll Item Type ID",
"PayrollItemTypeDescription" => "Payroll Item Type Description"];
}?>
