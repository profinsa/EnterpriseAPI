<?php
/*
  Name of Page: financials reports controller

  Method: controller for financials report pages

  Date created: Nikita Zaharov, 09.05.2017

  Use: The controller is responsible for:
  - page rendering using view

  Input parameters:
  $app : application instance, object

  Output parameters:
  $scope: object, used by view, most like model
  $translation: model, it is responsible for translation in view

  Called from:
  + index.php

  Calls:
  models/translation.php
  models/financials/*.php
  app from index.php

  Last Modified: 25.02.2019
  Last Modified by: Nikita Zaharov
*/

require 'models/translation.php';
require 'models/security.php';
require 'models/permissionsGenerated.php';
require 'models/drillDowner.php';

class controller{
    public $user = false;
    public $action = "";
    public $mode = "financials";
    public $path;
    public $interface = "default";
    public $breadCrumbTitle = "GAAP Financial Statements";
    public $dashboardTitle = "GAAP Financial Statements";
        
    public function process($app){
        if(!key_exists("user", $_SESSION) || !$_SESSION["user"] || !key_exists("EmployeeUserName", $_SESSION["user"])){ //redirect to prevent access unlogined users
            $_SESSION["user"] = false;
            http_response_code(401);
            echo "wrong session";
            exit;
        }

        $type = $_GET["type"];
        $overridenType = $type;
        if($type == "ifrs")
            $type = "gaap";
        
        $module = $_GET["module"];
        
        //$_perm = new permissionsByFile();
        //preg_match("/\/([^\/]+)(List|Detail)$/", $model_path, $filename);
        // if(key_exists($filename[1], $_perm->permissions))
        //  $security = new Security($_SESSION["user"]["accesspermissions"], $_perm->permissions[$filename[1]]);
        // else
        //  return response('permissions not found', 500)->header('Content-Type', 'text/plain');

        $this->user = $_SESSION["user"];
        $this->interface = $_SESSION["user"]["interface"] = $interface = key_exists("interface", $_GET) ? $_GET["interface"] : (key_exists("interface", $_SESSION["user"]) ? $_SESSION["user"]["interface"] : "default");
               
        $GLOBALS["user"] = $user = $this->user;
        $path = $type . "/" . $module;
        $id = "";
        if(preg_match('/gaap\/BalanceSheet(\w+)/', $path, $numberParts)){
            $reqpath = "/gaap/BalanceSheetStandard";
            $id = $numberParts[1];
        }else if(preg_match('/gaap\/IncomeStatement(\w+)/', $path, $numberParts)){
            $reqpath = "/gaap/IncomeStatement";
            $id = $numberParts[1];
        }else if(preg_match('/gaap\/CashFlow(\w+)/', $path, $numberParts)){
            $reqpath = "/gaap/CashFlow";
            $id = $numberParts[1];
        }else if(preg_match('/gaap\/TrialBalance(\w+)/', $path, $numberParts)){
            $reqpath = "/gaap/TrialBalance";
            $id = $numberParts[1];
        }else
            $reqpath = $path;
        require __DIR__ . "/../models/reports/financials/" . $reqpath . ".php";
        $data = new financialsReportData($id);
               
        $translation = new translation($user["language"]);

        $app->title = $data->title;
        if($overridenType == 'ifrs'){
            $app->title = preg_replace('/(GAAP)/', 'IFRS', $app->title);
            $this->breadCrumbTitle = preg_replace('/(GAAP)/', 'IFRS', $this->breadCrumbTitle);
            $this->dashboardTitle = preg_replace('/(GAAP)/', 'IFRS', $this->dashboardTitle);
        }

        $templates = [
            "gaap" => [
                "AgedPayablesSummary" => "gaap/AgedPayablesSummary",
                "AgedPayablesSummaryComparative" => "gaap/AgedPayablesSummary",
                "AgedPayablesSummaryYTD" => "gaap/AgedPayablesSummary",
                "AgedReceivablesSummary" => "gaap/AgedReceivablesSummary",
                "AgedReceivablesSummaryComparative" => "gaap/AgedReceivablesSummary",
                "AgedReceivablesSummaryYTD" => "gaap/AgedReceivablesSummary",

                "main" => "gaap/main",

                "BalanceSheetStandard" => "gaap/BalanceSheetStandard",
                "BalanceSheetCompany" => "gaap/BalanceSheetStandard",
                "BalanceSheetDivision" => "gaap/BalanceSheetStandard",
                "BalanceSheetPeriod" => "gaap/BalanceSheetStandard",
                "BalanceSheetCompanyPeriod" => "gaap/BalanceSheetStandard",
                "BalanceSheetDivisionPeriod" => "gaap/BalanceSheetStandard",
                
                "IncomeStatementStandard" => "gaap/IncomeStatement",
                "IncomeStatementCompany" => "gaap/IncomeStatement",
                "IncomeStatementDivision" => "gaap/IncomeStatement",
                "IncomeStatementPeriod" => "gaap/IncomeStatement",
                "IncomeStatementCompanyPeriod" => "gaap/IncomeStatement",
                "IncomeStatementDivisionPeriod" => "gaap/IncomeStatement",

                "CashFlowStandard" => "gaap/CashFlow",
                "CashFlowCompany" => "gaap/CashFlow",
                "CashFlowDivision" => "gaap/CashFlow",
                "CashFlowPeriod" => "gaap/CashFlow",
                "CashFlowCompanyPeriod" => "gaap/CashFlow",
                "CashFlowDivisionPeriod" => "gaap/CashFlow",

            	"TrialBalanceStandard" => "gaap/TrialBalance",
                "TrialBalanceCompany" => "gaap/TrialBalance",
                "TrialBalanceDivision" => "gaap/TrialBalance"
            ],
            "common" => [
                "worksheets" => "worksheets"
            ]
        ];

        $drill = new drillDowner();

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {            
            $translation = new translation($this->user["language"]);
            if(key_exists("title", $_GET))
                $this->breadCrumbTitle = $this->dashboardTitle = $translation->translateLabel("Report: " ) . $translation->translateLabel($_GET["title"]);
            
               $scope = $this;
               $ascope = json_decode(json_encode($scope), true);

               $keyString = $this->user["CompanyID"] . "__" . $this->user["DivisionID"] . "__" . $this->user["DepartmentID"];
               $content = $templates[$type][$module] . ".php";
               require "views/reports/financials/" . ( key_exists("partial",$_GET) || $module == "worksheets" || $module =="main" ? $templates[$type][$module] :"container") .'.php';
        }
    }
}
?>