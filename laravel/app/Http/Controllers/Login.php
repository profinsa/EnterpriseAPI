<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Response;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Session;

use Gregwar\Captcha\CaptchaBuilder;

require __DIR__ . "/../Models/translation.php";
require __DIR__ . "/../Models/companies.php";
require __DIR__ . "/../Models/users.php";

class _app{
    public $title = "Integral Accounting New Tech PHP";
}

class _translation{
    public function translateLabel($label){
        return $label;
    }
}

class Login extends BaseController
{
    //use AuthorizesRequests, DispatchesJobs, ValidatesRequests;
    public function show(){
        $captcha = new CaptchaBuilder;
        $captcha->build();
        Session::put("captcha", $captcha->getPhrase());
        if(Session::has("user") || ! Session::get("user"))
            Session::put("user", ["language" => "English"]);

        $sessionValues = Session::all();//получаем данные из сессии
        $token = $sessionValues['_token'];
        return view("login", [ "app" => new _app,
                               "translation" => new \App\Models\translation("english"),
                               "companies" => new \App\Models\companies,
                               "captchaBuilder" => $captcha,
                               "user" => Session::get("user"),
                               "token" => $token
                               //                             "translation" => new \App\Models\users
        ]);
    }

    public function login(){
        $captcha = new CaptchaBuilder;
        $users = new \App\Models\users();
        $wrong_captcha = false;
        $user = false;

        if($_POST["captcha"] != Session::get("captcha"))
            $wrong_captcha = true;

        if(!$wrong_captcha && $user = $users->search($_POST["company"], $_POST["name"], $_POST["password"], $_POST["division"], $_POST["department"])){//access granted, captcha is matched                 
            $user["language"] = $_POST["language"];
            Session::put("user", $user);
            return Response::json(array(
                "message" =>  "ok"
            ), 200); 
        }else{//something wrong: captcha, company, username, password. Generating new captcha
            $captcha->build();
            Session::put("captcha", $captcha->getPhrase());

            $response = array(
                "captcha" =>  $captcha->inline()
            );
            if($wrong_captcha)
                $response["wrong_captcha"] = true;
            if(!$user)
                $response["wrong_user"] = true;

            return Response::json($response, 401); 
        }        
    }

    public function ByPassLogin(){
    }
}

?>