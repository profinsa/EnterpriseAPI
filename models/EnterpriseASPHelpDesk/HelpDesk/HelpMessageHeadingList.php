<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpmessageheading";
public $dashboardTitle ="Help Message Headings";
public $breadCrumbTitle ="Help Message Headings";
public $idField ="MessageHeadingId";
public $idFields = ["CompanyID","DivisionID","DepartmentID","MessageHeadingId"];
public $gridFields = [

"MessageHeadingId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"MessageHeadingTitle" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"MessageHeadingDescription" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"MessageHeadingId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageHeadingTitle" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageHeadingDescription" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageHeadingPictureURL" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"MessageHeadingDate" => [
"dbType" => "datetime",
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
