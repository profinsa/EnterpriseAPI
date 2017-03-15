<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "companiessystemwidemessage";
public $dashboardTitle ="CompaniesSystemWideMessage ";
public $breadCrumbTitle ="CompaniesSystemWideMessage ";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $gridFields = [

"SystemMessageAt" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"SystemMessageAt" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"SystemMessageBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SystemMessage" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"SystemMessageAt" => "SystemMessage At",
"SystemMessageBy" => "SystemMessageBy",
"SystemMessage" => "SystemMessage"];
}?>
