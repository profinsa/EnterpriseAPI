<?php
/*
Name of Page: language

Method: controller

Date created: Nikita Zaharov, 15.02.2016

Use: 

The controller is responsible for:

Input parameters:
$db: database instance
$app : application instance, object

Output parameters:
exposed language management api

Called from:
+ index.php

Calls:
models/translation.php
app from index.php

Last Modified: 15.02.2016
Last Modified by: Nikita Zaharov
*/

//require 'models/translation.php';

class controller{
    public $user = false;
    
    public function process($app){
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {            
            if(key_exists("logout", $_GET) || !$_SESSION["user"]){ //Logout action or redirect to prevent access un logined users
                $_SESSION["user"] = false;
                header("Location: index.php?page=login");
                exit;
            }
            
            $this->user = $_SESSION["user"];
               
            if(key_exists("setLanguage", $_GET)){
                $this->user["language"] = $_GET["setLanguage"];
                $_SESSION["user"] = $this->user;
                echo json_encode([ "message" => "ok"]);
            }
        }
    }
}
?>