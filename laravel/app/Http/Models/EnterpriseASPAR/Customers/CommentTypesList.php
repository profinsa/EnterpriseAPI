<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "commenttypes";
public $dashboardTitle ="Comment Types";
public $breadCrumbTitle ="Comment Types";
public $idField ="CommentType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CommentType"];
public $gridFields = [

"CommentType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"CommentType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CommentType" => "Comment Type"];
}?>
