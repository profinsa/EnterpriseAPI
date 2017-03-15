<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "leadtype";
protected $gridFields =["LeadTypeID","LeadTypeDescription"];
public $dashboardTitle ="Lead Type";
public $breadCrumbTitle ="Lead Type";
public $idField ="LeadTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","LeadTypeID"];
public $editCategories = [
"Main" => [

"LeadTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"LeadTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"LeadTypeID" => "Lead Type ID",
"LeadTypeDescription" => "Lead Type Description"];
}?>
