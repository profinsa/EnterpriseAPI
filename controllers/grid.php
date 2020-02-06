<?php
/*
  Name of Page: gridController

  Method: controller for many grid pages(like General Ledger pages etc), used for rendering page and interacting with it

  Date created: Nikita Zaharov, 21.02.2017

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
  models/gridDataSource derivatives -- models who inherits from gridDataSource
  app from index.php

  Last Modified: 24.01.2020
  Last Modified by: Nikita Zaharov
*/

require 'models/users.php';
require 'models/translation.php';
require 'models/security.php';
require 'models/permissionsGenerated.php';
require 'models/drillDowner.php';
require 'models/linksMaker.php';
require 'models/interfaces.php';
require 'models/redirects.php';

class controller{
    public $config;
    public $user = false;
    public $interface = "default";
    public $interfaceType = "ltr";
    public $interfaces;
    public $action = "";
    public $mode = "grid";
    public $category = "Main";
    public $item = "0";
    public $dashboardTitle = "";
    public $breadCrumbTitle = "";
    public $path;
    public $pathPage;
    
    protected $redirectModel;
    function __construct(){
        $this->redirectModel = redirects::$Models;
        $this->interfaces = new interfaces();
    }

    public function checkPermissions($model_path, $data, &$security, $type, $param1 = ""){
        if(!key_exists("user", $_SESSION) || !$_SESSION["user"] || !key_exists("EmployeeUserName", $_SESSION["user"])){ 
            //redirect to prevent access unlogined users
            $_SESSION["user"] = false;
            http_response_code(401);
            echo "wrong session";
            exit;
        }

        ///////////////////////
        //checking permissions
        preg_match("/\/(\w+)$/", $this->action, $page);
        $this->pathPage = $page = $page[1];

        $_perm = new permissionsByFile();
        if(property_exists($data, "publicAccess") && key_exists($type, $data->publicAccess)){
            if($type == "procedure" && in_array($_GET["procedure"], $data->publicAccess["procedure"]));
            else{
                http_response_code(400);
                echo 'not allowed';
                exit;
            }
        }else{
            preg_match("/\/([^\/]+)(List|Detail)$/", $model_path, $filename);
            if(key_exists($filename[1], $_perm->permissions))
                $security = new Security($_SESSION["user"]["accesspermissions"], $_perm->permissions[$filename[1]]);
            else{
                http_response_code(400);
                echo 'permissions not found';
                exit;
            }
        }
    }
        
    public function process($app){
        ///////////////////////
        //loading common models
        require 'models/menuIdToHref.php';
        $drill = new drillDowner();
        $linksMaker = new linksMaker();

        //////////////////////
        //loading data source
        $this->action = $this->path =  $_GET["action"];
        $model_path = $menuIdToPath[$_GET["action"]];
        $PartsPath = $model_path . "/";

        $requireModelPath = key_exists($model_path, $this->redirectModel) ? $this->redirectModel[$model_path] : $model_path;
        if(!file_exists('models/' . $requireModelPath . '.php'))
            throw new Exception("model " . 'models/' . $requireModelPath . '.php' . " is not found");
        require 'models/' . $requireModelPath. '.php';
        
        preg_match("/\/([^\/]+)$/", $model_path, $filename);
        $newPath = $filename[1];
        if($requireModelPath != $model_path || class_exists($newPath)){
            $data = new $newPath;
        }
        else
            $data = new gridData();
        
        /////////////////////
        //loading user
        $users = new users();
        $users->checkLoginInUrl();
        if(key_exists("user", $_SESSION) && $_SESSION["user"] && key_exists("EmployeeUserName", $_SESSION["user"])){
            $this->interface = $_SESSION["user"]["interface"] = $interface = key_exists("interface", $_GET) ? $_GET["interface"] : (key_exists("interface", $_SESSION["user"]) ? $_SESSION["user"]["interface"] : "default");
            $this->interfaceType = $_SESSION["user"]["interfaceType"] = $interfaceType = key_exists("interfacetype", $_GET) ? $_GET["interfacetype"] : (key_exists("interfaceType", $_SESSION["user"]) ? $_SESSION["user"]["interfaceType"] : $this->interfaceType);
        }

        if(key_exists("user", $_SESSION))
            $this->user = $GLOBALS["user"] = $_SESSION["user"];               
        
        if($_SERVER['REQUEST_METHOD'] === 'POST'){
            if(key_exists("update", $_GET)){
                $this->checkPermissions($model_path, $data, $security, "update");
                $data->updateItem($_POST["id"], $_POST["category"], $_POST);
                header('Content-Type: application/json');
                echo "{ \"message\" : \"ok\"}";
            }else if(key_exists("new", $_GET)){
                $this->checkPermissions($model_path, $data, $security, "insert");
                $data->insertItem($_POST);
                header('Content-Type: application/json');
                echo "{ \"message\" : \"ok\"}";
            }else if(key_exists("procedure", $_GET)){
                $name = $_GET["procedure"];
                $this->checkPermissions($model_path, $data, $security, "procedure", $name);
                $data->$name();
            }
        }else if($_SERVER['REQUEST_METHOD'] === 'GET'){            
            if(key_exists("procedure", $_GET)){
                $name = $_GET["procedure"];
                $this->checkPermissions($model_path, $data, $security, "procedure", $name);
                $data->$name();
            }else if(key_exists("getItem", $_GET)){
                $this->checkPermissions($model_path, $data, $security, "getItem");
                echo json_encode($data->getItem($_GET["getItem"]));
            }else if(key_exists("delete", $_GET)){
                $this->checkPermissions($model_path, $data, $security, "delete");
                $data->deleteItem($_GET["id"]);
                header('Content-Type: application/json');
                echo "{ \"message\" : \"ok\"}";
            }else{
                $this->checkPermissions($model_path, $data, $security, "getPage");

                $translation = new translation($this->user["language"]);
                $this->dashboardTitle = $translation->translateLabel($data->dashboardTitle);
                $this->breadCrumbTitle = $translation->translateLabel($data->breadCrumbTitle);
            
                $redirectView = redirects::$Views;
                if(key_exists("mode", $_GET))
                    $this->mode = $_GET["mode"];
                if(key_exists("category", $_GET))
                    $this->category = $_GET["category"];
                if(key_exists("item", $_GET))
                    $this->item = $_GET["item"];
                
                $security->setModel($data, $this->item, $this->mode);
                $this->config = config();
                
                $scope = $this;
                $user = $this->user;
                $ascope = json_decode(json_encode($scope), true);

                $keyString = $this->user["CompanyID"] . "__" . $this->user["DivisionID"] . "__" . $this->user["DepartmentID"];
                require 'models/menuCategoriesGenerated.php';
                require 'views/gridView.php';
            }
        }
    }
}
?>