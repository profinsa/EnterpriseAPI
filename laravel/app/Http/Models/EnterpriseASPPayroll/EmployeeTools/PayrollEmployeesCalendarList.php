<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployeescalendar";
protected $gridFields =["EmployeeID","AppointmenStart","AppointmentEnd","AppointmentReason","RelatedTaskID","RelatedCustomerID","RelatedLeadID","RelatedVendorID"];
public $dashboardTitle ="PayrollEmployeesCalendar";
public $breadCrumbTitle ="PayrollEmployeesCalendar";
public $idField ="EmployeeID";
public $editCategories = [
"Main" => [

"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AppointmenStart" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"AppointmentEnd" => [
"inputType" => "datepicker",
"defaultValue" => "now"
],
"AppointmentReason" => [
"inputType" => "text",
"defaultValue" => ""
],
"AppointmentDescription" => [
"inputType" => "text",
"defaultValue" => ""
],
"RelatedTaskID" => [
"inputType" => "text",
"defaultValue" => ""
],
"RelatedDocumentID" => [
"inputType" => "text",
"defaultValue" => ""
],
"RelatedCustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"RelatedLeadID" => [
"inputType" => "text",
"defaultValue" => ""
],
"RelatedVendorID" => [
"inputType" => "text",
"defaultValue" => ""
],
"AppointmentNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"RequestedBy" => [
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