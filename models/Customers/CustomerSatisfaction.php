<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customersatisfaction";
protected $gridFields =["CustomerID","ItemID","SurveyDate"];
public $dashboardTitle ="CustomerSatisfaction";
public $breadCrumbTitle ="CustomerSatisfaction";
public $idField ="CustomerID";
public $editCategories = [
"Main" => [

"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ItemID" => [
"inputType" => "text",
"defaultValue" => ""
],
"SurveyDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionOne" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionOneMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionTwo" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionTwoMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionThree" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionThreeMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFour" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFourMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFive" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFiveMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionSix" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionSixMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionSeven" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionSevenMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionEight" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionEightMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionNine" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionNineMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionTen" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionTenMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionEleven" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionElevenMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionTwelve" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionTwelveMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionThirteen" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionThirteenMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFourteen" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFourteenMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFifteen" => [
"inputType" => "text",
"defaultValue" => ""
],
"QuestionFifteenMetric" => [
"inputType" => "text",
"defaultValue" => ""
],
"FreeForm" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerID" => "Customer ID",
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
"FreeForm" => "FreeForm"];
}?>
