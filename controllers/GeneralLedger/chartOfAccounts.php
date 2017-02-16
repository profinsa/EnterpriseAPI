<?php
/*
Name of Page: chartOfAccount

Method: controller of GeneralLedger/chartOfAccount page, used for rendering page and interacting with it

Date created: Nikita Zaharov, 09.02.2016

Use: The controller is responsible for:
- page rendering using view
- handling XHR request(delete, update and new item in grid)

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
models/GeneralLedger/chartOfAccounts.php
app from index.php

Last Modified: 16.02.2016
Last Modified by: Nikita Zaharov
*/

require 'models/translation.php';

class controller{
    public $user = false;
    public $dashboardTitle = "Chart Of Accounts";
    public $breadCrumbTitle = "Chart Of Accounts";
    public $mode = "grid";
    public $category = "Main";
    public $item = "0";
    
    public function __construct($db){
    }
    
    public function process($app){
        if(!$_SESSION["user"]){ //redirect to prevent access unlogined users
            $_SESSION["user"] = false;
            header("Location: index.php?page=login");
            exit;
        }

        require 'models/' . $app->page . '.php';

        $this->user = $_SESSION["user"];
               
        $data = new chartOfAccounts($app->db);
        
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if(key_exists("update", $_GET)){
                $data->updateItem($_POST["GLAccountNumber"], $_POST["category"], $_POST);
                header('Content-Type: application/json');
                echo "{ \"message\" : \"ok\"}";
            }else if(key_exists("new", $_GET)){
                $data->insertItem($_POST);
                header('Content-Type: application/json');
                echo "{ \"message\" : \"ok\"}";
            }
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {            
            if(key_exists("getItem", $_GET)){
                echo json_encode($data->getItem($_GET["getItem"]));
            }else if(key_exists("delete", $_GET)){
                $data->deleteItem($_GET["GLAccountNumber"]);
                header('Content-Type: application/json');
                echo "{ \"message\" : \"ok\"}";
            }else{
                $translation = new translation($app->db, $this->user["language"]);
                $this->dashboardTitle = $translation->translateLabel($this->dashboardTitle);
                $this->breadCrumbTitle = $translation->translateLabel($this->breadCrumbTitle);
            
                $scope = $this;
                if(key_exists("mode", $_GET))
                    $this->mode = $_GET["mode"];
                if(key_exists("category", $_GET))
                    $this->category = $_GET["category"];
                if(key_exists("item", $_GET))
                    $this->item = $_GET["item"];
                
                require 'views/' . $app->page . '.php';
            }
        }
    }
}
?>