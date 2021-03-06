<?php
/*
  Name of Page: dashboard controller

  Method: controller for dashboard pages(GeneralLedger and other). Used for rendering page and interacting with it

  Date created: Nikita Zaharov, 5.04.2017

  Use: The controller is responsible for:
  - page rendering using view
  - handling XHR request(delete, update and new item in grid)

  Input parameters:
  $app : application instance, object

  Output parameters:
  $scope: object, used by view, most like model
  $translation: model, it is responsible for translation in view

  Called from:
  + index.php

  Calls:
  models/translation.php
  models/dashboard/*
  app from index.php

  Last Modified: 14.04.2020
  Last Modified by: Nikita Zaharov
*/

require 'models/translation.php';
require 'models/security.php';
require 'models/permissionsGenerated.php';
require 'models/drillDowner.php';
require 'models/linksMaker.php';
require 'models/interfaces.php';

class dashboardController{
    public $user = false;
    public $interface = "default";
    public $interfaces;
    public $category = "Accounting";
    public $path;
    public $mode = "dashboard";

    function __construct(){
        $this->interfaces = new interfaces();
    }
    
    public function process($app){
        if(!$_SESSION["user"] || !key_exists("EmployeeUserName", $_SESSION["user"])){ //redirect to prevent access unlogined users
            $_SESSION["user"] = false;
            http_response_code(401);
            echo "wrong session";
            exit;
        }

        $config = config();
        $this->screen =  key_exists("screen", $_GET) ? $_GET["screen"] : "Accounting";
        $modelsRewrite = [
            "Accounting" => "Accounting",
            "Customer" => "Accounting",
            "Vendor" => "Accounting",
            "Item" => "Accounting",
            "PurchaseAndReceiving" => "Accounting",
            "SalesAndShipping" => "Accounting",
            "CRM" => "Accounting",
            "MRP" => "Accounting",
            "Tasks" => "Tasks",
            "Support" => "Accounting",
            "Admin" => "Accounting",
            "Distribution" => "Accounting",
            "Financial" => "Accounting",
            "Trust" => "Accounting",
            "NGO" => "Accounting",
            "ECommerce" => "Accounting"
        ];

        $titlesRewrite = [
            "Tasks" => "Tasks",
            "Customer" => "Customer",
            "Vendor" => "Vendor",
            "Item" => "Item",
            "PurchaseAndReceiving" => "Purchase & Receiving",
            "SalesAndShipping" => "Sales & Shipping",
            "CRM" => "CRM",
            "MRP" => "MRP",
            "Support" => "Support",
            "Admin" => "Admin",
            "Distribution" => "Distribution",
            "Financial" => "Financials",
            "Trust" => "Trust",
            "NGO" => "NGO",
            "simple" => "Accounting",
            "simpleservice" => "Accounting",
            "Accounting" => "Multi-Entity Accounting Dashboard",
            "ECommerce" => "ECommerce Fulfillment"
            //            "Accounting" => "Accounting"
        ];
        
        $modelName = $modelsRewrite[$this->screen];
        if(!file_exists('models/dashboards/' . $modelName . '.php'))
            throw new Exception("model " . 'models/dashboards/' . $modelName . '.php' . " is not found");
        require 'models/dashboards/' . $modelName . '.php';
        
        $_perm = new permissionsByFile();

        $user = $GLOBALS["user"] = $this->user = $_SESSION["user"];
               
        $this->interface = $_SESSION["user"]["interface"] = $interface = key_exists("interface", $_GET) ? $_GET["interface"] : (key_exists("interface", $_SESSION["user"]) ? $_SESSION["user"]["interface"] : "default");
        $data = new dashboardData();
        $drill = new drillDowner();
        $linksMaker = new linksMaker();
        
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if(key_exists("procedure", $_GET)){
                $name = $_GET["procedure"];
                $data->$name();
            }
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {            
            $translation = new translation($this->user["language"]);
            $this->dashboardTitle = $translation->translateLabel($data->dashboardTitle);
            $this->breadCrumbTitle = $translation->translateLabel($data->breadCrumbTitle);
          
            $scope = $this;
            $ascope = json_decode(json_encode($scope), true);
            
            if(key_exists("mode", $_GET))
                $this->mode = $_GET["mode"];
            
            if(key_exists("item", $_GET))
                $this->item = $_GET["item"];

            $keyString = $this->user["CompanyID"] . "__" . $this->user["DivisionID"] . "__" . $this->user["DepartmentID"];
            
            if(key_exists("screen",$_GET)){
                $this->breadCrumbTitle = $this->dashboardTitle = $titlesRewrite[$_GET["screen"]];
                $dashboardFile = $_GET["screen"];
            }else{
                $dashboardFile = "Accounting";
                $this->breadCrumbTitle = $this->dashboardTitle = $translation->translateLabel("Accounting");
                if(key_exists("defaultDashboard", $config)){
                    $dashboardFile = $config["defaultDashboard"];
                    $this->breadCrumbTitle = $this->dashboardTitle = $titlesRewrite[$config["defaultDashboard"]];
                }else{
                    $dashboardFile = $this->interfaces->description[$this->interface]["defaultDashboard"];
                    $this->breadCrumbTitle = $this->dashboardTitle = $titlesRewrite[$dashboardFile];
                }
                if(key_exists("DefaultDashboard", $user["accesspermissions"]) && $user["accesspermissions"]["DefaultDashboard"] != ""){
                    $dashboardFile = preg_replace("/[\s]+/", "", $user["accesspermissions"]["DefaultDashboard"]);
                    $this->breadCrumbTitle = $this->dashboardTitle =  $translation->translateLabel($user["accesspermissions"]["DefaultDashboard"]); 
                }
            }
            if(key_exists("hideui", $_GET)){
                if(key_exists("list", $_GET)){
                    $result = [];
                    $list = explode(",", $_GET["list"]);
                    foreach($list as $function){
                        $function = "get" . ($name = $function);
                        $result[$name] = $data->$function();
                    }
                    echo json_encode($result, JSON_PRETTY_PRINT);
                }
                /*$dashboardData = [
    "companyDailyActivity" => $data->getCompanyDailyActivityByDepartments(),
    "departments" => $data->getDepartments(),
    "companyAccountStatus" => $data->CompanyAccountsStatus(),
    "companyAccountStatusByDepartments" => $data->getAccountsStatusesByDepartments(),
    "leadFollowUpByDepartments" => $data->getLeadFollowUpByDepartments(),
    "todaysTasksByDepartments" => $data->getTodaysTasksByDepartments(),
    "topOrdersReceiptsByDepartments" => $data->getTopOrdersReceiptsByDepartments()
    ];*/
            }
            else
                require "views/dashboards/{$dashboardFile}.php";
        }
    }
}
?>