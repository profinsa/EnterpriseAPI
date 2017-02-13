<?php
/*
Name of Page: ByPassLogin

Method: This is controller for ByPassLogin page. It contains simple logic for log in as default user and redirecting to index

Date created: Nikita Zaharov, 13.02.2016

Use: controller is used by index.php, load by GET request parameter - page=ByPassLogin.

The controller is responsible for:
+ log in as default user
+ redirecting to index

Input parameters:
$db: database instance
$app : application instance, object

Output parameters:
none

Called from:
+ index.php

Calls:
models/users.php
app from index.php

Last Modified: 13.02.2016
Last Modified by: Nikita Zaharov
*/

require 'models/users.php';

class controller{
    public $user = false;
    
    public function __construct($db){
    }
    
    public function process($app){
        $users = new users($app->db);
        $defaultUser = defaultUser();
        if($_SERVER['REQUEST_METHOD'] === 'GET') { //log in as default user and redirect to index
            $user = $users->search($defaultUser["Company"],
                                   $defaultUser["Username"],
                                   $defaultUser["Password"],
                                   $defaultUser["Division"],
                                   $defaultUser["Department"]);                 

            $user["language"] = $defaultUser["Language"];
            $_SESSION["user"] = $user;

            header("Location: index.php?page=index");
            exit;
        }
    }
}
?>