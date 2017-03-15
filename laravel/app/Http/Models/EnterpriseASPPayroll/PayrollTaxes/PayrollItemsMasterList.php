<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollitemsmaster";
public $gridFields =["PayrollItemID","PayrollItemDescription","Basis","PayrollItemTypeID","YTDMaximum","Minimum","WageHigh","WageLow","ItemAmount","ItemPercent","PercentAmount","TotalAmount","GLAccount"];
public $dashboardTitle ="PayrollItemsMaster";
public $breadCrumbTitle ="PayrollItemsMaster";
public $idField ="PayrollItemID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","PayrollItemID"];
public $editCategories = [
"Main" => [

"PayrollItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PayrollItemDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"Basis" => [
"inputType" => "text",
"defaultValue" => ""
],
"PayrollItemTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"YTDMaximum" => [
"inputType" => "text",
"defaultValue" => ""
],
"Minimum" => [
"inputType" => "text",
"defaultValue" => ""
],
"WageHigh" => [
"inputType" => "text",
"defaultValue" => ""
],
"WageLow" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemPercent" => [
"inputType" => "text",
"defaultValue" => ""
],
"PercentAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"TotalAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApplyItem" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAccount" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAccount2" => [
"inputType" => "text",
"defaultValue" => ""
],
"GLAccount3" => [
"inputType" => "text",
"defaultValue" => ""
],
"Employer" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployerItemAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployerItemPercent" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployerPercentAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployerTotalAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"DefaultItem" => [
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line2" => [
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line3" => [
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line4" => [
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line6a" => [
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line6b" => [
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line7" => [
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line9" => [
"inputType" => "text",
"defaultValue" => ""
],
"Frm941Line12" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box1" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box2" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box3" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box4" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box5" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box6" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box7" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box8" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box9" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box10" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box11" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box12" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box13" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box13b" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box14" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box15" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box17" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box18" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box20" => [
"inputType" => "text",
"defaultValue" => ""
],
"W2Box21" => [
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
