<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpnewsboard";
public $gridFields =["NewsId","NewsProductId","NewsTitle","NewsDate","NewsMessage"];
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
"inputType" => "datetime",
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
