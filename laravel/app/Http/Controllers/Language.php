<?php
/*
Name of Page: language

Method: used for changing ui language

Date created: Nikita Zaharov, 23.02.2016

Use: 

Input parameters:
$db: database instance
$app : application instance, object

Output parameters:
exposed language management api

Called from:
+ index.php

Calls:

Last Modified: 23.02.2016
Last Modified by: Nikita Zaharov
*/


namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Response;
use Session;


class Language extends BaseController{
    public $user = false;
    
    public function set($lang){
        if(!Session::has("user")){ //Logout action or redirect to prevent access un logined users
            $_SESSION["user"] = false;
            header("Location: login");
            return;
        }
            
        $user = Session::get("user");

        $user["language"] = $lang;
        Session::put("user", $user);
        return Response::json(array(
            "message" =>  "ok"
        ), 200); 
    }
}
?>