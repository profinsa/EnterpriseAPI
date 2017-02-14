<?php
/*
Name of Page: chartOfAccount

Method:

Date created: Nikita Zaharov, 09.02.2016

Use: 

The controller is responsible for:

Input parameters:
$db: database instance
$app : application instance, object

Output parameters:
$scope: object, used by view, most like model
$translation: model, it is responsible for translation in view

Called from:
+ index.php

Calls:
models/translation.php
app from index.php

Last Modified: 13.02.2016
Last Modified by: Nikita Zaharov
*/

require 'models/translation.php';
require 'models/GeneralLedger/chartsOfAccount.php';

class controller{
    public $user = false;
    public $dashboardTitle = "Chart Of Accounts";
    public $breadCrumbTitle = "Chart Of Accounts";
    
    public function __construct($db){
    }
    
    public function process($app){
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {            
            if(key_exists("logout", $_GET) || !$_SESSION["user"]){ //Logout action or redirect to prevent access un logined users
                $_SESSION["user"] = false;
                header("Location: index.php?page=login");
                exit;
            }
            
            $this->user = $_SESSION["user"];
               
            $grid = new chartsOfAccount($app->db);

            if(key_exists($_GET["getItem"])){
                echo json_encode($grid->getItem($_GET["getItem"]));
            }else if(key_exists($_GET["update"])){
            }else if(key_exists($_GET["delete"])){
            }
            $translation = new translation($app->db, $this->user["language"]);
            $this->dashboardTitle = $translation->translateLabel($this->dashboardTitle);
            $this->breadCrumbTitle = $translation->translateLabel($this->breadCrumbTitle);
            
            $scope = $this;
            require 'views/chartsOfAccount.php';
        }
    }
}
?>