<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "terms";
protected $gridFields =["TermsID","TermsDescription","NetDays","DiscountPercent","DiscountDays"];
public $dashboardTitle ="Terms";
public $breadCrumbTitle ="Terms";
public $idField ="TermsID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","TermsID"];
public $editCategories = [
"Main" => [

"TermsID" => [
"inputType" => "text",
"defaultValue" => ""
],
"TermsDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"NetDays" => [
"inputType" => "text",
"defaultValue" => ""
],
"DiscountPercent" => [
"inputType" => "text",
"defaultValue" => ""
],
"DiscountDays" => [
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
