<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "companiesdisplaylang";
public $dashboardTitle ="CompaniesDisplayLang";
public $breadCrumbTitle ="CompaniesDisplayLang";
public $idField ="DisplayLang";
public $idFields = ["CompanyID","DivisionID","DepartmentID","DisplayLang"];
public $gridFields = [

"DisplayLang" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ApprovedBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EnteredBy" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"DisplayLang" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"LangDescription" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"DisplayLang" => "Display Lang",
"ApprovedBy" => "Approved By",
"EnteredBy" => "Entered By",
"LangDescription" => "LangDescription",
"Approved" => "Approved",
"ApprovedDate" => "ApprovedDate"];
}?>
