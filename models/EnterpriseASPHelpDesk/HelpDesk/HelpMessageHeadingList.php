<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpmessageheading";
public $gridFields =["MessageHeadingId","MessageHeadingTitle","MessageHeadingDescription"];
public $dashboardTitle ="Help Message Headings";
public $breadCrumbTitle ="Help Message Headings";
public $idField ="MessageHeadingId";
public $idFields = ["CompanyID","DivisionID","DepartmentID","MessageHeadingId"];
public $editCategories = [
"Main" => [

"MessageHeadingId" => [
"inputType" => "text",
"defaultValue" => ""
],
"MessageHeadingTitle" => [
"inputType" => "text",
"defaultValue" => ""
],
"MessageHeadingDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"MessageHeadingPictureURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"MessageHeadingDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"MessageHeadingId" => "Heading Id",
"MessageHeadingTitle" => "Heading Title",
"MessageHeadingDescription" => "Heading Description",
"MessageHeadingPictureURL" => "MessageHeadingPictureURL",
"MessageHeadingDate" => "MessageHeadingDate"];
}?>
