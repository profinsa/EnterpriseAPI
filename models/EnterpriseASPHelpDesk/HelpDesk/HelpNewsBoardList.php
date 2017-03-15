<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpnewsboard";
protected $gridFields =["NewsId","NewsProductId","NewsTitle","NewsDate","NewsMessage"];
public $dashboardTitle ="Help News Board";
public $breadCrumbTitle ="Help News Board";
public $idField ="NewsId";
public $idFields = ["CompanyID","DivisionID","DepartmentID","NewsId"];
public $editCategories = [
"Main" => [

"NewsId" => [
"inputType" => "text",
"defaultValue" => ""
],
"NewsProductId" => [
"inputType" => "text",
"defaultValue" => ""
],
"NewsTitle" => [
"inputType" => "text",
"defaultValue" => ""
],
"NewsDate" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"NewsMessage" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"NewsId" => "News Id",
"NewsProductId" => "ProductI d",
"NewsTitle" => "Title",
"NewsDate" => "Date",
"NewsMessage" => "Message"];
}?>
