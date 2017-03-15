<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollitems";
public $dashboardTitle ="PayrollItems";
public $breadCrumbTitle ="PayrollItems";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","PayrollItemID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"PayrollItemID" => [
    "dbType" => "varchar(36)",
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
]
];

public $editCategories = [
"Main" => [

"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
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
],
"GLEmployeeCreditAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLEmployerDebitAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"GLEmployerCreditAccount" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"PayrollItemID" => "Payroll Item ID",
"Basis" => "Basis",
"PayrollItemTypeID" => "Payroll Item Type ID",
"ItemAmount" => "Item Amount",
"ItemPercent" => "Item Percent",
"PercentAmount" => "Percent Amount",
"TotalAmount" => "Total Amount",
"PayrollItemDescription" => "PayrollItemDescription",
"YTDMaximum" => "YTDMaximum",
"Minimum" => "Minimum",
"WageHigh" => "WageHigh",
"WageLow" => "WageLow",
"ApplyItem" => "ApplyItem",
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
"W2Box21" => "W2Box21",
"GLEmployeeCreditAccount" => "GLEmployeeCreditAccount",
"GLEmployerDebitAccount" => "GLEmployerDebitAccount",
"GLEmployerCreditAccount" => "GLEmployerCreditAccount"];
}?>
