<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customerreferences";
protected $gridFields =["CustomerID","ReferenceID","CompanyName","ProjectName","Country","FirstName","LastName","MiddleName"];
public $dashboardTitle ="CustomerReferences";
public $breadCrumbTitle ="CustomerReferences";
public $idField ="ReferenceID";
public $editCategories = [
"Main" => [

"ReferenceID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CompanyName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ProjectName" => [
"inputType" => "text",
"defaultValue" => ""
],
"PerferedLanguage" => [
"inputType" => "text",
"defaultValue" => ""
],
"Country" => [
"inputType" => "text",
"defaultValue" => ""
],
"AddressLine1" => [
"inputType" => "text",
"defaultValue" => ""
],
"AddressLine2" => [
"inputType" => "text",
"defaultValue" => ""
],
"AddressLine3" => [
"inputType" => "text",
"defaultValue" => ""
],
"City" => [
"inputType" => "text",
"defaultValue" => ""
],
"State" => [
"inputType" => "text",
"defaultValue" => ""
],
"Zip" => [
"inputType" => "text",
"defaultValue" => ""
],
"FirstName" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastName" => [
"inputType" => "text",
"defaultValue" => ""
],
"MiddleName" => [
"inputType" => "text",
"defaultValue" => ""
],
"AdditionalLastName" => [
"inputType" => "text",
"defaultValue" => ""
],
"Title" => [
"inputType" => "text",
"defaultValue" => ""
],
"Salutation" => [
"inputType" => "text",
"defaultValue" => ""
],
"Email" => [
"inputType" => "text",
"defaultValue" => ""
],
"PhoneCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"PhoneArea" => [
"inputType" => "text",
"defaultValue" => ""
],
"PhoneNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"PhoneExt" => [
"inputType" => "text",
"defaultValue" => ""
],
"NumberOfEmployees" => [
"inputType" => "text",
"defaultValue" => ""
],
"NumberOfUsers" => [
"inputType" => "text",
"defaultValue" => ""
]
]
"Vert" => [
]
"Dept" => [
]
"Description" => [

"DescribeProject" => [
"inputType" => "text",
"defaultValue" => ""
],
"DescriptSolution" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerID" => "Customer ID",
"ReferenceID" => "Reference ID",
"CompanyName" => "Company Name",
"ProjectName" => "Project Name",
"Country" => "Country",
"FirstName" => "First Name",
"LastName" => "Last Name",
"MiddleName" => "Middle Name",
"PerferedLanguage" => "Perfered Language",
"AddressLine1" => "Address 1",
"AddressLine2" => "Address 2",
"AddressLine3" => "Address 3",
"City" => "City",
"State" => "State",
"Zip" => "Zip",
"AdditionalLastName" => "Additional Last Name",
"Title" => "Title",
"Salutation" => "Salutation",
"Email" => "Email",
"PhoneCountry" => "Phone Country",
"PhoneArea" => "Phone Area",
"PhoneNumber" => "Phone Number",
"PhoneExt" => "Phone Ext",
"NumberOfEmployees" => "Number Of Employees",
"NumberOfUsers" => "Number Of Users",
"DescribeProject" => "Describe Project",
"DescriptSolution" => "Descript Solution"];
}?>
