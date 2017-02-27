<?php
/*
Name of Page: Index

Method: This is controller for index page.

Date created: Nikita Zaharov, 23.02.2016

Use: controller is used by index.php, load by GET request parameter - page=index.

The controller is responsible for:
+ loading user and translation models
+ render index page

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

Last Modified: 23.02.2016
Last Modified by: Nikita Zaharov
*/

namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Response;
use Session;

require __DIR__ . "/../../common.php";
require __DIR__ . "/../Models/translation.php";

class _app{
    public $title = "Integral Accounting New Tech PHP";
}

class Index extends BaseController{
    public $dashboardTitle = "Accounting Dashboard";
    public $breadCrumbTitle = "Accounting Dashboard";
    
    public function index(){
        if(!Session::has("user") || !key_exists("EmployeeUserName", Session::get("user"))){//redirect to prevent access un logined users
            Session::put("user", []);
            header("Location: login");
            return;
        }

        $user = Session::get("user");
               
        $translation = new \App\Models\translation($user["language"]);
        $this->dashboardTitle = $translation->translateLabel($this->dashboardTitle);
        $this->breadCrumbTitle = $translation->translateLabel($this->breadCrumbTitle);

        $sessionValues = Session::all();//получаем данные из сессии
        $token = $sessionValues['_token'];
        return view("nindex", [ "app" => new _app,
                               "public_prefix" => public_prefix(),
                               "translation" => $translation,
                               "companies" => new \App\Models\companies,
                               "user" => $user,
                               "dashboardTitle" => $translation->translateLabel($this->dashboardTitle),
                               "breadCrumbTitle" => $translation->translateLabel($this->breadCrumbTitle),
                               "token" => $token
        ]);
    }
}
?>