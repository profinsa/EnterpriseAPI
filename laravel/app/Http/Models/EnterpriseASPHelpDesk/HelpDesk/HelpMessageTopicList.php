<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpmessagetopic";
protected $gridFields =["MessageHeadingID","MessageTopicId","MessageTopicTitle","MessageTopicDescription"];
public $dashboardTitle ="Help Message Topics";
public $breadCrumbTitle ="Help Message Topics";
public $idField ="MessageHeadingID";
public $editCategories = [
"Main" => [

"MessageHeadingID" => [
"inputType" => "text",
"defaultValue" => ""
],
"MessageTopicId" => [
"inputType" => "text",
"defaultValue" => ""
],
"MessageTopicTitle" => [
"inputType" => "text",
"defaultValue" => ""
],
"MessageTopicDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"MessageTopicPictureURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"MessageTopicDate" => [
"inputType" => "datepicker",
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