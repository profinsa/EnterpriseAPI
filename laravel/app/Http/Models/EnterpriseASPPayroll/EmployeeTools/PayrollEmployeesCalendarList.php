<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeescalendar";
public $dashboardTitle ="PayrollEmployeesCalendar";
public $breadCrumbTitle ="PayrollEmployeesCalendar";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID","AppointmenStart"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"AppointmenStart" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"AppointmentEnd" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
],
"AppointmentReason" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"RelatedTaskID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"RelatedCustomerID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"RelatedLeadID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"RelatedVendorID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AppointmenStart" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"AppointmentEnd" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"AppointmentReason" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"AppointmentDescription" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"RelatedTaskID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"RelatedDocumentID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"RelatedCustomerID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"RelatedLeadID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"RelatedVendorID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"AppointmentNotes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"RequestedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"AppointmenStart" => "Appointmen Start",
"AppointmentEnd" => "Appointment End",
"AppointmentReason" => "Appointment Reason",
"RelatedTaskID" => "RelatedTask ID",
"RelatedCustomerID" => "Related Customer ID",
"RelatedLeadID" => "Related Lead ID",
"RelatedVendorID" => "Related Vendor ID",
"AppointmentDescription" => "AppointmentDescription",
"RelatedDocumentID" => "RelatedDocumentID",
"AppointmentNotes" => "AppointmentNotes",
"RequestedBy" => "RequestedBy"];
}?>
