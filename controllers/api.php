<?php
/*
  Name of Page: API controller

  Method: controller for API

  Date created: Nikita Zaharov, 17.10.2019

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
  models/help/*
  app from index.php

  Last Modified: 17.10.2019
  Last Modified by: Nikita Zaharov
*/

require 'models/translation.php';
require 'models/security.php';
require 'models/permissionsGenerated.php';
//require 'models/users.php';
require 'models/linksMaker.php';
require 'models/EnterpriseASPHelpDesk/CRM/LeadInformationList.php';

class controller{
    public $user = false;
    public $action = "";
    public $mode = "docreports";
    public $config;
    public $path;

    public function process($app){
        /*$users = new users();
        $users->checkLoginInUrl();
        if(!key_exists("user", $_SESSION) || !$_SESSION["user"] || !key_exists("EmployeeUserName", $_SESSION["user"])){ //redirect to prevent access unlogined users
            $_SESSION["user"] = false;
            http_response_code(401);
            echo "wrong session";
            exit;
            }*/

        $id = key_exists("url", $_GET) ? $_GET["url"] : "";
        $this->config = $config = config();
        $this->user = $config["user"];
        $this->user["EmployeeID"] = "Help";
        SESSION::set("user", $this->user);
        $scope = $GLOBALS["scope"] = $this;
        
        //$this->user = $_SESSION["user"];
               
        $linksMaker = new linksMaker();
        $ascope = json_decode(json_encode($this), true);
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if(key_exists("method", $_GET)){
                $leadInformation = new LeadInformationList();
                switch($_GET["method"]){
                case "addLead" :
                    $result = [];
                    foreach($leadInformation->editCategories as $key=>$value)
                        $result = array_merge($result, $leadInformation->getNewItem("", $key));
                    $result["LeadID"] = $_POST["EMAIL"];
                    $leadInformation->insertItemLocal($result, true);
                    echo "<html><body>Thanks for your interest to our software!<br>Newletter we will email you when updates are made to the software!</body></html>";
                    break;
                default:
                    echo "ok";
                }
            }
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {            
            $translation = new translation($this->user["language"]);
            
            $keyString = $this->user["CompanyID"] . "__" . $this->user["DivisionID"] . "__" . $this->user["DepartmentID"];
            require 'views/api/index.php';
        }
    }
}
?>