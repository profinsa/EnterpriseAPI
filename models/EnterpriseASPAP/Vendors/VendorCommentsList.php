<?php

/*
Name of Page: VendorCommentsList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendorCommentsList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/VendorCommentsList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendorCommentsList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPAP\Vendors\VendorCommentsList.php
 
Calls:
MySql Database
 
Last Modified: 04/13/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "vendorcomments";
public $dashboardTitle ="Vendor Comments";
public $breadCrumbTitle ="Vendor Comments";
public $idField ="VendorID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","VendorID","CommentLineID"];
public $gridFields = [

"VendorID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"CommentLineID" => [
    "dbType" => "int(11)",
    "inputType" => "text"
],
"CommentTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CommentDate" => [
    "dbType" => "timestamp",
    "format" => "{0:d}",
    "inputType" => "datetime"
],
"Comment" => [
    "dbType" => "varchar(255)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"VendorID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"CommentLineID" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"CommentDate" => [
"dbType" => "timestamp",
"inputType" => "datetime",
"defaultValue" => "now"
],
"CommentTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Comment" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"VendorID" => "Vendor ID",
"CommentLineID" => "Comment Line ID",
"CommentTypeID" => "Comment Type ID",
"CommentDate" => "Comment Date",
"Comment" => "Comment"];
}?>
