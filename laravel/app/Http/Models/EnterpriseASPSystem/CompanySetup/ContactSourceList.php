<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "contactsource";
public $dashboardTitle ="Contact Source";
public $breadCrumbTitle ="Contact Source";
public $idField ="ContactSourceID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ContactSourceID"];
public $gridFields = [

"ContactSourceID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ContactSourceDescription" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ContactSourceID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ContactSourceDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ContactSourceID" => "Contact Source ID",
"ContactSourceDescription" => "Contact Source Description"];
}?>
