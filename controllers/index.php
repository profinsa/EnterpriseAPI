<?php
/*
  Name of Page: Index

  Method: This is controller for index page.

  Date created: Nikita Zaharov, 02.09.2017

  Use: controller is used by index.php, load by GET request parameter - page=index.

  The controller is responsible for:
  + loading user and translation models
  + render index page

  Input parameters:
  $app : application instance, object

  Output parameters:
  $scope: object, used by view, most like model
  $translation: model, it is responsible for translation in view

  Called from:
  + index.php

  Calls:
  models/translation.php
  app from index.php

  Last Modified: 14.04.2020
  Last Modified by: Nikita Zaharov
*/

require 'models/users.php';
require 'models/translation.php';
require 'models/security.php';
require 'models/drillDowner.php';
require 'models/linksMaker.php';
require 'models/interfaces.php';

class indexController{
    public $user = false;
    public $interface = "default";
    public $interfaceType = "ltr";
    public $dashboardTitle = "Accounting Dashboard";
    public $breadCrumbTitle = "Accounting Dashboard";
    public $config;
    public $security;
    public $interfaces;

    function __construct(){
        $this->interfaces = new interfaces();
    }
    
    public function process($app){
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {
            $users = new users();
            $users->checkLoginInUrl();
            if(key_exists("logout", $_GET) || !key_exists("user", $_SESSION) || !$_SESSION["user"] || !key_exists("EmployeeUserName", $_SESSION["user"])){ //Logout action or redirect to prevent access un logined users
                $_SESSION["user"] = false;
                header("Location: index.php?page=login&config=" . $_SESSION["configName"]);
                exit;
            }
            
            $this->interface = $_SESSION["user"]["interface"] = $interface = key_exists("interface", $_GET) ? $_GET["interface"] : (key_exists("interface", $_SESSION["user"]) ? $_SESSION["user"]["interface"] : "default");
            if(!key_exists("interfaceName", $_SESSION["user"]))
                $_SESSION["user"]["interfaceName"] = $this->interfaces->description[$this->interface]["title"]; 
                
            $this->interfaceType = $_SESSION["user"]["interfaceType"] = $interfaceType = key_exists("interfacetype", $_GET) ? $_GET["interfacetype"] : (key_exists("interfaceType", $_SESSION["user"]) ? $_SESSION["user"]["interfaceType"] : $this->interfaceType);
            
            $drill = new drillDowner();
            $linksMaker = new linksMaker();
            $this->user = $user = $_SESSION["user"];
               
            $security = $this->security = new Security($this->user["accesspermissions"], []);
            $translation = new translation($this->user["language"]);
            $this->dashboardTitle = $translation->translateLabel($this->dashboardTitle);
            $this->breadCrumbTitle = $translation->translateLabel($this->breadCrumbTitle);
            $this->config = config();
            $scope = $this;
            $ascope = json_decode(json_encode($scope), true);
            $keyString = $this->user["CompanyID"] . "__" . $this->user["DivisionID"] . "__" . $this->user["DepartmentID"];
            require 'models/menuCategoriesGenerated.php';
            require 'views/interfaces/' . $this->interfaces->description[$interface]["interface"] . '/index.php';
        }
    }
}
?>