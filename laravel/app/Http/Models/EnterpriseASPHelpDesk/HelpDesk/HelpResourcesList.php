<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpresources";
public $dashboardTitle ="Help Resources";
public $breadCrumbTitle ="Help Resources";
public $idField ="ResourceId";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ResourceId"];
public $gridFields = [

"ResourceId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ResourceType" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ResourceProductId" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ResourceRank" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"ResourceLink" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"ResourceDescription" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ResourceId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ResourceType" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ResourceProductId" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ResourceRank" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"ResourceLink" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ResourceDescription" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ResourceId" => "Resource Id",
"ResourceType" => "Resource Type",
"ResourceProductId" => "Product Id",
"ResourceRank" => "Rank",
"ResourceLink" => "Link",
"ResourceDescription" => "Description"];
}?>
