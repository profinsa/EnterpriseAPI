<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollitemtypes";
public $dashboardTitle ="PayrollItemTypes";
public $breadCrumbTitle ="PayrollItemTypes";
public $idField ="PayrollItemTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PayrollItemTypeID"];
public $gridFields = [

"PayrollItemTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PayrollItemTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PayrollItemTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PayrollItemTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PayrollItemTypeID" => "Payroll Item Type ID",
"PayrollItemTypeDescription" => "Payroll Item Type Description"];
}?>
