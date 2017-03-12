<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "contacttype";
protected $gridFields =["ContactType","ContactTypeDescription"];
public $dashboardTitle ="Contact Type";
public $breadCrumbTitle ="Contact Type";
public $idField ="ContactType";
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
