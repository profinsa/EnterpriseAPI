<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployees";
public $dashboardTitle ="Employees";
public $breadCrumbTitle ="Employees";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID"];
public $gridFields = [

"EmployeeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeTypeID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"EmployeeName" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ActiveYN" => [
    "dbType" => "tinyint(1)",
    "inputType" => "text"
],
"EmployeeUserName" => [
    "dbType" => "varchar(15)",
    "inputType" => "text"
],
"HireDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"EmployeeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeTypeID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeUserName" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePassword" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePasswordOld" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePasswordDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EmployeePasswordExpires" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePasswordExpiresDate" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ActiveYN" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeAddress1" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeAddress2" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeCity" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeState" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeZip" => [
"dbType" => "varchar(10)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeCountry" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePhone" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeFax" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeSSNumber" => [
"dbType" => "varchar(15)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeEmailAddress" => [
"dbType" => "varchar(60)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeDepartmentID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"PictureURL" => [
"dbType" => "varchar(80)",
"inputType" => "text",
"defaultValue" => ""
],
"HireDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Birthday" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"Commissionable" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"CommissionPerc" => [
"dbType" => "float",
"inputType" => "text",
"defaultValue" => ""
],
"CommissionCalcMethod" => [
"dbType" => "varchar(1)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeManager" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeRegionID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeSourceID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeIndustryID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"Notes" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"NextOfKinName" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"NextOfKinNumber" => [
"dbType" => "varchar(30)",
"inputType" => "text",
"defaultValue" => ""
],
"MonthToDateGross" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"MonthToDateFICA" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"MonthToDateFederal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"MonthToDateState" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"MonthToDateLocal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"MonthToDateOther" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"QuarterToDateGross" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"QuarterToDateFICA" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"QuarterToDateFederal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"QuarterToDateState" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"QuarterToDateLocal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"QuarterToDateOther" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"YearToDateGross" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"YearToDateFICA" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"YearToDateFederal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"YearToDateState" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"YearToDateLocal" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"YearToDateOther" => [
"dbType" => "decimal(19,4)",
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeCounty" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"dbType" => "tinyint(1)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"EmployeeID" => "Employee ID",
"EmployeeTypeID" => "Employee Type",
"EmployeeName" => "Employee Name",
"ActiveYN" => "Active",
"EmployeeUserName" => "User Name",
"HireDate" => "Hire Date",
"EmployeePassword" => "EmployeePassword",
"EmployeePasswordOld" => "EmployeePasswordOld",
"EmployeePasswordDate" => "EmployeePasswordDate",
"EmployeePasswordExpires" => "EmployeePasswordExpires",
"EmployeePasswordExpiresDate" => "EmployeePasswordExpiresDate",
"EmployeeAddress1" => "EmployeeAddress1",
"EmployeeAddress2" => "EmployeeAddress2",
"EmployeeCity" => "EmployeeCity",
"EmployeeState" => "EmployeeState",
"EmployeeZip" => "EmployeeZip",
"EmployeeCountry" => "EmployeeCountry",
"EmployeePhone" => "EmployeePhone",
"EmployeeFax" => "EmployeeFax",
"EmployeeSSNumber" => "EmployeeSSNumber",
"EmployeeEmailAddress" => "EmployeeEmailAddress",
"EmployeeDepartmentID" => "EmployeeDepartmentID",
"PictureURL" => "PictureURL",
"Birthday" => "Birthday",
"Commissionable" => "Commissionable",
"CommissionPerc" => "CommissionPerc",
"CommissionCalcMethod" => "CommissionCalcMethod",
"EmployeeManager" => "EmployeeManager",
"EmployeeRegionID" => "EmployeeRegionID",
"EmployeeSourceID" => "EmployeeSourceID",
"EmployeeIndustryID" => "EmployeeIndustryID",
"Notes" => "Notes",
"NextOfKinName" => "NextOfKinName",
"NextOfKinNumber" => "NextOfKinNumber",
"MonthToDateGross" => "MonthToDateGross",
"MonthToDateFICA" => "MonthToDateFICA",
"MonthToDateFederal" => "MonthToDateFederal",
"MonthToDateState" => "MonthToDateState",
"MonthToDateLocal" => "MonthToDateLocal",
"MonthToDateOther" => "MonthToDateOther",
"QuarterToDateGross" => "QuarterToDateGross",
"QuarterToDateFICA" => "QuarterToDateFICA",
"QuarterToDateFederal" => "QuarterToDateFederal",
"QuarterToDateState" => "QuarterToDateState",
"QuarterToDateLocal" => "QuarterToDateLocal",
"QuarterToDateOther" => "QuarterToDateOther",
"YearToDateGross" => "YearToDateGross",
"YearToDateFICA" => "YearToDateFICA",
"YearToDateFederal" => "YearToDateFederal",
"YearToDateState" => "YearToDateState",
"YearToDateLocal" => "YearToDateLocal",
"YearToDateOther" => "YearToDateOther",
"EmployeeCounty" => "EmployeeCounty",
"Approved" => "Approved",
"ApprovedBy" => "ApprovedBy",
"ApprovedDate" => "ApprovedDate",
"EnteredBy" => "EnteredBy"];
}?>
