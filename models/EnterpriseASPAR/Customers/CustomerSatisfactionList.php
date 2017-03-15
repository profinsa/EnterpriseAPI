<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customersatisfaction";
public $dashboardTitle ="CustomerSatisfaction";
public $breadCrumbTitle ="CustomerSatisfaction";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ItemID","SurveyDate"];
public $gridFields = [

"CustomerID" => [
    "dbType" => "varchar(50)",
    "inputType" => "text"
],
"ItemID" => [
    "dbType" => "varchar(36)",
    "inputType" => "text"
],
"SurveyDate" => [
    "dbType" => "datetime",
    "inputType" => "datetime"
]
];

public $editCategories = [
"Main" => [

"CustomerID" => [
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

"CustomerID" => "Customer ID",
"ItemID" => "Item ID",
"SurveyDate" => "Survey Date",
"QuestionOne" => "QuestionOne",
"QuestionOneMetric" => "QuestionOneMetric",
"QuestionTwo" => "QuestionTwo",
"QuestionTwoMetric" => "QuestionTwoMetric",
"QuestionThree" => "QuestionThree",
"QuestionThreeMetric" => "QuestionThreeMetric",
"QuestionFour" => "QuestionFour",
"QuestionFourMetric" => "QuestionFourMetric",
"QuestionFive" => "QuestionFive",
"QuestionFiveMetric" => "QuestionFiveMetric",
"QuestionSix" => "QuestionSix",
"QuestionSixMetric" => "QuestionSixMetric",
"QuestionSeven" => "QuestionSeven",
"QuestionSevenMetric" => "QuestionSevenMetric",
"QuestionEight" => "QuestionEight",
"QuestionEightMetric" => "QuestionEightMetric",
"QuestionNine" => "QuestionNine",
"QuestionNineMetric" => "QuestionNineMetric",
"QuestionTen" => "QuestionTen",
"QuestionTenMetric" => "QuestionTenMetric",
"QuestionEleven" => "QuestionEleven",
"QuestionElevenMetric" => "QuestionElevenMetric",
"QuestionTwelve" => "QuestionTwelve",
"QuestionTwelveMetric" => "QuestionTwelveMetric",
"QuestionThirteen" => "QuestionThirteen",
"QuestionThirteenMetric" => "QuestionThirteenMetric",
"QuestionFourteen" => "QuestionFourteen",
"QuestionFourteenMetric" => "QuestionFourteenMetric",
"QuestionFifteen" => "QuestionFifteen",
"QuestionFifteenMetric" => "QuestionFifteenMetric",
"FreeForm" => "FreeForm"];
}?>
