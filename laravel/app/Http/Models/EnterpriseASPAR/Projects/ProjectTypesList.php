<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "projecttypes";
public $dashboardTitle ="Project Types";
public $breadCrumbTitle ="Project Types";
public $idField ="ProjectTypeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ProjectTypeID"];
public $gridFields = [

"ProjectTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ProjectTypeDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ProjectTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ProjectTypeDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"ProjectTypeID" => "Project Type ID",
"ProjectTypeDescription" => "Project Type Description"];
}?>
