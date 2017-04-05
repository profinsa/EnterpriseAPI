<?php
/*
Name of Page: subgridController

Method: controller for pages with subgrid (like Ledger Transactions Detail etc), used for rendering page and interacting with it

Date created: Nikita Zaharov, 3.04.2016

Use: The controller is responsible for:
- page rendering using view
- handling XHR request(delete, update and new item in grid)

Input parameters:
$app : application instance, object

Output parameters:
$scope: object, used by view, most like model
$translation: model, it is responsible for translation in view

Called from:
+ index.php

Calls:
models/translation.php
models/gridDataSource derevatives -- models who inherits from gridDataSource
app from index.php

Last Modified: 03.04.2016
Last Modified by: Nikita Zaharov
*/

require 'models/translation.php';
require 'models/security.php';
require 'models/permissionsGenerated.php';

class controller{
    public $user = false;
    public $action = "";
    public $mode = "subgrid";
    public $category = "Main";
    public $item = "0";
    public $dashboardTitle = "";
    public $breadCrumbTitle = "";

    public function process($app){
        if(!$_SESSION["user"] || !key_exists("EmployeeUserName", $_SESSION["user"])){ //redirect to prevent access unlogined users
            $_SESSION["user"] = false;
            http_response_code(401);
            echo "wrong session";
            exit;
        }

        require 'models/menuIdToHref.php';
        $this->action = $_GET["action"];
        $model_path = $menuIdToPath[$_GET["action"]];
        if(!file_exists('models/' . $model_path . '.php'))
            throw new Exception("model " . 'models/' . $model_path . '.php' . " is not found");
        
        $PartsPath = $model_path . "/";
        $_perm = new permissionsByFile();
        preg_match("/\/([^\/]+)(List|Detail)$/", $model_path, $filename);
        preg_match("/(.+)(List|Detail)$/", $model_path, $path);
        $model_path = $path[1] . 'Detail';
        require 'models/' . $model_path . '.php';
        if(key_exists($filename[1], $_perm->permissions))
            $security = new Security($_SESSION["user"]["accesspermissions"], $_perm->permissions[$filename[1]]);
        else
            return response('permissions not found', 500)->header('Content-Type', 'text/plain');

        $this->user = $_SESSION["user"];
               
        $data = new gridData();
        
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if(key_exists("update", $_GET)){
                $data->updateItem($_POST["id"], $_POST["category"], $_POST);
                header('Content-Type: application/json');
                echo "{ \"message\" : \"ok\"}";
            }else if(key_exists("new", $_GET)){
                $data->insertSubgridItem($_POST, $_GET["items"]);
                header('Content-Type: application/json');
                echo "{ \"message\" : \"ok\"}";
            }else if(key_exists("procedure", $_GET)){
                $name = $_GET["procedure"];
                $data->$name();
            }
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {            
            if(key_exists("getItem", $_GET)){
                echo json_encode($data->getItem($_GET["getItem"]));
            }else if(key_exists("delete", $_GET)){
                $data->deleteItem($_GET["id"]);
                header('Content-Type: application/json');
                echo "{ \"message\" : \"ok\"}";
            }else{
                $translation = new translation($this->user["language"]);
                $this->dashboardTitle = $translation->translateLabel($data->dashboardTitle);
                $this->breadCrumbTitle = $translation->translateLabel($data->breadCrumbTitle);
            
                $scope = $this;
                if(key_exists("mode", $_GET))
                    $this->mode = $_GET["mode"];
                if(key_exists("category", $_GET))
                    $this->category = $_GET["category"];
                if(key_exists("items", $_GET))
                    $this->items = $_GET["items"];
                if(key_exists("item", $_GET))
                    $this->item = $_GET["item"];
                if(!key_exists("items", $_GET))
                    $this->items = $_GET["item"];

                $keyString = $this->user["CompanyID"] . "__" . $this->user["DivisionID"] . "__" . $this->user["DepartmentID"];
                require 'models/menuCategoriesGenerated.php';
                require 'views/subGridView.php';
            }
        }
    }
}
?>