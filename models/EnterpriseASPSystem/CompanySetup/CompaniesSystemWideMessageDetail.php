<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "companiessystemwidemessage";
public $gridFields =["SystemMessageAt"];
public $dashboardTitle ="CompaniesSystemWideMessage ";
public $breadCrumbTitle ="CompaniesSystemWideMessage ";
public $idField ="undefined";
public $idFields = ["CompanyID","DivisionID","DepartmentID"];
public $editCategories = [
"Main" => [

"SystemMessageAt" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"SystemMessageBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"SystemMessage" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"SystemMessageAt" => "SystemMessage At",
"SystemMessageBy" => "SystemMessageBy",
"SystemMessage" => "SystemMessage"];
}?>
