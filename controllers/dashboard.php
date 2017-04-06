<?php
/*
Name of Page: dashboard controller

Method: controller for dashboard pages(GeneralLedger and other). Used for rendering page and interacting with it

Date created: Nikita Zaharov, 5.04.2016

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

Last Modified: 05.04.2016
Last Modified by: Nikita Zaharov
*/

require 'models/translation.php';
require 'models/security.php';
require 'models/permissionsGenerated.php';

class controller{
    public $user = false;
    public $category = "GeneralLedger";
    public $path;

    public function process($app){
        if(!$_SESSION["user"] || !key_exists("EmployeeUserName", $_SESSION["user"])){ //redirect to prevent access unlogined users
            $_SESSION["user"] = false;
            http_response_code(401);
            echo "wrong session";
            exit;
        }

        $this->category =  $_GET["category"];
        if(!file_exists('models/dashboards/' . $this->category . '.php'))
            throw new Exception("model " . 'models/dashboards/' . $this->category . '.php' . " is not found");
        require 'models/dashboards/' . $this->category . '.php';
        
        $_perm = new permissionsByFile();

        $this->user = $_SESSION["user"];
               
        $data = new dashboardData();
        
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
            if(key_exists("mode", $_GET))
                $this->mode = $_GET["mode"];
            if(key_exists("category", $_GET))
                $this->category = $_GET["category"];
            if(key_exists("item", $_GET))
                $this->item = $_GET["item"];

            $keyString = $this->user["CompanyID"] . "__" . $this->user["DivisionID"] . "__" . $this->user["DepartmentID"];
            require 'views/dashboard.php';
        }
    }
}
?>