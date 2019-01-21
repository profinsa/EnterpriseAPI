<?php
/*
  Name of Page: autoreports controller

  Method: controller for autoreports and generic report pages

  Date created: Nikita Zaharov, 14.02.2017

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
  models/autoreports.php
  app from index.php

  Last Modified: 01.17.2019
  Last Modified by: Nikita Zaharov
*/

require 'models/translation.php';
require 'models/security.php';
require 'models/permissionsGenerated.php';
// require "common.php";
require "models/drillDowner.php";

function numberToStr($strin){
    return preg_replace('/\B(?=(\d{3})+(?!\d))/', ',', $strin);
}

class controller{
    public $user = false;
    public $action = "";
    public $mode = "autoreports";
    public $dashboardTitle = "";
    public $breadCrumbTitle = "";
    public $path;

    public function process($app){
        if(!$_SESSION["user"] || !key_exists("EmployeeUserName", $_SESSION["user"])){ //redirect to prevent access unlogined users
            $_SESSION["user"] = false;
            http_response_code(401);
            echo "wrong session";
            exit;
        }

        require 'models/reports/autoreports.php';
        
        //$_perm = new permissionsByFile();
        //preg_match("/\/([^\/]+)(List|Detail)$/", $model_path, $filename);
        // if(key_exists($filename[1], $_perm->permissions))
        //  $security = new Security($_SESSION["user"]["accesspermissions"], $_perm->permissions[$filename[1]]);
        // else
        //  return response('permissions not found', 500)->header('Content-Type', 'text/plain');

        $this->user = $_SESSION["user"];

        $data = new autoreportsData($source = (key_exists("source", $_GET) ? $_GET["source"] : $_GET["getreport"]));
        
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {            
            $translation = new translation($this->user["language"]);
            $drill = new drillDowner();

            if(key_exists("title", $_GET))
                $this->breadCrumbTitle = $this->dashboardTitle = $translation->translateLabel("Report: " ) . $translation->translateLabel($_GET["title"]);
            
               $scope = $this;

               $keyString = $this->user["CompanyID"] . "__" . $this->user["DivisionID"] . "__" . $this->user["DepartmentID"];
               require 'models/menuCategoriesGenerated.php';
               if(key_exists("getreport", $_GET)){
                   $content = $_GET["type"];
                   require 'views/reports/autoreports/container.php';
               }else
                   require 'views/reports/autoreports.php';
        }
    }
}
?>