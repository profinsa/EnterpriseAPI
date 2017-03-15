<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "contacttype";
public $gridFields =["ContactType","ContactTypeDescription"];
public $dashboardTitle ="Contact Type";
public $breadCrumbTitle ="Contact Type";
public $idField ="ContactType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ContactType"];
public $editCategories = [
"Main" => [

"ContactType" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ContactType" => "Contact Type",
"ContactTypeDescription" => "Contact Type Description"];
}?>
