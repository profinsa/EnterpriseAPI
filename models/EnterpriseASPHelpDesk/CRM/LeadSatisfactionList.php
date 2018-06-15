<?php

/*
Name of Page: LeadSatisfactionList model
 
Method: Model for www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\CRM\LeadSatisfactionList.php It provides data from database and default values, column names and categories
 
Date created: 02/16/2017  Kenna Fetterman
 
Use: this model used by views/LeadSatisfactionList for:
- as a dictionary for view during building interface(tabs and them names, fields and them names etc, column name and corresponding translationid)
- for loading data from tables, updating, inserting and deleting
 
Input parameters:
$db: database instance
methods have their own parameters
 
Output parameters:
- dictionaries as public properties
- methods have their own output
 
Called from:
created and used for ajax requests by controllers/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\CRM\LeadSatisfactionList.php
used as model by views/www.integralaccountingx.com\EnterpriseX\models\EnterpriseASPHelpDesk\CRM\LeadSatisfactionList.php
 
Calls:
MySql Database
 
Last Modified: 04/12/2017
Last Modified by: Kenna Fetterman
*/
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
public $tableName = "leadsatisfaction";
public $dashboardTitle ="LeadSatisfaction";
public $breadCrumbTitle ="LeadSatisfaction";
public $idField ="LeadID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","LeadID","ItemID","SurveyDate"];
public $gridFields = [

"LeadID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"SurveyDate" => [
    "dbType" => "datetime",
    "format" => "{0:d}",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"LeadID" => [
"dbType" => "varchar(50)",
"inputType" => "text",
"defaultValue" => ""
],
"ItemID" => [
"dbType" => "varchar(36)",
"inputType" => "text",
"defaultValue" => ""
],
"SurveyDate" => [
"dbType" => "datetime",
"inputType" => "datetime",
"defaultValue" => "now"
],
"QuestionOne" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionOneMetric" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionTwo" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionTwoMetric" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionThree" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionThreeMetric" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFour" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFourMetric" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFive" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFiveMetric" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionSix" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionSixMetric" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionSeven" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionSevenMetric" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionEight" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionEightMetric" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionNine" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionNineMetric" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionTen" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionTenMetric" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionEleven" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionElevenMetric" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionTwelve" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionTwelveMetric" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionThirteen" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionThirteenMetric" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFourteen" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFourteenMetric" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFifteen" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFifteenMetric" => [
"dbType" => "int(11)",
"inputType" => "text",
"defaultValue" => ""
],
"FreeForm" => [
"dbType" => "varchar(255)",
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"LeadID" => "Lead ID",
"ItemID" => "Item ID",
"SurveyDate" => "Survey Date",
"QuestionOne" => "Question One",
"QuestionOneMetric" => "Question One Metric",
"QuestionTwo" => "Question Two",
"QuestionTwoMetric" => "Question Two Metric",
"QuestionThree" => "Question Three",
"QuestionThreeMetric" => "Question Three Metric",
"QuestionFour" => "Question Four",
"QuestionFourMetric" => "Question Four Metric",
"QuestionFive" => "Question Five",
"QuestionFiveMetric" => "Question Five Metric",
"QuestionSix" => "Question Six",
"QuestionSixMetric" => "Question Six Metric",
"QuestionSeven" => "Question Seven",
"QuestionSevenMetric" => "Question Seven Metric",
"QuestionEight" => "Question Eight",
"QuestionEightMetric" => "Question Eight Metric",
"QuestionNine" => "Question Nine",
"QuestionNineMetric" => "Question Nine Metric",
"QuestionTen" => "Question Ten",
"QuestionTenMetric" => "Question Ten Metric",
"QuestionEleven" => "Question Eleven",
"QuestionElevenMetric" => "Question Eleven Metric",
"QuestionTwelve" => "Question Twelve",
"QuestionTwelveMetric" => "Question Twelve Metric",
"QuestionThirteen" => "Question Thirteen",
"QuestionThirteenMetric" => "Question Thirteen Metric",
"QuestionFourteen" => "Question Fourteen",
"QuestionFourteenMetric" => "Question Fourteen Metric",
"QuestionFifteen" => "Question Fifteen", 
"QuestionFifteenMetric" => "Question Fifteen Metric",
"FreeForm" => "Free Form"];
}?>
