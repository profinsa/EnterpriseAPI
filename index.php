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

function db_start(){
    $config = config();
    $db = mysqli_connect($config["db_host"], $config["db_user"], $config["db_password"], $config["db_base"])
        or die('database error: ' . mysqli_error());
    return $db;
}
function db_end($db){
    mysqli_close($db);    
}
class app{
    public $db = false;
    public $controller = false;
    public $title = 'Integral Accounting X';
    public $page = 'index';
    public function __construct($database){
        $this->db = $database; 
        if(isset($_GET["page"]))
            $this->page = $_GET["page"];
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        }else if($_SERVER['REQUEST_METHOD'] === 'GET'){
        }
        if(!file_exists('controllers/' . $this->page . '.php'))
            throw new Exception("controller ". 'controllers/' . $this->page . '.php' . "is not found");
        require 'controllers/' . $this->page . '.php';
        $this->controller = new controller($database);
    }
}

try{
    $db = db_start();
    session_start();

    $_app = new app($db);
    $_app->controller->process($_app);

    db_end($db);
}catch(Exception $e){
    echo '<b>Fatal error: </b>' . $e->getMessage();
}
?>