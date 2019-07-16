<?php
/*
  Name of Page: Help System controller

  Method: controller for Help System pages

  Date created: Nikita Zaharov, 16.07.2019

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

  Last Modified: 16.07.2019
  Last Modified by: Nikita Zaharov
*/

require 'models/translation.php';
require 'models/security.php';
require 'models/permissionsGenerated.php';
require 'models/users.php';

class controller{
    public $user = false;
    public $action = "";
    public $mode = "docreports";
    public $path;

    public function process($app){
        $users = new users();
        $users->checkLoginInUrl();
        if(!key_exists("user", $_SESSION) || !$_SESSION["user"] || !key_exists("EmployeeUserName", $_SESSION["user"])){ //redirect to prevent access unlogined users
            $_SESSION["user"] = false;
            http_response_code(401);
            echo "wrong session";
            exit;
        }

        $id = $_GET["id"];
        require "models/help/index.php";
        
        $this->user = $_SESSION["user"];
               
        $data = new helpData($id);

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {            
            $translation = new translation($this->user["language"]);
            if(key_exists("title", $_GET))
                $this->breadCrumbTitle = $this->dashboardTitle = $translation->translateLabel("Help System" );
            
               $scope = $this;

               $keyString = $this->user["CompanyID"] . "__" . $this->user["DivisionID"] . "__" . $this->user["DepartmentID"];
               require 'views/help/index.php';
        }
    }
}
?>