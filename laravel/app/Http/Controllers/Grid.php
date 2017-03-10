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

Last Modified: 28.02.2016
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
    public function show($folder, $subfolder, $page, $mode, $category, $item){
        $public_prefix = public_prefix();
        if(!Session::has("user") || !key_exists("EmployeeUserName", Session::get("user"))){//redirect to prevent access un logined users
            Session::put("user", []);
            if(key_exists("partial", $_GET))
                return response('wrong session', 401)->header('Content-Type', 'text/plain');
            else
                return redirect("/login");
        }

        require __DIR__ . "/../Models/" . $folder . '/' . $subfolder .'/' . $page .  '.php';
        $data = new \App\Models\gridData();

        $user = Session::get("user");
               
        $translation = new \App\Models\translation($user["language"]);

        $sessionValues = Session::all();
        $token = $sessionValues['_token'];
        $app = new _app;
        return view(key_exists("partial",$_GET) ? "gridView" : "index",
                    [ "app" => $app,
                      "public_prefix" => $public_prefix,
                      "translation" => $translation,
                      "user" => $user,
                      "data" => $data,
                      "dashboardTitle" => $app->title = $data->dashboardTitle = $translation->translateLabel($data->dashboardTitle),
                      "breadCrumbTitle" => $data->breadCrumbTitle = $translation->translateLabel($data->breadCrumbTitle),
                      "scope" => [
                          "path" => $folder . "/" . $subfolder . "/" . $page,
                          "pathFolder" => $folder . '/' . $subfolder,
                          "pathPage" => $page,
                          "mode" => $mode,
                          "category" => $category,
                          "item" => $item
                      ],
                      "token" => $token,
                      "header" => "header.php",
                      "content" => "gridView.php"
                    ]);
    }

    public function update($folder, $page){
        require __DIR__ . "/../Models/" . $folder . "/" . $subfolder  . '/' . $page .  '.php';
        $data = new \App\Models\gridData();
        
        $data->updateItem($_POST["id"], $_POST["category"], $_POST);
        header('Content-Type: application/json');
        echo "{ \"message\" : \"ok\"}";
    }
    
    public function insert($folder, $page){
        require __DIR__ . "/../Models/" . $folder . "/" . $subfolder  . '/' . $page .  '.php';
        $data = new \App\Models\gridData();
        
        $data->insertItem($_POST);
        header('Content-Type: application/json');
        echo "{ \"message\" : \"ok\"}";
    }

    public function delete($folder, $page, $item){
        require __DIR__ . "/../Models/" . $folder . "/" . $subfolder  . '/' . $page .  '.php';
        $data = new \App\Models\gridData();
        
        $data->deleteItem($item);
        header('Content-Type: application/json');
        echo "{ \"message\" : \"ok\"}";
    }
}
?>
