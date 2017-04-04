<?php
/*
Name of Page: Index

Method: This is controller for index page.

Date created: Nikita Zaharov, 09.02.2016

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

Last Modified: 21.02.2016
Last Modified by: Nikita Zaharov
*/

require 'models/translation.php';
require 'models/security.php';

class controller{
    public $user = false;
    public $dashboardTitle = "Accounting Dashboard";
    public $breadCrumbTitle = "Accounting Dashboard";
    
    public function process($app){
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {            
            if(key_exists("logout", $_GET) || !$_SESSION["user"] || !key_exists("EmployeeUserName", $_SESSION["user"])){ //Logout action or redirect to prevent access un logined users
                $_SESSION["user"] = false;
                header("Location: index.php?page=login");
                exit;
            }
            
            $this->user = $_SESSION["user"];
               
            $security = new Security($this->user["accesspermissions"], []);
            $translation = new translation($this->user["language"]);
            $this->dashboardTitle = $translation->translateLabel($this->dashboardTitle);
            $this->breadCrumbTitle = $translation->translateLabel($this->breadCrumbTitle);
            $scope = $this;
            $keyString = $this->user["CompanyID"] . "__" . $this->user["DivisionID"] . "__" . $this->user["DepartmentID"];
            require 'models/menuCategoriesGenerated.php';
            require 'views/index.php';
        }
    }
}
?>