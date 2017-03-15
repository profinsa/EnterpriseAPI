<?php
namespace App\Models;
 require __DIR__ . "/../../../Models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customersatisfaction";
public $gridFields =["CustomerID","ItemID","SurveyDate"];
public $dashboardTitle ="CustomerSatisfaction";
public $breadCrumbTitle ="CustomerSatisfaction";
public $idField ="CustomerID";
public $idFields = ["CompanyID","DivisionID","DepartmentID","CustomerID","ItemID","SurveyDate"];
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
"inputType" => "datetime",
"defaultValue" => "now"
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
