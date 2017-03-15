<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "payrollemployees";
protected $gridFields =["EmployeeID","EmployeeTypeID","EmployeeName","ActiveYN","EmployeeUserName","HireDate"];
public $dashboardTitle ="Employees";
public $breadCrumbTitle ="Employees";
public $idField ="EmployeeID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","EmployeeID"];
public $editCategories = [
"Main" => [

"EmployeeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeTypeID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeUserName" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePasswordOld" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePasswordDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"EmployeePasswordExpires" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePasswordExpiresDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ActiveYN" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeState" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeePhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeFax" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeSSNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeEmailAddress" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeDepartmentID" => [
"inputType" => "text",
"defaultValue" => ""
],
"PictureURL" => [
"inputType" => "text",
"defaultValue" => ""
],
"HireDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Birthday" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"Commissionable" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommissionPerc" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommissionCalcMethod" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeManager" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeRegionID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeSourceID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeIndustryID" => [
"inputType" => "text",
"defaultValue" => ""
],
"Notes" => [
"inputType" => "text",
"defaultValue" => ""
],
"NextOfKinName" => [
"inputType" => "text",
"defaultValue" => ""
],
"NextOfKinNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"MonthToDateGross" => [
"inputType" => "text",
"defaultValue" => ""
],
"MonthToDateFICA" => [
"inputType" => "text",
"defaultValue" => ""
],
"MonthToDateFederal" => [
"inputType" => "text",
"defaultValue" => ""
],
"MonthToDateState" => [
"inputType" => "text",
"defaultValue" => ""
],
"MonthToDateLocal" => [
"inputType" => "text",
"defaultValue" => ""
],
"MonthToDateOther" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuarterToDateGross" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuarterToDateFICA" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuarterToDateFederal" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuarterToDateState" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuarterToDateLocal" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuarterToDateOther" => [
"inputType" => "text",
"defaultValue" => ""
],
"YearToDateGross" => [
"inputType" => "text",
"defaultValue" => ""
],
"YearToDateFICA" => [
"inputType" => "text",
"defaultValue" => ""
],
"YearToDateFederal" => [
"inputType" => "text",
"defaultValue" => ""
],
"YearToDateState" => [
"inputType" => "text",
"defaultValue" => ""
],
"YearToDateLocal" => [
"inputType" => "text",
"defaultValue" => ""
],
"YearToDateOther" => [
"inputType" => "text",
"defaultValue" => ""
],
"EmployeeCounty" => [
"inputType" => "text",
"defaultValue" => ""
],
"Approved" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedBy" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovedDate" => [
"inputType" => "datetime",
"defaultValue" => "now"
],
"EnteredBy" => [
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
