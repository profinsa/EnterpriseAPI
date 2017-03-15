<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "commenttypes";
public $gridFields =["CommentType"];
public $dashboardTitle ="Comment Types";
public $breadCrumbTitle ="Comment Types";
public $idField ="CommentType";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CommentType"];
public $editCategories = [
"Main" => [

"CommentType" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CommentType" => "Comment Type"];
}?>
