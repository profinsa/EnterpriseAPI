<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemailmessages";
public $dashboardTitle ="PayrollEmailMessages";
public $breadCrumbTitle ="PayrollEmailMessages";
public $idField ="EmailMessageID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmailMessageID"];
public $gridFields = [

"EmailMessageID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"Sender" => [
    "dbType" => "varchar(60)",
    "inputType" => "text"
],
"CCTo" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"Subject" => [
    "dbType" => "varchar(120)",
    "inputType" => "text"
],
"Priority" => [
    "dbType" => "smallint(6)",
    "inputType" => "text"
],
"TimeSent" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"EmailMessageID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Body" => [
"dbType" => "longtext",
"inputType" => "text",
"defaultValue" => ""
],
"Sender" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"CCTo" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"Subject" => [
"dbType" => "varchar(120)",
"inputType" => "text",
"defaultValue" => ""
],
"Priority" => [
"dbType" => "smallint(6)",
"inputType" => "text",
"defaultValue" => ""
],
"TimeSent" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
]
]];
public $columnNames = [

"EmailMessageID" => "Message ID",
"Sender" => "Sender",
"CCTo" => "CC To",
"Subject" => "Subject",
"Priority" => "Priority",
"TimeSent" => "Time Sent",
"Body" => "Body"];
}?>
