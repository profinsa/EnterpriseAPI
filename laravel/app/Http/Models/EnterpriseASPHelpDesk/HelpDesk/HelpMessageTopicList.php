<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpmessagetopic";
public $dashboardTitle ="Help Message Topics";
public $breadCrumbTitle ="Help Message Topics";
public $idField ="MessageHeadingID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","MessageHeadingID","MessageTopicId"];
public $gridFields = [

"MessageHeadingID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"MessageTopicId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"MessageTopicTitle" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"MessageTopicDescription" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"MessageHeadingID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageTopicId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageTopicTitle" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageTopicDescription" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageTopicPictureURL" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageTopicDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"MessageHeadingID" => "Heading ID",
"MessageTopicId" => "Topic Id",
"MessageTopicTitle" => "Topic Title",
"MessageTopicDescription" => "Topic Description",
"MessageTopicPictureURL" => "MessageTopicPictureURL",
"MessageTopicDate" => "MessageTopicDate"];
}?>
