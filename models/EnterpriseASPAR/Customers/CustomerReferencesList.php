<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customerreferences";
public $dashboardTitle ="CustomerReferences";
public $breadCrumbTitle ="CustomerReferences";
public $idField ="ReferenceID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","ReferenceID","CustomerID"];
public $gridFields = [

"CustomerID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"ReferenceID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"CompanyName" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"ProjectName" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"Country" => [
    "dbType" => "varchar(80)",
    "inputType" => "text"
],
"FirstName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"LastName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"MiddleName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
]
];

public $editCategories = [
"Main" => [

"ReferenceID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"CustomerID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Permission" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"CompanyName" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"ProjectName" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"PerferedLanguage" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"Country" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"AddressLine1" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"AddressLine2" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"AddressLine3" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"City" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"State" => [
"dbType" => "varchar(40)",
"inputType" => "text",
"defaultValue" => ""
],
"Zip" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"FirstName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"LastName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"MiddleName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"AdditionalLastName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Title" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Salutation" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"Email" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"PhoneCountry" => [
"dbType" => "varchar(4)",
"inputType" => "text",
"defaultValue" => ""
],
"PhoneArea" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"PhoneNumber" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"PhoneExt" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"VertConsumerBusinessMfg" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"VertEducation" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"VertFinancial" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"VertGeneral" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"VertGovernment" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"VertHealthcare" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"VertIndustrialManagement" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"VertMedia" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"VertNonProfit" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"VertProfessional" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"VertRetail" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"VertTelecommunications" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ImplementedCompanyWide" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ImplementedWithinDepartments" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"DeptHumanResources" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"DeptInformationTechnology" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"DeptAccountingFinance" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"DeptResearch" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"DeptMarketing" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"DeptTravel" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"DeptSales" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"DeptDistributionWarehouse" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"DeptOther" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"NumberOfEmployees" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"NumberOfUsers" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"DescribeProject" => [
"dbType" => "varchar(999)",
"inputType" => "text",
"defaultValue" => ""
],
"DescriptSolution" => [
"dbType" => "varchar(999)",
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
