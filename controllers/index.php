<?php
require 'models/translation.php';

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
            $scope = $this;
            require 'views/index.php';
        }
    }
}
?>