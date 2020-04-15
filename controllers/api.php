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

  Last Modified: 15.04.2020
  Last Modified by: Nikita Zaharov
*/

require_once 'models/translation.php';
require_once 'models/security.php';
require_once 'models/permissionsGenerated.php';
//require 'models/users.php';
require_once 'models/linksMaker.php';
require_once 'models/interfaces.php';

class apiController{
    public $user = false;
    public $action = "";
    public $mode = "docreports";
    public $config;
    public $path;
    public $interfaces;

    public function __construct(){
        $this->interfaces = new interfaces();
    }
    
    public function process($app){
        /*$users = new users();
        $users->checkLoginInUrl();
        if(!key_exists("user", $_SESSION) || !$_SESSION["user"] || !key_exists("EmployeeUserName", $_SESSION["user"])){ //redirect to prevent access unlogined users
            $_SESSION["user"] = false;
            http_response_code(401);
            echo "wrong session";
            exit;
            }*/

        if(key_exists("module", $_GET)){
            switch($_GET["module"]){
            case "auth":
                $_GET["module"] = "login";
                break;
            }
            require 'controllers/' . $_GET["module"] . '.php';
            $controllerName = $_GET["module"] . "Controller";
            $app->controller = new $controllerName();
            if($_SERVER['REQUEST_METHOD'] === 'POST') {
                $postData = file_get_contents("php://input");
                $_POST = json_decode($postData, true);

                switch($_GET["module"]){
                case "login" :
                    switch($_GET["action"]){
                    case "login":
                        $_POST["company"] = $_POST["CompanyID"];
                        $_POST["division"] = $_POST["DivisionID"];
                        $_POST["department"] = $_POST["DepartmentID"];
                        $_POST["name"] = $_POST["EmployeeID"];
                        $_POST["password"] = $_POST["EmployeePassword"];
                        break;
                    }
                    break;
                case "grid" :
                    switch($_GET["action"]){
                    case "create":
                        $_GET["procedure"] = "insertItemRemote";
                        break;
                    case "update":
                        $_GET["procedure"] = "updateItemRemote";
                        break;
                    }
                    $_GET["action"] = $_GET["path"];
                    
                    break;
                }
                $app->controller->process($app);
            }else if($_SERVER['REQUEST_METHOD'] === 'GET') {
                switch($_GET["module"]){
                case "grid" :
                    switch($_GET["action"]){
                    case "list" :
                        $_GET["procedure"] = "getPageRemote";
                        break;
                    case "getEmptyRecord":
                        $_GET["procedure"] = "getEmptyRecord";
                        break;
                    case "delete":
                        $_GET["procedure"] = "deleteItem";
                        break;
                    }
                    $_GET["action"] = $_GET["path"];
                    
                    break;
                }
                $app->controller->process($app);
            }
        }else{
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
                    require_once 'models/EnterpriseASPHelpDesk/CRM/LeadInformationList.php';
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
                require 'views/api/index.js';
            }
        }
    }
}
?>