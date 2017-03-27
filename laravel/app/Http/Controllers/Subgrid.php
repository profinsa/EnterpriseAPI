<?php
/*
Name of Page: subgridController

Method: controller for many subgrid, embedded in other grid and ordinary pages. Used for rendering page and interacting with it

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
models/gridDataSource derivatives -- models who inherits from gridDataSource

Last Modified: 27.03.2016
Last Modified by: Nikita Zaharov
*/

namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Response;
use Illuminate\Http\Request;

use Session;

require __DIR__ . "/../Models/translation.php";
require __DIR__ . "/../Models/permissionsGenerated.php";
require __DIR__ . "/../Models/security.php";
require __DIR__ . "/../../common.php";

class _app{
    public $title = "Integral Accounting New Tech PHP";
}

class Subgrid extends BaseController{
    public function show($folder, $subfolder, $page, $mode, $category, $item){
        require __DIR__ . "/../Models/menuIdToHref.php";
        $public_prefix = public_prefix();
        if(!Session::has("user") || !key_exists("EmployeeUserName", Session::get("user"))){//redirect to prevent access un logined users
            Session::put("user", []);
            if(key_exists("partial", $_GET))
                return response('wrong session', 401)->header('Content-Type', 'text/plain');
            else
                return redirect("/login");
        }

        $user = Session::get("user");
        
        $model_path = $menuIdToPath[$folder . '/' . $subfolder .'/' . $page];

        $_perm = new \App\Models\permissionsByFile();
        preg_match("/\/([^\/]+)(List|Detail)$/", $model_path, $filename);
        preg_match("/(.+)(List|Detail)$/", $model_path, $path);
        $model_path = $path[1] . 'Detail';
        if(key_exists($filename[1], $_perm->permissions))
            $security = new \App\Models\Security($user["accesspermissions"], $_perm->permissions[$filename[1]]);
        else
            return response('permissions not found', 500)->header('Content-Type', 'text/plain');
        
        //echo json_encode($permissions->permissions[$filename[1]]);
        
        require __DIR__ . "/../Models/" . $model_path .  '.php';
        $data = new \App\Models\gridData();
               
        $translation = new \App\Models\translation($user["language"]);

        $sessionValues = Session::all();
        $token = $sessionValues['_token'];
        $app = new _app;

        //        preg_match("/(.+)
        return view(key_exists("partial",$_GET) ? "subGridView" : "index",
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
                      "content" => "subGridView.php",
                      "security" => $security,
                      "PartsPath" => $model_path . "/"
                    ]);
    }

    public function update($folder, $subfolder, $page){
        require __DIR__ . "/../Models/menuIdToHref.php";
        $model_path = $menuIdToPath[$folder . '/' . $subfolder .'/' . $page];
        $_perm = new \App\Models\permissionsByFile();
        preg_match("/\/([^\/]+)(List|Detail)$/", $model_path, $filename);
        preg_match("/(.+)(List|Detail)$/", $model_path, $path);
        $model_path = $path[1] . 'Detail';
        require __DIR__ . "/../Models/" . $model_path .  '.php';
        $data = new \App\Models\gridData();
        
        $data->updateItem($_POST["id"], false, $_POST);
        header('Content-Type: application/json');
        echo "{ \"message\" : \"ok\"}";
    }
    
    public function insert($folder, $subfolder, $page){
        require __DIR__ . "/../Models/menuIdToHref.php";
        $model_path = $menuIdToPath[$folder . '/' . $subfolder .'/' . $page];
        preg_match("/\/([^\/]+)(List|Detail)$/", $model_path, $filename);
        preg_match("/(.+)(List|Detail)$/", $model_path, $path);
        $model_path = $filename[1] . 'Detail';
        require __DIR__ . "/../Models/" . $model_path .  '.php';
        $data = new \App\Models\gridData();
        
        $data->insertItem($_POST);
        header('Content-Type: application/json');
        echo "{ \"message\" : \"ok\"}";
    }

    public function delete($folder, $subfolder, $page, $item){
        require __DIR__ . "/../Models/menuIdToHref.php";
        $model_path = $menuIdToPath[$folder . '/' . $subfolder .'/' . $page];
        preg_match("/\/([^\/]+)(List|Detail)$/", $model_path, $filename);
        preg_match("/(.+)(List|Detail)$/", $model_path, $path);
        $model_path = $filename[1] . 'Detail';
        require __DIR__ . "/../Models/" . $model_path .  '.php';

        $data = new \App\Models\gridData();
        
        $data->deleteItem($item);
        header('Content-Type: application/json');
        echo "{ \"message\" : \"ok\"}";
    }

    public function procedure(Request $request, $folder, $subfolder, $page, $name){
        require __DIR__ . "/../Models/menuIdToHref.php";
        $model_path = $menuIdToPath[$folder . '/' . $subfolder .'/' . $page];
        preg_match("/\/([^\/]+)(List|Detail)$/", $model_path, $filename);
        preg_match("/(.+)(List|Detail)$/", $model_path, $path);
        $model_path = $filename[1] . 'Detail';
        require __DIR__ . "/../Models/" . $model_path .  '.php';
        
        $data = new \App\Models\gridData();

        return $data->$name();
    }
}
?>
