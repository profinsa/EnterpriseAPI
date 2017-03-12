<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "contactsource";
protected $gridFields =["ContactSourceID","ContactSourceDescription"];
public $dashboardTitle ="Contact Source";
public $breadCrumbTitle ="Contact Source";
public $idField ="ContactSourceID";
public $editCategories = [
"Main" => [

"ContactSourceID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactSourceDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ContactSourceID" => "Contact Source ID",
"ContactSourceDescription" => "Contact Source Description"];
}?>
