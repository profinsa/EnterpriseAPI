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
               
            $translation = new translation($app->db, $this->user["language"]);
            $grid = new chartsOfAccount($app->db);
            $scope = $this;
            require 'views/chartsOfAccount.php';
        }
    }
}
?>