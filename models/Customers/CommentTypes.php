<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "commenttypes";
protected $gridFields =["CommentType"];
public $dashboardTitle ="Comment Types";
public $breadCrumbTitle ="Comment Types";
public $idField ="CommentType";
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
