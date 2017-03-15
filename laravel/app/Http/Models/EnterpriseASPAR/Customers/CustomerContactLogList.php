<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customercontactlog";
protected $gridFields =["CustomerID","ContactID","ContactLogID","ContactDate","ContactDesctiption"];
public $dashboardTitle ="Customer Contact Log";
public $breadCrumbTitle ="Customer Contact Log";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ContactID","ContactLogID"];
public $editCategories = [
"Main" => [

"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactLogID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ContactDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"ContactCallStartTime" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"ContactCallEndTime" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"ContactDesctiption" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerID" => "Customer ID",
"ContactID" => "Contact ID",
"ContactLogID" => "Contact Log ID",
"ContactDate" => "Contact Date",
"ContactDesctiption" => "Contact Desctiption",
"ContactCallStartTime" => "ContactCallStartTime",
"ContactCallEndTime" => "ContactCallEndTime"];
}?>
