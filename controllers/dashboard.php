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

  Last Modified: 05.29.2019
  Last Modified by: Nikita Zaharov
*/

require 'models/translation.php';
require 'models/security.php';
require 'models/permissionsGenerated.php';
require 'models/drillDowner.php';
require 'models/linksMaker.php';

class controller{
    public $user = false;
    public $interface = "default";
    public $category = "Accounting";
    public $path;
    public $mode = "dashboard";

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
            "Tasks" => "Tasks"
        ];

        $titlesRewrite = [
            "Tasks" => "Tasks",
            "Customer" => "Customer",
            "Vendor" => "Vendor",
            "Item" => "Item",
            "PurchaseAndReceiving" => "Purchase & Receiving",
            "SalesAndShipping" => "Sales & Shipping"
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
                if(key_exists("defaultDashboard", $config))
                    $dashboardFile = $config["defaultDashboard"];
                $this->breadCrumbTitle = $this->dashboardTitle = $translation->translateLabel("Accounting");
                if($user["accesspermissions"]["DefaultDashboard"] != ""){
                    $dashboardFile = preg_replace("/[\s]+/", "", $user["accesspermissions"]["DefaultDashboard"]);
                    $this->breadCrumbTitle = $this->dashboardTitle =  $translation->translateLabel($user["accesspermissions"]["DefaultDashboard"]); 
                }
            }
            require "views/dashboards/{$dashboardFile}.php";
        }
    }
}
?>