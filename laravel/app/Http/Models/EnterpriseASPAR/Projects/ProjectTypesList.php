<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "projecttypes";
public $gridFields =["ProjectTypeID","ProjectTypeDescription"];
public $dashboardTitle ="Project Types";
public $breadCrumbTitle ="Project Types";
public $idField ="ProjectTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ProjectTypeID"];
public $editCategories = [
"Main" => [

"ProjectTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectTypeDescription" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ProjectTypeID" => "Project Type ID",
"ProjectTypeDescription" => "Project Type Description"];
}?>
