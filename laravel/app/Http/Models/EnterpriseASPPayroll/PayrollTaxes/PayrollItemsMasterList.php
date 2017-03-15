<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollitemsmaster";
public $dashboardTitle ="PayrollItemsMaster";
public $breadCrumbTitle ="PayrollItemsMaster";
public $idField ="PayrollItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PayrollItemID"];
public $gridFields = [

"PayrollItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PayrollItemDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"Basis" => [
    "dbType" => "varchar(20)",
    "inputType" => "text"
],
"PayrollItemTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"YTDMaximum" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"Minimum" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"WageHigh" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"WageLow" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"ItemAmount" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"ItemPercent" => [
    "dbType" => "float",
    "inputType" => "text"
],
"PercentAmount" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"TotalAmount" => [
    "dbType" => "decimal(19,4)",
    "inputType" => "text"
],
"GLAccount" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"PayrollItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PayrollItemDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Basis" => [
"dbType" => "varchar(20)",
"inputType" => "text",
"defaultValue" => ""
],
"PayrollItemTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"YTDMaximum" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"Minimum" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"WageHigh" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"WageLow" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemPercent" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"PercentAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"TotalAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"ApplyItem" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAccount2" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLAccount3" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Employer" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployerItemAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployerItemPercent" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"EmployerPercentAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployerTotalAmount" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"DefaultItem" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line2" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line3" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line4" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line6a" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line6b" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line7" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line9" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line12" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box1" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box2" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box3" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box4" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box5" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box6" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box7" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box8" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box9" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box10" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box11" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box12" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box13" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box13b" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box14" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box15" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box17" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box18" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box20" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"W2Box21" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"PayrollItemID" => "Payroll Item ID",
"PayrollItemDescription" => "Payroll Item Description",
"Basis" => "Basis",
"PayrollItemTypeID" => "Payroll Item Type ID",
"YTDMaximum" => "YTD Maximum",
"Minimum" => "Minimum",
"WageHigh" => "Wage High",
"WageLow" => "Wage Low",
"ItemAmount" => "Item Amount",
"ItemPercent" => "Item Percent",
"PercentAmount" => "Percent Amount",
"TotalAmount" => "Total Amount",
"GLAccount" => "GL Account",
"ApplyItem" => "ApplyItem",
"GLAccount2" => "GLAccount2",
"GLAccount3" => "GLAccount3",
"Employer" => "Employer",
"EmployerItemAmount" => "EmployerItemAmount",
"EmployerItemPercent" => "EmployerItemPercent",
"EmployerPercentAmount" => "EmployerPercentAmount",
"EmployerTotalAmount" => "EmployerTotalAmount",
"DefaultItem" => "DefaultItem",
"Frm941Line2" => "Frm941Line2",
"Frm941Line3" => "Frm941Line3",
"Frm941Line4" => "Frm941Line4",
"Frm941Line6a" => "Frm941Line6a",
"Frm941Line6b" => "Frm941Line6b",
"Frm941Line7" => "Frm941Line7",
"Frm941Line9" => "Frm941Line9",
"Frm941Line12" => "Frm941Line12",
"W2Box1" => "W2Box1",
"W2Box2" => "W2Box2",
"W2Box3" => "W2Box3",
"W2Box4" => "W2Box4",
"W2Box5" => "W2Box5",
"W2Box6" => "W2Box6",
"W2Box7" => "W2Box7",
"W2Box8" => "W2Box8",
"W2Box9" => "W2Box9",
"W2Box10" => "W2Box10",
"W2Box11" => "W2Box11",
"W2Box12" => "W2Box12",
"W2Box13" => "W2Box13",
"W2Box13b" => "W2Box13b",
"W2Box14" => "W2Box14",
"W2Box15" => "W2Box15",
"W2Box17" => "W2Box17",
"W2Box18" => "W2Box18",
"W2Box20" => "W2Box20",
"W2Box21" => "W2Box21"];
}?>
