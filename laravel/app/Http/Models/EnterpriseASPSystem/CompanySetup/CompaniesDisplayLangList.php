<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "companiesdisplaylang";
protected $gridFields =["DisplayLang","ApprovedBy","EnteredBy"];
public $dashboardTitle ="CompaniesDisplayLang";
public $breadCrumbTitle ="CompaniesDisplayLang";
public $idField ="DisplayLang";
public $idFields = ["CompanyID","DivisionID","DepartmentID","DisplayLang"];
public $editCategories = [
"Main" => [

"DisplayLang" => [
"inputType" => "text",
"defaultValue" => ""
],
"LangDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
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
