<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "terms";
public $dashboardTitle ="Terms";
public $breadCrumbTitle ="Terms";
public $idField ="TermsID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TermsID"];
public $gridFields = [

"TermsID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"TermsDescription" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"NetDays" => [
    "dbType" => "smallint(6)",
    "inputType" => "text"
],
"DiscountPercent" => [
    "dbType" => "float",
    "format" => "{0:n}",
    "inputType" => "text"
],
"DiscountDays" => [
    "dbType" => "smallint(6)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"TermsID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"TermsDescription" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"NetDays" => [
"dbType" => "smallint(6)",
"inputType" => "text",
"defaultValue" => ""
],
"DiscountPercent" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"DiscountDays" => [
"dbType" => "smallint(6)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"TermsID" => "Terms ID",
"TermsDescription" => "Terms Description",
"NetDays" => "Net Days",
"DiscountPercent" => "Discount Percent",
"DiscountDays" => "Discount Days"];
}?>
