<?php
require 'vendor/autoload.php';

function db_start(){
    $db = mysqli_connect('localhost', 'root', 'dataB00m', 'integralx')
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
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if(isset($_POST["page"]))
                $this->page = $_POST["page"];
        }else if($_SERVER['REQUEST_METHOD'] === 'GET'){
            if(isset($_GET["page"]))
                $this->page = $_GET["page"];
        }
        require 'controllers/' . $this->page . '.php';
        $this->controller = new controller($database);
    }
}

$db = db_start();
session_start();

$_app = new app($db);
$_app->controller->process($_app);

db_end($db);
