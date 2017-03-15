<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemailmessages";
protected $gridFields =["EmailMessageID","Sender","CCTo","Subject","Priority","TimeSent"];
public $dashboardTitle ="PayrollEmailMessages";
public $breadCrumbTitle ="PayrollEmailMessages";
public $idField ="EmailMessageID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmailMessageID"];
public $editCategories = [
"Main" => [

"EmailMessageID" => [
"inputType" => "text",
"defaultValue" => ""
],
"Body" => [
"inputType" => "text",
"defaultValue" => ""
],
"Sender" => [
"inputType" => "text",
"defaultValue" => ""
],
"CCTo" => [
"inputType" => "text",
"defaultValue" => ""
],
"Subject" => [
"inputType" => "text",
"defaultValue" => ""
],
"Priority" => [
"inputType" => "text",
"defaultValue" => ""
],
"TimeSent" => [
"inputType" => "datepicker",
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
