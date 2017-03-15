<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "departments";
public $dashboardTitle ="Departments";
public $breadCrumbTitle ="Departments";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $gridFields = [

"DepartmentName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"DepartmentDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"DepartmentPhone" => [
    "dbType" => "varchar(30)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"DepartmentName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentAddress1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentAddress2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentCity" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentState" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentZip" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentCountry" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentPhone" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentFax" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentEmail" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentWebAddress" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"DepartmentNotes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"DepartmentID" => "Department ID",
"DepartmentName" => "Department Name",
"DepartmentDescription" => "Department Description",
"DepartmentPhone" => "Department Phone",
"DepartmentAddress1" => "DepartmentAddress1",
"DepartmentAddress2" => "DepartmentAddress2",
"DepartmentCity" => "DepartmentCity",
"DepartmentState" => "DepartmentState",
"DepartmentZip" => "DepartmentZip",
"DepartmentCountry" => "DepartmentCountry",
"DepartmentFax" => "DepartmentFax",
"DepartmentEmail" => "DepartmentEmail",
"DepartmentWebAddress" => "DepartmentWebAddress",
"DepartmentNotes" => "DepartmentNotes"];
}?>
