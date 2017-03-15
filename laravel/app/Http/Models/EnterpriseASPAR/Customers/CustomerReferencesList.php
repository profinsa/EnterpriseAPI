<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customerreferences";
public $gridFields =["CustomerID","ReferenceID","CompanyName","ProjectName","Country","FirstName","LastName","MiddleName"];
public $dashboardTitle ="CustomerReferences";
public $breadCrumbTitle ="CustomerReferences";
public $idField ="ReferenceID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ReferenceID","CustomerID"];
public $editCategories = [
"Main" => [

"ReferenceID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"Permission" => [
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
"VertConsumerBusinessMfg" => [
"inputType" => "text",
"defaultValue" => ""
],
"VertEducation" => [
"inputType" => "text",
"defaultValue" => ""
],
"VertFinancial" => [
"inputType" => "text",
"defaultValue" => ""
],
"VertGeneral" => [
"inputType" => "text",
"defaultValue" => ""
],
"VertGovernment" => [
"inputType" => "text",
"defaultValue" => ""
],
"VertHealthcare" => [
"inputType" => "text",
"defaultValue" => ""
],
"VertIndustrialManagement" => [
"inputType" => "text",
"defaultValue" => ""
],
"VertMedia" => [
"inputType" => "text",
"defaultValue" => ""
],
"VertNonProfit" => [
"inputType" => "text",
"defaultValue" => ""
],
"VertProfessional" => [
"inputType" => "text",
"defaultValue" => ""
],
"VertRetail" => [
"inputType" => "text",
"defaultValue" => ""
],
"VertTelecommunications" => [
"inputType" => "text",
"defaultValue" => ""
],
"ImplementedCompanyWide" => [
"inputType" => "text",
"defaultValue" => ""
],
"ImplementedWithinDepartments" => [
"inputType" => "text",
"defaultValue" => ""
],
"DeptHumanResources" => [
"inputType" => "text",
"defaultValue" => ""
],
"DeptInformationTechnology" => [
"inputType" => "text",
"defaultValue" => ""
],
"DeptAccountingFinance" => [
"inputType" => "text",
"defaultValue" => ""
],
"DeptResearch" => [
"inputType" => "text",
"defaultValue" => ""
],
"DeptMarketing" => [
"inputType" => "text",
"defaultValue" => ""
],
"DeptTravel" => [
"inputType" => "text",
"defaultValue" => ""
],
"DeptSales" => [
"inputType" => "text",
"defaultValue" => ""
],
"DeptDistributionWarehouse" => [
"inputType" => "text",
"defaultValue" => ""
],
"DeptOther" => [
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
],
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
"Permission" => "Permission",
"PerferedLanguage" => "PerferedLanguage",
"AddressLine1" => "AddressLine1",
"AddressLine2" => "AddressLine2",
"AddressLine3" => "AddressLine3",
"City" => "City",
"State" => "State",
"Zip" => "Zip",
"AdditionalLastName" => "AdditionalLastName",
"Title" => "Title",
"Salutation" => "Salutation",
"Email" => "Email",
"PhoneCountry" => "PhoneCountry",
"PhoneArea" => "PhoneArea",
"PhoneNumber" => "PhoneNumber",
"PhoneExt" => "PhoneExt",
"VertConsumerBusinessMfg" => "VertConsumerBusinessMfg",
"VertEducation" => "VertEducation",
"VertFinancial" => "VertFinancial",
"VertGeneral" => "VertGeneral",
"VertGovernment" => "VertGovernment",
"VertHealthcare" => "VertHealthcare",
"VertIndustrialManagement" => "VertIndustrialManagement",
"VertMedia" => "VertMedia",
"VertNonProfit" => "VertNonProfit",
"VertProfessional" => "VertProfessional",
"VertRetail" => "VertRetail",
"VertTelecommunications" => "VertTelecommunications",
"ImplementedCompanyWide" => "ImplementedCompanyWide",
"ImplementedWithinDepartments" => "ImplementedWithinDepartments",
"DeptHumanResources" => "DeptHumanResources",
"DeptInformationTechnology" => "DeptInformationTechnology",
"DeptAccountingFinance" => "DeptAccountingFinance",
"DeptResearch" => "DeptResearch",
"DeptMarketing" => "DeptMarketing",
"DeptTravel" => "DeptTravel",
"DeptSales" => "DeptSales",
"DeptDistributionWarehouse" => "DeptDistributionWarehouse",
"DeptOther" => "DeptOther",
"NumberOfEmployees" => "NumberOfEmployees",
"NumberOfUsers" => "NumberOfUsers",
"DescribeProject" => "DescribeProject",
"DescriptSolution" => "DescriptSolution"];
}?>
