<?php
/*
Name of Page: index

Method: main entry point of application

Date created: Nikita Zaharov, 08.02.2016

Use:  Initialization ofr application,  router for actions. Response for thing like page=index transoforms to call 
index.php from /controllers

Input parameters:
GET and POST params and data

Output parameters:
html site pages

Called from:
+ app object used by most of /controllers and /models

Calls:
+ /controllers/*


Last Modified: 13.02.2016
Last Modified by: Nikita Zaharov
*/
require 'vendor/autoload.php';
require './common.php';

use Illuminate\Database\Capsule\Manager as Capsule;

$GLOBALS["capsule"] = new Capsule;
$config = config();
$capsule->addConnection([
    "driver" => "mysql",
    "host" => $config["db_host"],
    "database" => $config["db_base"],
    "username" => $config["db_user"],
    "password" => $config["db_password"],
    "charset" => "utf8",
    "collation" => "utf8_unicode_ci",
    "prefix" => ""
]);
$capsule->setAsGlobal();

class app{
    public $controller = false;
    public $title = 'Integral Accounting X';
    public $page = 'index';
    public function __construct(){
        if(isset($_GET["page"]))
            $this->page = $_GET["page"];
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        }else if($_SERVER['REQUEST_METHOD'] === 'GET'){
        }
        if(!file_exists('controllers/' . $this->page . '.php'))
            throw new Exception("controller ". 'controllers/' . $this->page . '.php' . "is not found");
        include 'controllers/' . $this->page . '.php';
        $this->controller = new controller();
    }
}

try{
    session_start();

    $_app = new app();
    $_app->controller->process($_app);
}catch(Exception $e){
    echo '<b>Fatal error: </b>' . $e->getMessage();
}
?>