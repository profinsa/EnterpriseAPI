<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "helpresources";
protected $gridFields =["ResourceId","ResourceType","ResourceProductId","ResourceRank","ResourceLink","ResourceDescription"];
public $dashboardTitle ="Help Resources";
public $breadCrumbTitle ="Help Resources";
public $idField ="ResourceId";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ResourceId"];
public $editCategories = [
"Main" => [

"ResourceId" => [
"inputType" => "text",
"defaultValue" => ""
],
"ResourceType" => [
"inputType" => "text",
"defaultValue" => ""
],
"ResourceProductId" => [
"inputType" => "text",
"defaultValue" => ""
],
"ResourceRank" => [
"inputType" => "text",
"defaultValue" => ""
],
"ResourceLink" => [
"inputType" => "text",
"defaultValue" => ""
],
"ResourceDescription" => [
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
