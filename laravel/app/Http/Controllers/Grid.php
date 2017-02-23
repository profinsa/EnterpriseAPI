<?php
/*
Name of Page: gridController

Method: controller for many grid pages(like General Ledger pages etc), used for rendering page and interacting with it

Date created: Nikita Zaharov, 23.02.2016

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
+ router

Calls:
models/translation.php
models/gridDataSource derevatives -- models who inherits from gridDataSource

Last Modified: 23.02.2016
Last Modified by: Nikita Zaharov
*/

namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Response;
use Illuminate\Http\Request;

use Session;

require __DIR__ . "/../Models/translation.php";
require __DIR__ . "/../../common.php";

class _app{
    public $title = "Integral Accounting New Tech PHP";
}

class Grid extends BaseController{
    public function show($folder, $page, $mode, $category, $item){
        if(!Session::has("user") || !key_exists("EmployeeUserName", Session::get("user"))){//redirect to prevent access un logined users
            Session::put("user", []);
            header("Location: login");
            return;
        }

        require __DIR__ . "/../Models/" . $folder . '/' . $page .  '.php';

        $user = Session::get("user");
               
        $translation = new \App\Models\translation($user["language"]);
        $data = new \App\Models\gridData();

        $sessionValues = Session::all();//получаем данные из сессии
        $token = $sessionValues['_token'];
        return view("gridView", [ "app" => new _app,
                                  "public_prefix" => public_prefix(),
                                  "translation" => $translation,
                                  "user" => $user,
                                  "data" => $data,
                                  "dashboardTitle" => $data->dashboardTitle = $translation->translateLabel($data->dashboardTitle),
                                  "breadCrumbTitle" => $data->breadCrumbTitle = $translation->translateLabel($data->breadCrumbTitle),
                                  "scope" => [
                                      "path" => $folder . "/" . $page,
                                      "mode" => $mode,
                                      "category" => $category,
                                      "item" => $item
                                  ],
                                  "token" => $token
        ]);
    }

    public function update($folder, $page, $item){
        $data->updateItem($_POST["id"], $_POST["category"], $_POST);
        header('Content-Type: application/json');
        echo "{ \"message\" : \"ok\"}";
    }
    
    public function insert($folder, $page, $item){
        $data->insertItem($_POST);
        header('Content-Type: application/json');
        echo "{ \"message\" : \"ok\"}";
    }

    public function delete($folder, $page, $item){
        $data->deleteItem($_GET["id"]);
        header('Content-Type: application/json');
        echo "{ \"message\" : \"ok\"}";
    }
}
/*
    public $mode = "grid";
    public $category = "Main";
    
    public function process($app){
        }else if($_SERVER['REQUEST_METHOD'] === 'GET') {            
            if(key_exists("getItem", $_GET)){
                echo json_encode($data->getItem($_GET["getItem"]));
        }
    }
}
*/
?>
