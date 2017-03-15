<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "contacttype";
public $dashboardTitle ="Contact Type";
public $breadCrumbTitle ="Contact Type";
public $idField ="ContactType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ContactType"];
public $gridFields = [

"ContactType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContactTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ContactType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ContactType" => "Contact Type",
"ContactTypeDescription" => "Contact Type Description"];
}?>
